-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2025 at 11:02 AM
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
  `trang_thai` enum('dang_cho_cham','da_cham') DEFAULT 'dang_cho_cham',
  `hinh_anh_bai_lam` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bai_lam`
--

INSERT INTO `bai_lam` (`id`, `id_hoc_sinh`, `id_de`, `ngay_nop`, `trang_thai`, `hinh_anh_bai_lam`) VALUES
(53, 3, 4, '2025-05-06 07:47:49', 'da_cham', 'exam_submissions/minhkhang_mau5_tcJ5Khq.png'),
(54, 3, 7, '2025-05-06 07:48:00', 'da_cham', 'exam_submissions/minhkhang_mau5_zRZuhFL.png'),
(55, 2, 9, '2025-05-06 08:11:16', 'dang_cho_cham', 'exam_submissions/ngocphuong_1.jpg'),
(56, 3, 9, '2025-05-06 08:27:31', 'da_cham', 'exam_submissions/minhkhang_1_M8wXaGs.jpg');

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
(2647, 53, 12, 'A', 'Sai'),
(2648, 53, 43, 'B', 'Đúng'),
(2649, 53, 105, 'C', 'Đúng'),
(2650, 53, 32, 'D', 'Sai'),
(2651, 53, 16, 'A', 'Sai'),
(2652, 53, 62, '', ''),
(2653, 53, 44, '', ''),
(2654, 53, 73, '', ''),
(2655, 53, 95, '', ''),
(2656, 53, 38, '', ''),
(2657, 53, 55, '', ''),
(2658, 53, 28, '', ''),
(2659, 53, 45, '', ''),
(2660, 53, 109, '', ''),
(2661, 53, 113, '', ''),
(2662, 53, 26, '', ''),
(2663, 53, 103, '', ''),
(2664, 53, 114, '', ''),
(2665, 53, 75, '', ''),
(2666, 53, 18, '', ''),
(2667, 53, 20, '', ''),
(2668, 53, 85, '', ''),
(2669, 53, 77, '', ''),
(2670, 53, 68, '', ''),
(2671, 53, 111, '', ''),
(2672, 53, 34, '', ''),
(2673, 53, 64, '', ''),
(2674, 53, 42, '', ''),
(2675, 53, 52, '', ''),
(2676, 53, 104, '', ''),
(2677, 53, 106, '', ''),
(2678, 53, 88, '', ''),
(2679, 53, 92, '', ''),
(2680, 53, 97, '', ''),
(2681, 53, 82, '', ''),
(2682, 53, 117, '', ''),
(2683, 53, 11, '', ''),
(2684, 53, 81, '', ''),
(2685, 53, 89, '', ''),
(2686, 53, 99, '', ''),
(2687, 53, 96, '', ''),
(2688, 53, 93, '', ''),
(2689, 53, 56, '', ''),
(2690, 53, 91, '', ''),
(2691, 53, 3, '', ''),
(2692, 53, 86, '', ''),
(2693, 53, 53, '', ''),
(2694, 53, 46, '', ''),
(2695, 53, 4, '', ''),
(2696, 53, 10, '', ''),
(2697, 54, 65, 'A', 'Sai'),
(2698, 54, 112, 'B', 'Đúng'),
(2699, 54, 85, 'C', 'Đúng'),
(2700, 54, 68, 'D', 'Sai'),
(2701, 54, 64, 'A', 'Sai'),
(2702, 54, 47, '', ''),
(2703, 54, 58, '', ''),
(2704, 54, 39, '', ''),
(2705, 54, 36, '', ''),
(2706, 54, 63, '', ''),
(2707, 54, 42, '', ''),
(2708, 54, 38, '', ''),
(2709, 54, 72, '', ''),
(2710, 54, 105, '', ''),
(2711, 54, 84, '', ''),
(2712, 54, 30, '', ''),
(2713, 54, 25, '', ''),
(2714, 54, 51, '', ''),
(2715, 54, 59, '', ''),
(2716, 54, 96, '', ''),
(2717, 54, 11, '', ''),
(2718, 54, 34, '', ''),
(2719, 54, 8, '', ''),
(2720, 54, 9, '', ''),
(2721, 54, 49, '', ''),
(2722, 54, 111, '', ''),
(2723, 54, 107, '', ''),
(2724, 54, 32, '', ''),
(2725, 54, 87, '', ''),
(2726, 54, 7, '', ''),
(2727, 54, 1, '', ''),
(2728, 54, 13, '', ''),
(2729, 54, 71, '', ''),
(2730, 54, 29, '', ''),
(2731, 54, 94, '', ''),
(2732, 54, 104, '', ''),
(2733, 54, 90, '', ''),
(2734, 54, 10, '', ''),
(2735, 54, 91, '', ''),
(2736, 54, 79, '', ''),
(2737, 54, 21, '', ''),
(2738, 54, 53, '', ''),
(2739, 54, 116, '', ''),
(2740, 54, 28, '', ''),
(2741, 54, 77, '', ''),
(2742, 54, 62, '', ''),
(2743, 54, 37, '', ''),
(2744, 54, 114, '', ''),
(2745, 54, 48, '', ''),
(2746, 54, 60, '', ''),
(2747, 55, 26, 'A', 'Sai'),
(2748, 55, 102, 'B', 'Sai'),
(2749, 55, 104, 'B', 'Đúng'),
(2750, 55, 116, '', ''),
(2751, 55, 80, 'A', 'Sai'),
(2752, 55, 62, 'C', 'Sai'),
(2753, 55, 4, 'D', 'Sai'),
(2754, 55, 94, 'B', 'Sai'),
(2755, 55, 54, 'A, D', 'Sai'),
(2756, 55, 89, 'C, D', 'Sai'),
(2757, 55, 106, 'C', 'Sai'),
(2758, 55, 48, 'A', 'Đúng'),
(2759, 55, 12, 'D', 'Đúng'),
(2760, 55, 35, 'B', 'Sai'),
(2761, 55, 50, '', ''),
(2762, 55, 82, 'A', 'Sai'),
(2763, 55, 52, 'D', 'Sai'),
(2764, 55, 27, 'B', 'Sai'),
(2765, 55, 20, 'C', 'Đúng'),
(2766, 55, 98, 'A', 'Sai'),
(2767, 55, 92, '', ''),
(2768, 55, 113, 'B', 'Sai'),
(2769, 55, 23, '', ''),
(2770, 55, 76, '', ''),
(2771, 55, 8, 'C', 'Sai'),
(2772, 55, 86, 'A', 'Sai'),
(2773, 55, 114, 'C', 'Sai'),
(2774, 55, 59, '', ''),
(2775, 55, 11, 'D', 'Sai'),
(2776, 55, 58, 'B', 'Sai'),
(2777, 55, 3, '', ''),
(2778, 55, 40, 'B', 'Sai'),
(2779, 55, 61, 'A', 'Sai'),
(2780, 55, 66, 'B', 'Sai'),
(2781, 55, 65, 'C', 'Đúng'),
(2782, 55, 99, 'D', 'Sai'),
(2783, 55, 110, 'A', 'Sai'),
(2784, 55, 31, '', ''),
(2785, 55, 24, 'B', 'Sai'),
(2786, 55, 30, 'C', 'Đúng'),
(2787, 55, 120, '', ''),
(2788, 55, 69, 'A', 'Sai'),
(2789, 55, 68, 'B', 'Đúng'),
(2790, 55, 111, 'C', 'Sai'),
(2791, 55, 64, 'D', 'Sai'),
(2792, 55, 85, 'C', 'Đúng'),
(2793, 55, 44, 'A', 'Sai'),
(2794, 55, 60, '', ''),
(2795, 55, 17, 'B', 'Sai'),
(2796, 55, 91, '', ''),
(2797, 56, 26, 'A', 'Sai'),
(2798, 56, 102, 'B', 'Sai'),
(2799, 56, 104, 'B', 'Đúng'),
(2800, 56, 116, '', ''),
(2801, 56, 80, 'A', 'Sai'),
(2802, 56, 62, 'C', 'Sai'),
(2803, 56, 4, 'D', 'Sai'),
(2804, 56, 94, 'B', 'Sai'),
(2805, 56, 54, 'A, D', 'Sai'),
(2806, 56, 89, 'C, D', 'Sai'),
(2807, 56, 106, 'C', 'Sai'),
(2808, 56, 48, 'A', 'Đúng'),
(2809, 56, 12, 'D', 'Đúng'),
(2810, 56, 35, 'B', 'Sai'),
(2811, 56, 50, '', ''),
(2812, 56, 82, 'A', 'Sai'),
(2813, 56, 52, 'D', 'Sai'),
(2814, 56, 27, 'B', 'Sai'),
(2815, 56, 20, 'C', 'Đúng'),
(2816, 56, 98, 'A', 'Sai'),
(2817, 56, 92, '', ''),
(2818, 56, 113, 'B', 'Sai'),
(2819, 56, 23, '', ''),
(2820, 56, 76, '', ''),
(2821, 56, 8, 'C', 'Sai'),
(2822, 56, 86, 'A', 'Sai'),
(2823, 56, 114, 'C', 'Sai'),
(2824, 56, 59, '', ''),
(2825, 56, 11, 'D', 'Sai'),
(2826, 56, 58, 'B', 'Sai'),
(2827, 56, 3, '', ''),
(2828, 56, 40, 'B', 'Sai'),
(2829, 56, 61, 'A', 'Sai'),
(2830, 56, 66, 'B', 'Sai'),
(2831, 56, 65, 'C', 'Đúng'),
(2832, 56, 99, 'D', 'Sai'),
(2833, 56, 110, 'A', 'Sai'),
(2834, 56, 31, '', ''),
(2835, 56, 24, 'B', 'Sai'),
(2836, 56, 30, 'C', 'Đúng'),
(2837, 56, 120, '', ''),
(2838, 56, 69, 'A', 'Sai'),
(2839, 56, 68, 'B', 'Đúng'),
(2840, 56, 111, 'C', 'Sai'),
(2841, 56, 64, 'D', 'Sai'),
(2842, 56, 85, 'C', 'Đúng'),
(2843, 56, 44, 'A', 'Sai'),
(2844, 56, 60, '', ''),
(2845, 56, 17, 'B', 'Sai'),
(2846, 56, 91, '', '');

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
(4, 'thi cuối kỳ', '', '2025-04-08 08:41:15', NULL),
(6, 'thi cuối kỳ 2', '111', '2025-04-08 08:53:19', 1),
(7, 'thi cuối kỳ 1', '112', '2025-04-08 08:55:24', 1),
(9, 'minhkhang', '113', '2025-05-06 07:24:18', 3);

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
(150, 7, 60, 50),
(201, 9, 26, 1),
(202, 9, 102, 2),
(203, 9, 104, 3),
(204, 9, 116, 4),
(205, 9, 80, 5),
(206, 9, 62, 6),
(207, 9, 4, 7),
(208, 9, 94, 8),
(209, 9, 54, 9),
(210, 9, 89, 10),
(211, 9, 106, 11),
(212, 9, 48, 12),
(213, 9, 12, 13),
(214, 9, 35, 14),
(215, 9, 50, 15),
(216, 9, 82, 16),
(217, 9, 52, 17),
(218, 9, 27, 18),
(219, 9, 20, 19),
(220, 9, 98, 20),
(221, 9, 92, 21),
(222, 9, 113, 22),
(223, 9, 23, 23),
(224, 9, 76, 24),
(225, 9, 8, 25),
(226, 9, 86, 26),
(227, 9, 114, 27),
(228, 9, 59, 28),
(229, 9, 11, 29),
(230, 9, 58, 30),
(231, 9, 3, 31),
(232, 9, 40, 32),
(233, 9, 61, 33),
(234, 9, 66, 34),
(235, 9, 65, 35),
(236, 9, 99, 36),
(237, 9, 110, 37),
(238, 9, 31, 38),
(239, 9, 24, 39),
(240, 9, 30, 40),
(241, 9, 120, 41),
(242, 9, 69, 42),
(243, 9, 68, 43),
(244, 9, 111, 44),
(245, 9, 64, 45),
(246, 9, 85, 46),
(247, 9, 44, 47),
(248, 9, 60, 48),
(249, 9, 17, 49),
(250, 9, 91, 50);

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

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('b35dudx0sbon26y7wj249u36bsv0h9g1', 'eyJ1c2VybmFtZSI6Im1pbmhraGFuZzEiLCJyb2xlIjoidGVhY2hlciJ9:1uCE8C:oCAqV0VlyCqq97-MdXH3mkNXomBEdOjEH8OG-tIkhF8', '2025-05-20 08:58:28.623536'),
('n8pplnzu9bzd4dghi78xpy1itiq8bcnu', 'eyJ1c2VybmFtZSI6Im1pbmhraGFuZzEiLCJyb2xlIjoidGVhY2hlciJ9:1u8Lfh:vl7XyMnnpCvNERrRAaKQ2otPwqcueyvWUa_bg5pddgQ', '2025-05-09 16:13:01.039804'),
('xndn6jntlghhujppcr7u8mzlk11u7v3a', 'eyJ1c2VybmFtZSI6Im1pbmhraGFuZyIsInJvbGUiOiJzdHVkZW50In0:1u8OyM:W30hjBwZwnwvsWeBIAfOp7WMvxS1mHUGPJc6ea6ivt4', '2025-05-09 19:44:30.500801');

-- --------------------------------------------------------

--
-- Table structure for table `giao_vien`
--

CREATE TABLE `giao_vien` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `dark_mode` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `giao_vien`
--

INSERT INTO `giao_vien` (`id`, `ten_dang_nhap`, `mat_khau`, `dark_mode`) VALUES
(1, 'hongtham1', '12345', 0),
(2, 'ngocphuong1', '12345', 0),
(3, 'minhkhang1', '12345', 0),
(4, 'hoangphuc1', '12345', 0);

-- --------------------------------------------------------

--
-- Table structure for table `hoc_sinh`
--

CREATE TABLE `hoc_sinh` (
  `id` int(11) NOT NULL,
  `ten_dang_nhap` varchar(50) NOT NULL,
  `mat_khau` varchar(255) NOT NULL,
  `dark_mode` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hoc_sinh`
