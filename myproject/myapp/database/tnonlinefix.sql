-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 08, 2025 at 11:04 AM
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
-- Database: `tnonlinefix`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add ngan hang cau hoi', 7, 'add_nganhangcauhoi'),
(26, 'Can change ngan hang cau hoi', 7, 'change_nganhangcauhoi'),
(27, 'Can delete ngan hang cau hoi', 7, 'delete_nganhangcauhoi'),
(28, 'Can view ngan hang cau hoi', 7, 'view_nganhangcauhoi'),
(29, 'Can add de thi', 8, 'add_dethi'),
(30, 'Can change de thi', 8, 'change_dethi'),
(31, 'Can delete de thi', 8, 'delete_dethi'),
(32, 'Can view de thi', 8, 'view_dethi'),
(33, 'Can add de thi chi tiet', 9, 'add_dethichitiet'),
(34, 'Can change de thi chi tiet', 9, 'change_dethichitiet'),
(35, 'Can delete de thi chi tiet', 9, 'delete_dethichitiet'),
(36, 'Can view de thi chi tiet', 9, 'view_dethichitiet');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bai_lam`
--

CREATE TABLE `bai_lam` (
  `id` int(11) NOT NULL,
  `id_hoc_sinh` int(11) DEFAULT NULL,
  `id_de` int(11) DEFAULT NULL,
  `ngay_nop` datetime DEFAULT current_timestamp(),
  `trang_thai` enum('dang_cho_cham','da_cham') DEFAULT 'dang_cho_cham'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bai_lam`
--

INSERT INTO `bai_lam` (`id`, `id_hoc_sinh`, `id_de`, `ngay_nop`, `trang_thai`) VALUES
(1, 1, 1, '2025-04-01 10:00:00', 'dang_cho_cham');

-- --------------------------------------------------------

--
-- Table structure for table `cau_hoi`
--

