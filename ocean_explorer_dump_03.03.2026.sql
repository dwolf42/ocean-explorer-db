-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server-Version:               12.1.2-MariaDB - MariaDB Server
-- Server-Betriebssystem:        Win64
-- HeidiSQL Version:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Exportiere Datenbank-Struktur für ocean_explorer
CREATE DATABASE IF NOT EXISTS `ocean_explorer` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_uca1400_ai_ci */;
USE `ocean_explorer`;

-- Exportiere Struktur von Tabelle ocean_explorer.radar_results
CREATE TABLE IF NOT EXISTS `radar_results` (
  `radar_resultID` int(11) NOT NULL AUTO_INCREMENT,
  `height` int(11) NOT NULL,
  `ground` varchar(100) DEFAULT NULL,
  `navigable` enum('Yes','No') DEFAULT 'Yes',
  PRIMARY KEY (`radar_resultID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.scan_results
CREATE TABLE IF NOT EXISTS `scan_results` (
  `scan_resultID` int(11) NOT NULL AUTO_INCREMENT,
  `total_depth_average` int(11) NOT NULL,
  `standard_deviation` double DEFAULT NULL,
  PRIMARY KEY (`scan_resultID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.sector
CREATE TABLE IF NOT EXISTS `sector` (
  `sectorID` int(11) NOT NULL AUTO_INCREMENT,
  `position_x` int(11) NOT NULL,
  `position_y` int(11) NOT NULL,
  PRIMARY KEY (`sectorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.ship
CREATE TABLE IF NOT EXISTS `ship` (
  `shipID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `typ` varchar(100) NOT NULL,
  `active` enum('Yes','No') DEFAULT 'Yes',
  PRIMARY KEY (`shipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.ship_radar_results
CREATE TABLE IF NOT EXISTS `ship_radar_results` (
  `ship_radar_resultID` int(11) NOT NULL AUTO_INCREMENT,
  `radar_resultID` int(11) NOT NULL,
  `sectorID` int(11) NOT NULL,
  `shipID` int(11) NOT NULL,
  PRIMARY KEY (`ship_radar_resultID`),
  KEY `radar_resultID` (`radar_resultID`),
  KEY `sectorID` (`sectorID`),
  KEY `shipID` (`shipID`),
  CONSTRAINT `1` FOREIGN KEY (`radar_resultID`) REFERENCES `radar_results` (`radar_resultID`),
  CONSTRAINT `2` FOREIGN KEY (`sectorID`) REFERENCES `sector` (`sectorID`),
  CONSTRAINT `3` FOREIGN KEY (`shipID`) REFERENCES `ship` (`shipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.ship_scan_results
CREATE TABLE IF NOT EXISTS `ship_scan_results` (
  `ship_scan_resultID` int(11) NOT NULL AUTO_INCREMENT,
  `scan_resultID` int(11) NOT NULL,
  `sectorID` int(11) NOT NULL,
  `shipID` int(11) NOT NULL,
  PRIMARY KEY (`ship_scan_resultID`),
  KEY `scan_resultID` (`scan_resultID`),
  KEY `sectorID` (`sectorID`),
  KEY `shipID` (`shipID`),
  CONSTRAINT `1` FOREIGN KEY (`scan_resultID`) REFERENCES `scan_results` (`scan_resultID`),
  CONSTRAINT `2` FOREIGN KEY (`sectorID`) REFERENCES `sector` (`sectorID`),
  CONSTRAINT `3` FOREIGN KEY (`shipID`) REFERENCES `ship` (`shipID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.submarine
CREATE TABLE IF NOT EXISTS `submarine` (
  `submarineID` int(11) NOT NULL AUTO_INCREMENT,
  `shipID` int(11) NOT NULL,
  `sink_positionID` int(11) DEFAULT NULL,
  `arise_positionID` int(11) DEFAULT NULL,
  `active` enum('Yes','No') DEFAULT 'Yes',
  `sunk` enum('Yes','No') DEFAULT 'No',
  PRIMARY KEY (`submarineID`),
  KEY `shipID` (`shipID`),
  KEY `sink_positionID` (`sink_positionID`),
  KEY `arise_positionID` (`arise_positionID`),
  CONSTRAINT `1` FOREIGN KEY (`shipID`) REFERENCES `ship` (`shipID`),
  CONSTRAINT `2` FOREIGN KEY (`sink_positionID`) REFERENCES `submarine_sink_position` (`sink_positionID`),
  CONSTRAINT `3` FOREIGN KEY (`arise_positionID`) REFERENCES `submarine_arise_position` (`arise_positionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.submarine_arise_position
CREATE TABLE IF NOT EXISTS `submarine_arise_position` (
  `arise_positionID` int(11) NOT NULL AUTO_INCREMENT,
  `position_x` int(11) NOT NULL,
  `position_y` int(11) NOT NULL,
  `position_z` int(11) NOT NULL,
  PRIMARY KEY (`arise_positionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.submarine_measurements
CREATE TABLE IF NOT EXISTS `submarine_measurements` (
  `depth_valuesID` int(11) NOT NULL AUTO_INCREMENT,
  `submarineID` int(11) NOT NULL,
  `sectorID` int(11) NOT NULL,
  `vec_x` int(11) NOT NULL,
  `vec_y` int(11) NOT NULL,
  `vec_z` int(11) NOT NULL,
  PRIMARY KEY (`depth_valuesID`),
  KEY `submarineID` (`submarineID`),
  KEY `sectorID` (`sectorID`),
  CONSTRAINT `1` FOREIGN KEY (`submarineID`) REFERENCES `submarine` (`submarineID`),
  CONSTRAINT `2` FOREIGN KEY (`sectorID`) REFERENCES `sector` (`sectorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

-- Exportiere Struktur von Tabelle ocean_explorer.submarine_sink_position
CREATE TABLE IF NOT EXISTS `submarine_sink_position` (
  `sink_positionID` int(11) NOT NULL AUTO_INCREMENT,
  `position_x` int(11) NOT NULL,
  `position_y` int(11) NOT NULL,
  `position_z` int(11) NOT NULL,
  PRIMARY KEY (`sink_positionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- Daten-Export vom Benutzer nicht ausgewählt

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
