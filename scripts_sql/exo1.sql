-- ============================================
-- Exercice 1 : [Population de la base de données]
-- Réalisé par : [Fontaine Melvin]
-- Date : [18/05/2026]
-- ============================================

-- Inserer dans la table Streamers 10 streamers 
INSERT INTO Streamer
(pseudo, url_twitch)
VALUES
('ZeratoR','https://www.twitch.tv/zerator'),
('AntoineDaniel','https://www.twitch.tv/antoinedaniel'),
('MisterMV','https://www.twitch.tv/mistermv'),
('Ultia','https://www.twitch.tv/ultia'),
('BagheraJones','https://www.twitch.tv/bagherajones'),
('Domingo','https://www.twitch.tv/domingo'),
('Ponce','https://www.twitch.tv/ponce'),
('JLTomy','https://www.twitch.tv/jltomy'),
('Kameto','https://www.twitch.tv/kameto'),
('Gotaga','https://www.twitch.tv/gotaga');



INSERT INTO Stream
(id_streamer, titre, heure_debut, heure_fin, date_fin_effective)
VALUES

--ZeratoR
(1, 'Soirée Speedrun', 
 '2025-09-05 20:00:00',
 '2025-09-05 23:00:00',
 '2025-09-05 22:54:12'),
 
 (1, 'Préparation ZEvent',
 '2025-09-07 15:00:00',
 '2025-09-07 18:00:00',
 '2025-09-07 17:43:50'),
 
 
--AntoineDaniel
(2, 'Discussion & Réactions',
 '2025-09-05 18:00:00',
 '2025-09-05 21:00:00',
 '2025-09-05 20:48:03'),

--MisterMV
(3, 'Découverte Roblox',
 '2025-09-05 21:00:00',
 '2025-09-06 00:00:00',
 NULL),

--Ultia
(4, 'Mk8',
 '2025-09-05 22:00:00',
 '2025-09-06 01:00:00',
 '2025-09-06 00:51:55'),

--BagheraJones
(5, 'Aventure Minecraft',
 '2025-09-06 14:00:00',
 '2025-09-06 17:00:00',
 '2025-09-06 16:42:18'),

--Domingo
(6, 'Talk Show du Samedi',
 '2025-09-06 19:00:00',
 '2025-09-06 22:00:00',
 NULL),

--Ponce
(7, 'Mk8',
 '2025-09-06 20:00:00',
 '2025-09-06 23:30:00',
 '2025-09-06 23:27:10'),

--JLTomy
(8, 'GTA 5 RP',
 '2025-09-06 16:00:00',
 '2025-09-06 19:00:00',
 '2025-09-06 18:55:41'),

--Kameto
(9, 'Analyse Esport',
 '2025-09-06 21:00:00',
 '2025-09-07 00:00:00',
 NULL),

--Gotaga
(10, 'J ai voulu faire top 1 sans l aide d aucun copain',
 '2025-09-06 22:00:00',
 '2025-09-07 01:00:00',
 '2025-09-07 00:58:09');
 
 
 
INSERT INTO Creneau
(id_creneau, date_debut_autorisee, date_fin_autorisee, id_streamer)
VALUES

-- ZeratoR
(1, '2025-09-05 19:00:00', '2025-09-05 23:59:00', 1),
(2, '2025-09-06 14:00:00', '2025-09-06 18:00:00', 1),
(3, '2025-09-07 15:00:00', '2025-09-07 20:00:00', 1),

-- AntoineDaniel
(4, '2025-09-05 17:00:00', '2025-09-05 22:00:00', 2),
(5, '2025-09-06 20:00:00', '2025-09-06 23:00:00', 2),
(6, '2025-09-07 16:00:00', '2025-09-07 19:00:00', 2),

-- MisterMV
(7, '2025-09-05 20:00:00', '2025-09-06 00:30:00', 3),
(8, '2025-09-06 15:00:00', '2025-09-06 18:00:00', 3),
(9, '2025-09-07 21:00:00', '2025-09-08 00:00:00', 3),

-- Ultia
(10, '2025-09-05 21:00:00', '2025-09-06 01:30:00', 4),
(11, '2025-09-06 10:00:00', '2025-09-06 13:00:00', 4),
(12, '2025-09-07 18:00:00', '2025-09-07 22:00:00', 4),

-- BagheraJones
(13, '2025-09-06 13:00:00', '2025-09-06 17:30:00', 5),
(14, '2025-09-07 14:00:00', '2025-09-07 18:00:00', 5),
(15, '2025-09-08 20:00:00', '2025-09-08 23:00:00', 5),

-- Domingo
(16, '2025-09-06 18:00:00', '2025-09-06 22:30:00', 6),
(17, '2025-09-07 11:00:00', '2025-09-07 14:00:00', 6),
(18, '2025-09-08 19:00:00', '2025-09-08 23:00:00', 6),

-- Ponce
(19, '2025-09-06 19:00:00', '2025-09-06 23:59:00', 7),
(20, '2025-09-07 15:00:00', '2025-09-07 18:00:00', 7),
(21, '2025-09-08 21:00:00', '2025-09-09 00:00:00', 7),

-- JLTomy
(22, '2025-09-06 15:00:00', '2025-09-06 19:30:00', 8),
(23, '2025-09-07 20:00:00', '2025-09-07 23:00:00', 8),
(24, '2025-09-08 14:00:00', '2025-09-08 17:00:00', 8),

-- Kameto
(25, '2025-09-06 20:00:00', '2025-09-07 00:30:00', 9),
(26, '2025-09-07 17:00:00', '2025-09-07 21:00:00', 9),
(27, '2025-09-08 19:00:00', '2025-09-08 23:59:00', 9),

-- Gotaga
(28, '2025-09-06 21:00:00', '2025-09-07 01:30:00', 10),
(29, '2025-09-07 13:00:00', '2025-09-07 16:00:00', 10),
(30, '2025-09-08 20:00:00', '2025-09-08 23:30:00', 10);


INSERT INTO Defi
(id_defi, intitule, montant_palier, etat_validation)
VALUES

(1, 'Jeu d''horreur dans le noir', 500.00, TRUE),

(2, 'Cosplay imposé par le chat', 1000.00, TRUE),

(3, '24h de stream sans pause', 2500.00, FALSE),

(4, 'Teinture de cheveux en direct', 5000.00, TRUE),

(5, 'Tournoi Mario Kart avec abonnés', 10000.00, TRUE),

(6, 'Dégustation de nourriture extrême', 15000.00, FALSE),

(7, 'Challenge danse TikTok', 25000.00, TRUE),

(8, 'Live IRL dans une ville choisie par le chat', 50000.00, FALSE),

(9, 'Saut en parachute', 75000.00, FALSE),

(10, 'Concert caritatif en live', 100000.00, FALSE);


INSERT INTO Participation_Defi
(id_streamer, id_defi)
VALUES

-- Défis solo
(1, 1),   
(2, 2),   
(3, 3),   
(4, 4),   
(5, 5),   

-- Défis en groupe
(1, 7),   
(2, 7),   
(4, 7),   

(3, 8),   
(5, 8),   
(7, 8),   

(1, 9),   
(6, 9),   
(10, 9), 

(2, 10), 
(8, 10),  
(9, 10),  
(10, 10); 