--

INSERT INTO `hoc_sinh` (`id`, `ten_dang_nhap`, `mat_khau`, `dark_mode`) VALUES
(1, 'hongtham', '12345', 0),
(2, 'ngocphuong', '12345', 0),
(3, 'minhkhang', '12345', 0),
(4, 'hoangphuc', '12345', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ket_qua`
--

CREATE TABLE `ket_qua` (
  `id` int(11) NOT NULL,
  `id_bai_lam` int(11) DEFAULT NULL,
  `diem` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ket_qua`
--

INSERT INTO `ket_qua` (`id`, `id_bai_lam`, `diem`) VALUES
(29, 53, 0.4),
(30, 54, 0.4),
(31, 55, 1.6),
(32, 56, 1.6);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `chi_tiet_bai_lam`
--
ALTER TABLE `chi_tiet_bai_lam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2847;

--
-- AUTO_INCREMENT for table `de_thi`
--
ALTER TABLE `de_thi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `de_thi_chi_tiet`
--
ALTER TABLE `de_thi_chi_tiet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=251;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

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
-- Constraints for table `chi_tiet_bai_lam`
--
ALTER TABLE `chi_tiet_bai_lam`
  ADD CONSTRAINT `chi_tiet_bai_lam_ibfk_1` FOREIGN KEY (`id_bai_lam`) REFERENCES `bai_lam` (`id`) ON DELETE CASCADE;

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
