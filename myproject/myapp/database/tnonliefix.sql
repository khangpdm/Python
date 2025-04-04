-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2025 at 08:08 AM
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
-- Database: `tnonliefix`
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
(28, 'Can view ngan hang cau hoi', 7, 'view_nganhangcauhoi');

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

-- --------------------------------------------------------

--
-- Table structure for table `cau_hoi`
--

CREATE TABLE `cau_hoi` (
  `id` int(11) NOT NULL,
  `id_de` int(11) DEFAULT NULL,
  `id_ngan_hang` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chi_tiet_bai_lam`
--

CREATE TABLE `chi_tiet_bai_lam` (
  `id` int(11) NOT NULL,
  `id_bai_lam` int(11) DEFAULT NULL,
  `id_cau_hoi` int(11) DEFAULT NULL,
  `cau_tra_loi` char(1) DEFAULT NULL CHECK (`cau_tra_loi` in ('A','B','C','D')),
  `ket_qua` enum('Đúng','Sai') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, 'contenttypes', '0001_initial', '2025-04-04 06:06:53.953663'),
(2, 'auth', '0001_initial', '2025-04-04 06:06:54.296236'),
(3, 'admin', '0001_initial', '2025-04-04 06:06:54.383578'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-04-04 06:06:54.388999'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-04-04 06:06:54.394868'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-04-04 06:06:54.460429'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-04-04 06:06:54.492697'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-04-04 06:06:54.506040'),
(9, 'auth', '0004_alter_user_username_opts', '2025-04-04 06:06:54.511486'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-04-04 06:06:54.563884'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-04-04 06:06:54.567842'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-04-04 06:06:54.574437'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-04-04 06:06:54.594511'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-04-04 06:06:54.613814'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-04-04 06:06:54.634342'),
(16, 'auth', '0011_update_proxy_permissions', '2025-04-04 06:06:54.648782'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-04-04 06:06:54.673125'),
(18, 'sessions', '0001_initial', '2025-04-04 06:06:54.727863');

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
(1, 'OOP là viết tắt của:', 'Object Open Programming', 'Open Object Programming', 'Object Oriented Programming.', 'Object Oriented Proccessing.', 'C'),
(2, 'Đặc điểm cơ bản của lập trình hướng đối tượng thể hiện ở:', 'Tính đóng gói, tính kế thừa, tính đa hình, tính đặc biệt hóa.', 'Tính đóng gói, tính kế thừa, tính đa hình, tính trừu tượng.', 'Tính chia nhỏ, tính kế thừa.', 'Tính đóng gói, tính trừu tượng.', 'B'),
(3, 'Lập trình hướng đối tượng là:', 'Lập trình hướng đối tượng là phương pháp đặt trọng tâm vào các đối tượng, nó không cho phép dữ liệu chuyển động một cách tự do trong hệ thống.', 'Lập trình hướng đối tượng là phương pháp lập trình cơ bản gần với mã máy', 'Lập trình hướng đối tượng là phương pháp mới của lập trình máy tính, chia chương trình thành các hàm; quan tâm đến chức năng của hệ thống.', 'Lập trình hướng đối tượng là phương pháp đặt trọng tâm vào các chức năng, cấu trúc chương trình được xây dựng theo cách tiếp cận hướng chức năng.', 'A'),
(4, 'Thế nào được gọi là hiện tượng nạp chồng?', 'Hiện tượng lớp con kế thừa định nghĩa một hàm hoàn toàn giống lớp cha.', 'Hiện tượng lớp con kế thừa định nghĩa một hàm cùng tên nhưng khác kiểu với một hàm ở lớp cha.', 'Hiện tượng lớp con kế thừa định nghĩa một hàm cùng tên, cùng kiểu với một hàm ở lớp cha nhưng khác đối số', 'Hiện tượng lớp con kế thừa định nghĩa một hàm cùng tên, cùng các đối số nhưng khác kiểu với một hàm ở lớp cha.', 'A'),
(5, 'Trong java, khi khai báo một thuộc tính hoặc một hàm của một lớp mà không có từ khóa quyền truy cập thì mặc định quyền truy cập là gì?', 'public.', 'protected.', 'friendly.', 'private.', 'C'),
(6, 'Đối với quyền truy cập nào thì cho phép truy cập các lớp con trong cùng gói với lớp cha?', 'private, friendly, protected.', 'friendly, public.', 'friendly, protected, public.', 'public, protected.', 'C'),
(7, 'Khi xây dựng phương thức khởi tạo (constructor), việc thường làm là:', 'Khởi tạo giá trị cho các thành phần dữ liệu của đối tượng.', 'Khai báo kiểu cho các thành phần dữ liệu của đối tượng.', 'Khai báo các phương thức của đối tượng.', 'Tất cả đều sai.', 'A'),
(8, 'Phương thức khởi tạo (constructor) là phương thức được thực thi:', 'Lúc hủy đối tượng.', 'Lúc tạo đối tượng.', 'Lúc sử dụng đối tượng.', 'Cả ba câu trên đều đúng.', 'B'),
(9, 'Tên của phương thức khởi tạo:', 'Không được trùng với tên lớp.', 'Phải trùng với tên lớp.', 'Đặt tên tùy ý.', 'Tất cả đều đúng.', 'B'),
(10, 'Đối tượng sống kể từ khi:', 'Khởi tạo đối tượng (bằng toán tử new) cho đến hết phương trình.', 'Khởi tạo đối tượng (bằng toán tử new) cho đến hết phương thức chứa nó.', 'Khởi tạo đối tượng (bằng toán tử new) cho đến hết khối chứa nó.', 'Tất cả đều đúng.', 'D'),
(11, 'Chọn câu đúng nhất đối với hướng dẫn tạo lớp:', 'Lấy danh từ chính mô tả khái niệm làm tên lớp.', 'Lấy các danh từ mô tả cho khái niệm chính làm thuộc tính.', 'Lấy các động từ tác động lên đối tượng làm phương thức.', 'Tất cả đều đúng.', 'C'),
(12, 'Từ khóa static có thể đứng trước:', 'Thành phần dữ liệu của lớp.', 'Phương thức của lớp.', 'Đoạn code.', 'Tất cả đều đúng.', 'D'),
(13, 'Cho biết kết quả câu lệnh sau: System.out.println(Math.round(Math.random()*1000000)%100);', 'Kết quả xuất ra giá trị từ 0 đến 99.', 'Kết quả xuất ra giá trị từ 0 đến 100.', 'Kết quả xuất ra giá trị từ 1 đến 99.', 'Kết quả xuất ra giá trị từ 1 đến 100.', 'B'),
(14, 'Khi định nghĩa lớp con, từ khóa extends trong Java:', 'Đặt trước tên lớp con.', 'Đặt trước tên lớp cha.', 'Đặt sau tên lớp cha.', 'Tất cả đều sai.', 'B'),
(15, 'Khi định nghĩa một lớp con:', 'Được phép khai báo thêm các thành phần dữ liệu.', 'Được phép khai báo them các phương thức.', 'A, B đều sai.', 'A, B đều đúng.', 'D'),
(16, 'Từ khóa this trong Java là:', 'Đối tượng cha của đối tượng đang thao tác.', 'Đối tượng đang thao tác.', 'Cả 2 đều đúng.', 'Cả 2 đều sai.', 'B'),
(17, 'Nếu modifier của lớp là public thì tên file .java:', 'Phải trùng với tên class, phân biệt chữ hoa và thường.', 'Phải trùng với tên class, không phân biệt chữ hoa và thường.', 'Không phải trùng với tên class.', 'Tất cả đều sai.', 'A'),
(18, 'Biến đối tượng trong Java là:', 'Tham chiếu (địa chỉ) của vùng nhớ chứa dữ liệu của đối tượng.', 'Biến static.', 'Biến cục bộ.', 'Tất cả đều sai.', 'A'),
(19, 'Khi một thành phần của class được khai báo modifier là friendly thì thành phần đó:', 'Không cho phép các đối tượng thuộc các class cùng package (cùng thư mục) truy cập.', 'Cho phép các đối tượng thuộc các class cùng package (cùng thư mục) truy cập.', 'Cho phép các đối tượng thuộc các class cùng package (cùng thư mục) truy cập và khác package truy cập.', 'Tất cả đều đúng.', 'B'),
(20, 'Ưu điểm của OOP:', 'Dễ mô tả các quan hệ phân cấp trong thế giới thực.', 'Có tính bảo mật cao.', 'Câu A, B đúng.', 'Câu A, B sai.', 'C'),
(21, 'Ưu điểm của OOP:', 'Dễ tái sử dụng code.', 'Bảo mật kém.', 'Có tính bảo mật cao.', 'A, C đúng.', 'D'),
(22, 'Ưu điểm của class file trong Java là:', 'Java class file có thể được dùng ở bất kỳ platform nào.', 'Tính module hóa cao, dùng bộ nhớ tốt hơn với class file hơn là file thực thi vì class file cần một bước địch nữa mới được CPU thực thi.', 'Cả 2 đều đúng.', 'Cả 2 đều sai.', 'D'),
(23, 'Source code của java có tên mở rộng là:', '.class.', '.java.', '.com.', 'Tất cả đều sai.', 'B'),
(24, 'JDK bao gồm các thành phần chính:', 'Classes, Compiler, Debugger, Java Runtime Environment.', 'Classes, Compiler, Debugger.', 'Classes, Compiler, Java Runtime Environment.', 'Compiler, Debugger, Java Runtime Environment.', 'A'),
(25, 'Lớp Student có các thuộc tính: name, age và các phương thức: getName(), getAge(). Giả sử x là một đối tượng thuộc lớp Student. Chọn phát biểu đúng trong OOP:', 'int age = x.getAge();', 'getAge(x);', 'getName(x);', 'int age = getAge(x);', 'A'),
(26, 'Bao đóng là một đặt tính của OOP nhằm để:', 'Che dấu dữ liệu.', 'Bên ngoài chỉ giao tiếp được với đối tượng thông qua một số phương thức.', 'Cả 2 câu A, B đều đúng.', 'Cả 2 câu A, B đều sai.', 'B'),
(27, 'Các từ khóa cho cấu trúc rẽ nhánh của Java gồm:', 'if, else, switch, case, default, break.', 'IF, ELSE, SWITCH, CASE, DEFAULT, BREAK.', 'Cả 2 câu A, B đều đúng.', 'Cả 2 câu A, B đều sai.', 'A'),
(28, 'Các hằng trong Java gồm:', 'True, False, Null.', 'TRUE, FALSE, NULL.', 'True, False, NULL.', 'true, false, null.', 'C'),
(29, 'Tên đầu tiên của Java là gì?', 'Java.', 'Oak.', 'Cafe.', 'James golings.', 'B'),
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
(40, 'Đặc điểm của Tính bao gói trong Lập trình hướng đối tượng:', 'Cơ chế chia chương trình thành các hàm và thủ tục thực hiện các chức năng riêng rẽ.', 'Cơ chế cho thấy một hàm có thể có nhiều thể hiện khác nhau ở từng thời điểm.', 'Cơ chế rang buộc dữ liệu và thao tác trên dữ liệu đó thành một thể thống nhất, tránh được các tác động bất ngờ từ bên ngoài. Thể thống nhất này gọi là đối tượng.', 'Cơ chế không cho phép các thành phần khác truy cập đến bên trong nó.', 'C'),
(41, 'Tính kế thừa trong lập trình hướng đối tượng:', 'Khả năng xây dựng các lớp mới từ các lớp cũ, lớp mới được gọi là lớp dẫn xuất, lớp cũ được gọi là lớp cơ sở', 'Khả năng sử dụng lại các hàm đã xây dựng', 'Khả năng sử dụng lại các kiểu dữ liệu đã xây dựng', 'Tất cả đều đúng', 'A'),
(42, 'Trong kế thừa. Lớp mới có thuật ngữ tiếng Anh là:', 'Derived Class', 'Base Class', 'Inheritance Class', 'Object Class', 'A'),
(43, 'Trong kế thừa. Lớp cha có thuật ngữ tiếng Anh là:', 'Base Class', 'Derived Class', 'Inheritance Class', 'Object Class', 'B'),
(44, 'Đặc điểm của Tính đa hình?', 'Khả năng một hàm, thủ tục có thể được kế thừa lại', 'Khả năng một thông điệp có thể được truyền lại cho lớp con của nó', 'Khả năng một hàm, thủ tục được sử dụng lại', 'Khả năng một thông điệp có thể thay đổi cách thể hiện của nó theo lớp cụ thể của đối tượng được nhận thông điệp', 'D'),
(45, 'Khái niệm Lớp đối tượng?', 'Một thiết kế hay mẫu cho các đối tượng cùng kiểu', 'Một thể hiện cụ thể cho các đối tượng', 'Tập các phần tử cùng loại', 'Tập các giá trị cùng loại', 'A'),
(46, 'Trong các phương án sau, phương án nào mô tả đối tượng:', 'Máy tính', 'Xe đạp', 'Quả cam', 'Tất cả đều đúng', 'D'),
(47, 'Muốn lập trình hướng đối tượng, bạn cần phải phân tích chương trình, bài toán thành các:', 'Hàm, thủ tục', 'Các module', 'Các đối tượng từ đó xây dựng các lớp đối tượng tương ứng', 'Các thông điệp', 'C'),
(48, 'Khái niệm Trừu tượng hóa?', 'Phương pháp chỉ quan tâm đến những chi tiết cần thiết (chi tiết chính) và bỏ qua những chi tiết không cần thiết', 'Phương pháp quan tâm đến mọi chi tiết của đối tượng', 'Phương pháp thay thế những chi tiết chính bằng những chi tiết tương tự', 'Không có phương án chính xác', 'A'),
(49, 'Phương pháp lập trình tuần tự là:', 'Phương pháp lập trình với việc cấu trúc hóa dữ liệu và cấu trúc hóa chương trình để tránh các lệnh nhảy', 'Phương pháp lập trình với cách liệt kê các lệnh kế tiếp', 'Phương pháp lập trình được cấu trúc nghiêm ngặt với cấu trúc dạng module', 'Phương pháp xây dựng chương trình ứng dụng theo quan điểm dựa trên các cấu trúc dữ liệu trừu tượng, các thể hiện cụ thể của cấu trúc và quan hệ giữa chúng', 'B'),
(50, 'Phương pháp lập trình cấu trúc là:', 'Phương pháp lập trình với cách liệt kê các lệnh kế tiếp', 'Phương pháp quan tâm đến mọi chi tiết của đối tượng', 'Phương pháp lập trình với việc cấu trúc hóa dữ liệu và cấu trúc hóa chương trình để tránh các lệnh nhảy', 'Phương pháp lập trình được cấu trúc nghiêm ngặt với cấu trúc dạng module', 'C');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cau_hoi`
--
ALTER TABLE `cau_hoi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chi_tiet_bai_lam`
--
ALTER TABLE `chi_tiet_bai_lam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `de_thi`
--
ALTER TABLE `de_thi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

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
