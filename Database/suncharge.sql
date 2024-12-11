-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2024 at 08:41 PM
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
(1, 0, '', 'Free', '', '0000-00-00', '0000-00-00', '', 0, 0);

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
(10, '39E45C79', 'Unused', NULL, NULL, NULL, NULL, 0),
(11, '59A87B79', 'Unused', NULL, NULL, NULL, NULL, 0);

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
(94, '49C8B779', '2024-12-09', '17:23:46', 'Access Denied', ''),
(95, '437939BB', '2024-12-09', '18:43:41', 'Access Granted', ''),
(96, '437939BB', '2024-12-09', '18:44:11', 'Access Granted', ''),
(97, '437939BB', '2024-12-09', '18:44:13', 'No Balance - Access Denied', ''),
(98, '437939BB', '2024-12-09', '18:44:16', 'Access Granted', ''),
(99, '437939BB', '2024-12-09', '18:44:18', 'No Balance - Access Denied', ''),
(100, '49C8B779', '2024-12-09', '18:44:21', 'Access Denied', ''),
(101, '49C8B779', '2024-12-09', '18:44:22', 'Access Denied', ''),
(102, '49C8B779', '2024-12-09', '18:44:25', 'Access Denied', ''),
(103, '437939BB', '2024-12-09', '18:44:40', 'Access Granted', ''),
(104, '', '2024-12-09', '20:00:58', 'Administrator has removed Santarin and Card 1 from Locker Number 1', 'Return'),
(105, '', '2024-12-09', '20:01:05', 'Marlon has rented locker number 1', 'Rent'),
(106, '437939BB', '2024-12-09', '20:01:18', 'Access Denied', ''),
(107, '437939BB', '2024-12-09', '20:01:29', 'Access Denied', ''),
(108, '437939BB', '2024-12-09', '20:01:54', 'Access Denied', ''),
(109, '437939BB', '2024-12-09', '20:02:12', 'Access Denied', ''),
(110, '437939BB', '2024-12-09', '20:02:31', 'Access Granted', ''),
(111, '', '2024-12-09', '20:04:33', 'Administrator has removed Marlon and Card 1 from Locker Number 1', 'Return'),
(112, '', '2024-12-09', '20:04:40', 'Marlon has rented locker number 1', 'Rent'),
(113, '', '2024-12-09', '20:06:04', 'Administrator has removed Marlon and Card 1 from Locker Number 1', 'Return'),
(114, '', '2024-12-09', '20:06:15', 'Marlon has rented locker number 1', 'Rent'),
(115, '', '2024-12-09', '20:08:01', 'Administrator has removed Marlon and Card 1 from Locker Number 1', 'Return'),
(116, '', '2024-12-09', '20:08:04', 'Bautista has rented locker number 1', 'Rent'),
(117, '437939BB', '2024-12-09', '20:08:10', 'Access Granted', ''),
(118, '', '2024-12-09', '20:09:13', 'Administrator has removed Bautista and Card 1 from Locker Number 1', 'Return'),
(119, '', '2024-12-09', '20:09:17', ' has rented locker number 1', 'Rent'),
(120, '49C8B779', '2024-12-09', '20:09:26', 'Access Granted', ''),
(121, '49C8B779', '2024-12-10', '16:45:17', 'Access Granted', ''),
(122, '49C8B779', '2024-12-10', '16:45:18', 'No Balance - Access Denied', ''),
(123, '49C8B779', '2024-12-10', '16:45:19', 'Access Granted', ''),
(124, '49C8B779', '2024-12-10', '16:45:19', 'No Balance - Access Denied', ''),
(125, '49C8B779', '2024-12-10', '16:45:55', 'Access Granted', ''),
(126, '49C8B779', '2024-12-10', '16:45:55', 'No Balance - Access Denied', ''),
(127, '49C8B779', '2024-12-10', '16:46:13', 'Access Granted', ''),
(128, '49C8B779', '2024-12-10', '16:47:26', 'Access Granted', ''),
(129, '49C8B779', '2024-12-10', '16:47:26', 'No Balance - Access Denied', ''),
(130, '', '2024-12-10', '16:49:35', ' has rented locker number 1', 'Rent'),
(131, '437939BB', '2024-12-10', '16:50:34', 'Access Granted', ''),
(132, '437939BB', '2024-12-10', '16:51:43', 'Access Granted', ''),
(133, '437939BB', '2024-12-10', '16:51:43', 'No Balance - Access Denied', ''),
(134, '437939BB', '2024-12-10', '16:54:57', 'Access Granted', ''),
(135, '437939BB', '2024-12-10', '16:55:09', 'Access Granted', ''),
(136, '437939BB', '2024-12-10', '16:55:35', 'Access Granted', ''),
(137, '', '2024-12-10', '16:57:49', 'Marlon has rented locker number 1', 'Rent'),
(138, '437939BB', '2024-12-10', '16:58:09', 'Access Granted', ''),
(139, '437939BB', '2024-12-10', '16:58:21', 'Access Granted', ''),
(140, '437939BB', '2024-12-10', '16:58:21', 'No Balance - Access Denied', ''),
(141, '437939BB', '2024-12-10', '17:03:35', 'Access Granted', ''),
(142, '437939BB', '2024-12-10', '19:33:00', 'Access Granted', ''),
(143, '437939BB', '2024-12-10', '19:33:01', 'No Balance - Access Denied', ''),
(144, '437939BB', '2024-12-10', '19:33:10', 'Access Granted', ''),
(145, '437939BB', '2024-12-10', '19:33:10', 'No Balance - Access Denied', ''),
(146, '437939BB', '2024-12-10', '19:33:11', 'Access Granted', ''),
(147, '437939BB', '2024-12-10', '19:33:11', 'No Balance - Access Denied', ''),
(148, '437939BB', '2024-12-10', '19:33:12', 'Access Granted', ''),
(149, '437939BB', '2024-12-10', '19:33:13', 'No Balance - Access Denied', ''),
(150, '437939BB', '2024-12-10', '19:33:16', 'Access Granted', ''),
(151, '39FB1179', '2024-12-10', '19:35:32', 'Access Denied', ''),
(152, '39FB1179', '2024-12-10', '19:35:35', 'Access Denied', ''),
(153, '437939BB', '2024-12-10', '19:36:06', 'Access Granted', ''),
(154, '437939BB', '2024-12-10', '19:36:13', 'Access Granted', ''),
(155, '437939BB', '2024-12-10', '19:36:13', 'No Balance - Access Denied', ''),
(156, '', '2024-12-10', '19:44:11', 'Administrator has removed Marlon and Card 1 from Locker Number 1', 'Return'),
(157, '59A87B79', '2024-12-10', '19:46:34', 'Access Denied', ''),
(158, '', '2024-12-10', '19:47:04', 'Marlon has rented locker number 1', 'Rent'),
(159, '59A87B79', '2024-12-10', '19:47:05', 'Access Granted', ''),
(160, '59A87B79', '2024-12-10', '19:47:06', 'No Balance - Access Denied', ''),
(161, '59A87B79', '2024-12-10', '19:47:20', 'Access Granted', ''),
(162, '59A87B79', '2024-12-10', '19:55:12', 'Access Granted', ''),
(163, '59A87B79', '2024-12-10', '19:55:12', 'No Balance - Access Denied', ''),
(164, '59A87B79', '2024-12-10', '19:55:13', 'Access Granted', ''),
(165, '59A87B79', '2024-12-10', '19:55:13', 'No Balance - Access Denied', ''),
(166, '59A87B79', '2024-12-10', '20:00:53', 'Access Granted', ''),
(167, '59A87B79', '2024-12-10', '20:00:53', 'No Balance - Access Denied', ''),
(168, '59A87B79', '2024-12-10', '20:05:15', 'Access Granted', ''),
(169, '59A87B79', '2024-12-10', '20:05:15', 'No Balance - Access Denied', ''),
(170, '59A87B79', '2024-12-10', '20:05:30', 'Access Granted', ''),
(171, '59A87B79', '2024-12-10', '20:21:29', 'Access Granted', ''),
(172, '59A87B79', '2024-12-10', '20:21:29', 'No Balance - Access Denied', ''),
(173, '59A87B79', '2024-12-10', '20:21:33', 'Access Granted', ''),
(174, '59A87B79', '2024-12-10', '20:28:50', 'Access Granted', ''),
(175, '59A87B79', '2024-12-10', '20:28:50', 'No Balance - Access Denied', ''),
(176, '59A87B79', '2024-12-10', '20:38:20', 'Access Granted', ''),
(177, '59A87B79', '2024-12-10', '20:38:20', 'No Balance - Access Denied', ''),
(178, '59A87B79', '2024-12-10', '20:38:25', 'Access Granted', ''),
(179, '59A87B79', '2024-12-10', '20:38:25', 'No Balance - Access Denied', ''),
(180, '59A87B79', '2024-12-10', '20:38:34', 'Access Granted', ''),
(181, '59A87B79', '2024-12-10', '20:48:57', 'Access Granted', ''),
(182, '59A87B79', '2024-12-10', '20:48:57', 'No Balance - Access Denied', ''),
(183, '59A87B79', '2024-12-10', '20:52:23', 'Access Granted', ''),
(184, '59A87B79', '2024-12-10', '20:52:23', 'No Balance - Access Denied', ''),
(185, '59A87B79', '2024-12-10', '20:56:03', 'Access Granted', ''),
(186, '59A87B79', '2024-12-10', '20:56:30', 'Access Granted', ''),
(187, '59A87B79', '2024-12-10', '20:56:30', 'No Balance - Access Denied', ''),
(188, '59A87B79', '2024-12-10', '21:14:23', 'Access Granted', ''),
(189, '59A87B79', '2024-12-10', '21:14:25', 'No Balance - Access Denied', ''),
(190, '59A87B79', '2024-12-10', '21:14:29', 'Access Granted', ''),
(191, '59A87B79', '2024-12-10', '21:14:33', 'No Balance - Access Denied', ''),
(192, '59A87B79', '2024-12-10', '21:15:01', 'Access Granted', ''),
(193, '59A87B79', '2024-12-10', '22:57:33', 'Access Granted', ''),
(194, '59A87B79', '2024-12-10', '22:57:33', 'No Balance - Access Denied', ''),
(195, '59A87B79', '2024-12-10', '22:58:41', 'Access Granted', ''),
(196, '59A87B79', '2024-12-10', '22:58:41', 'No Balance - Access Denied', ''),
(197, '59A87B79', '2024-12-10', '23:20:54', 'Access Granted', ''),
(198, '59A87B79', '2024-12-10', '23:20:54', 'No Balance - Access Denied', ''),
(199, '59A87B79', '2024-12-10', '23:36:12', 'Access Granted', ''),
(200, '59A87B79', '2024-12-10', '23:36:13', 'No Balance - Access Denied', ''),
(201, '59A87B79', '2024-12-10', '23:36:14', 'Access Granted', ''),
(202, '59A87B79', '2024-12-10', '23:36:15', 'No Balance - Access Denied', ''),
(203, '59A87B79', '2024-12-10', '23:53:12', 'Access Granted', ''),
(204, '59A87B79', '2024-12-10', '23:53:12', 'No Balance - Access Denied', ''),
(205, '59A87B79', '2024-12-11', '00:00:16', 'Access Granted', ''),
(206, '59A87B79', '2024-12-11', '00:00:17', 'No Balance - Access Denied', ''),
(207, '59A87B79', '2024-12-11', '00:01:23', 'Access Granted', ''),
(208, '59A87B79', '2024-12-11', '00:01:23', 'No Balance - Access Denied', ''),
(209, '59A87B79', '2024-12-11', '00:28:32', 'Access Granted', ''),
(210, '59A87B79', '2024-12-11', '00:28:33', 'No Balance - Access Denied', ''),
(211, '59A87B79', '2024-12-11', '00:37:34', 'Access Granted', ''),
(212, '59A87B79', '2024-12-11', '00:37:34', 'No Balance - Access Denied', ''),
(213, '59A87B79', '2024-12-11', '00:42:46', 'Access Granted', ''),
(214, '59A87B79', '2024-12-11', '00:42:48', 'No Balance - Access Denied', ''),
(215, '59A87B79', '2024-12-11', '01:01:14', 'Access Granted', ''),
(216, '59A87B79', '2024-12-11', '01:01:14', 'No Balance - Access Denied', ''),
(217, '59A87B79', '2024-12-11', '01:07:09', 'Access Granted', ''),
(218, '59A87B79', '2024-12-11', '01:07:10', 'No Balance - Access Denied', ''),
(219, '59A87B79', '2024-12-11', '01:07:11', 'Access Granted', ''),
(220, '59A87B79', '2024-12-11', '01:07:11', 'No Balance - Access Denied', ''),
(221, '59A87B79', '2024-12-11', '01:07:13', 'Access Granted', ''),
(222, '59A87B79', '2024-12-11', '01:07:13', 'No Balance - Access Denied', ''),
(223, '59A87B79', '2024-12-11', '01:07:30', 'Access Granted', ''),
(224, '59A87B79', '2024-12-11', '01:07:31', 'No Balance - Access Denied', ''),
(225, '59A87B79', '2024-12-11', '01:13:56', 'Access Granted', ''),
(226, '59A87B79', '2024-12-11', '01:13:57', 'No Balance - Access Denied', ''),
(227, '59A87B79', '2024-12-11', '01:13:59', 'Access Granted', ''),
(228, '59A87B79', '2024-12-11', '01:13:59', 'No Balance - Access Denied', ''),
(229, '59A87B79', '2024-12-11', '01:17:43', 'Access Granted', ''),
(230, '59A87B79', '2024-12-11', '01:17:43', 'No Balance - Access Denied', ''),
(231, '59A87B79', '2024-12-11', '01:17:45', 'Access Granted', ''),
(232, '59A87B79', '2024-12-11', '01:17:45', 'No Balance - Access Denied', ''),
(233, '59A87B79', '2024-12-11', '01:17:46', 'Access Granted', ''),
(234, '59A87B79', '2024-12-11', '01:17:46', 'No Balance - Access Denied', ''),
(235, '59A87B79', '2024-12-11', '01:17:52', 'Access Granted', ''),
(236, '59A87B79', '2024-12-11', '01:17:52', 'No Balance - Access Denied', ''),
(237, '59A87B79', '2024-12-11', '01:17:54', 'Access Granted', ''),
(238, '59A87B79', '2024-12-11', '01:17:54', 'No Balance - Access Denied', ''),
(239, '59A87B79', '2024-12-11', '01:46:40', 'Access Granted', ''),
(240, '59A87B79', '2024-12-11', '01:46:40', 'No Balance - Access Denied', ''),
(241, '59A87B79', '2024-12-11', '23:53:26', 'Access Granted', ''),
(242, '59A87B79', '2024-12-11', '23:53:27', 'No Balance - Access Denied', ''),
(243, '59A87B79', '2024-12-11', '23:53:31', 'Access Granted', ''),
(244, '59A87B79', '2024-12-11', '23:53:31', 'No Balance - Access Denied', ''),
(245, '59A87B79', '2024-12-11', '23:53:34', 'Access Granted', ''),
(246, '59A87B79', '2024-12-11', '23:53:36', 'No Balance - Access Denied', ''),
(247, '59A87B79', '2024-12-11', '23:53:40', 'Access Granted', ''),
(248, '59A87B79', '2024-12-11', '23:53:47', 'No Balance - Access Denied', ''),
(249, '', '2024-12-12', '00:03:27', 'Administrator has removed Marlon and Card 1 from Locker Number 1', 'Return'),
(250, '', '2024-12-12', '00:03:30', 'Marlon has rented locker number 1', 'Rent'),
(251, '5993E479', '2024-12-12', '00:03:46', 'Access Granted', ''),
(252, '5993E479', '2024-12-12', '00:33:25', 'Access Granted', ''),
(253, '5993E479', '2024-12-12', '00:33:25', 'No Balance - Access Denied', ''),
(254, '5993E479', '2024-12-12', '00:33:28', 'Access Granted', ''),
(255, '5993E479', '2024-12-12', '00:33:28', 'No Balance - Access Denied', ''),
(256, '', '2024-12-12', '00:34:07', 'Administrator has removed Marlon and Card 2 from Locker Number 1', 'Return'),
(257, '5993E479', '2024-12-12', '00:34:17', 'Access Denied', ''),
(258, '5993E479', '2024-12-12', '00:34:28', 'Access Denied', ''),
(259, '5993E479', '2024-12-12', '00:34:54', 'Access Denied', ''),
(260, '5993E479', '2024-12-12', '00:35:08', 'Access Denied', ''),
(261, '5993E479', '2024-12-12', '00:35:21', 'Access Granted', ''),
(262, '', '2024-12-12', '00:35:56', 'Marlon has rented locker number 1', 'Rent'),
(263, '5993E479', '2024-12-12', '00:36:02', 'Access Granted', ''),
(264, '5993E479', '2024-12-12', '00:36:05', 'No Balance - Access Denied', ''),
(265, '5993E479', '2024-12-12', '00:36:06', 'Access Granted', ''),
(266, '5993E479', '2024-12-12', '00:36:06', 'No Balance - Access Denied', ''),
(267, '5993E479', '2024-12-12', '00:36:10', 'Access Granted', ''),
(268, '', '2024-12-12', '00:36:12', 'Administrator has removed Marlon and Card 2 from Locker Number 1', 'Return'),
(269, '5993E479', '2024-12-12', '00:36:25', 'Access Denied', ''),
(270, '5993E479', '2024-12-12', '00:36:27', 'Access Denied', ''),
(271, '69A0D179', '2024-12-12', '00:53:19', 'Access Denied', ''),
(272, '69A0D179', '2024-12-12', '00:53:20', 'Access Denied', ''),
(273, '', '2024-12-12', '00:53:28', 'Marlon has rented locker number 1', 'Rent'),
(274, '69A0D179', '2024-12-12', '00:53:35', 'Access Granted', ''),
(275, '', '2024-12-12', '00:53:41', 'Administrator has removed Marlon and Card 3 from Locker Number 1', 'Return'),
(276, '69A0D179', '2024-12-12', '00:53:51', 'Access Denied', ''),
(277, '', '2024-12-12', '00:54:48', 'Marlon has rented locker number 1', 'Rent'),
(278, '69A0D179', '2024-12-12', '00:54:54', 'Access Granted', ''),
(279, '69A0D179', '2024-12-12', '00:55:01', 'Access Granted', ''),
(280, '69A0D179', '2024-12-12', '00:55:01', 'No Balance - Access Denied', ''),
(281, '69A0D179', '2024-12-12', '00:55:04', 'Access Granted', ''),
(282, '69A0D179', '2024-12-12', '00:55:04', 'No Balance - Access Denied', ''),
(283, '69A0D179', '2024-12-12', '00:55:06', 'Access Granted', ''),
(284, '69A0D179', '2024-12-12', '00:55:06', 'No Balance - Access Denied', ''),
(285, '', '2024-12-12', '00:55:27', 'Administrator has removed Marlon and Card 3 from Locker Number 1', 'Return'),
(286, '', '2024-12-12', '00:55:33', 'John Paul has rented locker number 1', 'Rent'),
(287, '59A87B79', '2024-12-12', '00:55:37', 'Access Granted', ''),
(288, '', '2024-12-12', '02:11:59', 'Administrator has removed John Paul and Card 5 from Locker Number 1', 'Return'),
(289, '', '2024-12-12', '02:15:43', 'Marlon has rented locker number 1', 'Rent'),
(290, '59A87B79', '2024-12-12', '02:15:54', 'Access Granted', ''),
(291, '59A87B79', '2024-12-12', '02:45:53', 'Access Granted', ''),
(292, '59A87B79', '2024-12-12', '02:45:53', 'No Balance - Access Denied', ''),
(293, '59A87B79', '2024-12-12', '03:03:13', 'Access Granted', ''),
(294, '59A87B79', '2024-12-12', '03:03:13', 'No Balance - Access Denied', ''),
(295, '', '2024-12-12', '03:35:44', 'Administrator has removed Marlon and Card 6 from Locker Number 1', 'Return');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sales`
--

CREATE TABLE `tbl_sales` (
  `transaction_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `locker_number` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_sales`
--

INSERT INTO `tbl_sales` (`transaction_id`, `date`, `time`, `locker_number`, `name`, `amount`) VALUES
(1, '2024-12-08', '15:08:38', 2, 'Open', 1),
(2, '2024-12-08', '15:09:21', 1, 'Ian', 1),
(3, '2024-12-08', '15:09:31', 1, 'Ian', 1),
(4, '2024-12-10', '10:00:48', 1, 'Marlon', 1),
(5, '2024-12-10', '10:01:11', 1, 'Marlon', 4),
(6, '2024-12-10', '10:01:31', 2, 'Open', 5),
(7, '2024-12-10', '12:37:08', 2, 'Open', 5),
(8, '2024-12-10', '12:40:19', 1, 'Marlon', 5),
(9, '2024-12-10', '12:40:29', 1, 'Marlon', 4),
(10, '2024-12-10', '12:41:05', 1, 'Marlon', 5),
(11, '2024-12-10', '12:42:49', 2, 'Open', 5),
(12, '2024-12-10', '14:00:07', 1, 'Marlon', 5),
(13, '2024-12-10', '14:26:25', 2, 'Open', 6),
(14, '2024-12-10', '14:27:22', 2, 'Open', 5),
(15, '2024-12-10', '14:27:46', 2, 'Open', 10),
(16, '2024-12-10', '14:28:02', 1, 'Marlon', 5),
(17, '2024-12-10', '14:28:06', 1, 'Marlon', 5),
(18, '2024-12-10', '14:32:30', 2, 'Open', 9),
(19, '2024-12-12', '03:34:56', NULL, 'Card No.6', 20),
(20, '2024-12-12', '03:35:32', NULL, 'Card No.6', 20),
(21, '2024-12-12', '03:39:09', NULL, 'Card No.10', 400);

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
  MODIFY `card_number` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbl_log`
--
ALTER TABLE `tbl_log`
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=296;

--
-- AUTO_INCREMENT for table `tbl_sales`
--
ALTER TABLE `tbl_sales`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
