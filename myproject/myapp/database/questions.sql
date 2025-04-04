-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2025 at 10:04 AM
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
-- Database: `multiple_choice`
--

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `correct_answer` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`question_id`, `subject_id`, `question_text`, `correct_answer`) VALUES
(1, 1, 'OOP là viết tắt của:', 'Object Oriented Programming.'),
(2, 1, 'Đặc điểm cơ bản của lập trình hướng đối tượng thể hiện ở:', 'Tính đóng gói, tính kế thừa, tính đa hình, tính trừu tượng.'),
(3, 1, 'Lập trình hướng đối tượng là:', 'Lập trình hướng đối tượng là phương pháp đặt trọng tâm vào các đối tượng, nó không cho phép dữ liệu chuyển động một cách tự do trong hệ thống.'),
(4, 1, 'Thế nào được gọi là hiện tượng nạp chồng?', 'Hiện tượng lớp con kế thừa định nghĩa một hàm hoàn toàn giống lớp cha.'),
(5, 1, 'Trong java, khi khai báo một thuộc tính hoặc một hàm của một lớp mà không có từ khóa quyền truy cập thì mặc định quyền truy cập là gì?', 'friendly.'),
(6, 1, 'Đối với quyền truy cập nào thì cho phép truy cập các lớp con trong cùng gói với lớp cha?', 'friendly, protected, public.'),
(7, 1, 'Khi xây dựng phương thức khởi tạo (constructor), việc thường làm là:', 'Khởi tạo giá trị cho các thành phần dữ liệu của đối tượng.'),
(8, 1, 'Phương thức khởi tạo (constructor) là phương thức được thực thi:', 'Lúc tạo đối tượng.'),
(9, 1, 'Tên của phương thức khởi tạo:', 'Phải trùng với tên lớp.'),
(10, 1, 'Đối tượng sống kể từ khi:', 'Khởi tạo đối tượng (bằng toán tử new) cho đến hết khối chứa nó.'),
(11, 1, 'Chọn câu đúng nhất đối với hướng dẫn tạo lớp:', 'Lấy các động từ tác động lên đối tượng làm phương thức.'),
(12, 1, 'Từ khóa static có thể đứng trước:', 'Tất cả đều đúng.'),
(13, 1, 'Cho biết kết quả câu lệnh sau: System.out.println(Math.round(Math.random()*1000000)%100);', 'Kết quả xuất ra giá trị từ 0 đến 100.'),
(14, 1, 'Khi định nghĩa lớp con, từ khóa extends trong Java:', 'Đặt trước tên lớp cha.'),
(15, 1, 'Khi định nghĩa một lớp con:', 'A, B đều đúng.'),
(16, 1, 'Từ khóa this trong Java là:', 'Đối tượng đang thao tác.'),
(17, 1, 'Nếu modifier của lớp là public thì tên file .java:', 'Phải trùng với tên class, phân biệt chữ hoa và thường.'),
(18, 1, 'Biến đối tượng trong Java là:', 'Tham chiếu (địa chỉ) của vùng nhớ chứa dữ liệu của đối tượng.'),
(19, 1, 'Khi một thành phần của class được khai báo modifier là friendly thì thành phần đó:', 'Cho phép các đối tượng thuộc các class cùng package (cùng thư mục) truy cập.'),
(20, 1, 'Ưu điểm của OOP:', 'Câu A, B đúng.'),
(21, 1, 'Ưu điểm của OOP:', 'Câu A, C đúng.'),
(22, 1, 'Ưu điểm của class file trong Java là:', 'Cả 2 đều sai.'),
(23, 1, 'Source code của java có tên mở rộng là:', '.java'),
(24, 1, 'JDK bao gồm các thành phần chính:', 'Classes, Compiler, Debugger, Java, Runtime Environment.'),
(25, 1, 'Lớp Student có các thuộc tính: name, age và các phương thức: getName(), getAge(). Giả sử x là một đối tượng thuộc lớp Student. Chọn phát biểu đúng trong OOP:', 'int age = x.getAge();'),
(26, 1, 'Bao đóng là một đặt tính của OOP nhằm để:', 'Bên ngoài chỉ giao tiếp được với đối tượng thông qua một số phương thức.'),
(27, 1, 'Các từ khóa cho cấu trúc rẽ nhánh của Java gồm:', 'if, else, switch, case, default, break.'),
(28, 1, 'Các hằng trong Java gồm:', 'True, False, Null.'),
(29, 1, 'Tên đầu tiên của Java là gì?', 'Oak.'),
(30, 1, 'Giả sử đã định nghĩa lớp XX với một phương thức thông thường là Display, sau đó sinh ra đối tượng objX từ lớp XX. Để gọi phương thức Display ta sử dụng cú pháp nào?', 'objX.Display();'),
(31, 1, 'Đối tượng là gì?', 'Một thể hiện của lớp.'),
(32, 1, 'Từ khoá nào được sử dụng để khai báo một phương thức trong Java?', 'Method.'),
(33, 1, 'Từ khoá nào được sử dụng để khai báo một biến trong Java?', 'Var.'),
(34, 1, 'Từ khoá nào được sử dụng để khai báo một phương thức làm việc với đối tượng của lớp?', 'This.'),
(35, 1, 'Từ khoá nào được sử dụng để khai báo một phương thức được ghi đè trong Java?', 'Override.'),
(36, 1, 'Từ khoá nào được sử dụng để khai báo một phương thức được gọi tự động khi một đối tượng được tạo ra?', 'Constructor.'),
(37, 1, 'Từ khoá nào được sử dụng để khai báo một phương thức hoạt động như một lớp trừu tượng?', 'Abstract.'),
(38, 1, 'Từ khoá nào được sử dụng để khai báo một lớp trừu tượng trong Java?', 'Abstract.'),
(39, 1, 'Trong Java, lớp con là gì?', 'Lớp được kế thừa từ lớp cha.'),
(40, 1, 'Đặc điểm của Tính bao gói trong Lập trình hướng đối tượng:', 'Cơ chế ràng buộc dữ liệu và thao tác trên dữ liệu đó thành một thể thống nhất, tránh được các tác động bất ngờ từ bên ngoài. Thể thống nhất này được gọi là đối tượng.'),
(41, 1, 'Tính kế thừa trong lập trình hướng đối tượng:', 'Khả năng xây dựng các lớp mới từ lớp cũ, lớp mới được gọi là lớp dẫn xuất, lớp cũ được gọi là lớp cơ sở.'),
(42, 1, 'Trong kế thừa. Lớp mới có thuật ngữ tiếng Anh là:', 'Derived class.'),
(43, 1, 'Trong kế thừa. Lớp cha có thuật ngữ tiếng Anh là:', 'Derived class.'),
(44, 1, 'Đặc điểm của Tính đa hình?', 'Khả năng một thông điệp có thể thay đổi cách thể hiện của nó theo lớp cụ thể của đối tượng được nhận thông điệp.'),
(45, 1, 'Khái niệm Lớp đối tượng?', 'Một thiết kế hay mẫu cho các đối tượng cùng kiểu.'),
(46, 1, 'Trong các phương án sau, phương án nào mô tả đối tượng:', 'Tất cả đều đúng.'),
(47, 1, 'Muốn lập trình hướng đối tượng, bạn cần phải phân tích chương trình, bài toán thành các:', 'Các đối tượng từ đó xây dựng các lớp đối tượng tương ứng.'),
(48, 1, 'Khái niệm Trừu tượng hóa?', 'Phương pháp chỉ quan tâm đến những chi tiết cần thiết (chi tiết chính) và bỏ qua những chi tiết không cần thiết'),
(49, 1, 'Phương pháp lập trình tuần tự là:', 'Phương pháp lập trình với cách liệt kê các lệnh kế tiếp.'),
(50, 1, 'Phương pháp lập trình cấu trúc là:', 'Phương pháp lập trình với việc cấu trúc hóa dữ liệu và cấu trúc hóa chương trình để tránh các lệnh nhảy.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
