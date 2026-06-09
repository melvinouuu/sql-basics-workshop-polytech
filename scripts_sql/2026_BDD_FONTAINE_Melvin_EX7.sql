-- ============================================
-- Exercice 7 : [ Gestion des validations avec CASE et contraintes ]
-- Réalisé par : [Fontaine Melvin]
-- Date : [01/06/2026]
-- ============================================


SELECT titre, pseudo, date_debut_autorisee, date_fin_autorisee, heure_debut, heure_fin,
       CASE
           WHEN Stream.heure_debut >= Creneau.date_debut_autorisee
            AND Stream.heure_fin <= Creneau.date_fin_autorisee
           THEN 'VALIDE'
           ELSE 'INVALIDE'
       END AS validation
FROM Stream
JOIN Streamer
ON Stream.id_streamer = Streamer.id_streamer
JOIN Creneau
ON Stream.id_creneau = Creneau.id_creneau;


SELECT Stream.titre,
       Streamer.pseudo,
       Creneau.date_debut_autorisee,
       Creneau.date_fin_autorisee,
       Stream.heure_debut,
       Stream.heure_fin
FROM Stream
JOIN Streamer
ON Stream.id_streamer = Streamer.id_streamer
JOIN Creneau
ON Stream.id_creneau = Creneau.id_creneau
WHERE Stream.heure_debut < Creneau.date_debut_autorisee
   OR Stream.heure_fin > Creneau.date_fin_autorisee;
   
   
SELECT titre,pseudo,heure_fin,date_fin_effective,
   CASE
	   WHEN Stream.date_fin_effective IS NULL
			OR Stream.date_fin_effective <= Stream.heure_fin
	   THEN 'OK'
	   ELSE 'DEPASSEMENT'
   END AS statut,
   CASE
	   WHEN Stream.date_fin_effective > Stream.heure_fin
	   THEN EXTRACT(EPOCH FROM (Stream.date_fin_effective - Stream.heure_fin)) / 60
	   ELSE 0
   END AS duree_depassement_minutes
FROM Stream
JOIN Streamer
ON Stream.id_streamer = Streamer.id_streamer;


SELECT 
    COUNT(*) AS nombre_streams_en_retard,
    AVG(EXTRACT(EPOCH FROM (date_fin_effective - heure_fin)) / 60) AS duree_moyenne_retard_minutes
FROM Stream
WHERE date_fin_effective > heure_fin;