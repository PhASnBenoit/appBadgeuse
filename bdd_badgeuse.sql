-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 11 mars 2025 à 15:43
-- Version du serveur :  10.2.36-MariaDB
-- Version de PHP : 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `bdd_badgeuse`
--

-- --------------------------------------------------------

--
-- Structure de la table `badgesNotAffected`
--

CREATE TABLE `badgesNotAffected` (
  `id_badgesNotAffected` int(11) NOT NULL,
  `tag_rfid` varchar(15) NOT NULL,
  `date` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `etudiants`
--

CREATE TABLE `etudiants` (
  `id_etudiants` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `tag_rfid` varchar(8) NOT NULL COMMENT 'tag badge'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `etudiants`
--

INSERT INTO `etudiants` (`id_etudiants`, `nom`, `prenom`, `tag_rfid`) VALUES
(1, 'GOUIN', 'Ivan', 'ce1a58c3'),
(2, 'BUSSI', 'Guilhem', 'f1ee8f49'),
(3, 'BOUFFLET', 'Mathias', 'a1fc8f49'),
(4, 'VOLLE', 'Clément', 'd1fa8f49'),
(5, 'AMADORI', 'Johann', 'e1f88f49'),
(6, 'PELAT', 'Thomas', 'f1f68f49'),
(7, 'BAHASSOU', 'Moncef', 'd1fe9449'),
(8, 'BA', 'Issa', 'd1029049'),
(9, 'ZAPOLOWSKI', 'Yannis', 'e1009049'),
(10, 'SCHERRER', 'Kévin', 'f1fe8f49');

-- --------------------------------------------------------

--
-- Structure de la table `logins`
--

CREATE TABLE `logins` (
  `id_logins` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `mdp` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `logins`
--

INSERT INTO `logins` (`id_logins`, `login`, `mdp`) VALUES
(1, 'antoine', 'd033e22ae348aeb5660fc2140aec35850c4da997');

-- --------------------------------------------------------

--
-- Structure de la table `presences`
--

CREATE TABLE `presences` (
  `id_presences` int(11) NOT NULL,
  `id_etudiants` int(11) NOT NULL,
  `date_deb` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_fin` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_users` int(11) NOT NULL,
  `id_logins` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_users`, `id_logins`, `nom`, `prenom`) VALUES
(1, 1, 'ANTOINE', 'Philippe');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `badgesNotAffected`
--
ALTER TABLE `badgesNotAffected`
  ADD PRIMARY KEY (`id_badgesNotAffected`);

--
-- Index pour la table `etudiants`
--
ALTER TABLE `etudiants`
  ADD PRIMARY KEY (`id_etudiants`);

--
-- Index pour la table `logins`
--
ALTER TABLE `logins`
  ADD PRIMARY KEY (`id_logins`);

--
-- Index pour la table `presences`
--
ALTER TABLE `presences`
  ADD PRIMARY KEY (`id_presences`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `badgesNotAffected`
--
ALTER TABLE `badgesNotAffected`
  MODIFY `id_badgesNotAffected` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT pour la table `etudiants`
--
ALTER TABLE `etudiants`
  MODIFY `id_etudiants` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `logins`
--
ALTER TABLE `logins`
  MODIFY `id_logins` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `presences`
--
ALTER TABLE `presences`
  MODIFY `id_presences` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
