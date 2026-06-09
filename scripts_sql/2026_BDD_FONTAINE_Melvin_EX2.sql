-- ============================================
-- Exercice 2 : [ Requêtes SELECT simples et filtrées]
-- Réalisé par : [Fontaine Melvin]
-- Date : [18/05/2026]
-- ============================================


SELECT pseudo, url_twitch
FROM Streamer
ORDER BY pseudo ASC;


SELECT *
FROM Creneau
WHERE DATE(date_debut_autorisee) = '2025-09-06';


SELECT *
FROM Defi
WHERE etat_validation = TRUE
AND montant_palier > 5000.00;


SELECT *
FROM Stream
WHERE date_fin_effective IS NULL;