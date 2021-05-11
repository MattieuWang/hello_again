-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 11, 2021 at 07:33 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blacklist`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `addlist`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addlist` ()  NO SQL
    DETERMINISTIC
INSERT INTO blacklist(ip)
SELECT ip FROM ip_lists WHERE count>1 
GROUP BY ip$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE IF NOT EXISTS `blacklist` (
  `ip` varchar(100) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_munual` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `blacklist`
--

INSERT INTO `blacklist` (`ip`, `updated_at`, `is_munual`) VALUES
('192.179.0.0', '2021-05-09 15:15:45', 1);

-- --------------------------------------------------------

--
-- Table structure for table `ip_lists`
--

DROP TABLE IF EXISTS `ip_lists`;
CREATE TABLE IF NOT EXISTS `ip_lists` (
  `ip` varchar(100) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `count` int(10) UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DELIMITER $$
--
-- Events
--
DROP EVENT `RESTART_Ip_Lists`$$
CREATE DEFINER=`root`@`localhost` EVENT `RESTART_Ip_Lists` ON SCHEDULE EVERY 1 MINUTE STARTS '2021-05-09 16:45:35' ENDS '2021-06-30 00:00:54' ON COMPLETION PRESERVE ENABLE DO TRUNCATE TABLE ip_lists$$

DROP EVENT `RESTART_blacklist`$$
CREATE DEFINER=`root`@`localhost` EVENT `RESTART_blacklist` ON SCHEDULE EVERY 10 MINUTE STARTS '2021-05-09 17:00:00' ENDS '2021-06-30 00:00:28' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM blacklist
where is_munual='0'$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
