--
-- Requêtes de test de la base de données TIFOSI
--

use tifosi;

----------------------------------------------------------------------
-- 1. la liste des noms des focaccias par ordre alphabétique croissant
----------------------------------------------------------------------

-- Selection de la colonne nom de la table focaccia dans table focaccia
SELECT nom_focaccia
FROM focaccia
-- Affichage par ordre croissant (ASC=ascending)
ORDER BY nom_focaccia ASC;

-- Résultat : 
--  nom_focaccia
--     Américaine
--     Emmentalacci
--     Gorgonzollaccia
--     Hawaienne
--     Mozaccia
--     Paysanne
--     Raclaccia
--     Tradizione


--------------------------------------------
-- 2. le nombre total d'ingrédients
--------------------------------------------

-- compte le nombre d'ingredient dans la table ingredient
SELECT COUNT(id_ingredient) AS total_ingredients
FROM ingredient;

-- Résultat:
-- total_ingredients :
--  25

------------------------------------------
-- 3. le prix moyen des focaccias
------------------------------------------

SELECT AVG(prix) AS prix_moyen
FROM focaccia;
--Résultat:
-- 10,375000


---------------------------------------------------------------------
-- 4.La liste des boissons avec leur marque, triée par nom de boisson
---------------------------------------------------------------------
-- Selectionn le nom de la boisson et le nom de sa marque
SELECT nom_boisson, nom_marque
-- commence par la table des boissons
FROM boisson
-- relie les boissons à leur marque 
JOIN marque
    -- relie les deux tables grace à l'identifiant de la marque
    ON boisson.id_marque = marque.id_marque

-- Résultat
--  nom_boisson             nom_marque
-- Coca-cola zéro               Coca-cola
-- Coca-cola original           Coca-cola
-- Fanta citron                 Coca-cola
-- Fanta orange                 Coca-cola
-- Capri-sun                    Coca-cola
-- Eau de source               Cristalline
-- Monster energy ultra gold     Monster
-- Monster energy ultra blue     Monster
-- Pepsi                         Pepsico
-- Pepsi Max Zéro                Pepsico
-- Lipton zéro citron            Pepsico
-- Lipton Peach                  Pepsico



-------------------------------------------------
-- 5. La liste des ingredients pour une Raclaccia
-------------------------------------------------
SELECT nom_ingredient
FROM ingredient 	
JOIN comprend  ON ingredient.id_ingredient= comprend.id_ingredient 
JOIN focaccia  ON comprend.id_focaccia= focaccia.id_focaccia
WHERE nom_focaccia='Raclaccia'


-- Résultat : 
--  nom_ingredient
--   Ail
--   Base Tomate
--   Champignon
--   Cresson
--   Parmesan
--   Poivre
--   Raclette


----------------------------------------------------------
-- 6. Le nom et nombre d'ingredients pour chaque focaccia
----------------------------------------------------------

SELECT focaccia.nom_focaccia,
       COUNT(comprend.id_ingredient) AS nombre_ingredients
FROM focaccia
-- Permet de garder toutes les focaccias, même sans ingrédient
LEFT JOIN comprend
    ON focaccia.id_focaccia = comprend.id_focaccia
GROUP BY focaccia.id_focaccia, focaccia.nom_focaccia

-- Résultat : 
-- nom_focaccia        nombre_ingredients
-- Mozaccia                    10
-- Gorgonzollaccia              8
-- Raclaccia                    7
-- Emmentalaccia                7
-- Tradizione                   9
-- Hawaienne                    9
-- Américaine                   8
-- Paysanne                     12

-----------------------------------------------------
-- 7.le nom de la focaccia qui a le plus d'ingrédients
-----------------------------------------------------

SELECT focaccia.nom_focaccia,
-- compte les ingredients de chaque focaccia
COUNT(comprend.id_ingredient) AS nombre_ingredients
FROM focaccia 
JOIN comprend  ON focaccia.id_focaccia = comprend.id_focaccia
-- regroupe les ingrédients par focaccia
GROUP BY focaccia.id_focaccia, focaccia.nom_focaccia
-- Affichage par ordre décroissant (DESC=descending) de la plus garnie à la moins garnie
ORDER BY nombre_ingredients DESC
-- Affiche que la premiere ligne qui a le plus d'ingredients
LIMIT 1;


-- Résultat : 
-- Focaccia:             Nombre d’ingrédients:
-- Paysanne                    12

-----------------------------------------------------
-- 8.la liste des focaccia qui contiennent de l'ail
-----------------------------------------------------
-- Evite d'afficher deux fois une focaccia
SELECT DISTINCT focaccia.nom_focaccia
FROM focaccia 
-- Relie les focaccias à leurs ingrédients
JOIN comprend  ON focaccia.id_focaccia = comprend.id_focaccia
JOIN ingredient  ON comprend.id_ingredient = ingredient.id_ingredient
-- garde uniquement l'ingredient AIL
WHERE ingredient.nom_ingredient = 'Ail'


-- Résultat :
-- nom_focaccia :
--   Mozaccia
--   Gorgonzollaccia
--   Raclaccia
--   Paysanne

----------------------------------------
-- 9.La liste des ingrédients inutilisés
----------------------------------------

SELECT nom_ingredient
FROM ingredient
-- conserve les ingredients dont l'id n'apparait pas dans la liste
WHERE id_ingredient NOT IN (
    -- Sous-requête qui récupère les id des ingredients utlisés dans 'comprend'
    SELECT id_ingredient
    FROM comprend
)

-- Résultat : 
-- nom_ingredient: 
--   Salami
--   Tomate cerise


--------------------------------------------------------
-- 10.La liste des focaccia qui n'ont pas de champignons
--------------------------------------------------------


SELECT nom_focaccia
FROM focaccia
-- exclut les focaccias qui contiennent des champignons
WHERE id_focaccia NOT IN (
    -- recherche les identifiants qui contiennent des champignons
    SELECT id_focaccia
    FROM comprend
    -- recherche l'identifiant de l ingredient champignon
    WHERE id_ingredient = (
        SELECT id_ingredient
        FROM ingredient
        WHERE nom_ingredient = 'Champignon'
    )
)


-- Résultat :
--  nom_focaccia :
--    Hawaienne
--    Américaine
