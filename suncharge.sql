-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 22, 2024 at 01:41 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

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
  `studentID` int(11) DEFAULT NULL,
  `time_taken` datetime DEFAULT current_timestamp(),
  `locker_number` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_card`
--

INSERT INTO `tbl_card` (`card_number`, `card_uid`, `used_by`, `studentID`, `time_taken`, `locker_number`) VALUES
(1, '437939bb', NULL, NULL, NULL, '1'),
(2, '49c8b779 ', 'Ian Santarin', NULL, NULL, '2');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_history`
--

CREATE TABLE `tbl_history` (
  `id` int(6) NOT NULL,
  `date` date NOT NULL,
  `card_number` int(5) NOT NULL,
  `name` varchar(50) NOT NULL,
  `student_id` int(10) NOT NULL,
  `time_taken` datetime NOT NULL,
  `time_returned` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_history`
--

INSERT INTO `tbl_history` (`id`, `date`, `card_number`, `name`, `student_id`, `time_taken`, `time_returned`) VALUES
(1001, '2024-11-14', 3, 'Christian Oliver Santarin', 202110157, '2024-11-14 10:20:02', '2024-11-14 10:20:02'),
(1002, '2024-11-14', 2, 'Marlon Bautista', 0, '2024-11-10 21:10:04', '2024-11-14 17:49:16'),
(1003, '2024-11-14', 1, 'Christian Oliver Santarin', 202110157, '2024-11-14 17:49:32', '2024-11-14 17:50:11'),
(1004, '2024-11-15', 1, 'Marlon Bautista', 202110158, '2024-11-15 04:25:53', '2024-11-15 04:26:03'),
(1005, '2024-11-18', 1, 'Marlon', 202110208, '0000-00-00 00:00:00', '2024-11-18 13:05:08'),
(1006, '2024-11-18', 2, 'Ian', 202110210, '0000-00-00 00:00:00', '2024-11-18 13:05:11'),
(1007, '2024-11-19', 1, 'Christian Oliver Santarin', 202110157, '2024-11-19 20:46:49', '2024-11-19 20:46:55'),
(1008, '2024-11-19', 2, 'Marlon Bautista', 202110158, '2024-11-19 21:32:16', '2024-11-19 21:38:20'),
(1009, '2024-11-19', 1, 'Christian Oliver Santarin', 202110157, '2024-11-19 21:39:28', '2024-11-19 21:39:37'),
(1010, '2024-11-22', 1, 'Christian Oliver Santarin', 202110157, '2024-11-20 21:10:01', '2024-11-22 04:09:42'),
(1011, '2024-11-22', 1, 'Christian Oliver Santarin', 202110157, '2024-11-22 04:10:53', '2024-11-22 04:17:10'),
(1012, '2024-11-22', 1, 'Marlon Bautista', 0, '0000-00-00 00:00:00', '2024-11-22 04:45:12');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_sales`
--

CREATE TABLE `tbl_sales` (
  `id` int(5) NOT NULL,
  `date` date NOT NULL,
  `charger1` int(5) NOT NULL,
  `charger2` int(5) NOT NULL,
  `charger3` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_sales`
--

INSERT INTO `tbl_sales` (`id`, `date`, `charger1`, `charger2`, `charger3`) VALUES
(1, '2024-11-17', 5, 0, 0),
(2, '2024-11-19', 3, 9, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_studentlist`
--

CREATE TABLE `tbl_studentlist` (
  `studentID` int(11) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL,
  `section` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_studentlist`
--

INSERT INTO `tbl_studentlist` (`studentID`, `firstname`, `surname`, `section`) VALUES
(202110157, 'Christian Oliver', 'Santarin', 'BSIT-4D'),
(202110158, 'Marlon', 'Bautista', 'BSIT-4D');

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
-- Indexes for table `tbl_sales`
--
ALTER TABLE `tbl_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_studentlist`
--
ALTER TABLE `tbl_studentlist`
  ADD PRIMARY KEY (`studentID`);

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
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1013;

--
-- AUTO_INCREMENT for table `tbl_sales`
--
ALTER TABLE `tbl_sales`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
