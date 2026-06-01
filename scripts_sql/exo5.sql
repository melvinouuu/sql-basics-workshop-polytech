-- ============================================
-- Exercice 5 : [ Mises à jour (UPDATE) et suppressions (DELETE) ]
-- Réalisé par : [Fontaine Melvin]
-- Date : [01/06/2026]
-- ============================================

UPDATE Defi
SET montant_palier = montant_palier * 1.10
WHERE intitule = 'Saut en parachute';



pour verif avant 

SELECT *
FROM Stream
WHERE date_fin_effective IS NULL;

DELETE FROM Stream
WHERE date_fin_effective IS NULL;




verif 
SELECT *
FROM Creneau
WHERE date_fin_autorisee < CURRENT_DATE;

DELETE FROM Creneau
WHERE date_fin_autorisee < CURRENT_DATE;


ERROR:  Key (id_creneau)=(2) is still referenced from table "stream".update or delete on table "creneau" violates foreign key constraint "stream_id_creneau_fkey" on table "stream" 

ERROR:  update or delete on table "creneau" violates foreign key constraint "stream_id_creneau_fkey" on table "stream"
SQL state: 23503
Detail: Key (id_creneau)=(2) is still referenced from table "stream".

solution :
voir les concernés

SELECT *
FROM Stream
WHERE id_creneau IN (
    SELECT id_creneau
    FROM Creneau
    WHERE date_fin_autorisee < CURRENT_DATE
);

suppr ’abord les streams liés
DELETE FROM Stream
WHERE id_creneau IN (
    SELECT id_creneau
    FROM Creneau
    WHERE date_fin_autorisee < CURRENT_DATE
);

suppr les creneaux 
DELETE FROM Creneau
WHERE date_fin_autorisee < CURRENT_DATE;


