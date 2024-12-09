-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2024 at 10:40 AM
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
(1, 1, '437939bb', 'Rented', 'Santarin', '2024-12-09', '2025-01-08', 'BSIT-4D', 0, 0),
(2, 2, '49c8b779', 'Rented', 'Marlon', '2024-12-09', '2025-01-08', 'BSIT-4D', 0, 0),
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
(1, '437939bb', 'Used', 'Santarin', 'BSIT-4D', '2024-12-09', 1, 0),
(2, '49c8b779', 'Used', 'Marlon', 'BSIT-4D', '2024-12-09', 2, 20);

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
(41, '437939BB', '2024-12-08', '22:18:51', 'No Balance - Access Denied', ''),
(42, '437939BB', '2024-12-09', '04:08:35', 'Access Granted', ''),
(43, '437939BB', '2024-12-09', '04:08:35', 'No Balance - Access Denied', ''),
(44, '', '2024-12-09', '04:08:41', 'Administrator has removed Ian and Card 1 from Locker Number 1', 'Return'),
(45, '49C8B779', '2024-12-09', '04:08:46', 'Access Denied', ''),
(46, '437939BB', '2024-12-09', '04:10:25', 'Access Denied', ''),
(47, '437939BB', '2024-12-09', '04:10:32', 'Access Denied', ''),
(48, '', '2024-12-09', '04:10:56', ' has rented locker number 1', 'Rent'),
(49, '', '2024-12-09', '04:11:08', ' has rented locker number 1', 'Rent'),
(50, '', '2024-12-09', '04:11:23', ' has rented locker number 1', 'Rent'),
(51, '', '2024-12-09', '04:11:36', 'Marlon has rented locker number 1', 'Rent'),
(52, '437939BB', '2024-12-09', '04:11:54', 'Access Granted', ''),
(53, '', '2024-12-09', '04:12:38', ' has rented locker number 2', 'Rent'),
(54, '49C8B779', '2024-12-09', '04:13:09', 'Access Granted', ''),
(55, '', '2024-12-09', '04:13:30', 'Eldrin has rented locker number 2', 'Rent'),
(56, '49C8B779', '2024-12-09', '04:17:16', 'Access Granted', ''),
(57, '49C8B779', '2024-12-09', '04:17:45', 'Access Granted', ''),
(58, '49C8B779', '2024-12-09', '04:18:27', 'Access Granted', ''),
(59, '49C8B779', '2024-12-09', '04:18:28', 'No Balance - Access Denied', ''),
(60, '437939BB', '2024-12-09', '04:18:47', 'Access Granted', ''),
(61, '49C8B779', '2024-12-09', '04:19:02', 'Access Granted', ''),
(62, '49C8B779', '2024-12-09', '04:19:03', 'No Balance - Access Denied', ''),
(63, '49C8B779', '2024-12-09', '04:19:17', 'Access Granted', ''),
(64, '49C8B779', '2024-12-09', '04:20:14', 'Access Denied', ''),
(65, '', '2024-12-09', '04:20:29', 'Administrator has removed Eldrin and Card 2 from Locker Number 2', 'Return'),
(66, '', '2024-12-09', '04:21:43', 'Eldrin has rented locker number 2', 'Rent'),
(67, '', '2024-12-09', '04:22:37', 'Administrator has removed Eldrin and Card 2 from Locker Number 2', 'Return'),
(68, '', '2024-12-09', '04:22:45', 'Marlon has rented locker number 2', 'Rent'),
(69, '', '2024-12-09', '04:22:51', 'Administrator has removed Marlon and Card 1 from Locker Number 2', 'Return'),
(70, '', '2024-12-09', '04:23:22', 'Administrator has removed Marlon and Card 1 from Locker Number 1', 'Return'),
(71, '', '2024-12-09', '04:24:35', ' has rented locker number 2', 'Rent'),
(72, '', '2024-12-09', '04:27:44', 'Marlon has rented locker number 2', 'Rent'),
(73, '', '2024-12-09', '04:28:45', 'Administrator has removed Marlon and Card 2 from Locker Number 2', 'Return'),
(74, '', '2024-12-09', '04:29:35', 'Marlon has rented locker number 2', 'Rent'),
(75, '', '2024-12-09', '04:29:52', 'Administrator has removed Marlon and Card 2 from Locker Number 2', 'Return'),
(76, '', '2024-12-09', '04:30:13', 'Marlon has rented locker number 2', 'Rent'),
(77, '', '2024-12-09', '16:38:16', 'Administrator has removed Marlon and Card 2 from Locker Number 2', 'Return'),
(78, '', '2024-12-09', '16:38:41', 'Marlon has rented locker number 2', 'Rent'),
(79, '', '2024-12-09', '16:43:01', 'Administrator has removed Marlon and Card 2 from Locker Number 2', 'Return'),
(80, '', '2024-12-09', '16:43:13', 'Marlon has rented locker number 1', 'Rent'),
(81, '', '2024-12-09', '16:43:22', ' has rented locker number 2', 'Rent'),
(82, '', '2024-12-09', '16:43:41', 'Administrator has removed Marlon and Card 2 from Locker Number 1', 'Return'),
(83, '', '2024-12-09', '16:43:48', 'Marlon has rented locker number 3', 'Rent'),
(84, '', '2024-12-09', '17:21:32', 'Administrator has removed Marlon and Card 2 from Locker Number 3', 'Return'),
(85, '49C8B779', '2024-12-09', '17:21:44', 'Access Denied', ''),
(86, '49C8B779', '2024-12-09', '17:21:45', 'Access Denied', ''),
(87, '49C8B779', '2024-12-09', '17:21:46', 'Access Denied', ''),
(88, '49C8B779', '2024-12-09', '17:21:48', 'Access Denied', ''),
(89, '49C8B779', '2024-12-09', '17:21:51', 'Access Denied', ''),
(90, '', '2024-12-09', '17:22:30', 'Santarin has rented locker number 1', 'Rent'),
(91, '', '2024-12-09', '17:23:10', 'Marlon has rented locker number 2', 'Rent'),
(92, '437939BB', '2024-12-09', '17:23:27', 'Access Granted', ''),
(93, '49C8B779', '2024-12-09', '17:23:36', 'Access Denied', ''),
(94, '49C8B779', '2024-12-09', '17:23:46', 'Access Denied', '');

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
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `tbl_sales`
--
ALTER TABLE `tbl_sales`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
