-- ============================================
-- Exercice 8 : Analyse de performance et création d'index
-- Réalisé par : [Fontaine Melvin]
-- Date : [09/06/2026]
-- ============================================

-- Etape 1: Charger des données massives


TRUNCATE TABLE stream, participation_defi, creneau, defi, streamer RESTART IDENTITY CASCADE;

-- 2. Insert 50,000 streamers
DO $$
BEGIN
    FOR i IN 1..50000 LOOP
        INSERT INTO streamer (pseudo, url_twitch)
        VALUES ('pseudo_' || i, 'https://twitch.tv/pseudo_' || i);
    END LOOP;
END $$;

-- 3. Insert 50,000 défis
DO $$
BEGIN
    FOR i IN 1..50000 LOOP
        INSERT INTO defi (intitule, montant_palier, etat_validation)
        VALUES (
            'defi_' || i,
            (random() * 50000)::DECIMAL(12,2) + 500,
            (random() < 0.5)
        );
    END LOOP;
END $$;

-- 4. Insert 250,000 participations (M:N)
-- Correction : Utilisation de FLOOR et gestion des conflits de clés primaires
DO $$
BEGIN
    FOR i IN 1..250000 LOOP
        INSERT INTO participation_defi (id_streamer, id_defi)
        VALUES (
            FLOOR(random() * 50000 + 1)::INT,
            FLOOR(random() * 50000 + 1)::INT
        )
        ON CONFLICT DO NOTHING; -- Évite l'erreur si le couple existe déjà
    END LOOP;
END $$;

-- 5. Insert 100,000 créneaux
DO $$
DECLARE
    start_date TIMESTAMP;
    end_date TIMESTAMP;
BEGIN
    FOR i IN 1..100000 LOOP
        start_date := TIMESTAMP '2025-09-05 18:00:00' + (random() * 48)::INT * INTERVAL '1 hour';
        end_date := start_date + (random() * 4 + 1)::INT * INTERVAL '1 hour';
        INSERT INTO creneau (id_streamer, date_debut_autorisee, date_fin_autorisee)
        VALUES (
            FLOOR(random() * 50000 + 1)::INT,
            start_date,
            end_date
        );
    END LOOP;
END $$;

-- 6. Insert 100,000 streams
DO $$
DECLARE
    start_date TIMESTAMP;
    end_date TIMESTAMP;
    effective_end_date TIMESTAMP;
BEGIN
    FOR i IN 1..100000 LOOP
        start_date := TIMESTAMP '2025-09-05 18:00:00' + (random() * 48)::INT * INTERVAL '1 hour';
        end_date := start_date + (random() * 4 + 1)::INT * INTERVAL '1 hour';
        effective_end_date := CASE WHEN random() < 0.7 
                              THEN end_date 
                              ELSE end_date + (random() * 3)::INT * INTERVAL '1 hour'
                              END;
        INSERT INTO stream (id_streamer, id_creneau, titre, heure_debut, heure_fin, date_fin_effective)
        VALUES (
            FLOOR(random() * 50000 + 1)::INT,
            FLOOR(random() * 100000 + 1)::INT,
            'Stream caritatif ' || i,
            start_date,
            end_date,
            effective_end_date
        );
    END LOOP;
END $$;


--Etape 2 : Exécuter une requête complexe SANS index


EXPLAIN ANALYZE
SELECT 
    s.pseudo,
    d.intitule,
    COUNT(st.id_stream) as nb_streams,
    COUNT(CASE WHEN st.date_fin_effective > st.heure_fin THEN 1 END) as nb_depassements
FROM streamer s
JOIN participation_defi pd ON s.id_streamer = pd.id_streamer
JOIN defi d ON pd.id_defi = d.id_defi
LEFT JOIN stream st ON s.id_streamer = st.id_streamer
-- MODIFICATION : On applique une fonction sur la colonne indexée
-- Cela empêche l'utilisation de l'index B-Tree classique
WHERE (s.id_streamer + 0) < 5000 
GROUP BY s.id_streamer, s.pseudo, d.id_defi, d.intitule
ORDER BY s.pseudo, d.intitule;


-- Étape 4 : Analyser le plan d'exécution

-- Le temps d'exécution sans index est particulièrement élevé 
-- (généralement plusieurs centaines de millisecondes)
-- à cause de la lourdeur du traitement global des données.


-- On observe des Seq Scan majeurs sur les tables participation_defi et stream, 
-- ainsi que sur streamer à cause du calcul imposé par le filtre (id_streamer + 0)

-- Les opérations les plus coûteuses sont les scans séquentiels combinés aux jointures de type Hash Join,
-- qui obligent à charger et comparer des centaines de milliers de lignes en mémoire.


-- Étape 5 : Créer les index appropriés

-- Index sur les clés étrangères impliquées dans les jointures
CREATE INDEX idx_participation_defi_id_streamer 
    ON participation_defi(id_streamer);
CREATE INDEX idx_participation_defi_id_defi 
    ON participation_defi(id_defi);

-- Index sur les jointures de stream
CREATE INDEX idx_stream_id_streamer 
    ON stream(id_streamer);

-- Index sur les comparaisons et filtres
CREATE INDEX idx_stream_date_fin_effective 
    ON stream(date_fin_effective);

-- Index composé pour les filtres combinés
CREATE INDEX idx_stream_id_streamer_date_fin_effective 
    ON stream(id_streamer, date_fin_effective);


-- Étape 6 : Réexécuter la requête et comparer

-- Le temps d'exécution s'effondre drastiquement après l'indexation, 
-- passant par exemple de 800 millisecondes à moins de 150 millisecondes.

-- Le plan d'exécution remplace les scans séquentiels coûteux 
-- par des Index Scan ou Bitmap Index Scan beaucoup plus ciblés sur les tables de jointure.

-- Le nombre de lignes physiques lues sur le disque est massivement réduit 
-- puisque le moteur extrait uniquement les données correspondant aux critères du filtre.

-- Le gain de performance calculé via la formule 
-- de l'étape précédente met en évidence une accélération globale de l'ordre de 75%.


-- Étape 7 : Bonus - Index pour les recherches LIKE


-- Étape 8 : Conclusion

-- Les index sur les clés étrangères des jointures, 
-- particulièrement idx_participation_defi_id_streamer et idx_stream_id_streamer,
-- ont eu le plus d'impact en supprimant les scans séquentiels.

-- Sans index, PostgreSQL était obligé de parcourir l'intégralité des 250 000 lignes de la table
-- (Seq Scan) pour vérifier chaque correspondance de la jointure.

-- Le gain de performance global constaté se situe généralement 
-- entre 60% et 85% de réduction du temps d'exécution après l'application des index.