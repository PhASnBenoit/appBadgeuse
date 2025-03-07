-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 23, 2024 at 03:42 PM
-- Server version: 10.11.9-MariaDB
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bdd_badgeuse`
--

-- --------------------------------------------------------

--
-- Table structure for table `badgesNotAffected`
--

CREATE TABLE `badgesNotAffected` (
  `id_badgesNotAffected` int(11) NOT NULL,
  `tag_rfid` varchar(15) NOT NULL,
  `date` datetime NOT NULL COMMENT 'Découverte du badge'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `badgesNotAffected`
--

INSERT INTO `badgesNotAffected` (`id_badgesNotAffected`, `tag_rfid`, `date`) VALUES
(1, 'ce1a58c3', '2024-12-23 13:06:43');

-- --------------------------------------------------------

--
-- Table structure for table `etudiants`
--

CREATE TABLE `etudiants` (
  `id_etudiants` int(11) NOT NULL,
  `id_rfid` varchar(15) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `etudiants`
--

INSERT INTO `etudiants` (`id_etudiants`, `id_rfid`, `nom`, `prenom`) VALUES
(1, '806f8f1c', 'ANTOINE', 'Philippe');

-- --------------------------------------------------------

--
-- Table structure for table `presences`
--

CREATE TABLE `presences` (
  `id_presences` int(11) NOT NULL,
  `id_rfid` varchar(15) NOT NULL,
  `date_deb` datetime NOT NULL,
  `date_fin` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `presences`
--

INSERT INTO `presences` (`id_presences`, `id_rfid`, `date_deb`, `date_fin`) VALUES
(6, '806f8f1c', '2024-12-22 11:53:33', '2024-12-22 11:53:38'),
(8, '806f8f1c', '2024-12-22 15:37:15', '2024-12-22 15:38:01'),
(9, '806f8f1c', '2024-12-22 15:38:23', '2024-12-22 15:39:10'),
(10, '806f8f1c', '2024-12-22 15:39:43', '2024-12-22 15:40:49'),
(11, '806f8f1c', '2024-12-22 15:41:23', '2024-12-22 15:42:36'),
(12, '806f8f1c', '2024-12-22 15:45:39', '2024-12-22 15:46:41'),
(13, '806f8f1c', '2024-12-22 16:41:01', '2024-12-22 16:50:57'),
(14, '806f8f1c', '2024-12-22 16:56:16', '2024-12-22 16:58:57'),
(15, '806f8f1c', '2024-12-22 17:00:07', '2024-12-22 17:01:17'),
(16, '806f8f1c', '2024-12-22 17:03:43', '2024-12-22 17:05:35'),
(17, '806f8f1c', '2024-12-22 17:05:42', '2024-12-22 17:25:21'),
(18, '806f8f1c', '2024-12-22 18:20:19', '2024-12-22 18:00:00'),
(19, '806f8f1c', '2024-12-22 18:38:28', '2024-12-22 18:43:23'),
(20, '806f8f1c', '2024-12-22 18:43:54', '2024-12-22 18:44:17'),
(21, '806f8f1c', '2024-12-23 13:03:06', '2024-12-23 13:05:37'),
(22, '806f8f1c', '2024-12-23 13:10:52', '2024-12-23 14:05:42'),
(24, '806f8f1c', '2024-12-23 14:16:56', '2024-12-23 15:53:56'),
(25, '806f8f1c', '2024-12-23 15:55:30', '2024-12-23 15:59:47'),
(26, '806f8f1c', '2024-12-23 15:59:56', '2024-12-23 16:39:04'),
(27, '806f8f1c', '2024-12-23 16:39:35', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `profs`
--

CREATE TABLE `profs` (
  `id_profs` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `info` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `passe` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;

--
-- Dumping data for table `profs`
--

INSERT INTO `profs` (`id_profs`, `nom`, `prenom`, `info`, `login`, `passe`) VALUES
(1, 'ANTOINE', 'Philippe', '', 'antoine', 'd033e22ae348aeb5660fc2140aec35850c4da997');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `badgesNotAffected`
--
ALTER TABLE `badgesNotAffected`
  ADD PRIMARY KEY (`id_badgesNotAffected`);

--
-- Indexes for table `etudiants`
--
ALTER TABLE `etudiants`
  ADD PRIMARY KEY (`id_etudiants`);

--
-- Indexes for table `presences`
--
ALTER TABLE `presences`
  ADD PRIMARY KEY (`id_presences`);

--
-- Indexes for table `profs`
--
ALTER TABLE `profs`
  ADD PRIMARY KEY (`id_profs`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `badgesNotAffected`
--
ALTER TABLE `badgesNotAffected`
  MODIFY `id_badgesNotAffected` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `etudiants`
--
ALTER TABLE `etudiants`
  MODIFY `id_etudiants` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `presences`
--
ALTER TABLE `presences`
  MODIFY `id_presences` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `profs`
--
ALTER TABLE `profs`
  MODIFY `id_profs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
