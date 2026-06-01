-- ============================================
-- Exercice 3 : [ Requêtes de jointure simples]
-- Réalisé par : [Fontaine Melvin]
-- Date : [01/06/2026]
-- ============================================


SELECT pseudo, date_debut_autorisee
FROM Streamer
JOIN Creneau
ON Streamer.id_streamer = Creneau.id_streamer
ORDER BY pseudo, date_debut_autorisee;


SELECT titre, pseudo, date_debut_autorisee
FROM Stream
JOIN Streamer
ON Stream.id_streamer = Streamer.id_streamer
JOIN Creneau
ON Stream.id_creneau = Creneau.id_creneau
WHERE DATE(date_debut_autorisee) = '2025-09-05'
   OR DATE(date_debut_autorisee) = '2025-09-06';

-- probleme car id stream existe pas dans creneau 




SELECT intitule,pseudo,montant_palier
FROM participation_defi
JOIN Defi
ON participation_defi.id_defi = Defi.id_defi
JOIN Streamer
ON participation_defi.id_streamer = Streamer.id_streamer;



