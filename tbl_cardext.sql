-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2024 at 12:51 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `suncharge`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cardext`
--

CREATE TABLE `tbl_cardext` (
  `card_number` int(11) NOT NULL,
  `card_uid` varchar(20) NOT NULL,
  `status` varchar(25) NOT NULL,
  `used_by` varchar(50) DEFAULT NULL,
  `section` varchar(10) DEFAULT NULL,
  `date_taken` date DEFAULT NULL,
  `locker_number` int(255) DEFAULT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_cardext`
--

INSERT INTO `tbl_cardext` (`card_number`, `card_uid`, `status`, `used_by`, `section`, `date_taken`, `locker_number`, `balance`) VALUES
(9, '102983', 'Unused', NULL, NULL, NULL, NULL, 1),
(10, '123123123', 'Used', 'Ian', 'BSIT-4D', '2024-12-07', NULL, 20),
(11, '123', 'Unused', NULL, NULL, NULL, NULL, 0),
(12, '12123', 'Unused', NULL, NULL, NULL, NULL, 0),
(13, '12399', 'Unused', NULL, NULL, NULL, NULL, 0),
(14, 'ABCDEFG', 'Used', 'MARLON', 'BSIT-4D', '2024-12-07', NULL, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_cardext`
--
ALTER TABLE `tbl_cardext`
  ADD PRIMARY KEY (`card_number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_cardext`
--
ALTER TABLE `tbl_cardext`
  MODIFY `card_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
