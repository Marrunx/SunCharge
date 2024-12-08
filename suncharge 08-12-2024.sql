-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 08, 2024 at 03:19 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

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
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(18) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(0, 'admin', 'admin123');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_card`
--

CREATE TABLE `tbl_card` (
  `locker_number` int(11) NOT NULL,
  `card_number` int(11) NOT NULL,
  `card_uid` varchar(10) DEFAULT NULL,
  `locker_status` varchar(10) NOT NULL,
  `used_by` varchar(50) DEFAULT NULL,
  `date_rented` date DEFAULT NULL,
  `date_expired` date DEFAULT NULL,
  `section` varchar(10) DEFAULT NULL,
  `card_balance` int(11) NOT NULL,
  `coinslot_balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_card`
--

INSERT INTO `tbl_card` (`locker_number`, `card_number`, `card_uid`, `locker_status`, `used_by`, `date_rented`, `date_expired`, `section`, `card_balance`, `coinslot_balance`) VALUES
(1, 1, '437939bb', 'Rented', 'Ian', '2024-12-08', '2025-01-07', 'BSIT', 0, 0),
(2, 0, '', 'Free', '', '0000-00-00', '0000-00-00', '', 0, 0),
(3, 0, '', 'Free', '', '0000-00-00', '0000-00-00', '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_cardarchive`
--

CREATE TABLE `tbl_cardarchive` (
  `card_number` int(11) NOT NULL,
  `date_archived` date NOT NULL,
  `card_uid` varchar(20) NOT NULL,
  `status` varchar(25) NOT NULL,
  `used_by` varchar(50) NOT NULL,
  `section` varchar(10) NOT NULL,
  `date_taken` date NOT NULL,
  `locker_number` int(11) NOT NULL,
  `balance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, '437939bb', 'Used', 'Ian', 'BSIT', '2024-12-08', 1, 0),
(2, '49c8b779', 'Used', 'Marlon', 'BSIT', '2024-12-08', NULL, 20);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_log`
--

CREATE TABLE `tbl_log` (
  `action_id` int(11) NOT NULL,
  `card_uid` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `description` varchar(255) NOT NULL,
  `action` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_log`
--

INSERT INTO `tbl_log` (`action_id`, `card_uid`, `date`, `time`, `description`, `action`) VALUES
(36, '49C8B779', '2024-12-08', '22:17:12', 'Access Denied', ''),
(37, '437939BB', '2024-12-08', '22:18:28', 'Access Granted', ''),
(38, '437939BB', '2024-12-08', '22:18:28', 'No Balance - Access Denied', ''),
(39, '49C8B779', '2024-12-08', '22:18:40', 'Access Denied', ''),
(40, '437939BB', '2024-12-08', '22:18:51', 'Access Granted', ''),
(41, '437939BB', '2024-12-08', '22:18:51', 'No Balance - Access Denied', '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sales`
--

CREATE TABLE `tbl_sales` (
  `transaction_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `locker_number` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_sales`
--

INSERT INTO `tbl_sales` (`transaction_id`, `date`, `time`, `locker_number`, `name`, `amount`) VALUES
(1, '2024-12-08', '15:08:38', 2, 'Open', 1),
(2, '2024-12-08', '15:09:21', 1, 'Ian', 1),
(3, '2024-12-08', '15:09:31', 1, 'Ian', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_card`
--
ALTER TABLE `tbl_card`
  ADD PRIMARY KEY (`locker_number`);

--
-- Indexes for table `tbl_cardarchive`
--
ALTER TABLE `tbl_cardarchive`
  ADD PRIMARY KEY (`card_number`);

--
-- Indexes for table `tbl_cardext`
--
ALTER TABLE `tbl_cardext`
  ADD PRIMARY KEY (`card_number`);

--
-- Indexes for table `tbl_log`
--
ALTER TABLE `tbl_log`
  ADD PRIMARY KEY (`action_id`);

--
-- Indexes for table `tbl_sales`
--
ALTER TABLE `tbl_sales`
  ADD PRIMARY KEY (`transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_card`
--
ALTER TABLE `tbl_card`
  MODIFY `locker_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbl_cardext`
--
ALTER TABLE `tbl_cardext`
  MODIFY `card_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_log`
--
ALTER TABLE `tbl_log`
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `tbl_sales`
--
ALTER TABLE `tbl_sales`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
