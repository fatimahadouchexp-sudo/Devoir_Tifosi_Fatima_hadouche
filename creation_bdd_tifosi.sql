--
-- Base de données : `tifosi`
--
CREATE DATABASE IF NOT EXISTS `tifosi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `tifosi`;





----------------------------------
-- 1. Création de la table `marque`
----------------------------------

CREATE TABLE `marque` (
  `id_marque` int(11) NOT NULL,
  `nom_marque` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Ajout de clé primaire pour la table `marque`
--
ALTER TABLE `marque`
  ADD PRIMARY KEY (`id_marque`);


--
-- Ici la propriété AUTO_INCREMENT est ajoutée à la colonne `id_marque` 
-- pour que les valeurs soient générées automatiquement lors de l'insertion de nouvelles lignes.
ALTER TABLE `marque`
  MODIFY `id_marque` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;





------------------------------------
-- 2. Création de la table `boisson`
------------------------------------

CREATE TABLE `boisson` (
  `id_boisson` int(11) NOT NULL,
  `nom_boisson` varchar(50) NOT NULL,
  `id_marque` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Ajout de clé primaire pour la table `boisson`
--
ALTER TABLE `boisson`
  ADD PRIMARY KEY (`id_boisson`),
  ADD KEY `ik_boisson_marque` (`id_marque`);

--
-- Ici la propriété AUTO_INCREMENT est ajoutée à la colonne `id_boisson` 
-- pour que les valeurs soient générées automatiquement lors de l'insertion de nouvelles lignes.
ALTER TABLE `boisson`
  MODIFY `id_boisson` int(11) NOT NULL AUTO_INCREMENT=13;

--
-- Ajout de clé étrangère pour la table `boisson`
--
ALTER TABLE `boisson`
  ADD CONSTRAINT `ik_boisson_marque` FOREIGN KEY (`id_marque`) REFERENCES `marque` (`id_marque`);




--------------------------------------
-- 3. Création de la table `ingredient`
--------------------------------------

CREATE TABLE `ingredient` (
  `id_ingredient` int(11) NOT NULL,
  `nom_ingredient` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Ajout de clé primaire pour la table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`id_ingredient`);


--
-- Ici la propriété AUTO_INCREMENT est ajoutée à la colonne `id_ingredient` 
-- pour que les valeurs soient générées automatiquement lors de l'insertion de nouvelles lignes.
--
ALTER TABLE `ingredient`
  MODIFY `id_ingredient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;



-------------------------------------
-- 4. Création de la table `focaccia`
-------------------------------------

CREATE TABLE `focaccia` (
  `id_focaccia` int(11) NOT NULL,
  `nom_focaccia` varchar(50) NOT NULL,
  `prix` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Ajout de clé primaire pour la table `focaccia`
--
ALTER TABLE `focaccia`
  ADD PRIMARY KEY (`id_focaccia`);


--
-- Ici la propriété AUTO_INCREMENT est ajoutée à la colonne `id_focaccia` 
-- pour que les valeurs soient générées automatiquement lors de l'insertion de nouvelles lignes.
--
ALTER TABLE `focaccia`
  MODIFY `id_focaccia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;


-------------------------------------
-- 5. Création de la table `comprend`
-------------------------------------

CREATE TABLE `comprend` (
  `id_focaccia` int(11) NOT NULL,
  `id_ingredient` int(11) NOT NULL,
  `quantite` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Ajout de clé primaire et clé étrangère pour la table `comprend`
--
ALTER TABLE `comprend`
  ADD PRIMARY KEY (`id_focaccia`,`id_ingredient`),
  ADD KEY `ik_comprend_ingredient` (`id_ingredient`);


--
-- Ajout de la clé primaire composée et d'un index
-- pour accélérer les recherches par ingrédient
--
ALTER TABLE `comprend`
  ADD CONSTRAINT `ik_comprend_focaccia` FOREIGN KEY (`id_focaccia`) REFERENCES `focaccia` (`id_focaccia`),
  ADD CONSTRAINT `ik_comprend_ingredient` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredient` (`id_ingredient`);



-------------------------------------
--  6. Création de la table `client`
-------------------------------------

CREATE TABLE `client` (
  `id_client` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `email` varchar(150) NOT NULL,
  `code_postal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Ajout de clé primaire pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`);


--
-- Ici la propriété AUTO_INCREMENT est ajoutée à la colonne `id_client` 
-- pour que les valeurs soient générées automatiquement lors de l'insertion de nouvelles lignes.
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT;




---------------------------------
-- 7. Création de la table `menu`
---------------------------------

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prix` decimal(5,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Ajout de clé primaire pour la table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Ici la propriété AUTO_INCREMENT est ajoutée à la colonne `id_menu` 
-- pour que les valeurs soient générées automatiquement lors de l'insertion de nouvelles lignes.
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT;



----------------------------------------
-- 8. Création de la table `menu_boisson`
----------------------------------------

CREATE TABLE `menu_boisson` (
  `id_menu` int(11) NOT NULL,
  `id_boisson` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci; 


--
-- Ajout de clé primaire et clé étrangère pour la table `menu_boisson`
--
ALTER TABLE `menu_boisson`
  ADD PRIMARY KEY (`id_menu`,`id_boisson`),
  ADD KEY `ik_menu_boisson_boisson` (`id_boisson`);

--
-- Ajout de la clé primaire composée et d'un index
-- sur la colonne id_boisson.
--
ALTER TABLE `menu_boisson`
  ADD CONSTRAINT `ik_menu_boisson_boisson` FOREIGN KEY (`id_boisson`) REFERENCES `boisson` (`id_boisson`),
  ADD CONSTRAINT `ik_menu_boisson_menu` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`);
COMMIT;
