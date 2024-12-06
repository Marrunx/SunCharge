-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 06, 2024 at 11:18 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
  `card_number` int(5) NOT NULL,
  `card_uid` varchar(20) NOT NULL,
  `used_by` varchar(50) DEFAULT NULL,
  `section` varchar(11) DEFAULT NULL,
  `time_taken` datetime DEFAULT current_timestamp(),
  `locker_number` varchar(11) NOT NULL,
  `card_balance` int(255) NOT NULL,
  `coinslot_balance` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_card`
--

INSERT INTO `tbl_card` (`card_number`, `card_uid`, `used_by`, `section`, `time_taken`, `locker_number`, `card_balance`, `coinslot_balance`) VALUES
(1, '437939bb', 'alonzo', 'bsit4d', '2024-12-03 17:37:02', '1', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_history`
--

CREATE TABLE `tbl_history` (
  `id` int(6) NOT NULL,
  `date` date NOT NULL,
  `card_number` int(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `section` int(10) NOT NULL,
  `time_taken` datetime NOT NULL,
  `time_returned` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_history`
--

INSERT INTO `tbl_history` (`id`, `date`, `card_number`, `name`, `section`, `time_taken`, `time_returned`) VALUES
(1001, '2024-11-14', 3, 'Christian Oliver Santarin', 202110157, '2024-11-14 10:20:02', '2024-11-14 10:20:02'),
(1002, '2024-11-14', 2, 'Marlon Bautista', 0, '2024-11-10 21:10:04', '2024-11-14 17:49:16'),
(1003, '2024-11-14', 1, 'Christian Oliver Santarin', 202110157, '2024-11-14 17:49:32', '2024-11-14 17:50:11'),
(1004, '2024-11-15', 1, 'Marlon Bautista', 202110158, '2024-11-15 04:25:53', '2024-11-15 04:26:03'),
(1005, '2024-11-18', 1, 'Marlon', 202110208, '0000-00-00 00:00:00', '2024-11-18 13:05:08'),
(1006, '2024-11-18', 2, 'Ian', 202110210, '0000-00-00 00:00:00', '2024-11-18 13:05:11'),
(1007, '2024-11-19', 1, 'Christian Oliver Santarin', 202110157, '2024-11-19 20:46:49', '2024-11-19 20:46:55'),
(1008, '2024-11-19', 2, 'Marlon Bautista', 202110158, '2024-11-19 21:32:16', '2024-11-19 21:38:20'),
(1009, '2024-11-19', 1, 'Christian Oliver Santarin', 202110157, '2024-11-19 21:39:28', '2024-11-19 21:39:37'),
(1010, '2024-11-23', 1, 'Christian Oliver Santarin', 202110157, '2024-11-20 21:10:01', '2024-11-23 00:37:05'),
(1011, '2024-11-29', 1, 'Ian', 0, '2024-11-29 06:33:30', '2024-11-29 06:36:58'),
(1012, '2024-11-29', 1, 'Ian', 0, '2024-11-29 06:33:30', '2024-11-29 06:38:18'),
(1013, '2024-11-29', 1, 'Ian', 0, '2024-11-29 06:33:30', '2024-11-29 06:38:19'),
(1014, '2024-11-29', 1, 'Ian', 0, '2024-11-29 06:33:30', '2024-11-29 06:38:19'),
(1015, '2024-11-29', 1, 'Ian', 0, '2024-11-29 06:33:30', '2024-11-29 06:38:42'),
(1016, '2024-11-29', 1, 'Ian Santarin', 0, '2024-11-29 06:38:58', '2024-11-29 07:03:36');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_log`
--

CREATE TABLE `tbl_log` (
  `action_id` int(11) NOT NULL,
  `card_uid` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `description` varchar(255) NOT NULL,
  `action` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_log`
--

INSERT INTO `tbl_log` (`action_id`, `card_uid`, `date`, `time`, `description`, `action`) VALUES
(16, '0', '2024-12-05', '23:03:35', 'Ian has rented locker number 1', 'Rent'),
(17, '0', '2024-12-05', '23:03:48', 'Administrator has removed Ian and Card 12 from Locker Number 1', 'Return'),
(18, '437939', '2024-12-06', '02:22:17', 'This UID is trying to access Locker 1, DENIED', ''),
(19, '437939', '2024-12-06', '02:22:54', 'This UID has access to Locker 1, APPROVE', ''),
(20, '73', '2024-12-06', '02:23:12', 'This UID is trying to access Locker 1, DENIED', ''),
(21, '73', '2024-12-06', '02:23:22', 'This UID is trying to access Locker 1, DENIED', ''),
(22, '599', '2024-12-06', '02:23:41', 'This UID is trying to access Locker 1, DENIED', ''),
(23, '599', '2024-12-06', '02:23:54', 'This UID is trying to access Locker 1, DENIED', ''),
(24, '39', '2024-12-06', '02:24:04', 'This UID is trying to access Locker 1, DENIED', ''),
(25, '595', '2024-12-06', '02:24:15', 'This UID is trying to access Locker 1, DENIED', ''),
(26, '39', '2024-12-06', '02:28:01', 'This UID is trying to access Locker 1, DENIED', ''),
(27, '599', '2024-12-06', '02:28:11', 'This UID is trying to access Locker 1, DENIED', ''),
(28, '599A8179', '2024-12-06', '02:28:36', 'This UID is trying to access Locker 1, DENIED', ''),
(29, '437939BB', '2024-12-06', '02:30:03', 'This UID is trying to access Locker 1, DENIED', ''),
(30, '437939BB', '2024-12-06', '02:33:34', 'This UID has access to Locker 1, APPROVE', ''),
(31, '437939BB', '2024-12-06', '02:33:53', 'This UID is trying to access Locker 1, DENIED', ''),
(32, '437939BB', '2024-12-06', '02:33:59', 'This UID is trying to access Locker 1, DENIED', ''),
(33, '437939BB', '2024-12-06', '02:34:01', 'This UID is trying to access Locker 1, DENIED', ''),
(34, '437939BB', '2024-12-06', '02:34:03', 'This UID is trying to access Locker 1, DENIED', ''),
(35, '595BA279', '2024-12-06', '02:34:30', 'This UID is trying to access Locker 1, DENIED', ''),
(36, '39FB1179', '2024-12-06', '02:34:32', 'This UID is trying to access Locker 1, DENIED', ''),
(37, '437939BB', '2024-12-06', '02:36:24', 'This UID is trying to access Locker 1, DENIED', ''),
(38, '437939BB', '2024-12-06', '02:36:28', 'This UID is trying to access Locker 1, DENIED', ''),
(39, '437939BB', '2024-12-06', '02:36:38', 'This UID has access to Locker 1, APPROVE', ''),
(40, '437939BB', '2024-12-06', '02:36:49', 'This UID is trying to access Locker 1, DENIED', ''),
(41, '437939BB', '2024-12-06', '02:36:52', 'This UID is trying to access Locker 1, DENIED', ''),
(42, '437939BB', '2024-12-06', '02:37:02', 'This UID has access to Locker 1, APPROVE', ''),
(43, '437939BB', '2024-12-06', '02:37:12', 'This UID is trying to access Locker 1, DENIED', ''),
(44, '437939BB', '2024-12-06', '02:37:14', 'This UID is trying to access Locker 1, DENIED', ''),
(45, '437939BB', '2024-12-06', '02:37:16', 'This UID is trying to access Locker 1, DENIED', ''),
(46, '437939BB', '2024-12-06', '02:37:18', 'This UID is trying to access Locker 1, DENIED', ''),
(47, '437939BB', '2024-12-06', '02:37:20', 'This UID is trying to access Locker 1, DENIED', ''),
(48, '599A8179', '2024-12-06', '02:47:53', 'This UID is trying to access Locker 1, DENIED', ''),
(49, '39FB1179', '2024-12-06', '02:49:10', 'This UID is trying to access Locker 1, DENIED', ''),
(50, '437939BB', '2024-12-06', '02:49:23', 'This UID has access to Locker 1, APPROVE', ''),
(51, '437939BB', '2024-12-06', '02:49:47', 'This UID is trying to access Locker 1, DENIED', ''),
(52, '437939BB', '2024-12-06', '02:49:49', 'This UID is trying to access Locker 1, DENIED', ''),
(53, '437939BB', '2024-12-06', '02:49:57', 'This UID is trying to access Locker 1, DENIED', ''),
(54, '437939BB', '2024-12-06', '02:50:06', 'This UID has access to Locker 1, APPROVE', ''),
(55, '595BA279', '2024-12-06', '02:50:21', 'This UID is trying to access Locker 1, DENIED', ''),
(56, '595BA279', '2024-12-06', '02:50:22', 'This UID is trying to access Locker 1, DENIED', ''),
(57, '437939BB', '2024-12-06', '02:51:26', 'This UID is trying to access Locker 1, DENIED', ''),
(58, '437939BB', '2024-12-06', '02:52:27', 'This UID is trying to access Locker 1, DENIED', ''),
(59, '437939BB', '2024-12-06', '03:13:58', 'This UID has access to Locker 1, APPROVE', ''),
(60, '437939BB', '2024-12-06', '03:14:06', 'This UID is trying to access Locker 1, DENIED', ''),
(61, '437939BB', '2024-12-06', '03:14:08', 'This UID is trying to access Locker 1, DENIED', ''),
(62, '437939BB', '2024-12-06', '03:14:10', 'This UID is trying to access Locker 1, DENIED', ''),
(63, '437939BB', '2024-12-06', '03:14:17', 'This UID is trying to access Locker 1, DENIED', ''),
(64, '437939BB', '2024-12-06', '03:14:19', 'This UID is trying to access Locker 1, DENIED', ''),
(65, '437939BB', '2024-12-06', '03:14:20', 'This UID is trying to access Locker 1, DENIED', ''),
(66, '437939BB', '2024-12-06', '03:14:22', 'This UID is trying to access Locker 1, DENIED', ''),
(67, '437939BB', '2024-12-06', '03:14:32', 'This UID has access to Locker 1, APPROVE', ''),
(68, '437939BB', '2024-12-06', '03:15:06', 'This UID is trying to access Locker 1, DENIED', ''),
(69, '437939BB', '2024-12-06', '03:15:11', 'This UID is trying to access Locker 1, DENIED', ''),
(70, '437939BB', '2024-12-06', '03:15:55', 'This UID is trying to access Locker 1, DENIED', ''),
(71, '437939BB', '2024-12-06', '03:16:05', 'This UID is trying to access Locker 1, DENIED', ''),
(72, '437939BB', '2024-12-06', '03:16:14', 'This UID is trying to access Locker 1, DENIED', ''),
(73, '437939BB', '2024-12-06', '03:16:28', 'This UID is trying to access Locker 1, DENIED', ''),
(74, '437939BB', '2024-12-06', '03:16:30', 'This UID is trying to access Locker 1, DENIED', ''),
(75, '437939BB', '2024-12-06', '03:16:36', 'This UID is trying to access Locker 1, DENIED', ''),
(76, '595BA279', '2024-12-06', '03:28:24', 'This UID is trying to access Locker 1, DENIED', ''),
(77, '595BA279', '2024-12-06', '03:28:27', 'This UID is trying to access Locker 1, DENIED', ''),
(78, '595BA279', '2024-12-06', '03:28:29', 'This UID is trying to access Locker 1, DENIED', ''),
(79, '595BA279', '2024-12-06', '03:28:34', 'This UID is trying to access Locker 1, DENIED', ''),
(80, '595BA279', '2024-12-06', '03:28:36', 'This UID is trying to access Locker 1, DENIED', ''),
(81, '595BA279', '2024-12-06', '03:29:18', 'This UID is trying to access Locker 1, DENIED', ''),
(82, '595BA279', '2024-12-06', '03:30:22', 'This UID is trying to access Locker 1, DENIED', ''),
(83, '595BA279', '2024-12-06', '03:30:25', 'This UID is trying to access Locker 1, DENIED', ''),
(84, '595BA279', '2024-12-06', '03:30:28', 'This UID is trying to access Locker 1, DENIED', ''),
(85, '595BA279', '2024-12-06', '03:30:30', 'This UID is trying to access Locker 1, DENIED', ''),
(86, '595BA279', '2024-12-06', '03:30:32', 'This UID is trying to access Locker 1, DENIED', ''),
(87, '595BA279', '2024-12-06', '03:30:34', 'This UID is trying to access Locker 1, DENIED', ''),
(88, '595BA279', '2024-12-06', '03:30:36', 'This UID is trying to access Locker 1, DENIED', ''),
(89, '595BA279', '2024-12-06', '03:30:40', 'This UID is trying to access Locker 1, DENIED', ''),
(90, '595BA279', '2024-12-06', '03:31:07', 'This UID is trying to access Locker 1, DENIED', ''),
(91, '595BA279', '2024-12-06', '03:31:10', 'This UID is trying to access Locker 1, DENIED', ''),
(92, '595BA279', '2024-12-06', '03:31:43', 'This UID is trying to access Locker 1, DENIED', ''),
(93, '595BA279', '2024-12-06', '03:31:58', 'This UID is trying to access Locker 1, DENIED', ''),
(94, '437939BB', '2024-12-06', '03:32:47', 'This UID has access to Locker 1, APPROVE', ''),
(95, '437939BB', '2024-12-06', '03:33:53', 'This UID has access to Locker 1, APPROVE', ''),
(96, '437939BB', '2024-12-06', '03:35:13', 'This UID has access to Locker 1, APPROVE', ''),
(97, '437939BB', '2024-12-06', '03:35:26', 'This UID is trying to access Locker 1, DENIED', ''),
(98, '49C8B779', '2024-12-06', '03:51:23', 'This UID is trying to access Locker 1, DENIED', ''),
(99, '437939BB', '2024-12-06', '03:51:31', 'This UID has access to Locker 1, APPROVE', ''),
(100, '437939BB', '2024-12-06', '03:51:57', 'This UID is trying to access Locker 1, DENIED', ''),
(101, '437939BB', '2024-12-06', '03:52:16', 'This UID has access to Locker 1, APPROVE', ''),
(102, '437939BB', '2024-12-06', '03:52:24', 'This UID is trying to access Locker 1, DENIED', ''),
(103, '437939BB', '2024-12-06', '03:53:27', 'This UID has access to Locker 1, APPROVE', ''),
(104, '437939BB', '2024-12-06', '03:55:27', 'This UID has access to Locker 1, APPROVE', ''),
(105, '437939BB', '2024-12-06', '03:55:40', 'This UID is trying to access Locker 1, DENIED', ''),
(106, '437939BB', '2024-12-06', '04:08:39', 'This UID has access to Locker 1, APPROVE', ''),
(107, '437939BB', '2024-12-06', '04:08:54', 'This UID is trying to access Locker 1, DENIED', ''),
(108, '437939BB', '2024-12-06', '04:09:33', 'This UID is trying to access Locker 1, DENIED', ''),
(109, '437939BB', '2024-12-06', '04:16:06', 'This UID has access to Locker 1, APPROVE', ''),
(110, '437939BB', '2024-12-06', '04:16:31', 'This UID is trying to access Locker 1, DENIED', ''),
(111, '437939BB', '2024-12-06', '04:16:32', 'This UID is trying to access Locker 1, DENIED', ''),
(112, '437939BB', '2024-12-06', '04:16:34', 'This UID is trying to access Locker 1, DENIED', ''),
(113, '437939BB', '2024-12-06', '04:16:57', 'This UID is trying to access Locker 1, DENIED', ''),
(114, '437939BB', '2024-12-06', '04:17:02', 'This UID is trying to access Locker 1, DENIED', ''),
(115, '437939BB', '2024-12-06', '04:17:04', 'This UID is trying to access Locker 1, DENIED', ''),
(116, '437939BB', '2024-12-06', '04:17:06', 'This UID is trying to access Locker 1, DENIED', ''),
(117, '437939BB', '2024-12-06', '04:18:18', 'This UID has access to Locker 1, APPROVE', ''),
(118, '437939BB', '2024-12-06', '04:19:55', 'This UID is trying to access Locker 1, DENIED', ''),
(119, '437939BB', '2024-12-06', '04:22:54', 'This UID is trying to access Locker 1, DENIED', ''),
(120, '437939BB', '2024-12-06', '04:22:56', 'This UID is trying to access Locker 1, DENIED', ''),
(121, '437939BB', '2024-12-06', '04:23:04', 'This UID is trying to access Locker 1, DENIED', ''),
(122, '437939BB', '2024-12-06', '04:24:01', 'This UID is trying to access Locker 1, DENIED', ''),
(123, '437939BB', '2024-12-06', '04:25:36', 'This UID is trying to access Locker 1, DENIED', ''),
(124, '437939BB', '2024-12-06', '04:25:42', 'This UID is trying to access Locker 1, DENIED', ''),
(125, '437939BB', '2024-12-06', '04:26:04', 'This UID is trying to access Locker 1, DENIED', ''),
(126, '437939BB', '2024-12-06', '04:26:07', 'This UID is trying to access Locker 1, DENIED', ''),
(127, '437939BB', '2024-12-06', '04:27:51', 'This UID is trying to access Locker 1, DENIED', ''),
(128, '437939BB', '2024-12-06', '04:27:55', 'This UID is trying to access Locker 1, DENIED', ''),
(129, '437939BB', '2024-12-06', '04:29:14', 'This UID is trying to access Locker 1, DENIED', ''),
(130, '437939BB', '2024-12-06', '04:30:14', 'This UID is trying to access Locker 1, DENIED', ''),
(131, '437939BB', '2024-12-06', '04:30:28', 'This UID has access to Locker 1, APPROVE', ''),
(132, '437939BB', '2024-12-06', '06:32:54', 'This UID has access to Locker 1, APPROVE', ''),
(133, '437939BB', '2024-12-06', '06:33:09', 'This UID is trying to access Locker 1, DENIED', '');

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
(1, '2024-12-05', '19:48:01', 2, 'Open', 0),
(2, '2024-12-05', '19:48:58', 2, 'Open', 19),
(3, '2024-12-05', '19:51:15', 1, 'alonzo', 19),
(4, '2024-12-05', '20:11:51', 2, 'Open', 20),
(5, '2024-12-05', '20:12:17', 2, 'Open', 19),
(6, '2024-12-05', '20:12:46', 1, 'alonzo', 20),
(7, '2024-12-05', '20:14:18', 2, 'Open', 20),
(8, '2024-12-05', '20:15:06', 2, 'Open', 20),
(9, '2024-12-05', '20:16:04', 2, 'Open', 19),
(10, '2024-12-05', '20:16:16', 1, 'alonzo', 20),
(11, '2024-12-05', '20:19:46', 1, 'alonzo', 19),
(12, '2024-12-05', '20:20:09', 2, 'Open', 20),
(13, '2024-12-05', '20:32:00', 2, 'Open', 20),
(14, '2024-12-05', '20:35:28', 2, 'Open', 21),
(15, '2024-12-05', '20:55:37', 2, 'Open', 21),
(16, '2024-12-05', '21:08:55', 2, 'Open', 19);

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
  ADD PRIMARY KEY (`card_number`);

--
-- Indexes for table `tbl_history`
--
ALTER TABLE `tbl_history`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `card_number` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbl_history`
--
ALTER TABLE `tbl_history`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1017;

--
-- AUTO_INCREMENT for table `tbl_log`
--
ALTER TABLE `tbl_log`
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `tbl_sales`
--
ALTER TABLE `tbl_sales`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