CREATE TABLE `cau_hoi` (
  `id` int(11) NOT NULL,
  `id_de` int(11) DEFAULT NULL,
  `id_ngan_hang` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cau_hoi`
--

INSERT INTO `cau_hoi` (`id`, `id_de`, `id_ngan_hang`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 1, 14),
(15, 1, 15),
(16, 1, 16),
(17, 1, 17),
(18, 1, 18),
(19, 1, 19),
(20, 1, 20),
(21, 1, 21),
(22, 1, 22),
(23, 1, 23),
(24, 1, 24),
(25, 1, 25),
(26, 1, 26),
(27, 1, 27),
(28, 1, 28),
(29, 1, 29),
(30, 1, 30),
(31, 1, 31),
(32, 1, 32),
(33, 1, 33),
(34, 1, 34),
(35, 1, 35),
(36, 1, 36),
(37, 1, 37),
(38, 1, 38),
(39, 1, 39),
(40, 1, 40),
(41, 1, 41),
(42, 1, 42),
(43, 1, 43),
(44, 1, 44),
(45, 1, 45),
(46, 1, 46),
(47, 1, 47),
(48, 1, 48),
(49, 1, 49),
(50, 1, 50),
(51, 1, 51),
(52, 1, 52),
(53, 1, 53),
(54, 1, 54),
(55, 1, 55),
(56, 1, 56),
(57, 1, 57),
(58, 1, 58),
(59, 1, 59),
(60, 1, 60),
(61, 1, 61),
(62, 1, 62),
(63, 1, 63),
(64, 1, 64),
(65, 1, 65),
(66, 1, 66),
(67, 1, 67),
(68, 1, 68),
(69, 1, 69),
(70, 1, 70),
(71, 1, 71),
(72, 1, 72),
(73, 1, 73),
(74, 1, 74),
(75, 1, 75),
(76, 1, 76),
(77, 1, 77),
(78, 1, 78),
(79, 1, 79),
(80, 1, 80),
(81, 1, 81),
(82, 1, 82),
(83, 1, 83),
(84, 1, 84),
(85, 1, 85),
(86, 1, 86),
(87, 1, 87),
(88, 1, 88),
(89, 1, 89),
(90, 1, 90),
(91, 1, 91),
(92, 1, 92),
(93, 1, 93),
(94, 1, 94),
(95, 1, 95),
(96, 1, 96),
(97, 1, 97),
(98, 1, 98),
(99, 1, 99),
(100, 1, 100),
(101, 1, 101),
(102, 1, 102),
(103, 1, 103),
(104, 1, 104),
(105, 1, 105),
(106, 1, 106),
(107, 1, 107),
(108, 1, 108),
(109, 1, 109),
(110, 1, 110),
(111, 1, 111),
(112, 1, 112),
(113, 1, 113),
(114, 1, 114),
(115, 1, 115),
(116, 1, 116),
(117, 1, 117),
(118, 1, 118),
(119, 1, 119),
(120, 1, 120);

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_bai_lam`
--

CREATE TABLE `chi_tiet_bai_lam` (
  `id` int(11) NOT NULL,
  `id_bai_lam` int(11) DEFAULT NULL,
  `id_cau_hoi` int(11) DEFAULT NULL,
  `cau_tra_loi` char(255) DEFAULT NULL,
  `ket_qua` enum('Đúng','Sai') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chi_tiet_bai_lam`
--

INSERT INTO `chi_tiet_bai_lam` (`id`, `id_bai_lam`, `id_cau_hoi`, `cau_tra_loi`, `ket_qua`) VALUES
(562, 1, 1, 'A', 'Sai'),
(563, 1, 2, 'B', 'Đúng'),
(564, 1, 3, 'B', 'Sai'),
(565, 1, 5, 'A', 'Sai'),
(566, 1, 6, 'C', 'Đúng'),
(567, 1, 7, 'D', 'Sai'),
(568, 1, 8, 'B', 'Đúng'),
(569, 1, 9, 'A, D', 'Sai'),
(570, 1, 10, 'C, D', 'Sai'),
(571, 1, 11, 'C', 'Đúng'),
(572, 1, 12, 'A', 'Sai'),
(573, 1, 13, 'D', 'Sai'),
(574, 1, 14, 'B', 'Đúng'),
(575, 1, 16, 'A', 'Sai'),
(576, 1, 17, 'D', 'Sai'),
(577, 1, 18, 'B', 'Sai'),
(578, 1, 19, 'C', 'Sai'),
(579, 1, 20, 'A', 'Sai'),
(580, 1, 22, 'B', 'Sai'),
(581, 1, 25, 'C', 'Sai'),
(582, 1, 26, 'A', 'Sai'),
(583, 1, 27, 'C', 'Sai'),
(584, 1, 29, 'D', 'Sai'),
(585, 1, 30, 'B', 'Sai'),
(586, 1, 32, 'B', 'Sai'),
(587, 1, 33, 'A', 'Đúng'),
(588, 1, 34, 'B', 'Sai'),
(589, 1, 35, 'C', 'Sai'),
(590, 1, 36, 'D', 'Sai'),
(591, 1, 37, 'A', 'Đúng'),
(592, 1, 39, 'B', 'Sai'),
(593, 1, 40, 'C', 'Đúng'),
(594, 1, 42, 'A', 'Đúng'),
(595, 1, 43, 'B', 'Đúng'),
(596, 1, 44, 'C', 'Sai'),
(597, 1, 45, 'D', 'Sai'),
(598, 1, 46, 'C', 'Sai'),
(599, 1, 47, 'A', 'Sai'),
(600, 1, 49, 'B', 'Đúng'),
(601, 1, 51, 'B', 'Sai'),
(602, 1, 52, 'D', 'Sai'),
(603, 1, 53, 'A', 'Sai'),
(604, 1, 54, 'B, D', 'Sai'),
(605, 1, 55, 'C', 'Sai'),
(606, 1, 56, 'B', 'Đúng'),
(607, 1, 57, 'A, C', 'Sai'),
(608, 1, 58, 'C', 'Sai'),
(609, 1, 59, 'A, B, C, D', 'Sai'),
(610, 1, 60, 'B, C, D', 'Sai'),
(611, 1, 61, 'B, D', 'Sai'),
(612, 1, 62, 'A', 'Sai'),
(613, 1, 63, 'B', 'Sai'),
(614, 1, 64, 'A', 'Sai'),
(615, 1, 65, 'C', 'Đúng'),
(616, 1, 66, 'A', 'Sai'),
(617, 1, 68, 'B, D', 'Sai'),
(618, 1, 69, 'C', 'Đúng'),
(619, 1, 70, 'A', 'Sai'),
(620, 1, 71, 'B', 'Sai'),
(621, 1, 72, 'A', 'Sai'),
(622, 1, 73, 'D', 'Sai'),
(623, 1, 74, 'C', 'Sai'),
(624, 1, 75, 'B', 'Sai'),
(625, 1, 76, 'B', 'Đúng'),
(626, 1, 77, 'C', 'Đúng'),
(627, 1, 78, 'A', 'Sai'),
(628, 1, 79, 'D', 'Sai'),
(629, 1, 80, 'B, C', 'Sai'),
(630, 1, 81, 'A, D', 'Sai'),
(631, 1, 82, 'B', 'Sai'),
(632, 1, 83, 'A', 'Đúng'),
(633, 1, 84, 'C', 'Sai'),
(634, 1, 85, 'B, D', 'Sai'),
(635, 1, 86, 'D', 'Đúng'),
(636, 1, 87, 'C', 'Sai'),
(637, 1, 88, 'A', 'Sai'),
(638, 1, 89, 'C', 'Đúng'),
(639, 1, 90, 'B, C, D', 'Sai'),
(640, 1, 91, 'B, D', 'Sai'),
(641, 1, 92, 'C', 'Sai'),
(642, 1, 94, 'A, B, C', 'Sai'),
(643, 1, 95, 'D', 'Sai'),
(644, 1, 96, 'C', 'Sai'),
(645, 1, 97, 'A', 'Sai'),
(646, 1, 98, 'B', 'Sai'),
(647, 1, 99, 'D', 'Sai'),
(648, 1, 100, 'A, C', 'Sai'),
(649, 1, 101, 'B', 'Sai'),
(650, 1, 102, 'A', 'Sai'),
(651, 1, 103, 'D', 'Sai'),
(652, 1, 104, 'C', 'Sai'),
(653, 1, 105, 'B', 'Sai'),
(654, 1, 106, 'C', 'Sai'),
(655, 1, 107, 'A', 'Đúng'),
(656, 1, 108, 'D', 'Sai'),
(657, 1, 109, 'B', 'Sai'),
(658, 1, 110, 'A', 'Sai'),
(659, 1, 111, 'C', 'Sai'),
(660, 1, 112, 'B', 'Đúng'),
(661, 1, 113, 'A, D', 'Sai'),
(662, 1, 114, 'B, C', 'Sai'),
(663, 1, 115, 'A, C, D', 'Sai'),
(664, 1, 116, 'A, D', 'Sai'),
(665, 1, 117, 'B', 'Sai'),
(666, 1, 119, 'B, D', 'Sai'),
(667, 1, 120, 'A, B, C', 'Sai');

-- --------------------------------------------------------

--
-- Table structure for table `de_thi`
--

CREATE TABLE `de_thi` (
  `id` int(11) NOT NULL,
  `ten_de` varchar(255) NOT NULL,
  `ma_de` varchar(50) NOT NULL,
  `ngay_tao` datetime DEFAULT current_timestamp(),
  `id_giao_vien` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `de_thi`
--

INSERT INTO `de_thi` (`id`, `ten_de`, `ma_de`, `ngay_tao`, `id_giao_vien`) VALUES
(1, 'Đề thi OOP 120', 'DE120', '2025-04-05 14:40:46', 1),
(4, 'thi cuối kỳ', '', '2025-04-08 08:41:15', NULL),
(6, 'thi cuối kỳ 2', '111', '2025-04-08 08:53:19', 1),
(7, 'thi cuối kỳ 1', '112', '2025-04-08 08:55:24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `de_thi_chi_tiet`
--

CREATE TABLE `de_thi_chi_tiet` (
  `id` int(11) NOT NULL,
  `de_thi_id` int(11) NOT NULL,
  `cau_hoi_id` int(11) NOT NULL,
  `thu_tu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `de_thi_chi_tiet`
--

INSERT INTO `de_thi_chi_tiet` (`id`, `de_thi_id`, `cau_hoi_id`, `thu_tu`) VALUES
(1, 4, 12, 1),
(2, 4, 43, 2),
(3, 4, 105, 3),
(4, 4, 32, 4),
(5, 4, 16, 5),
(6, 4, 62, 6),
(7, 4, 44, 7),
(8, 4, 73, 8),
(9, 4, 95, 9),
(10, 4, 38, 10),
(11, 4, 55, 11),
(12, 4, 28, 12),
(13, 4, 45, 13),
(14, 4, 109, 14),
(15, 4, 113, 15),
(16, 4, 26, 16),
(17, 4, 103, 17),
(18, 4, 114, 18),
(19, 4, 75, 19),
(20, 4, 18, 20),
(21, 4, 20, 21),
(22, 4, 85, 22),
(23, 4, 77, 23),
(24, 4, 68, 24),
(25, 4, 111, 25),
(26, 4, 34, 26),
(27, 4, 64, 27),
(28, 4, 42, 28),
(29, 4, 52, 29),
(30, 4, 104, 30),
(31, 4, 106, 31),
(32, 4, 88, 32),
(33, 4, 92, 33),
(34, 4, 97, 34),
(35, 4, 82, 35),
(36, 4, 117, 36),
(37, 4, 11, 37),
(38, 4, 81, 38),
(39, 4, 89, 39),
(40, 4, 99, 40),
(41, 4, 96, 41),
(42, 4, 93, 42),
(43, 4, 56, 43),
(44, 4, 91, 44),
(45, 4, 3, 45),
(46, 4, 86, 46),
(47, 4, 53, 47),
(48, 4, 46, 48),
(49, 4, 4, 49),
(50, 4, 10, 50),
(51, 6, 94, 1),
(52, 6, 20, 2),
(53, 6, 11, 3),
(54, 6, 67, 4),
(55, 6, 34, 5),
(56, 6, 17, 6),
(57, 6, 102, 7),
(58, 6, 52, 8),
(59, 6, 2, 9),
(60, 6, 62, 10),
(61, 6, 65, 11),
(62, 6, 76, 12),
(63, 6, 98, 13),
(64, 6, 24, 14),
(65, 6, 16, 15),
(66, 6, 25, 16),
(67, 6, 15, 17),
(68, 6, 104, 18),
(69, 6, 85, 19),
(70, 6, 70, 20),
(71, 6, 10, 21),
(72, 6, 36, 22),
(73, 6, 112, 23),
(74, 6, 110, 24),
(75, 6, 51, 25),
(76, 6, 61, 26),
(77, 6, 69, 27),
(78, 6, 48, 28),
(79, 6, 56, 29),
(80, 6, 71, 30),
(81, 6, 117, 31),
(82, 6, 106, 32),
(83, 6, 73, 33),
(84, 6, 78, 34),
(85, 6, 113, 35),
(86, 6, 46, 36),
(87, 6, 90, 37),
(88, 6, 81, 38),
(89, 6, 9, 39),
(90, 6, 118, 40),
(91, 6, 33, 41),
(92, 6, 68, 42),
(93, 6, 58, 43),
(94, 6, 44, 44),
(95, 6, 60, 45),
(96, 6, 77, 46),
(97, 6, 6, 47),
(98, 6, 79, 48),
(99, 6, 26, 49),
(100, 6, 55, 50),
(101, 7, 65, 1),
(102, 7, 112, 2),
(103, 7, 85, 3),
(104, 7, 68, 4),
(105, 7, 64, 5),
(106, 7, 47, 6),
(107, 7, 58, 7),
(108, 7, 39, 8),
(109, 7, 36, 9),
(110, 7, 63, 10),
(111, 7, 42, 11),
(112, 7, 38, 12),
(113, 7, 72, 13),
(114, 7, 105, 14),
(115, 7, 84, 15),
(116, 7, 30, 16),
(117, 7, 25, 17),
(118, 7, 51, 18),
(119, 7, 59, 19),
(120, 7, 96, 20),
(121, 7, 11, 21),
(122, 7, 34, 22),
(123, 7, 8, 23),
(124, 7, 9, 24),
(125, 7, 49, 25),
(126, 7, 111, 26),
(127, 7, 107, 27),
(128, 7, 32, 28),
(129, 7, 87, 29),
(130, 7, 7, 30),
(131, 7, 1, 31),
(132, 7, 13, 32),
(133, 7, 71, 33),
(134, 7, 29, 34),
(135, 7, 94, 35),
(136, 7, 104, 36),
(137, 7, 90, 37),
(138, 7, 10, 38),
(139, 7, 91, 39),
(140, 7, 79, 40),
(141, 7, 21, 41),
(142, 7, 53, 42),
(143, 7, 116, 43),
(144, 7, 28, 44),
(145, 7, 77, 45),
(146, 7, 62, 46),
(147, 7, 37, 47),
(148, 7, 114, 48),
(149, 7, 48, 49),
(150, 7, 60, 50);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(8, 'myapp', 'dethi'),
(9, 'myapp', 'dethichitiet'),
(7, 'myapp', 'nganhangcauhoi'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-04-08 08:23:46.346585'),
(2, 'auth', '0001_initial', '2025-04-08 08:23:46.726813'),
(3, 'admin', '0001_initial', '2025-04-08 08:23:46.826628'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-04-08 08:23:46.836317'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-04-08 08:23:46.850515'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-04-08 08:23:46.928749'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-04-08 08:23:46.978959'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-04-08 08:23:46.993637'),
(9, 'auth', '0004_alter_user_username_opts', '2025-04-08 08:23:47.004691'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-04-08 08:23:47.050637'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-04-08 08:23:47.064035'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-04-08 08:23:47.079696'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-04-08 08:23:47.098071'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-04-08 08:23:47.112245'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-04-08 08:23:47.139285'),
(16, 'auth', '0011_update_proxy_permissions', '2025-04-08 08:23:47.150914'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-04-08 08:23:47.171024'),
(18, 'sessions', '0001_initial', '2025-04-08 08:23:47.211500');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `giao_vien`
--

CREATE TABLE `giao_vien` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `giao_vien`
--

INSERT INTO `giao_vien` (`id`, `ten_dang_nhap`, `mat_khau`) VALUES
(1, 'hongtham1', '12345'),
(2, 'ngocphuong1', '12345'),
(3, 'minhkhang1', '12345'),
(4, 'hoangphuc1', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `hoc_sinh`
--

CREATE TABLE `hoc_sinh` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hoc_sinh`
--

INSERT INTO `hoc_sinh` (`id`, `ten_dang_nhap`, `mat_khau`) VALUES
(1, 'hongtham', '12345'),
(2, 'ngocphuong', '12345'),
(3, 'minhkhang', '12345'),
(4, 'hoangphuc', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `ket_qua`
--

CREATE TABLE `ket_qua` (
  `id` int(11) NOT NULL,
  `id_bai_lam` int(11) DEFAULT NULL,
  `diem` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ngan_hang_cau_hoi`
--

CREATE TABLE `ngan_hang_cau_hoi` (
  `id` int(11) NOT NULL,
  `noi_dung` text NOT NULL,
  `dap_an_A` text NOT NULL,
  `dap_an_B` text NOT NULL,
  `dap_an_C` text NOT NULL,
  `dap_an_D` text NOT NULL,
  `dap_an_dung` char(1) DEFAULT NULL CHECK (`dap_an_dung` in ('A','B','C','D'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ngan_hang_cau_hoi`
--

INSERT INTO `ngan_hang_cau_hoi` (`id`, `noi_dung`, `dap_an_A`, `dap_an_B`, `dap_an_C`, `dap_an_D`, `dap_an_dung`) VALUES
(1, 'OOP là viết tắt của:', 'Object Open Programming', 'Open Object Programming', 'Object Oriented Programming.', 'Object Oriented Processing.', 'C'),
(2, 'Đặc điểm cơ bản của lập trình hướng đối tượng thể hiện ở:', 'Tính đóng gói, tính kế thừa, tính đa hình, tính đặc biệt hóa.', 'Tính đóng gói, tính kế thừa, tính đa hình, tính trừu tượng.', 'Tính chia nhỏ, tính kế thừa.', 'Tính đóng gói, tính trừu tượng.', 'B'),
(3, 'Lập trình hướng đối tượng là:', 'Lập trình hướng đối tượng là phương pháp đặt trọng tâm vào các đối tượng.', 'Lập trình hướng đối tượng là phương pháp lập trình cơ bản gần với mã máy.', 'Lập trình hướng đối tượng là phương pháp mới của lập trình máy tính.', 'Lập trình hướng đối tượng là phương pháp đặt trọng tâm vào các chức năng.', 'A'),
(4, 'Thế nào được gọi là hiện tượng nạp chồng?', 'Hiện tượng lớp con kế thừa định nghĩa một hàm hoàn toàn giống lớp cha.', 'Hiện tượng lớp con kế thừa định nghĩa một hàm cùng tên nhưng khác kiểu với một hàm ở lớp cha.', 'Hiện tượng lớp con kế thừa định nghĩa một hàm cùng tên, cùng kiểu với một hàm ở lớp cha nhưng khác đối số.', 'Hiện tượng lớp con kế thừa định nghĩa một hàm cùng tên, cùng các đối số nhưng khác kiểu với một hàm ở lớp cha.', 'A'),
(5, 'Trong Java, khi khai báo một thuộc tính hoặc một hàm của một lớp mà không có từ khóa quyền truy cập thì mặc định quyền truy cập là gì?', 'public.', 'protected.', 'friendly.', 'private.', 'C'),
(6, 'Đối với quyền truy cập nào thì cho phép truy cập các lớp con trong cùng gói với lớp cha?', 'private, friendly, protected.', 'friendly, public.', 'friendly, protected, public.', 'public, protected.', 'C'),
(7, 'Khi xây dựng phương thức khởi tạo (constructor), việc thường làm là:', 'Khởi tạo giá trị cho các thành phần dữ liệu của đối tượng.', 'Khai báo kiểu cho các thành phần dữ liệu của đối tượng.', 'Khai báo các phương thức của đối tượng.', 'Tất cả đều sai.', 'A'),
(8, 'Phương thức khởi tạo (constructor) là phương thức được thực thi:', 'Lúc hủy đối tượng.', 'Lúc tạo đối tượng.', 'Lúc sử dụng đối tượng.', 'Cả ba câu trên đều đúng.', 'B'),
(9, 'Tên của phương thức khởi tạo:', 'Không được trùng với tên lớp.', 'Phải trùng với tên lớp.', 'Đặt tên tùy ý.', 'Tất cả đều đúng.', 'B'),
(10, 'Đối tượng sống kể từ khi:', 'Khởi tạo đối tượng (bằng toán tử new) cho đến hết phương trình.', 'Khởi tạo đối tượng (bằng toán tử new) cho đến hết phương thức chứa nó.', 'Khởi tạo đối tượng (bằng toán tử new) cho đến hết khối chứa nó.', 'Tất cả đều đúng.', 'D'),
(11, 'Chọn câu đúng nhất đối với hướng dẫn tạo lớp:', 'Lấy danh từ chính mô tả khái niệm làm tên lớp.', 'Lấy các danh từ mô tả cho khái niệm chính làm thuộc tính.', 'Lấy các động từ tác động lên đối tượng làm phương thức.', 'Tất cả đều đúng.', 'C'),
(12, 'Từ khóa static có thể đứng trước:', 'Thành phần dữ liệu của lớp.', 'Phương thức của lớp.', 'Đoạn code.', 'Tất cả đều đúng.', 'D'),
(13, 'Cho biết kết quả câu lệnh sau: System.out.println(Math.round(Math.random()*1000000)%100);', 'Kết quả xuất ra giá trị từ 0 đến 99.', 'Kết quả xuất ra giá trị từ 0 đến 100.', 'Kết quả xuất ra giá trị từ 1 đến 99.', 'Kết quả xuất ra giá trị từ 1 đến 100.', 'B'),
(14, 'Khi định nghĩa lớp con, từ khóa extends trong Java:', 'Đặt trước tên lớp con.', 'Đặt trước tên lớp cha.', 'Đặt sau tên lớp cha.', 'Tất cả đều sai.', 'B'),
(15, 'Khi định nghĩa một lớp con:', 'Được phép khai báo thêm các thành phần dữ liệu.', 'Được phép khai báo thêm các phương thức.', 'A, B đều sai.', 'A, B đều đúng.', 'D'),
(16, 'Từ khóa this trong Java là:', 'Đối tượng cha của đối tượng đang thao tác.', 'Đối tượng đang thao tác.', 'Cả 2 đều đúng.', 'Cả 2 đều sai.', 'B'),
(17, 'Nếu modifier của lớp là public thì tên file .java:', 'Phải trùng với tên class, phân biệt chữ hoa và thường.', 'Phải trùng với tên class, không phân biệt chữ hoa và thường.', 'Không phải trùng với tên class.', 'Tất cả đều sai.', 'A'),
(18, 'Biến đối tượng trong Java là:', 'Tham chiếu (địa chỉ) của vùng nhớ chứa dữ liệu của đối tượng.', 'Biến static.', 'Biến cục bộ.', 'Tất cả đều sai.', 'A'),
(19, 'Khi một thành phần của class được khai báo modifier là friendly thì thành phần đó:', 'Không cho phép các đối tượng thuộc các class cùng package (cùng thư mục) truy cập.', 'Cho phép các đối tượng thuộc các class cùng package (cùng thư mục) truy cập.', 'Cho phép các đối tượng thuộc các class cùng package (cùng thư mục) truy cập và khác package truy cập.', 'Tất cả đều đúng.', 'B'),
(20, 'Ưu điểm của OOP:', 'Dễ mô tả các quan hệ phân cấp trong thế giới thực.', 'Có tính bảo mật cao.', 'Câu A, B đúng.', 'Câu A, B sai.', 'C'),
(21, 'Ưu điểm của OOP:', 'Dễ tái sử dụng code.', 'Bảo mật kém.', 'Có tính bảo mật cao.', 'A, C đúng.', 'D'),
(22, 'Ưu điểm của class file trong Java là:', 'Java class file có thể được dùng ở bất kỳ platform nào.', 'Tính module hóa cao, dùng bộ nhớ tốt hơn với class file hơn là file thực thi.', 'Cả 2 đều đúng.', 'Cả 2 đều sai.', 'D'),
(23, 'Source code của java có tên mở rộng là:', '.class.', '.java.', '.com.', 'Tất cả đều sai.', 'B'),
(24, 'JDK bao gồm các thành phần chính:', 'Classes, Compiler, Debugger, Java Runtime Environment.', 'Classes, Compiler, Debugger.', 'Classes, Compiler, Java Runtime Environment.', 'Compiler, Debugger, Java Runtime Environment.', 'A'),
(25, 'Lớp Student có các thuộc tính: name, age và các phương thức: getName(), getAge(). Giả sử x là một đối tượng thuộc lớp Student. Chọn phát biểu đúng trong OOP:', 'int age = x.getAge();', 'getAge(x);', 'getName(x);', 'int age = getAge(x);', 'A'),
(26, 'Bao đóng là một đặt tính của OOP nhằm để:', 'Che dấu dữ liệu.', 'Bên ngoài chỉ giao tiếp được với đối tượng thông qua một số phương thức.', 'Cả 2 câu A, B đều đúng.', 'Cả 2 câu A, B đều sai.', 'B'),
(27, 'Các từ khóa cho cấu trúc rẽ nhánh của Java gồm:', 'if, else, switch, case, default, break.', 'IF, ELSE, SWITCH, CASE, DEFAULT, BREAK.', 'Cả 2 câu A, B đều đúng.', 'Cả 2 câu A, B đều sai.', 'A'),
(28, 'Các hằng trong Java gồm:', 'True, False, Null.', 'TRUE, FALSE, NULL.', 'True, False, NULL.', 'true, false, null.', 'C'),
(29, 'Tên đầu tiên của Java là gì?', 'Java.', 'Oak.', 'Cafe.', 'James Gosling.', 'B'),
(30, 'Giả sử đã định nghĩa lớp XX với một phương thức thông thường là Display, sau đó sinh ra đối tượng objX từ lớp XX. Để gọi phương thức Display ta sử dụng cú pháp nào?', 'XX.Display;', 'XX.Display();', 'objX.Display();', 'Display();', 'C'),
(31, 'Đối tượng là gì?', 'Các lớp được tạo thể hiện từ đó;', 'Một thể hiện của lớp;', 'Một tham chiếu đến một thuộc tính;', 'Một biến;', 'B'),
(32, 'Từ khoá nào được sử dụng để khai báo một phương thức trong Java?', 'Method', 'Function', 'Procedure', 'Class', 'A'),
(33, 'Từ khoá nào được sử dụng để khai báo một biến trong Java?', 'Var;', 'Int;', 'Class;', 'Display;', 'A'),
(34, 'Từ khoá nào được sử dụng để khai báo một phương thức làm việc với đối tượng của lớp?', 'This', 'Super', 'Private', 'Tất cả đều sai;', 'A'),
(35, 'Từ khoá nào được sử dụng để khai báo một phương thức được ghi đè trong Java?', 'Override', 'Overload', 'Super', 'Tất cả đều đúng', 'A'),
(36, 'Từ khoá nào được sử dụng để khai báo một phương thức được gọi tự động khi một đối tượng được tạo ra?', 'Constructor', 'Destructor', 'Initializer', 'Tất cả đều đúng', 'A'),
(37, 'Từ khoá nào được sử dụng để khai báo một phương thức hoạt động như một lớp trừu tượng?', 'Abstract', 'Virtual', 'Static', 'Tất cả đều sai', 'A'),
(38, 'Từ khoá nào được sử dụng để khai báo một lớp trừu tượng trong Java?', 'Abstract', 'Virtual', 'Static', 'Tất cả đều đúng', 'A'),
(39, 'Trong Java, lớp con là gì?', 'Lớp được kế thừa từ lớp cha', 'Lớp được tạo bởi một đối tượng', 'Lớp được tạo bởi một phương thức', 'Tất cả đều đúng', 'A'),
(40, 'Đặc điểm của Tính bao gói trong Lập trình hướng đối tượng:', 'Cơ chế chia chương trình thành các hàm và thủ tục thực hiện các chức năng riêng rẽ.', 'Cơ chế cho thấy một hàm có thể có nhiều thể hiện khác nhau ở từng thời điểm.', 'Cơ chế rang buộc dữ liệu và thao tác trên dữ liệu đó thành một thể thống nhất.', 'Cơ chế không cho phép các thành phần khác truy cập đến bên trong nó.', 'C'),
(41, 'Tính kế thừa trong lập trình hướng đối tượng:', 'Khả năng xây dựng các lớp mới từ các lớp cũ.', 'Khả năng sử dụng lại các hàm đã xây dựng.', 'Khả năng sử dụng lại các kiểu dữ liệu đã xây dựng.', 'Tất cả đều đúng', 'A'),
(42, 'Trong kế thừa. Lớp mới có thuật ngữ tiếng Anh là:', 'Derived Class', 'Base Class', 'Inheritance Class', 'Object Class', 'A'),
(43, 'Trong kế thừa. Lớp cha có thuật ngữ tiếng Anh là:', 'Base Class', 'Derived Class', 'Inheritance Class', 'Object Class', 'B'),
(44, 'Đặc điểm của Tính đa hình?', 'Khả năng một hàm, thủ tục có thể được kế thừa lại.', 'Khả năng một thông điệp có thể được truyền lại cho lớp con của nó.', 'Khả năng một hàm, thủ tục được sử dụng lại.', 'Khả năng một thông điệp có thể thay đổi cách thể hiện của nó theo lớp cụ thể của đối tượng.', 'D'),
(45, 'Khái niệm Lớp đối tượng?', 'Một thiết kế hay mẫu cho các đối tượng cùng kiểu.', 'Một thể hiện cụ thể cho các đối tượng.', 'Tập các phần tử cùng loại.', 'Tập các giá trị cùng loại.', 'A'),
(46, 'Trong các phương án sau, phương án nào mô tả đối tượng:', 'Máy tính', 'Xe đạp', 'Quả cam', 'Tất cả đều đúng', 'D'),
(47, 'Muốn lập trình hướng đối tượng, bạn cần phải phân tích chương trình, bài toán thành các:', 'Hàm, thủ tục', 'Các module', 'Các đối tượng từ đó xây dựng các lớp đối tượng tương ứng', 'Các thông điệp', 'C'),
(48, 'Khái niệm Trừu tượng hóa?', 'Phương pháp chỉ quan tâm đến những chi tiết cần thiết và bỏ qua những chi tiết không cần thiết.', 'Phương pháp quan tâm đến mọi chi tiết của đối tượng.', 'Phương pháp thay thế những chi tiết chính bằng những chi tiết tương tự.', 'Không có phương án chính xác.', 'A'),
(49, 'Phương pháp lập trình tuần tự là:', 'Phương pháp lập trình với việc cấu trúc hóa dữ liệu và cấu trúc hóa chương trình để tránh các lệnh nhảy.', 'Phương pháp lập trình với cách liệt kê các lệnh kế tiếp.', 'Phương pháp lập trình được cấu trúc nghiêm ngặt với cấu trúc dạng module.', 'Phương pháp xây dựng chương trình ứng dụng theo quan điểm dựa trên các cấu trúc dữ liệu trừu tượng.', 'B'),
(50, 'Phương pháp lập trình cấu trúc là:', 'Phương pháp lập trình với cách liệt kê các lệnh kế tiếp.', 'Phương pháp quan tâm đến mọi chi tiết của đối tượng.', 'Phương pháp lập trình với việc cấu trúc hóa dữ liệu và cấu trúc hóa chương trình để tránh các lệnh nhảy.', 'Phương pháp lập trình được cấu trúc nghiêm ngặt với cấu trúc dạng module.', 'C'),
(51, 'Câu hỏi 51', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(52, 'Câu hỏi 52', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(53, 'Câu hỏi 53', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(54, 'Câu hỏi 54', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(55, 'Câu hỏi 55', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(56, 'Câu hỏi 56', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(57, 'Câu hỏi 57', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(58, 'Câu hỏi 58', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(59, 'Câu hỏi 59', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(60, 'Câu hỏi 60', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(61, 'Câu hỏi 61', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(62, 'Câu hỏi 62', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(63, 'Câu hỏi 63', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(64, 'Câu hỏi 64', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(65, 'Câu hỏi 65', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(66, 'Câu hỏi 66', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(67, 'Câu hỏi 67', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(68, 'Câu hỏi 68', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(69, 'Câu hỏi 69', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(70, 'Câu hỏi 70', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(71, 'Câu hỏi 71', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(72, 'Câu hỏi 72', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(73, 'Câu hỏi 73', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(74, 'Câu hỏi 74', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(75, 'Câu hỏi 75', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(76, 'Câu hỏi 76', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(77, 'Câu hỏi 77', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(78, 'Câu hỏi 78', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(79, 'Câu hỏi 79', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(80, 'Câu hỏi 80', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(81, 'Câu hỏi 81', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(82, 'Câu hỏi 82', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(83, 'Câu hỏi 83', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(84, 'Câu hỏi 84', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(85, 'Câu hỏi 85', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(86, 'Câu hỏi 86', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(87, 'Câu hỏi 87', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(88, 'Câu hỏi 88', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(89, 'Câu hỏi 89', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(90, 'Câu hỏi 90', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(91, 'Câu hỏi 91', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(92, 'Câu hỏi 92', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(93, 'Câu hỏi 93', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(94, 'Câu hỏi 94', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(95, 'Câu hỏi 95', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(96, 'Câu hỏi 96', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(97, 'Câu hỏi 97', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(98, 'Câu hỏi 98', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(99, 'Câu hỏi 99', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(100, 'Câu hỏi 100', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(101, 'Câu hỏi 101', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(102, 'Câu hỏi 102', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(103, 'Câu hỏi 103', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(104, 'Câu hỏi 104', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(105, 'Câu hỏi 105', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(106, 'Câu hỏi 106', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(107, 'Câu hỏi 107', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(108, 'Câu hỏi 108', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(109, 'Câu hỏi 109', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(110, 'Câu hỏi 110', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(111, 'Câu hỏi 111', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(112, 'Câu hỏi 112', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(113, 'Câu hỏi 113', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(114, 'Câu hỏi 114', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(115, 'Câu hỏi 115', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(116, 'Câu hỏi 116', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B'),
(117, 'Câu hỏi 117', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'C'),
(118, 'Câu hỏi 118', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'D'),
(119, 'Câu hỏi 119', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'A'),
(120, 'Câu hỏi 120', 'Đáp án A', 'Đáp án B', 'Đáp án C', 'Đáp án D', 'B');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `bai_lam`
--
ALTER TABLE `bai_lam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_hoc_sinh` (`id_hoc_sinh`),
  ADD KEY `id_de` (`id_de`);

--
-- Indexes for table `cau_hoi`
--
ALTER TABLE `cau_hoi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_de` (`id_de`),
  ADD KEY `id_ngan_hang` (`id_ngan_hang`);

--
-- Indexes for table `chi_tiet_bai_lam`
--
ALTER TABLE `chi_tiet_bai_lam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_bai_lam` (`id_bai_lam`),
  ADD KEY `id_cau_hoi` (`id_cau_hoi`);

--
-- Indexes for table `de_thi`
--
ALTER TABLE `de_thi`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ma_de` (`ma_de`),
  ADD KEY `id_giao_vien` (`id_giao_vien`);

--
-- Indexes for table `de_thi_chi_tiet`
--
ALTER TABLE `de_thi_chi_tiet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `de_thi_id` (`de_thi_id`),
  ADD KEY `cau_hoi_id` (`cau_hoi_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `giao_vien`
--
ALTER TABLE `giao_vien`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`);

--
-- Indexes for table `hoc_sinh`
--
ALTER TABLE `hoc_sinh`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ten_dang_nhap` (`ten_dang_nhap`);

--
-- Indexes for table `ket_qua`
--
ALTER TABLE `ket_qua`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_bai_lam` (`id_bai_lam`);

--
-- Indexes for table `ngan_hang_cau_hoi`
--
ALTER TABLE `ngan_hang_cau_hoi`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bai_lam`
--
ALTER TABLE `bai_lam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cau_hoi`
--
ALTER TABLE `cau_hoi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `chi_tiet_bai_lam`
--
ALTER TABLE `chi_tiet_bai_lam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=668;

--
-- AUTO_INCREMENT for table `de_thi`
--
ALTER TABLE `de_thi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `de_thi_chi_tiet`
--
ALTER TABLE `de_thi_chi_tiet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `giao_vien`
--
ALTER TABLE `giao_vien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `hoc_sinh`
--
ALTER TABLE `hoc_sinh`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ket_qua`
--
ALTER TABLE `ket_qua`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ngan_hang_cau_hoi`
--
ALTER TABLE `ngan_hang_cau_hoi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `bai_lam`
--
ALTER TABLE `bai_lam`
  ADD CONSTRAINT `bai_lam_ibfk_1` FOREIGN KEY (`id_hoc_sinh`) REFERENCES `hoc_sinh` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bai_lam_ibfk_2` FOREIGN KEY (`id_de`) REFERENCES `de_thi` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cau_hoi`
--
ALTER TABLE `cau_hoi`
  ADD CONSTRAINT `cau_hoi_ibfk_1` FOREIGN KEY (`id_de`) REFERENCES `de_thi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cau_hoi_ibfk_2` FOREIGN KEY (`id_ngan_hang`) REFERENCES `ngan_hang_cau_hoi` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `chi_tiet_bai_lam`
--
ALTER TABLE `chi_tiet_bai_lam`
  ADD CONSTRAINT `chi_tiet_bai_lam_ibfk_1` FOREIGN KEY (`id_bai_lam`) REFERENCES `bai_lam` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `chi_tiet_bai_lam_ibfk_2` FOREIGN KEY (`id_cau_hoi`) REFERENCES `cau_hoi` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `de_thi`
--
ALTER TABLE `de_thi`
  ADD CONSTRAINT `de_thi_ibfk_1` FOREIGN KEY (`id_giao_vien`) REFERENCES `giao_vien` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `de_thi_chi_tiet`
--
ALTER TABLE `de_thi_chi_tiet`
  ADD CONSTRAINT `de_thi_chi_tiet_ibfk_1` FOREIGN KEY (`de_thi_id`) REFERENCES `de_thi` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `de_thi_chi_tiet_ibfk_2` FOREIGN KEY (`cau_hoi_id`) REFERENCES `ngan_hang_cau_hoi` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `ket_qua`
--
ALTER TABLE `ket_qua`
  ADD CONSTRAINT `ket_qua_ibfk_1` FOREIGN KEY (`id_bai_lam`) REFERENCES `bai_lam` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
