-- ============================================
-- Exercice 0 : [creation table de la base de données]
-- Réalisé par : [Fontaine Melvin]
-- Date : [18/05/2026]
-- ============================================

-- pour supprimer les contrainte supprimer juste une colonne et faire une update 
SET CONSTRAINTS ALL DEFERRED;
alter table creneau drop column date_debut_autorisee;
alter table creneau add column date_debut_autorisee TIMESTAMP NOT NULL;

-- Table Streamer contient les pseudo et url des chaines twitch présent au ZEvent. 
CREATE TABLE Streamer(
   id_streamer SERIAL,
   pseudo CHAR(50),
   url_twitch VARCHAR(50),
   PRIMARY KEY(id_streamer),
   UNIQUE(pseudo)
);

--Tableau contenant les créneaux de stream. 
CREATE TABLE Creneau(
   id_creneau SERIAL,
   date_debut_autorisee TIMESTAMP NOT NULL,
   date_fin_autorisee TIMESTAMP,
   id_streamer INT NOT NULL,
   PRIMARY KEY(id_creneau),
   FOREIGN KEY(id_streamer) REFERENCES Streamer(id_streamer)
);

--Table contenant les defis des streamers, un défis peut appartenir à un ou plusieur streamer. 
CREATE TABLE Defi(
   id_defi SERIAL,
   intitule VARCHAR(50),
   montant_palier DECIMAL(12,2),
   etat_validation BOOLEAN,
   PRIMARY KEY(id_defi)
);

--Table stream contenant les horaires des streams 
CREATE TABLE Stream(
   id_stream SERIAL,
   titre VARCHAR(50),
   heure_debut TIMESTAMP,
   heure_fin TIMESTAMP,
   date_fin_effective TIMESTAMP ,
   id_streamer INT ,
   id_creneau INT ,
   PRIMARY KEY(id_stream),
   FOREIGN KEY(id_streamer) REFERENCES Streamer(id_streamer),
   FOREIGN KEY(id_creneau) REFERENCES Creneau(id_creneau)
);

-- Table qui fait le lien entre les streamers et les defis 
CREATE TABLE participation_defi(
   id_streamer INT,
   id_defi INT,
   PRIMARY KEY(id_streamer, id_defi),
   FOREIGN KEY(id_streamer) REFERENCES Streamer(id_streamer),
   FOREIGN KEY(id_defi) REFERENCES Defi(id_defi)
);
