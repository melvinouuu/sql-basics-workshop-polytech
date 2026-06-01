-- ============================================
-- Exercice 6 : [ Requêtes avancées sur les données existantes ]
-- Réalisé par : [Fontaine Melvin]
-- Date : [01/06/2026]
-- ============================================

SELECT pseudo,
       COUNT(participation_defi.id_defi) AS nombre_defis
FROM Streamer
JOIN participation_defi
ON Streamer.id_streamer = participation_defi.id_streamer
GROUP BY pseudo
HAVING COUNT(participation_defi.id_defi) >= 1;


SELECT intitule,montant_palier
FROM Defi
LEFT JOIN participation_defi
ON Defi.id_defi = participation_defi.id_defi
WHERE participation_defi.id_defi IS NULL;


SELECT intitule,montant_palier,
       COALESCE(COUNT(participation_defi.id_streamer), 0) AS nombre_participants
FROM Defi
JOIN participation_defi
ON Defi.id_defi = participation_defi.id_defi
GROUP BY Defi.id_defi, Defi.intitule, Defi.montant_palier
HAVING COUNT(participation_defi.id_streamer) > 2;


SELECT pseudo,
       COUNT(participation_defi.id_defi) AS nombre_defis,
       SUM(Defi.montant_palier) AS montant_total
FROM Streamer
JOIN participation_defi
ON Streamer.id_streamer = participation_defi.id_streamer
JOIN Defi
ON participation_defi.id_defi = Defi.id_defi
GROUP BY Streamer.id_streamer, Streamer.pseudo
ORDER BY montant_total DESC;


SELECT pseudo,
       Creneau.date_debut_autorisee,
       COUNT(Stream.id_stream) AS nombre_streams
FROM Streamer
JOIN Creneau
ON Streamer.id_streamer = Creneau.id_streamer
LEFT JOIN Stream
ON Creneau.id_creneau = Stream.id_creneau
GROUP BY Streamer.pseudo, Creneau.date_debut_autorisee
ORDER BY Streamer.pseudo, Creneau.date_debut_autorisee;