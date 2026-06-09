-- ============================================
-- Exercice 4 : [ Agrégations et statistiques ]
-- Réalisé par : [Fontaine Melvin]
-- Date : [01/06/2026]
-- ============================================




SELECT pseudo, COALESCE(COUNT(id_stream), 0) AS nombre_streams
FROM streamer
LEFT JOIN stream ON streamer.id_streamer = stream.id_streamer
GROUP BY pseudo
ORDER BY nombre_streams DESC;


SELECT etat_validation,
       SUM(montant_palier) AS montant_total_paliers
FROM Defi
GROUP BY etat_validation;


SELECT pseudo,
       COUNT(participation_defi.id_defi) AS nombre_defis
FROM Streamer
JOIN participation_defi
ON Streamer.id_streamer = participation_defi.id_streamer
GROUP BY pseudo
HAVING COUNT(participation_defi.id_defi) >= 2;


SELECT titre,
       EXTRACT(EPOCH FROM (Stream.heure_fin - Stream.heure_debut)) / 3600 AS duree_heures,
       AVG(EXTRACT(EPOCH FROM (Stream.heure_fin - Stream.heure_debut)) / 3600) OVER() AS duree_moyenne
FROM Stream;