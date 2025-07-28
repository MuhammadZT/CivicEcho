-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 28, 2025 at 05:53 PM
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
-- Database: `civicecho`
--

-- --------------------------------------------------------

--
-- Table structure for table `attachment`
--

CREATE TABLE `attachment` (
  `attachment_id` int(11) NOT NULL,
  `complaint_id` int(11) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `uploaded_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint`
--

CREATE TABLE `complaint` (
  `complaint_id` int(11) NOT NULL,
  `nid` bigint(13) DEFAULT NULL,
  `priority_id` int(11) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `assigned_to` bigint(13) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint_category`
--

CREATE TABLE `complaint_category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complaint_category`
--

INSERT INTO `complaint_category` (`category_id`, `category_name`) VALUES
(1, 'Public Infrastructure'),
(2, 'Waste Management'),
(3, 'Traffic and Transport'),
(4, 'Health and Safety'),
(5, 'Environment and Pollution'),
(6, 'Education'),
(7, 'Law and Order'),
(8, 'Utilities'),
(9, 'Corruption and Governance'),
(10, 'Housing and Urban Development');

-- --------------------------------------------------------

--
-- Table structure for table `complaint_category_mapping`
--

CREATE TABLE `complaint_category_mapping` (
  `complaint_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `assigned_on` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complaint_log`
--

CREATE TABLE `complaint_log` (
  `log_id` int(11) NOT NULL,
  `complaint_id` int(11) DEFAULT NULL,
  `status_before` varchar(255) DEFAULT NULL,
  `status_after` varchar(255) DEFAULT NULL,
  `changed_by` bigint(13) DEFAULT NULL,
  `changed_on` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `complaint_id` int(11) DEFAULT NULL,
  `citizen_nid` bigint(13) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `feedback_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `government_officials`
--

CREATE TABLE `government_officials` (
  `official_nid` bigint(13) NOT NULL,
  `zoneID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `location`
--

CREATE TABLE `location` (
  `location_id` int(11) NOT NULL,
  `division` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `upazila` varchar(255) DEFAULT NULL,
  `zoneID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location`
--

INSERT INTO `location` (`location_id`, `division`, `district`, `upazila`, `zoneID`) VALUES
(1, 'Dhaka', 'Gazipur', 'Tongi', 1),
(2, 'Dhaka', 'Gazipur', 'Kaliakair', 1),
(3, 'Dhaka', 'Gazipur', 'Sreepur', 1),
(4, 'Dhaka', 'Gazipur', 'Kapasia', 1),
(5, 'Dhaka', 'Narayanganj', 'Narayanganj Sadar', 1),
(6, 'Dhaka', 'Narayanganj', 'Rupganj', 1),
(7, 'Dhaka', 'Narayanganj', 'Sonargaon', 1),
(8, 'Dhaka', 'Mymensingh', 'Mymensingh Sadar', 1),
(9, 'Dhaka', 'Mymensingh', 'Trishal', 1),
(10, 'Dhaka', 'Mymensingh', 'Ishwarganj', 1),
(11, 'Dhaka', 'Mymensingh', 'Haluaghat', 1),
(12, 'Dhaka', 'Mymensingh', 'Gouripur', 1),
(13, 'Dhaka', 'Tangail', 'Tangail Sadar', 1),
(14, 'Dhaka', 'Tangail', 'Gopalpur', 1),
(15, 'Dhaka', 'Tangail', 'Kalihati', 1),
(16, 'Dhaka', 'Tangail', 'Nagarpur', 1),
(17, 'Dhaka', 'Kishoreganj', 'Kishoreganj Sadar', 1),
(18, 'Dhaka', 'Kishoreganj', 'Mithamain', 1),
(19, 'Dhaka', 'Kishoreganj', 'Bajitpur', 1),
(20, 'Dhaka', 'Kishoreganj', 'Karimganj', 1),
(21, 'Dhaka', 'Moulvibazar', 'Moulvibazar Sadar', 1),
(22, 'Dhaka', 'Moulvibazar', 'Kulaura', 1),
(23, 'Dhaka', 'Moulvibazar', 'Barlekha', 1),
(24, 'Dhaka', 'Moulvibazar', 'Juri', 1),
(25, 'Dhaka', 'Dhaka', 'Dhanmondi', 2),
(26, 'Dhaka', 'Dhaka', 'Mirpur', 2),
(27, 'Dhaka', 'Dhaka', 'Gulshan', 2),
(28, 'Dhaka', 'Dhaka', 'Khilgaon', 2),
(29, 'Dhaka', 'Dhaka', 'Badda', 2),
(30, 'Dhaka', 'Dhaka', 'Mohakhali', 2),
(31, 'Dhaka', 'Dhaka', 'Tejgaon', 2),
(32, 'Dhaka', 'Dhaka', 'Puranapara', 2),
(33, 'Dhaka', 'Faridpur', 'Faridpur Sadar', 2),
(34, 'Dhaka', 'Faridpur', 'Nagarkanda', 2),
(35, 'Dhaka', 'Faridpur', 'Boalmari', 2),
(36, 'Dhaka', 'Faridpur', 'Madhukhali', 2),
(37, 'Dhaka', 'Munshiganj', 'Munshiganj Sadar', 2),
(38, 'Dhaka', 'Munshiganj', 'Sreenagar', 2),
(39, 'Dhaka', 'Madaripur', 'Madaripur Sadar', 2),
(40, 'Dhaka', 'Madaripur', 'Shibchar', 2),
(41, 'Dhaka', 'Madaripur', 'Rupsha', 2),
(42, 'Dhaka', 'Shariatpur', 'Shariatpur Sadar', 2),
(43, 'Dhaka', 'Shariatpur', 'Bhedarganj', 2),
(44, 'Dhaka', 'Rajbari', 'Rajbari Sadar', 2),
(45, 'Dhaka', 'Rajbari', 'Pangsha', 2),
(46, 'Dhaka', 'Rajbari', 'Goalanda', 2),
(47, 'Dhaka', 'Manikganj', 'Manikganj Sadar', 2),
(48, 'Dhaka', 'Manikganj', 'Shibalaya', 2),
(49, 'Dhaka', 'Manikganj', 'Daulatpur', 2),
(50, 'Dhaka', 'Narsingdi', 'Narsingdi Sadar', 2),
(51, 'Dhaka', 'Narsingdi', 'Raipura', 2),
(52, 'Dhaka', 'Narsingdi', 'Belabo', 2),
(53, 'Dhaka', 'Narsingdi', 'Monohardi', 2);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` int(11) NOT NULL,
  `user_id` bigint(13) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `notification_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otp_verification`
--

CREATE TABLE `otp_verification` (
  `otp_id` int(11) NOT NULL,
  `nid` bigint(13) DEFAULT NULL,
  `otp_code` int(11) DEFAULT NULL,
  `is_used` tinyint(1) DEFAULT NULL,
  `generated_on` datetime DEFAULT NULL,
  `expiry_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `priority_level`
--

CREATE TABLE `priority_level` (
  `priority_id` int(11) NOT NULL,
  `priority_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `priority_level`
--

INSERT INTO `priority_level` (`priority_id`, `priority_name`) VALUES
(1, 'High'),
(2, 'Medium'),
(3, 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`) VALUES
(1, 'Citizen'),
(2, 'Government Official');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_name`, `description`) VALUES
(1, 'Pending', 'Complaint has been received but not yet assigned to a department.'),
(2, 'In Progress', 'Complaint is being actively handled by the relevant department.'),
(3, 'Resolved', 'Complaint has been resolved and the citizen has been notified.'),
(4, 'Closed', 'Complaint has been closed without resolution.'),
(5, 'On Hold', 'Complaint is temporarily put on hold due to lack of information.');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `nid` bigint(13) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `zoneID` int(3) NOT NULL,
  `zoneName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`zoneID`, `zoneName`) VALUES
(1, 'Dhaka North'),
(2, 'Dhaka South');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attachment`
--
ALTER TABLE `attachment`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `complaint_id` (`complaint_id`);

--
-- Indexes for table `complaint`
--
ALTER TABLE `complaint`
  ADD PRIMARY KEY (`complaint_id`),
  ADD KEY `nid` (`nid`),
  ADD KEY `priority_id` (`priority_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `location_id` (`location_id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `complaint_category`
--
ALTER TABLE `complaint_category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `complaint_category_mapping`
--
ALTER TABLE `complaint_category_mapping`
  ADD PRIMARY KEY (`complaint_id`,`category_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `fk_status` (`status_id`);

--
-- Indexes for table `complaint_log`
--
ALTER TABLE `complaint_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `complaint_id` (`complaint_id`),
  ADD KEY `changed_by` (`changed_by`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `complaint_id` (`complaint_id`),
  ADD KEY `citizen_nid` (`citizen_nid`);

--
-- Indexes for table `government_officials`
--
ALTER TABLE `government_officials`
  ADD PRIMARY KEY (`official_nid`),
  ADD KEY `zoneID` (`zoneID`);

--
-- Indexes for table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`location_id`),
  ADD KEY `fk_zone` (`zoneID`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `otp_verification`
--
ALTER TABLE `otp_verification`
  ADD PRIMARY KEY (`otp_id`),
  ADD KEY `nid` (`nid`);

--
-- Indexes for table `priority_level`
--
ALTER TABLE `priority_level`
  ADD PRIMARY KEY (`priority_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `status_name` (`status_name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`nid`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`zoneID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attachment`
--
ALTER TABLE `attachment`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaint`
--
ALTER TABLE `complaint`
  MODIFY `complaint_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaint_category`
--
ALTER TABLE `complaint_category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `complaint_log`
--
ALTER TABLE `complaint_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `otp_verification`
--
ALTER TABLE `otp_verification`
  MODIFY `otp_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `priority_level`
--
ALTER TABLE `priority_level`
  MODIFY `priority_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `zoneID` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attachment`
--
ALTER TABLE `attachment`
  ADD CONSTRAINT `attachment_ibfk_1` FOREIGN KEY (`complaint_id`) REFERENCES `complaint` (`complaint_id`);

--
-- Constraints for table `complaint`
--
ALTER TABLE `complaint`
  ADD CONSTRAINT `complaint_ibfk_1` FOREIGN KEY (`nid`) REFERENCES `users` (`nid`),
  ADD CONSTRAINT `complaint_ibfk_2` FOREIGN KEY (`priority_id`) REFERENCES `priority_level` (`priority_id`),
  ADD CONSTRAINT `complaint_ibfk_3` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `complaint_ibfk_4` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`),
  ADD CONSTRAINT `complaint_ibfk_5` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`nid`);

--
-- Constraints for table `complaint_category_mapping`
--
ALTER TABLE `complaint_category_mapping`
  ADD CONSTRAINT `complaint_category_mapping_ibfk_1` FOREIGN KEY (`complaint_id`) REFERENCES `complaint` (`complaint_id`),
  ADD CONSTRAINT `complaint_category_mapping_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `complaint_category` (`category_id`),
  ADD CONSTRAINT `fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`);

--
-- Constraints for table `complaint_log`
--
ALTER TABLE `complaint_log`
  ADD CONSTRAINT `complaint_log_ibfk_1` FOREIGN KEY (`complaint_id`) REFERENCES `complaint` (`complaint_id`),
  ADD CONSTRAINT `complaint_log_ibfk_2` FOREIGN KEY (`changed_by`) REFERENCES `users` (`nid`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`complaint_id`) REFERENCES `complaint` (`complaint_id`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`citizen_nid`) REFERENCES `users` (`nid`);

--
-- Constraints for table `government_officials`
--
ALTER TABLE `government_officials`
  ADD CONSTRAINT `government_officials_ibfk_1` FOREIGN KEY (`official_nid`) REFERENCES `users` (`nid`),
  ADD CONSTRAINT `government_officials_ibfk_2` FOREIGN KEY (`zoneID`) REFERENCES `zones` (`zoneID`);

--
-- Constraints for table `location`
--
ALTER TABLE `location`
  ADD CONSTRAINT `fk_zone` FOREIGN KEY (`zoneID`) REFERENCES `zones` (`zoneID`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`nid`);

--
-- Constraints for table `otp_verification`
--
ALTER TABLE `otp_verification`
  ADD CONSTRAINT `otp_verification_ibfk_1` FOREIGN KEY (`nid`) REFERENCES `users` (`nid`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
