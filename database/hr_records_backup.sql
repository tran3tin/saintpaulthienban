-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 24, 2025 at 03:13 PM
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
-- Database: `hr_records`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `record_id` bigint(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `old_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_value`)),
  `new_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_value`)),
  `ip_address` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `description`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(1, 1, 'CREATE', 'sisters', 1, NULL, NULL, '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-14T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-09T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":null,\"documents\":null}', '127.0.0.1', '2025-12-21 16:02:40'),
(2, 1, 'UPDATE', 'sisters', 1, NULL, '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-14T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-09T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":null,\"documents\":null}', '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-13T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-08T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-19T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-17T17:00:00.000Z\",\"first_communion_date\":\"2010-12-24T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-21T16:05:17.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:05:17'),
(3, 1, 'UPDATE', 'sisters', 1, NULL, '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-13T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-08T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-19T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-17T17:00:00.000Z\",\"first_communion_date\":\"2010-12-24T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-21T16:05:17.000Z\",\"documents\":null}', '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-12T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-07T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-18T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-16T17:00:00.000Z\",\"first_communion_date\":\"2010-12-23T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-21T16:07:13.000Z\",\"documents\":\"[{\\\"id\\\":1766333230557,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766333230548-837iw9.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-21T16:07:10.557Z\\\"}]\"}', '127.0.0.1', '2025-12-21 16:07:13'),
(4, 1, 'UPDATE', 'sisters', 1, NULL, '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-12T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-07T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-18T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-16T17:00:00.000Z\",\"first_communion_date\":\"2010-12-23T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-21T16:07:13.000Z\",\"documents\":\"[{\\\"id\\\":1766333230557,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766333230548-837iw9.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-21T16:07:10.557Z\\\"}]\"}', '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-12T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-07T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-18T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-16T17:00:00.000Z\",\"first_communion_date\":\"2010-12-23T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":\"/uploads/photos/1766333233177-gczzjn.jpg\",\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-21T16:07:13.000Z\",\"documents\":\"[{\\\"id\\\":1766333230557,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766333230548-837iw9.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-21T16:07:10.557Z\\\"}]\"}', '127.0.0.1', '2025-12-21 16:07:13'),
(5, 1, 'CREATE', 'communities', 1, NULL, NULL, '{\"id\":1,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Sài Gòn\",\"address\":\"456 Duong Le Loi, Quan 1, TP Ho Chi Minh\",\"phone\":\"0283456789\",\"email\":\"congdoan.saigon@example.com\",\"established_date\":\"2015-01-14T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cong doan tai Thanh pho Ho Chi Minh, thanh lap nam 2015, chuyen co tu luc dung linh duc duong theo tien chi tham nhat cua Hoi dong OSP. Co khoang 45 chi em dang tap khon, hoc tap va dung cop tu do thuc hanh Tin Loi.\",\"created_at\":\"2025-12-21T16:09:03.000Z\",\"updated_at\":null,\"history\":null}', '127.0.0.1', '2025-12-21 16:09:03'),
(6, 1, 'UPDATE', 'communities', 1, NULL, '{\"id\":1,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Sài Gòn\",\"address\":\"456 Duong Le Loi, Quan 1, TP Ho Chi Minh\",\"phone\":\"0283456789\",\"email\":\"congdoan.saigon@example.com\",\"established_date\":\"2015-01-14T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cong doan tai Thanh pho Ho Chi Minh, thanh lap nam 2015, chuyen co tu luc dung linh duc duong theo tien chi tham nhat cua Hoi dong OSP. Co khoang 45 chi em dang tap khon, hoc tap va dung cop tu do thuc hanh Tin Loi.\",\"created_at\":\"2025-12-21T16:09:03.000Z\",\"updated_at\":null,\"history\":null}', '{\"id\":1,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Sài Gòn\",\"address\":\"456 Duong Le Loi, Quan 1, TP Ho Chi Minh\",\"phone\":\"0283456789\",\"email\":\"congdoan.saigon@example.com\",\"established_date\":\"2015-01-14T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cong doan tai Thanh pho Ho Chi Minh, thanh lap nam 2015, chuyen co tu luc dung linh duc duong theo tien chi tham nhat cua Hoi dong OSP. Co khoang 45 chi em dang tap khon, hoc tap va dung cop tu do thuc hanh Tin Loi.\",\"created_at\":\"2025-12-21T16:09:03.000Z\",\"updated_at\":\"2025-12-21T16:11:45.000Z\",\"history\":\"<p>Cong Doan Sai Gon la mot cong doan co lich su hinh thanh vao nam 2015, o thanh pho Ho Chi Minh. Cong doan co muc dich chi soc va phuc vu nhung nguoi ngheo, bi mac sot va bi co doan.</p><p><br></p><p>Hien tai, Cong doan co khoang 45 chi em dang hoat dong the nay. Mot so hoat dong chinh bao gom: Tap Deu Day hang tuan, chuong trinh day du ly the he, ho tro tai chinh va tro giup cac gia dinh kho khan.</p><p><br></p><p>Trung thuc va hang nam, Cong doan thuong co mot chuong trinh hu luc the he long tap trung vao phuc vu mo cang hoa lung van ha xa hoi.</p>\"}', '127.0.0.1', '2025-12-21 16:11:45'),
(7, 1, 'UPDATE', 'communities', 1, NULL, '{\"id\":1,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Sài Gòn\",\"address\":\"456 Duong Le Loi, Quan 1, TP Ho Chi Minh\",\"phone\":\"0283456789\",\"email\":\"congdoan.saigon@example.com\",\"established_date\":\"2015-01-14T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cong doan tai Thanh pho Ho Chi Minh, thanh lap nam 2015, chuyen co tu luc dung linh duc duong theo tien chi tham nhat cua Hoi dong OSP. Co khoang 45 chi em dang tap khon, hoc tap va dung cop tu do thuc hanh Tin Loi.\",\"created_at\":\"2025-12-21T16:09:03.000Z\",\"updated_at\":\"2025-12-21T16:11:45.000Z\",\"history\":\"<p>Cong Doan Sai Gon la mot cong doan co lich su hinh thanh vao nam 2015, o thanh pho Ho Chi Minh. Cong doan co muc dich chi soc va phuc vu nhung nguoi ngheo, bi mac sot va bi co doan.</p><p><br></p><p>Hien tai, Cong doan co khoang 45 chi em dang hoat dong the nay. Mot so hoat dong chinh bao gom: Tap Deu Day hang tuan, chuong trinh day du ly the he, ho tro tai chinh va tro giup cac gia dinh kho khan.</p><p><br></p><p>Trung thuc va hang nam, Cong doan thuong co mot chuong trinh hu luc the he long tap trung vao phuc vu mo cang hoa lung van ha xa hoi.</p>\"}', '{\"id\":1,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Sài Gòn\",\"address\":\"456 Duong Le Loi, Quan 1, TP Ho Chi Minh\",\"phone\":\"0283456789\",\"email\":\"congdoan.saigon@example.com\",\"established_date\":\"2015-01-14T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cong doan tai Thanh pho Ho Chi Minh, thanh lap nam 2015, chuyen co tu luc dung linh duc duong theo tien chi tham nhat cua Hoi dong OSP. Co khoang 45 chi em dang tap khon, hoc tap va dung cop tu do thuc hanh Tin Loi.\",\"created_at\":\"2025-12-21T16:09:03.000Z\",\"updated_at\":\"2025-12-21T16:12:42.000Z\",\"history\":\"<p>Cộng Đoàn Sài Gòn là một cộng đoàn có lịch sử hình thành vào năm 2015, ở thành phố Hồ Chí Minh. Cộng đoàn có mục đích chữ sóc và phục vụ những người nghèo, bọ mẹc bệnh tát và bị cơ đơn.</p><p><br></p><p>Hiện tại, Cộng đoàn có khoảng 45 chị em đang hoạt động. Một số hoạt động chính bao gồm: Tập học hàng tuần, chương trình dạy dự lý thế hệ, hỗ trợ tài chính và trợ giúp các gia đình khó khăn.</p><p><br></p><p>Hàng năm, Cộng đoàn có những chương trình tìm kiếm và phục vụ các gia đình có hoàn cảnh khó đõi, đồng thời phủc vụ văn hóa xã hội cộng đồng.</p>\"}', '127.0.0.1', '2025-12-21 16:12:42'),
(8, 1, 'CREATE', 'communities', 2, NULL, NULL, '{\"id\":2,\"code\":\"CD002\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"789 Duong Pho doc Thang, Thanh pho Da Lat\",\"phone\":\"0633123456\",\"email\":\"congdoan.dalat@example.com\",\"established_date\":\"2016-03-09T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Đà Lạt thành lập năm 2016 ở thành phố Đà Lạt. Cộng đoàn hoạt động nhằm giúp đỡ các em về phát triển tân thế, có khoảng 35 chị em. Hàng năm có các chương trình hỗ trợ gia đình và hào phỗ.\",\"created_at\":\"2025-12-21T16:15:02.000Z\",\"updated_at\":null,\"history\":null}', '127.0.0.1', '2025-12-21 16:15:02'),
(9, 1, 'CREATE', 'communities', 3, NULL, NULL, '{\"id\":3,\"code\":\"CD003\",\"name\":\"Cộng Đoàn Hà Nội\",\"address\":\"234 Duong Thach Thi Thanh, Quan Hoan Kiem, Ha Noi\",\"phone\":\"0434567890\",\"email\":\"congdoan.hanoi@example.com\",\"established_date\":\"2014-05-19T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Hà Nội thành lập năm 2014, là một trong những cộng đoàn cổ xưa nhất của Hội Động OSP. Cộng đoàn có khoảng 55 chị em đang hoạt động. Một số hoạt động chính: đãy dỡ đức vỞ quốc, hỗ trợ tài chính cho các em và gia đình nghèo khó.\",\"created_at\":\"2025-12-21T16:16:21.000Z\",\"updated_at\":null,\"history\":null}', '127.0.0.1', '2025-12-21 16:16:21'),
(10, 1, 'UPDATE', 'communities', 2, NULL, '{\"id\":2,\"code\":\"CD002\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"789 Duong Pho doc Thang, Thanh pho Da Lat\",\"phone\":\"0633123456\",\"email\":\"congdoan.dalat@example.com\",\"established_date\":\"2016-03-09T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Đà Lạt thành lập năm 2016 ở thành phố Đà Lạt. Cộng đoàn hoạt động nhằm giúp đỡ các em về phát triển tân thế, có khoảng 35 chị em. Hàng năm có các chương trình hỗ trợ gia đình và hào phỗ.\",\"created_at\":\"2025-12-21T16:15:02.000Z\",\"updated_at\":null,\"history\":null}', '{\"id\":2,\"code\":\"CD002\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"789 Duong Pho doc Thang, Thanh pho Da Lat\",\"phone\":\"0633123456\",\"email\":\"congdoan.dalat@example.com\",\"established_date\":\"2016-03-09T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Đà Lạt thành lập năm 2016 ở thành phố Đà Lạt. Cộng đoàn hoạt động nhằm giúp đỡ các em về phát triển tân thế, có khoảng 35 chị em. Hàng năm có các chương trình hỗ trợ gia đình và hào phỗ.\",\"created_at\":\"2025-12-21T16:15:02.000Z\",\"updated_at\":\"2025-12-21T16:17:30.000Z\",\"history\":\"<p>Cộng Đoàn Đà Lạt đầu tiên được thành lập vào năm 2016, ở thành phố Đà Lạt - thành phố được biết đến với khí hậu dị dự và phợng cảnh thiên nhiên đẹp lĩ.</p><p><br></p><p>Hiện nay, Cộng đoàn có khoảng 35 chị em tham gia học tập, Đão tạo và phục vụ các em có hoàn cảnh nghèo khó. Cộng đoàn có tổ chéc nhiều chương trình đóc sắc để hỗ trợ các chị em phát triển toàn diện về tâm lý và đức ãn.</p>\"}', '127.0.0.1', '2025-12-21 16:17:30'),
(11, 1, 'UPDATE', 'communities', 3, NULL, '{\"id\":3,\"code\":\"CD003\",\"name\":\"Cộng Đoàn Hà Nội\",\"address\":\"234 Duong Thach Thi Thanh, Quan Hoan Kiem, Ha Noi\",\"phone\":\"0434567890\",\"email\":\"congdoan.hanoi@example.com\",\"established_date\":\"2014-05-19T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Hà Nội thành lập năm 2014, là một trong những cộng đoàn cổ xưa nhất của Hội Động OSP. Cộng đoàn có khoảng 55 chị em đang hoạt động. Một số hoạt động chính: đãy dỡ đức vỞ quốc, hỗ trợ tài chính cho các em và gia đình nghèo khó.\",\"created_at\":\"2025-12-21T16:16:21.000Z\",\"updated_at\":null,\"history\":null}', '{\"id\":3,\"code\":\"CD003\",\"name\":\"Cộng Đoàn Hà Nội\",\"address\":\"234 Duong Thach Thi Thanh, Quan Hoan Kiem, Ha Noi\",\"phone\":\"0434567890\",\"email\":\"congdoan.hanoi@example.com\",\"established_date\":\"2014-05-19T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Hà Nội thành lập năm 2014, là một trong những cộng đoàn cổ xưa nhất của Hội Động OSP. Cộng đoàn có khoảng 55 chị em đang hoạt động. Một số hoạt động chính: đãy dỡ đức vỞ quốc, hỗ trợ tài chính cho các em và gia đình nghèo khó.\",\"created_at\":\"2025-12-21T16:16:21.000Z\",\"updated_at\":\"2025-12-21T16:18:55.000Z\",\"history\":\"<p>Cộng Đoàn Hà Nội được thành lập vào năm 2014, là một trong những cộng đoàn cổ xưa nhất của Hội Động OSP. Cộng đoàn có truyền thống mạnh mẽ về đọc Đão cáo và phục vụ ăn quàng yếu.</p><p><br></p><p>Hiện nay, Cộng đoàn có khoảng 55 chị em đang hoạt động, tham gia các hoạt động giáo dục, đào tạo kỹ năng và hỗ trợ nghềo khó. Cộng đoàn thường xuyên tổ chéc các chương trình hỗ trợ tài chính, hướng dẫn nhân đức và phục vụ cộng đồng.</p>\"}', '127.0.0.1', '2025-12-21 16:18:55'),
(12, 1, 'CREATE', 'sisters', 2, NULL, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-24T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"permanent_address\":null,\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-14T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":null,\"documents\":null}', '127.0.0.1', '2025-12-21 16:21:08'),
(13, 1, 'UPDATE', 'sisters', 2, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-24T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"permanent_address\":null,\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-14T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":null,\"documents\":null}', '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-23T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"permanent_address\":null,\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-13T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-27T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-11T17:00:00.000Z\",\"first_communion_date\":\"2009-12-24T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:23:08.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:23:08'),
(14, 1, 'CREATE', 'sisters', 3, NULL, NULL, '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-09T17:00:00.000Z\",\"place_of_birth\":null,\"permanent_address\":null,\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-19T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":null,\"documents\":null}', '127.0.0.1', '2025-12-21 16:24:00'),
(15, 1, 'UPDATE', 'sisters', 2, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-23T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":null,\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-13T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-27T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-11T17:00:00.000Z\",\"first_communion_date\":\"2009-12-24T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:23:08.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-22T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-12T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-26T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-10T17:00:00.000Z\",\"first_communion_date\":\"2009-12-23T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:33:51.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:33:51'),
(16, 1, 'UPDATE', 'sisters', 2, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-22T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-12T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-26T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-10T17:00:00.000Z\",\"first_communion_date\":\"2009-12-23T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:33:51.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-21T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-11T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-25T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-09T17:00:00.000Z\",\"first_communion_date\":\"2009-12-22T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:36:07.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:36:07'),
(17, 1, 'UPDATE', 'sisters', 2, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-21T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-11T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-25T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-09T17:00:00.000Z\",\"first_communion_date\":\"2009-12-22T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:36:07.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-20T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-10T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-24T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-08T17:00:00.000Z\",\"first_communion_date\":\"2009-12-21T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:38:36.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:38:36'),
(18, 1, 'UPDATE', 'sisters', 2, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-20T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-10T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-24T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-08T17:00:00.000Z\",\"first_communion_date\":\"2009-12-21T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:38:36.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-19T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-09T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-23T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-07T17:00:00.000Z\",\"first_communion_date\":\"2009-12-20T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:39:00.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:39:00'),
(19, 1, 'UPDATE', 'sisters', 2, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-19T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":null,\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-09T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-23T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-07T17:00:00.000Z\",\"first_communion_date\":\"2009-12-20T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:39:00.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-18T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":\"Nam Định\",\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-08T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-22T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-06T17:00:00.000Z\",\"first_communion_date\":\"2009-12-19T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:41:07.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:41:07'),
(20, 1, 'UPDATE', 'sisters', 3, NULL, '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-09T17:00:00.000Z\",\"place_of_birth\":null,\"hometown\":null,\"permanent_address\":null,\"current_address\":null,\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-19T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":null,\"documents\":null}', '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-08T17:00:00.000Z\",\"place_of_birth\":\"Quảng Trị\",\"hometown\":\"Quảng Trị\",\"permanent_address\":\"789 Phố Mọ Cỏ, Quảng Trị\",\"current_address\":\"Nha Tho Trung Tam, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-18T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":\"Phạm Văn Hậu\",\"father_occupation\":\"Nông dân\",\"mother_name\":\"Vũ Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Mọ Cỏ, Quảng Trị\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1996-10-14T17:00:00.000Z\",\"baptism_place\":\"Nha Tho Quang Tri\",\"confirmation_date\":\"2005-05-19T17:00:00.000Z\",\"first_communion_date\":\"2007-12-24T17:00:00.000Z\",\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":\"Phạm Văn Sơn\",\"emergency_contact_phone\":\"0934567890\",\"notes\":\"Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":\"2025-12-21T16:44:46.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-21 16:44:46'),
(21, 1, 'CREATE', 'vocation_journey', 1, NULL, NULL, '{\"id\":1,\"sister_id\":3,\"stage\":\"aspirant\",\"start_date\":\"1996-10-19T17:00:00.000Z\",\"end_date\":\"2005-05-18T17:00:00.000Z\",\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên, bắt đầu từ năm 1996 với các bài tập tinh thần cơ bản.\"}', '127.0.0.1', '2025-12-21 16:49:12'),
(22, 1, 'CREATE', 'vocation_journey', 2, NULL, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-18T17:00:00.000Z\",\"end_date\":\"2008-05-19T17:00:00.000Z\",\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 16:50:14'),
(23, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-18T17:00:00.000Z\",\"end_date\":\"2008-05-19T17:00:00.000Z\",\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-17T17:00:00.000Z\",\"end_date\":\"2008-05-18T17:00:00.000Z\",\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 16:51:33'),
(24, 1, 'UPDATE', 'vocation_journey', 1, NULL, '{\"id\":1,\"sister_id\":3,\"stage\":\"aspirant\",\"start_date\":\"1996-10-19T17:00:00.000Z\",\"end_date\":\"2005-05-18T17:00:00.000Z\",\"location\":null,\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên, bắt đầu từ năm 1996 với các bài tập tinh thần cơ bản.\"}', '{\"id\":1,\"sister_id\":3,\"stage\":\"aspirant\",\"start_date\":\"1996-10-18T17:00:00.000Z\",\"end_date\":\"2005-05-17T17:00:00.000Z\",\"location\":\"Đức Mẹ Núi Cúi\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên, bắt đầu từ năm 1996 với các bài tập tinh thần cơ bản.\"}', '127.0.0.1', '2025-12-21 16:52:09'),
(25, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-17T17:00:00.000Z\",\"end_date\":\"2008-05-18T17:00:00.000Z\",\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-16T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 16:52:31'),
(26, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-16T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-15T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 23:20:25'),
(27, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-15T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-14T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 23:24:15'),
(28, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-14T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-13T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 23:26:41'),
(29, 1, 'UPDATE', 'vocation_journey', 1, NULL, '{\"id\":1,\"sister_id\":3,\"stage\":\"aspirant\",\"start_date\":\"1996-10-18T17:00:00.000Z\",\"end_date\":\"2005-05-17T17:00:00.000Z\",\"location\":\"Đức Mẹ Núi Cúi\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên, bắt đầu từ năm 1996 với các bài tập tinh thần cơ bản.\"}', '{\"id\":1,\"sister_id\":3,\"stage\":\"aspirant\",\"start_date\":\"1996-10-17T17:00:00.000Z\",\"end_date\":\"2005-05-16T17:00:00.000Z\",\"location\":\"Đức Mẹ Núi Cúi\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên, bắt đầu từ năm 1996 với các bài tập tinh thần cơ bản.\"}', '127.0.0.1', '2025-12-21 23:31:51'),
(30, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-13T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-12T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 23:43:06'),
(31, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-12T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-11T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-21 23:45:43'),
(32, 1, 'UPDATE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-11T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-10T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\"}', '127.0.0.1', '2025-12-22 01:25:49');
INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `description`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(33, 1, 'CREATE', 'vocation_journey', 3, NULL, NULL, '{\"id\":3,\"sister_id\":2,\"stage\":\"aspirant\",\"start_date\":\"2023-12-31T17:00:00.000Z\",\"end_date\":\"2024-06-29T17:00:00.000Z\",\"location\":\"Nhà dòng Hà Nội, Việt Nam\",\"superior\":null,\"formation_director\":null,\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên với sự hướng dẫn của Ban Tuyển Chọn\"}', '127.0.0.1', '2025-12-22 02:32:34'),
(34, 1, 'CREATE', 'vocation_journey', 4, NULL, NULL, '{\"id\":4,\"sister_id\":2,\"stage\":\"\",\"start_date\":\"2024-06-30T17:00:00.000Z\",\"end_date\":\"2024-12-30T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":null,\"formation_director\":null,\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\"}', '127.0.0.1', '2025-12-22 02:34:11'),
(35, 1, 'CREATE', 'vocation_journey', 5, NULL, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"novice\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"2025-06-29T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\"}', '127.0.0.1', '2025-12-22 02:35:07'),
(36, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"novice\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"2025-06-29T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":null,\"formation_director\":null,\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"novice\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"2025-06-28T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\"}', '127.0.0.1', '2025-12-22 02:35:30'),
(37, 1, 'UPDATE', 'vocation_journey', 4, NULL, '{\"id\":4,\"sister_id\":2,\"stage\":\"\",\"start_date\":\"2024-06-30T17:00:00.000Z\",\"end_date\":\"2024-12-30T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":null,\"formation_director\":null,\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\"}', '{\"id\":4,\"sister_id\":2,\"stage\":\"temporary_vows\",\"start_date\":\"2024-06-29T17:00:00.000Z\",\"end_date\":\"2024-12-29T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\"}', '127.0.0.1', '2025-12-22 02:35:54'),
(38, 1, 'UPDATE', 'vocation_journey', 3, NULL, '{\"id\":3,\"sister_id\":2,\"stage\":\"aspirant\",\"start_date\":\"2023-12-31T17:00:00.000Z\",\"end_date\":\"2024-06-29T17:00:00.000Z\",\"location\":\"Nhà dòng Hà Nội, Việt Nam\",\"superior\":null,\"formation_director\":null,\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên với sự hướng dẫn của Ban Tuyển Chọn\"}', '{\"id\":3,\"sister_id\":2,\"stage\":\"aspirant\",\"start_date\":\"2023-12-30T17:00:00.000Z\",\"end_date\":\"2024-06-28T17:00:00.000Z\",\"location\":\"Nhà dòng Hà Nội, Việt Nam\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên với sự hướng dẫn của Ban Tuyển Chọn\"}', '127.0.0.1', '2025-12-22 02:36:25'),
(39, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"novice\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"2025-06-28T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-06-27T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\"}', '127.0.0.1', '2025-12-22 02:36:35'),
(40, 1, 'CREATE', 'vocation_journey', 6, NULL, NULL, '{\"id\":6,\"sister_id\":1,\"stage\":\"aspirant\",\"start_date\":\"2023-02-14T17:00:00.000Z\",\"end_date\":\"2023-08-13T17:00:00.000Z\",\"location\":\"Nhà Dòng Hà Nội, Quốc Tử Giám, Hà Nội\",\"superior\":null,\"formation_director\":null,\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên nhận lời mời từ Hội Dòng, quyết định theo đuổi con đường tu sĩ với sự cầu nguyện của gia đình\"}', '127.0.0.1', '2025-12-22 02:38:38'),
(41, 1, 'CREATE', 'vocation_journey', 7, NULL, NULL, '{\"id\":7,\"sister_id\":1,\"stage\":\"\",\"start_date\":\"2023-08-14T17:00:00.000Z\",\"end_date\":\"2024-02-13T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh tập trung vào việc học tập các điều chỉnh lời sống, chuẩn bị cho việc khấn thề tạm thời và những học hỏi sâu sắc về tinh thần Hội Dòng\"}', '127.0.0.1', '2025-12-22 02:40:33'),
(42, 1, 'CREATE', 'vocation_journey', 8, NULL, NULL, '{\"id\":8,\"sister_id\":1,\"stage\":\"novice\",\"start_date\":\"2024-02-14T17:00:00.000Z\",\"end_date\":\"2025-08-13T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện là thời kỳ đào tạo toàn diện về lời sống tu sĩ, các kỹ năng hoàn thiện tinh thần cống hiến đầy đủ cho Chúa và Giáo hội với sự hướng dẫn kỹ lưỡng\"}', '127.0.0.1', '2025-12-22 02:42:10'),
(43, 1, 'UPDATE', 'vocation_journey', 6, NULL, '{\"id\":6,\"sister_id\":1,\"stage\":\"aspirant\",\"start_date\":\"2023-02-14T17:00:00.000Z\",\"end_date\":\"2023-08-13T17:00:00.000Z\",\"location\":\"Nhà Dòng Hà Nội, Quốc Tử Giám, Hà Nội\",\"superior\":null,\"formation_director\":null,\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên nhận lời mời từ Hội Dòng, quyết định theo đuổi con đường tu sĩ với sự cầu nguyện của gia đình\"}', '{\"id\":6,\"sister_id\":1,\"stage\":\"aspirant\",\"start_date\":\"2023-02-13T17:00:00.000Z\",\"end_date\":\"2023-08-12T17:00:00.000Z\",\"location\":\"Nhà Dòng Hà Nội, Quốc Tử Giám, Hà Nội\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên nhận lời mời từ Hội Dòng, quyết định theo đuổi con đường tu sĩ với sự cầu nguyện của gia đình\"}', '127.0.0.1', '2025-12-22 02:43:14'),
(44, 1, 'UPDATE', 'vocation_journey', 7, NULL, '{\"id\":7,\"sister_id\":1,\"stage\":\"\",\"start_date\":\"2023-08-14T17:00:00.000Z\",\"end_date\":\"2024-02-13T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh tập trung vào việc học tập các điều chỉnh lời sống, chuẩn bị cho việc khấn thề tạm thời và những học hỏi sâu sắc về tinh thần Hội Dòng\"}', '{\"id\":7,\"sister_id\":1,\"stage\":\"temporary_vows\",\"start_date\":\"2023-08-13T17:00:00.000Z\",\"end_date\":\"2024-02-12T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh tập trung vào việc học tập các điều chỉnh lời sống, chuẩn bị cho việc khấn thề tạm thời và những học hỏi sâu sắc về tinh thần Hội Dòng\"}', '127.0.0.1', '2025-12-22 02:43:34'),
(45, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-06-27T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"2025-06-26T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\"}', '127.0.0.1', '2025-12-22 02:43:54'),
(46, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"2025-06-26T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":null}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:32:36'),
(47, 1, 'UPDATE', 'sisters', 3, NULL, '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-08T17:00:00.000Z\",\"place_of_birth\":\"Quảng Trị\",\"hometown\":\"Quảng Trị\",\"permanent_address\":\"789 Phố Mọ Cỏ, Quảng Trị\",\"current_address\":\"Nha Tho Trung Tam, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-18T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":\"Phạm Văn Hậu\",\"father_occupation\":\"Nông dân\",\"mother_name\":\"Vũ Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Mọ Cỏ, Quảng Trị\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1996-10-14T17:00:00.000Z\",\"baptism_place\":\"Nha Tho Quang Tri\",\"confirmation_date\":\"2005-05-19T17:00:00.000Z\",\"first_communion_date\":\"2007-12-24T17:00:00.000Z\",\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":\"Phạm Văn Sơn\",\"emergency_contact_phone\":\"0934567890\",\"notes\":\"Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":\"2025-12-21T16:44:46.000Z\",\"documents\":null}', '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-07T17:00:00.000Z\",\"place_of_birth\":\"Quảng Trị\",\"hometown\":\"Quảng Trị\",\"permanent_address\":\"789 Phố Mọ Cỏ, Quảng Trị\",\"current_address\":\"Nha Tho Trung Tam, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-17T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":\"Phạm Văn Hậu\",\"father_occupation\":\"Nông dân\",\"mother_name\":\"Vũ Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Mọ Cỏ, Quảng Trị\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1996-10-13T17:00:00.000Z\",\"baptism_place\":\"Nha Tho Quang Tri\",\"confirmation_date\":\"2005-05-18T17:00:00.000Z\",\"first_communion_date\":\"2007-12-23T17:00:00.000Z\",\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":\"Phạm Văn Sơn\",\"emergency_contact_phone\":\"0934567890\",\"notes\":\"Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":\"2025-12-22T03:33:19.000Z\",\"documents\":\"[{\\\"id\\\":1766374397592,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766374397588-4o89ln.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T03:33:17.592Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:33:19'),
(48, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:49:04'),
(49, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:49:57'),
(50, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:50:12'),
(51, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":\"2025-11-24T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:51:44'),
(52, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":\"2025-11-24T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-22T17:00:00.000Z\",\"end_date\":\"2025-11-24T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:51:57'),
(53, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-22T17:00:00.000Z\",\"end_date\":\"2025-11-24T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-21T17:00:00.000Z\",\"end_date\":\"2026-11-23T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:53:05'),
(54, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-21T17:00:00.000Z\",\"end_date\":\"2026-11-23T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-20T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 03:53:36'),
(55, 1, 'UPDATE', 'vocation_journey', 7, NULL, '{\"id\":7,\"sister_id\":1,\"stage\":\"temporary_vows\",\"start_date\":\"2023-08-13T17:00:00.000Z\",\"end_date\":\"2024-02-12T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh tập trung vào việc học tập các điều chỉnh lời sống, chuẩn bị cho việc khấn thề tạm thời và những học hỏi sâu sắc về tinh thần Hội Dòng\",\"documents\":null}', '{\"id\":7,\"sister_id\":1,\"stage\":\"temporary_vows\",\"start_date\":\"2023-08-12T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh tập trung vào việc học tập các điều chỉnh lời sống, chuẩn bị cho việc khấn thề tạm thời và những học hỏi sâu sắc về tinh thần Hội Dòng\",\"documents\":\"[]\"}', '127.0.0.1', '2025-12-22 03:56:51'),
(56, 1, 'UPDATE', 'sisters', 1, NULL, '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-12T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"hometown\":null,\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-07T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-18T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-16T17:00:00.000Z\",\"first_communion_date\":\"2010-12-23T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":\"/uploads/photos/1766333233177-gczzjn.jpg\",\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-21T16:07:13.000Z\",\"documents\":\"[{\\\"id\\\":1766333230557,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766333230548-837iw9.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-21T16:07:10.557Z\\\"}]\"}', '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-11T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"hometown\":\"Hưng Yên\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-06T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-17T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-15T17:00:00.000Z\",\"first_communion_date\":\"2010-12-22T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":\"/uploads/photos/1766333233177-gczzjn.jpg\",\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-22T04:01:38.000Z\",\"documents\":\"[{\\\"id\\\":1766333230557,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766333230548-837iw9.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-21T16:07:10.557Z\\\"}]\"}', '127.0.0.1', '2025-12-22 04:01:38'),
(57, 1, 'ADD_MEMBER', 'communities', 3, NULL, NULL, '{\"id\":1,\"sister_id\":3,\"community_id\":3,\"role\":\"superior\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"112\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"Tốt\"}', '127.0.0.1', '2025-12-22 04:14:12'),
(58, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-22 04:18:55'),
(59, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /.well-known/appspecific/com.chrome.devtools.json\",\"path\":\"/.well-known/appspecific/com.chrome.devtools.json\"}', '127.0.0.1', '2025-12-22 04:21:26'),
(60, 1, 'ADD_MEMBER', 'communities', 3, NULL, NULL, '{\"id\":2,\"sister_id\":3,\"community_id\":3,\"role\":\"superior\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '127.0.0.1', '2025-12-22 04:24:47'),
(61, 1, 'REMOVE_MEMBER', 'communities', 3, NULL, '{\"id\":1,\"sister_id\":3,\"community_id\":3,\"role\":\"superior\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"112\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"Tốt\"}', NULL, '127.0.0.1', '2025-12-22 04:50:45'),
(62, 1, 'ADD_MEMBER', 'communities', 1, NULL, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '127.0.0.1', '2025-12-22 07:05:12'),
(63, 1, 'UPDATE_MEMBER', 'communities', 3, NULL, '{\"id\":2,\"sister_id\":3,\"community_id\":3,\"role\":\"superior\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '{\"id\":2,\"sister_id\":3,\"community_id\":3,\"role\":\"superior\",\"start_date\":\"2025-12-20T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766395769495-2vw0u0.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 09:29:29'),
(64, 1, 'REMOVE_MEMBER', 'communities', 3, NULL, '{\"id\":2,\"sister_id\":3,\"community_id\":3,\"role\":\"superior\",\"start_date\":\"2025-12-20T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766395769495-2vw0u0.docx\",\"notes\":\"\"}', NULL, '127.0.0.1', '2025-12-22 09:52:28'),
(65, 1, 'ADD_MEMBER', 'communities', 2, NULL, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '127.0.0.1', '2025-12-22 09:56:17'),
(66, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 09:56:27'),
(67, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-10-29T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 09:57:29'),
(68, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-10-29T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 09:57:43'),
(69, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 09:57:53'),
(70, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:01:42'),
(71, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:01:51'),
(72, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:01:58'),
(73, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:02:29'),
(74, 1, 'REMOVE_MEMBER', 'communities', 2, NULL, '{\"id\":4,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', NULL, '127.0.0.1', '2025-12-22 10:02:34'),
(75, 1, 'ADD_MEMBER', 'communities', 2, NULL, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '127.0.0.1', '2025-12-22 10:02:54'),
(76, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:06:34'),
(77, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:08:16'),
(78, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:09:31'),
(79, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:09:54'),
(80, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:12:40'),
(81, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:12:48'),
(82, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:12:59'),
(83, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:16:57'),
(84, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:17:38'),
(85, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:19:03'),
(86, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:20:33'),
(87, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":\"2025-06-25T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-22T17:00:00.000Z\",\"end_date\":\"2025-06-24T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:23:19'),
(88, 1, 'REMOVE_MEMBER', 'communities', 2, NULL, '{\"id\":5,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-22T17:00:00.000Z\",\"end_date\":\"2025-06-24T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', NULL, '127.0.0.1', '2025-12-22 10:23:27'),
(89, 1, 'ADD_MEMBER', 'communities', 2, NULL, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":null}', '127.0.0.1', '2025-12-22 10:23:49'),
(90, 1, 'ADD_MEMBER', 'communities', 1, NULL, NULL, '{\"id\":7,\"sister_id\":1,\"community_id\":1,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '127.0.0.1', '2025-12-22 10:31:22'),
(91, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":7,\"sister_id\":1,\"community_id\":1,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', '{\"id\":7,\"sister_id\":1,\"community_id\":1,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:31:41'),
(92, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":7,\"sister_id\":1,\"community_id\":1,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":7,\"sister_id\":1,\"community_id\":1,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-12-31T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:33:27'),
(93, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:34:08'),
(94, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:34:33'),
(95, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:39:16'),
(96, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:39:53'),
(97, 1, 'UPDATE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:47:04'),
(98, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2025-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":null}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2025-12-20T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:48:58'),
(99, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2025-12-20T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2025-12-19T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 10:49:41'),
(100, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2025-12-19T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:12:55');
INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `description`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(101, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:15:56'),
(102, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"2025-09-30T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:16:46'),
(103, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"2025-09-30T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:16:58'),
(104, 1, 'UPDATE', 'vocation_journey', 4, NULL, '{\"id\":4,\"sister_id\":2,\"stage\":\"temporary_vows\",\"start_date\":\"2024-06-29T17:00:00.000Z\",\"end_date\":\"2024-12-29T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\",\"documents\":null}', '{\"id\":4,\"sister_id\":2,\"stage\":\"temporary_vows\",\"start_date\":\"2024-06-28T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\",\"documents\":\"[]\"}', '127.0.0.1', '2025-12-22 11:18:02'),
(105, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-30T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:23:10'),
(106, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"2025-06-24T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:23:32'),
(107, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-28T17:00:00.000Z\",\"end_date\":\"2025-06-24T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"2025-06-23T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:30:49'),
(108, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-27T17:00:00.000Z\",\"end_date\":\"2025-06-23T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":\"2025-06-22T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '127.0.0.1', '2025-12-22 11:31:14'),
(109, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-26T17:00:00.000Z\",\"end_date\":\"2025-06-22T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":\"2025-06-21T17:00:00.000Z\",\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '127.0.0.1', '2025-12-22 11:45:14'),
(110, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-25T17:00:00.000Z\",\"end_date\":\"2025-06-21T17:00:00.000Z\",\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '127.0.0.1', '2025-12-22 11:47:55'),
(111, 1, 'CREATE', 'education', 1, NULL, NULL, '{\"id\":1,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Kế Toán\",\"institution\":\"Trường Đại Học Kinh Tế Thành Phố Hồ Chí Minh\",\"start_date\":null,\"end_date\":null,\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 12:02:43'),
(112, 1, 'CREATE', 'education', 2, NULL, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-31T17:00:00.000Z\",\"end_date\":\"2022-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 12:03:53'),
(113, 1, 'CREATE', 'education', 3, NULL, NULL, '{\"id\":3,\"sister_id\":2,\"level\":\"master\",\"major\":\"Kế Toán Tài Chính\",\"institution\":\"Trường Cao Đẳng Tài Chính - Kế Toán\",\"start_date\":\"2015-08-14T17:00:00.000Z\",\"end_date\":\"2018-06-09T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 12:05:38'),
(114, 1, 'UPDATE', 'education', 3, NULL, '{\"id\":3,\"sister_id\":2,\"level\":\"master\",\"major\":\"Kế Toán Tài Chính\",\"institution\":\"Trường Cao Đẳng Tài Chính - Kế Toán\",\"start_date\":\"2015-08-14T17:00:00.000Z\",\"end_date\":\"2018-06-09T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '{\"id\":3,\"sister_id\":2,\"level\":\"master\",\"major\":\"Kế Toán Tài Chính\",\"institution\":\"Trường Cao Đẳng Tài Chính - Kế Toán\",\"start_date\":\"2015-08-13T17:00:00.000Z\",\"end_date\":\"2018-06-08T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"da_tot_nghiep\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 12:07:09'),
(115, 1, 'UPDATE', 'education', 3, NULL, '{\"id\":3,\"sister_id\":2,\"level\":\"master\",\"major\":\"Kế Toán Tài Chính\",\"institution\":\"Trường Cao Đẳng Tài Chính - Kế Toán\",\"start_date\":\"2015-08-13T17:00:00.000Z\",\"end_date\":\"2018-06-08T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"da_tot_nghiep\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '{\"id\":3,\"sister_id\":2,\"level\":\"master\",\"major\":\"Kế Toán Tài Chính\",\"institution\":\"Trường Cao Đẳng Tài Chính - Kế Toán\",\"start_date\":\"2015-08-12T17:00:00.000Z\",\"end_date\":\"2018-06-07T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2024,\"status\":\"da_tot_nghiep\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 12:09:59'),
(116, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-31T17:00:00.000Z\",\"end_date\":\"2022-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-30T17:00:00.000Z\",\"end_date\":\"2022-06-28T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":null}', '127.0.0.1', '2025-12-22 12:14:03'),
(117, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-30T17:00:00.000Z\",\"end_date\":\"2022-06-28T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":null}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-29T17:00:00.000Z\",\"end_date\":\"2022-06-27T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '127.0.0.1', '2025-12-22 12:14:38'),
(118, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-29T17:00:00.000Z\",\"end_date\":\"2022-06-27T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-28T17:00:00.000Z\",\"end_date\":null,\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '127.0.0.1', '2025-12-22 12:15:18'),
(119, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-28T17:00:00.000Z\",\"end_date\":null,\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-27T17:00:00.000Z\",\"end_date\":\"2030-06-24T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '127.0.0.1', '2025-12-22 12:17:50'),
(120, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-27T17:00:00.000Z\",\"end_date\":\"2030-06-24T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-26T17:00:00.000Z\",\"end_date\":\"2010-06-23T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '127.0.0.1', '2025-12-22 12:18:15'),
(121, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-26T17:00:00.000Z\",\"end_date\":\"2010-06-23T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-25T17:00:00.000Z\",\"end_date\":\"2030-06-22T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '127.0.0.1', '2025-12-22 12:21:19'),
(122, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-25T17:00:00.000Z\",\"end_date\":\"2030-06-22T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-24T17:00:00.000Z\",\"end_date\":null,\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '127.0.0.1', '2025-12-22 12:21:31'),
(123, 1, 'UPDATE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-24T17:00:00.000Z\",\"end_date\":null,\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-23T17:00:00.000Z\",\"end_date\":null,\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', '127.0.0.1', '2025-12-22 12:21:42'),
(124, 1, 'CREATE', 'education', 4, NULL, NULL, '{\"id\":4,\"sister_id\":1,\"level\":\"bachelor\",\"major\":\"Công nghệ Thông tin\",\"institution\":\"Đại học Quốc Gia Hà Nội\",\"start_date\":\"2015-08-31T17:00:00.000Z\",\"end_date\":\"2019-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 15:14:30'),
(125, 1, 'CREATE', 'education', 5, NULL, NULL, '{\"id\":5,\"sister_id\":1,\"level\":\"master\",\"major\":\"Quản lý Doanh nghiệp\",\"institution\":\"Đại học Kinh Tế Thương Mại\",\"start_date\":\"2019-08-31T17:00:00.000Z\",\"end_date\":\"2021-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 15:15:56'),
(126, 1, 'CREATE', 'education', 6, NULL, NULL, '{\"id\":6,\"sister_id\":1,\"level\":\"doctorate\",\"major\":\"Khoa học Dữ liệu\",\"institution\":\"Đại học Công Nghệ\",\"start_date\":\"2021-08-31T17:00:00.000Z\",\"end_date\":\"2024-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', '127.0.0.1', '2025-12-22 15:17:41'),
(127, 1, 'CREATE', 'education', 7, NULL, NULL, '{\"id\":7,\"sister_id\":3,\"level\":\"\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-31T17:00:00.000Z\",\"end_date\":\"2020-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '127.0.0.1', '2025-12-22 15:28:51'),
(128, 1, 'UPDATE', 'education', 7, NULL, '{\"id\":7,\"sister_id\":3,\"level\":\"\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-31T17:00:00.000Z\",\"end_date\":\"2020-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '{\"id\":7,\"sister_id\":3,\"level\":\"bachelor\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-30T17:00:00.000Z\",\"end_date\":\"2020-06-28T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '127.0.0.1', '2025-12-22 15:29:21'),
(129, 1, 'UPDATE', 'education', 7, NULL, '{\"id\":7,\"sister_id\":3,\"level\":\"bachelor\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-30T17:00:00.000Z\",\"end_date\":\"2020-06-28T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '{\"id\":7,\"sister_id\":3,\"level\":\"\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-29T17:00:00.000Z\",\"end_date\":\"2020-06-27T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '127.0.0.1', '2025-12-22 15:31:00'),
(130, 1, 'UPDATE', 'education', 7, NULL, '{\"id\":7,\"sister_id\":3,\"level\":\"\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-29T17:00:00.000Z\",\"end_date\":\"2020-06-27T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '{\"id\":7,\"sister_id\":3,\"level\":\"bachelor\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-28T17:00:00.000Z\",\"end_date\":\"2020-06-26T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '127.0.0.1', '2025-12-22 15:38:31'),
(131, 1, 'UPDATE', 'education', 7, NULL, '{\"id\":7,\"sister_id\":3,\"level\":\"bachelor\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-28T17:00:00.000Z\",\"end_date\":\"2020-06-26T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '{\"id\":7,\"sister_id\":3,\"level\":\"cap_1\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-27T17:00:00.000Z\",\"end_date\":\"2020-06-25T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', '127.0.0.1', '2025-12-22 15:38:40'),
(132, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"perpetual_vows\",\"start_date\":\"2024-12-20T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"\",\"start_date\":\"2024-12-19T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 15:40:16'),
(133, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"\",\"start_date\":\"2024-12-19T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-18T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-22 15:45:18'),
(134, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"superior\",\"start_date\":\"2024-12-24T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '127.0.0.1', '2025-12-22 15:46:57'),
(135, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"\",\"start_date\":\"2024-12-23T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"tong_quyen\",\"start_date\":\"2024-12-22T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '127.0.0.1', '2025-12-22 15:54:29'),
(136, 1, 'UPDATE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"tong_quyen\",\"start_date\":\"2024-12-22T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"tong_quyen\",\"start_date\":\"2024-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/decisions/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', '127.0.0.1', '2025-12-22 16:00:26'),
(137, 1, 'CREATE', 'missions', 1, NULL, NULL, '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-14T17:00:00.000Z\",\"end_date\":\"2025-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', '127.0.0.1', '2025-12-22 16:12:05'),
(138, 1, 'UPDATE', 'missions', 1, NULL, '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-14T17:00:00.000Z\",\"end_date\":\"2025-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-13T17:00:00.000Z\",\"end_date\":\"2026-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', '127.0.0.1', '2025-12-22 16:12:44'),
(139, 1, 'UPDATE', 'missions', 1, NULL, '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-13T17:00:00.000Z\",\"end_date\":\"2026-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-12T17:00:00.000Z\",\"end_date\":\"2026-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', '127.0.0.1', '2025-12-22 16:14:55'),
(140, 1, 'UPDATE', 'missions', 1, NULL, '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-12T17:00:00.000Z\",\"end_date\":\"2026-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-11T17:00:00.000Z\",\"end_date\":\"2029-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', '127.0.0.1', '2025-12-22 16:15:03'),
(141, 1, 'DELETE', 'missions', 1, NULL, '{\"id\":1,\"sister_id\":3,\"field\":\"Giáo dục - Khoa Học\",\"specific_role\":\"Giáo viên Toán học\",\"organization\":null,\"address\":null,\"start_date\":\"2024-01-11T17:00:00.000Z\",\"end_date\":\"2029-06-29T17:00:00.000Z\",\"notes\":\"Phân công dạy các lớp 10A, 10B và 11C tại trường THPT Bình Minh. Tham gia các hoạt động chuyên môn và hướng dẫn học sinh ôn thi. Kết quả học tập của lớp được xếp loại tốt.\"}', NULL, '127.0.0.1', '2025-12-22 16:15:07'),
(142, 1, 'CREATE', 'missions', 2, NULL, NULL, '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-28T17:00:00.000Z\",\"end_date\":\"2024-02-27T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\"}', '127.0.0.1', '2025-12-22 16:16:12'),
(143, 1, 'UPDATE', 'missions', 2, NULL, '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-28T17:00:00.000Z\",\"end_date\":\"2024-02-27T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\"}', '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-27T17:00:00.000Z\",\"end_date\":\"2027-02-27T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\"}', '127.0.0.1', '2025-12-22 16:16:31'),
(144, 1, 'CREATE', 'missions', 3, NULL, NULL, '{\"id\":3,\"sister_id\":1,\"field\":\"Xuất Bản\",\"specific_role\":null,\"organization\":null,\"address\":null,\"start_date\":\"2024-01-12T17:00:00.000Z\",\"end_date\":null,\"notes\":null}', '127.0.0.1', '2025-12-22 16:23:30'),
(145, 1, 'UPDATE', 'missions', 2, NULL, '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-27T17:00:00.000Z\",\"end_date\":\"2027-02-27T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\"}', '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-26T17:00:00.000Z\",\"end_date\":\"2024-02-26T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\"}', '127.0.0.1', '2025-12-22 16:42:36'),
(146, 1, 'UPDATE', 'missions', 2, NULL, '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-26T17:00:00.000Z\",\"end_date\":\"2024-02-26T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\",\"documents\":null}', '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-25T17:00:00.000Z\",\"end_date\":\"2024-02-25T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\",\"documents\":null}', '127.0.0.1', '2025-12-22 16:48:36'),
(147, 1, 'UPDATE', 'missions', 2, NULL, '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-25T17:00:00.000Z\",\"end_date\":\"2024-02-25T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\",\"documents\":null}', '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-24T17:00:00.000Z\",\"end_date\":\"2024-02-24T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766422314934-5r02u7.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T16:51:54.955Z\\\"},{\\\"url\\\":\\\"/uploads/certificates/1766422314945-unmm5j.jpg\\\",\\\"name\\\":\\\"Anh-gai-xinh-Facebook-Tiktok.jpg\\\",\\\"size\\\":164609,\\\"uploaded_at\\\":\\\"2025-12-22T16:51:54.955Z\\\"}]\"}', '127.0.0.1', '2025-12-22 16:51:57'),
(148, 1, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/sisters/2/vocation-journeys\",\"path\":\"/api/sisters/2/vocation-journeys\"}', '127.0.0.1', '2025-12-22 17:01:23'),
(149, 1, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/sisters/2/vocation-journeys\",\"path\":\"/api/sisters/2/vocation-journeys\"}', '127.0.0.1', '2025-12-22 17:01:48'),
(150, 1, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /api/sisters/2/vocation-journeys\",\"path\":\"/api/sisters/2/vocation-journeys\"}', '127.0.0.1', '2025-12-22 17:01:49'),
(151, 1, 'CREATE', 'health_records', 1, NULL, NULL, '{\"id\":1,\"sister_id\":3,\"general_health\":\"good\",\"chronic_diseases\":\"Cao huyết áp, béo phì\",\"work_limitations\":\"Hạn chế công việc nặng, tránh leo cầu thang nhiều\",\"checkup_date\":\"2025-12-14T17:00:00.000Z\",\"next_checkup_date\":\"2026-01-14T17:00:00.000Z\",\"checkup_place\":\"Bệnh viện Quân Y 175 Hà Nội\",\"doctor\":\"ThS. BS Nguyễn Văn A\",\"blood_pressure\":\"140/90\",\"heart_rate\":\"78\",\"weight\":\"73.50\",\"height\":\"165.00\",\"diagnosis\":\"Cao huyết áp độ 1, chỉ số BMI 29.5 (thừa cân)\",\"treatment\":\"Uống thuốc Lisinopril 10mg 1 lần/ngày, tập thể dục 30 phút/ngày 5 lần/tuần, giảm muối trong ăn\",\"notes\":\"Cần theo dõi huyết áp hàng ngày, tái khám sau 1 tháng để kiểm tra lại kết quả\",\"documents\":null,\"created_at\":\"2025-12-23T00:48:29.000Z\",\"updated_at\":null}', '127.0.0.1', '2025-12-23 00:48:29'),
(152, 1, 'CREATE', 'health_records', 2, NULL, NULL, '{\"id\":2,\"sister_id\":2,\"general_health\":\"average\",\"chronic_diseases\":\"Viêm mũi dị ứng, mệt mỏi\",\"work_limitations\":\"Tránh không khí lạnh, giảm các hoạt động ngoài trời khi có gió\",\"checkup_date\":\"2025-11-09T17:00:00.000Z\",\"next_checkup_date\":\"2025-12-09T17:00:00.000Z\",\"checkup_place\":\"Phòng khám Đa khoa Cộng Hòa\",\"doctor\":\"PGS. TS. Trương Minh Tuấn\",\"blood_pressure\":\"118/76\",\"heart_rate\":\"72\",\"weight\":\"58.00\",\"height\":\"162.00\",\"diagnosis\":\"Viêm mũi dị ứng mùa (Allergic Rhinitis)\",\"treatment\":\"Thuốc kháng histamine Loratadin 10mg/ngày, xịt mũi Mometasone Furoate 2 lần/ngày\",\"notes\":\"Tình trạng ổn định, cần tiếp tục dùng thuốc theo đơn\",\"documents\":null,\"created_at\":\"2025-12-23T00:50:44.000Z\",\"updated_at\":null}', '127.0.0.1', '2025-12-23 00:50:44'),
(153, 1, 'CREATE', 'health_records', 3, NULL, NULL, '{\"id\":3,\"sister_id\":2,\"general_health\":\"weak\",\"chronic_diseases\":\"Thiếu hụt canxi, thiếu máu nhẹ\",\"work_limitations\":\"Cần bổ sung canxi, hạn chế hoạt động quá sức, cần hỗ trợ quang y\",\"checkup_date\":\"2025-12-21T17:00:00.000Z\",\"next_checkup_date\":\"2026-01-21T17:00:00.000Z\",\"checkup_place\":\"Bệnh viện Nhi Đồng 1 Hồ Chí Minh\",\"doctor\":\"TS. BS Đỗ Thị Hoa\",\"blood_pressure\":\"110/70\",\"heart_rate\":\"76\",\"weight\":\"54.00\",\"height\":\"158.00\",\"diagnosis\":\"Thiếu canxi, thiếu máu nhẹ (Hemoglobin: 10.2 g/dL)\",\"treatment\":\"Bổ sung Canxi và Vitamin D3, thuốc tăng cơ hemoglobin (Ferrous Sulfate 325mg/ngày), chế độ ăn giàu sắt và đạm\",\"notes\":\"Tình trạng sức khỏe yếu, cần bổ sung dinh dưỡng, xét nghiệm lại sau 3 tháng\",\"documents\":null,\"created_at\":\"2025-12-23T00:52:55.000Z\",\"updated_at\":null}', '127.0.0.1', '2025-12-23 00:52:56'),
(154, 1, 'UPDATE', 'health_records', 2, NULL, '{\"id\":2,\"sister_id\":2,\"general_health\":\"average\",\"chronic_diseases\":\"Viêm mũi dị ứng, mệt mỏi\",\"work_limitations\":\"Tránh không khí lạnh, giảm các hoạt động ngoài trời khi có gió\",\"checkup_date\":\"2025-11-09T17:00:00.000Z\",\"next_checkup_date\":\"2025-12-09T17:00:00.000Z\",\"checkup_place\":\"Phòng khám Đa khoa Cộng Hòa\",\"doctor\":\"PGS. TS. Trương Minh Tuấn\",\"blood_pressure\":\"118/76\",\"heart_rate\":\"72\",\"weight\":\"58.00\",\"height\":\"162.00\",\"diagnosis\":\"Viêm mũi dị ứng mùa (Allergic Rhinitis)\",\"treatment\":\"Thuốc kháng histamine Loratadin 10mg/ngày, xịt mũi Mometasone Furoate 2 lần/ngày\",\"notes\":\"Tình trạng ổn định, cần tiếp tục dùng thuốc theo đơn\",\"documents\":null,\"created_at\":\"2025-12-23T00:50:44.000Z\",\"updated_at\":null}', '{\"id\":2,\"sister_id\":2,\"general_health\":\"average\",\"chronic_diseases\":\"Viêm mũi dị ứng, mệt mỏi\",\"work_limitations\":\"Tránh không khí lạnh, giảm các hoạt động ngoài trời khi có gió\",\"checkup_date\":\"2025-11-08T17:00:00.000Z\",\"next_checkup_date\":\"2025-12-08T17:00:00.000Z\",\"checkup_place\":\"Phòng khám Đa khoa Cộng Hòa\",\"doctor\":\"PGS. TS. Trương Minh Tuấn\",\"blood_pressure\":\"118/76\",\"heart_rate\":\"72\",\"weight\":\"58.00\",\"height\":\"162.00\",\"diagnosis\":\"Viêm mũi dị ứng mùa (Allergic Rhinitis)\",\"treatment\":\"Thuốc kháng histamine Loratadin 10mg/ngày, xịt mũi Mometasone Furoate 2 lần/ngày\",\"notes\":\"Tình trạng ổn định, cần tiếp tục dùng thuốc theo đơn\",\"documents\":\"[{\\\"id\\\":1766451214404,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766451214388-afrbhk.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-23T00:53:34.404Z\\\"}]\",\"created_at\":\"2025-12-22T17:50:44.000Z\",\"updated_at\":null}', '127.0.0.1', '2025-12-23 00:53:41'),
(155, 1, 'READ_SENSITIVE', 'health_records', 3, NULL, NULL, NULL, '127.0.0.1', '2025-12-23 00:59:53'),
(156, 1, 'READ_SENSITIVE', 'health_records', 3, NULL, NULL, NULL, '127.0.0.1', '2025-12-23 00:59:53'),
(157, 1, 'CREATE', 'departure_records', 1, NULL, NULL, '{\"id\":1,\"sister_id\":3,\"departure_date\":\"2025-12-23T17:00:00.000Z\",\"type\":\"Phép thường\",\"expected_return_date\":\"2025-12-26T17:00:00.000Z\",\"return_date\":null,\"destination\":\"Nhà họ hàng ở Hà Nội\",\"contact_phone\":\"0987654321\",\"contact_address\":\"Số 45, Ngõ 123, Phố Hàng Bông, Hà Nội\",\"approved_by\":null,\"notes\":null,\"documents\":\"[{\\\"id\\\":1766451613704,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766451613686-w2vjd5.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-23T01:00:13.704Z\\\"}]\",\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Về thăm gia đình nhân dịp Lễ Giáng sinh và năm mới\",\"support_notes\":null}', '127.0.0.1', '2025-12-23 01:03:35'),
(158, 1, 'CREATE', 'departure_records', 2, NULL, NULL, '{\"id\":2,\"sister_id\":2,\"departure_date\":\"2025-12-17T17:00:00.000Z\",\"type\":\"Phép ốm\",\"expected_return_date\":\"2025-12-19T17:00:00.000Z\",\"return_date\":null,\"destination\":\"Phòng khám Đa khoa Cộng Hòa, Hà Nội\",\"contact_phone\":\"0912345678\",\"contact_address\":\"Số 78, Đường Hoa Mỹ, Phường Bắc Sơn, Hà Nội\",\"approved_by\":null,\"notes\":null,\"documents\":null,\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Bị cảm cúm, sốt cao, cần đi khám và điều trị tại phòng khám\",\"support_notes\":null}', '127.0.0.1', '2025-12-23 01:05:04');
INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `description`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(159, 1, 'CREATE', 'departure_records', 3, NULL, NULL, '{\"id\":3,\"sister_id\":1,\"departure_date\":\"2026-01-04T17:00:00.000Z\",\"type\":\"Phép không lương\",\"expected_return_date\":\"2026-01-14T17:00:00.000Z\",\"return_date\":null,\"destination\":\"Thăm thân nhân ở Quảng Ninh\",\"contact_phone\":\"0938765432\",\"contact_address\":\"Số 28, Đường Hải Yên, Thành phố Hạ Long, Quảng Ninh\",\"approved_by\":null,\"notes\":null,\"documents\":null,\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Đi thăm gia đình nhân kỳ nghỉ Tết Nguyên đán, cần thời gian để quy tụ gia đình\",\"support_notes\":null}', '127.0.0.1', '2025-12-23 01:06:37'),
(160, 1, 'UPDATE', 'departure_records', 2, NULL, '{\"id\":2,\"sister_id\":2,\"departure_date\":\"2025-12-17T17:00:00.000Z\",\"type\":\"Phép ốm\",\"expected_return_date\":\"2025-12-19T17:00:00.000Z\",\"return_date\":null,\"destination\":\"Phòng khám Đa khoa Cộng Hòa, Hà Nội\",\"contact_phone\":\"0912345678\",\"contact_address\":\"Số 78, Đường Hoa Mỹ, Phường Bắc Sơn, Hà Nội\",\"approved_by\":null,\"notes\":null,\"documents\":null,\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Bị cảm cúm, sốt cao, cần đi khám và điều trị tại phòng khám\",\"support_notes\":null}', '{\"id\":2,\"sister_id\":2,\"departure_date\":\"2025-12-16T17:00:00.000Z\",\"type\":\"Phép ốm\",\"expected_return_date\":\"2025-12-18T17:00:00.000Z\",\"return_date\":\"1899-11-29T16:53:30.000Z\",\"destination\":\"Phòng khám Đa khoa Cộng Hòa, Hà Nội\",\"contact_phone\":\"0912345678\",\"contact_address\":\"Số 78, Đường Hoa Mỹ, Phường Bắc Sơn, Hà Nội\",\"approved_by\":null,\"notes\":null,\"documents\":\"[{\\\"id\\\":1766453604485,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766453604467-sswmyb.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-23T01:33:24.485Z\\\"}]\",\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Bị cảm cúm, sốt cao, cần đi khám và điều trị tại phòng khám\",\"support_notes\":null}', '127.0.0.1', '2025-12-23 01:33:26'),
(161, 1, 'CREATE', 'evaluations', 1, NULL, NULL, '{\"id\":1,\"sister_id\":2,\"evaluation_type\":\"annual\",\"period\":\"Năm 2024\",\"evaluation_date\":\"2025-12-22T17:00:00.000Z\",\"evaluator\":\"3\",\"spiritual_life\":85,\"community_life\":80,\"apostolic_work\":82,\"personal_development\":80,\"overall_rating\":82,\"strengths\":\"Có năng lực quản lý tốt, tinh thần trách nhiệm cao, có khả năng lãnh đạo đội ngũ tốt\",\"weaknesses\":\"Cần cải thiện kỹ năng giao tiếp, thỉnh thoảng thiếu kiên nhẫn\",\"evaluation_period\":\"\",\"evaluator_id\":null,\"spiritual_life_score\":85,\"community_life_score\":80,\"mission_score\":null,\"personality_score\":null,\"obedience_score\":null,\"general_comments\":null,\"recommendations\":\"Nên tham gia khóa đào tạo về kỹ năng giao tiếp, tiếp tục phát triển năng lực lãnh đạo\",\"notes\":null,\"documents\":null,\"created_at\":\"2025-12-23T01:36:31.000Z\",\"updated_at\":null}', '127.0.0.1', '2025-12-23 01:36:32'),
(162, 1, 'CREATE', 'evaluations', 2, NULL, NULL, '{\"id\":2,\"sister_id\":3,\"evaluation_type\":\"quarterly\",\"period\":\"Quý 4/2024\",\"evaluation_date\":\"2025-12-22T17:00:00.000Z\",\"evaluator\":\"2\",\"spiritual_life\":78,\"community_life\":75,\"apostolic_work\":76,\"personal_development\":77,\"overall_rating\":77,\"strengths\":\"Làm việc cẩn thận, có trách nhiệm cao, hỗ trợ tốt cho đội\",\"weaknesses\":\"Cần cải thiện kỹ năng lãnh đạo, thỉnh thoảng gặp khó khăn trong việc ra quyết định\",\"evaluation_period\":\"\",\"evaluator_id\":null,\"spiritual_life_score\":78,\"community_life_score\":75,\"mission_score\":null,\"personality_score\":null,\"obedience_score\":null,\"general_comments\":null,\"recommendations\":null,\"notes\":null,\"documents\":null,\"created_at\":\"2025-12-23T01:38:53.000Z\",\"updated_at\":null}', '127.0.0.1', '2025-12-23 01:38:53'),
(163, 1, 'CREATE', 'evaluations', 3, NULL, NULL, '{\"id\":3,\"sister_id\":3,\"evaluation_type\":\"monthly\",\"period\":\"Tháng 12/2025\",\"evaluation_date\":\"2025-12-22T17:00:00.000Z\",\"evaluator\":\"1\",\"spiritual_life\":88,\"community_life\":85,\"apostolic_work\":86,\"personal_development\":87,\"overall_rating\":87,\"strengths\":\"Có ý thức cao, tích cực công tác, sáng tạo trong công việc\",\"weaknesses\":\"Cần cải thiện kỹ năng quản lý thời gian, thỉnh thoảng quá tập trung vào chi tiết\",\"evaluation_period\":\"\",\"evaluator_id\":null,\"spiritual_life_score\":88,\"community_life_score\":85,\"mission_score\":null,\"personality_score\":null,\"obedience_score\":null,\"general_comments\":null,\"recommendations\":null,\"notes\":null,\"documents\":null,\"created_at\":\"2025-12-23T01:40:48.000Z\",\"updated_at\":null}', '127.0.0.1', '2025-12-23 01:40:48'),
(164, 1, 'CREATE', 'users', 2, NULL, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":null,\"last_login\":null,\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":null,\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 03:39:14'),
(165, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":null,\"last_login\":null,\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":null,\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":null,\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T03:40:05.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 03:40:05'),
(166, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[2,4,3,5,1,48,47,95,96,97,90,91,93,94]}', '127.0.0.1', '2025-12-23 03:40:05'),
(167, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[1]}', '127.0.0.1', '2025-12-23 03:40:05'),
(168, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T03:41:55.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T03:41:55.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T03:41:55.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T03:41:55.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 03:47:44'),
(169, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,47,48,90,91,93,94,95,96,97,427,429,430,428,170,172,171,169,12,14,13,11,52,51,99,101,100,98,107,108,105,109,10,7,9,8,86,85,6,50,49,82,84,83,81,116,118,20,22,21,19,56,55,112,27,24,26,25,23,58,57,126,128,125,127,123,124,16,18,17,15,54,53,135,137,136,134,74,76,75,73,32,29,31,30,28,60,59,133,131,34,35,36,33,72,71,144,145,139,141,143,142,140,138,42,66,38,40,39,64,41,70,65,67,63,37,69,62,61,68,46,45,44,43,164,165,167,166,163,162,147,146,148,78,80,79,77,121]}', '127.0.0.1', '2025-12-23 03:47:44'),
(170, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[3,2,1]}', '127.0.0.1', '2025-12-23 03:47:44'),
(171, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T03:41:55.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T03:41:55.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T03:41:55.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T03:41:55.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 03:47:52'),
(172, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-23 03:47:53'),
(173, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[3,1,2]}', '127.0.0.1', '2025-12-23 03:47:53'),
(174, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-18T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-17T17:00:00.000Z\",\"end_date\":\"2025-12-21T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-23 04:56:55'),
(175, 1, 'UPDATE', 'vocation_journey', 4, NULL, '{\"id\":4,\"sister_id\":2,\"stage\":\"temporary_vows\",\"start_date\":\"2024-06-28T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\",\"documents\":\"[]\"}', '{\"id\":4,\"sister_id\":2,\"stage\":\"temporary_vows\",\"start_date\":\"2024-06-27T17:00:00.000Z\",\"end_date\":\"2025-12-21T17:00:00.000Z\",\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\",\"documents\":\"[]\"}', '127.0.0.1', '2025-12-23 04:58:15'),
(176, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-17T17:00:00.000Z\",\"end_date\":\"2025-12-21T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-16T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '127.0.0.1', '2025-12-23 04:58:31'),
(177, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T04:48:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T04:48:37.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T04:48:37.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T04:48:37.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 05:15:42'),
(178, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-23 05:15:42'),
(179, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[1,2]}', '127.0.0.1', '2025-12-23 05:15:42'),
(180, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T05:16:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T05:16:35.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T05:16:35.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T05:16:35.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 05:17:45'),
(181, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-23 05:17:45'),
(182, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[1]}', '127.0.0.1', '2025-12-23 05:17:45'),
(183, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T10:06:43.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T10:06:43.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T10:06:43.000Z\",\"is_active\":0,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T11:25:25.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 11:25:25'),
(184, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-23 11:25:25'),
(185, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[1]}', '127.0.0.1', '2025-12-23 11:25:25'),
(186, 1, 'TOGGLE_STATUS', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T10:06:43.000Z\",\"is_active\":0,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T11:25:25.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-23T10:06:43.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-23T11:25:53.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-23 11:25:53'),
(187, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-16T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766374352443-h518sq.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T03:32:32.465Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-15T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766491473322-xxwd7b.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-23T12:04:33.345Z\\\"}]\"}', '127.0.0.1', '2025-12-23 12:04:35'),
(188, 1, 'UPDATE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-15T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766491473322-xxwd7b.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-23T12:04:33.345Z\\\"}]\"}', '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-14T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/1766491758093-rgz2hn.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-23T12:09:18.168Z\\\"}]\"}', '127.0.0.1', '2025-12-23 12:09:20'),
(189, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/certificates/1766497802950-63fl74.docx\",\"path\":\"/uploads/certificates/1766497802950-63fl74.docx\"}', '127.0.0.1', '2025-12-23 13:58:22'),
(190, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 13:58:25'),
(191, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/certificates/1766498295567-btukgb.docx\",\"path\":\"/uploads/certificates/1766498295567-btukgb.docx\"}', '127.0.0.1', '2025-12-23 14:00:24'),
(192, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 14:00:27'),
(193, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/certificates/1766498295567-btukgb.docx\",\"path\":\"/uploads/certificates/1766498295567-btukgb.docx\"}', '127.0.0.1', '2025-12-23 14:07:24'),
(194, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 14:07:27'),
(195, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/1766498752074-ss7jbo.docx\",\"path\":\"/uploads/1766498752074-ss7jbo.docx\"}', '127.0.0.1', '2025-12-23 14:08:00'),
(196, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 14:08:03'),
(197, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/1766499544262-q87os1.docx\",\"path\":\"/uploads/1766499544262-q87os1.docx\"}', '127.0.0.1', '2025-12-23 14:21:13'),
(198, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 14:21:16'),
(199, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/1766499544262-q87os1.docx\",\"path\":\"/uploads/1766499544262-q87os1.docx\"}', '127.0.0.1', '2025-12-23 14:22:54'),
(200, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 14:22:57'),
(201, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/1766499544262-q87os1.docx\",\"path\":\"/uploads/1766499544262-q87os1.docx\"}', '127.0.0.1', '2025-12-23 14:31:57'),
(202, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 14:32:00'),
(203, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/1766499544262-q87os1.docx\",\"path\":\"/uploads/1766499544262-q87os1.docx\"}', '127.0.0.1', '2025-12-23 14:32:23'),
(204, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 14:32:27'),
(205, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/decisions/1766399029513-t79qvf.docx\",\"path\":\"/uploads/decisions/1766399029513-t79qvf.docx\"}', '127.0.0.1', '2025-12-23 16:25:05'),
(206, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 16:25:09'),
(207, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/decisions/1766399029513-t79qvf.docx\",\"path\":\"/uploads/decisions/1766399029513-t79qvf.docx\"}', '127.0.0.1', '2025-12-23 16:25:13'),
(208, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 16:25:16'),
(209, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/decisions/1766399029513-t79qvf.docx\",\"path\":\"/uploads/decisions/1766399029513-t79qvf.docx\"}', '127.0.0.1', '2025-12-23 16:36:10'),
(210, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 16:36:14'),
(211, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/certificates/1766422314934-5r02u7.docx\",\"path\":\"/uploads/certificates/1766422314934-5r02u7.docx\"}', '127.0.0.1', '2025-12-23 16:38:11'),
(212, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /favicon.ico\",\"path\":\"/favicon.ico\"}', '127.0.0.1', '2025-12-23 16:38:14'),
(213, 1, 'UPDATE', 'sisters', 3, NULL, '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-07T17:00:00.000Z\",\"place_of_birth\":\"Quảng Trị\",\"hometown\":\"Quảng Trị\",\"permanent_address\":\"789 Phố Mọ Cỏ, Quảng Trị\",\"current_address\":\"Nha Tho Trung Tam, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-17T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":\"Phạm Văn Hậu\",\"father_occupation\":\"Nông dân\",\"mother_name\":\"Vũ Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Mọ Cỏ, Quảng Trị\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1996-10-13T17:00:00.000Z\",\"baptism_place\":\"Nha Tho Quang Tri\",\"confirmation_date\":\"2005-05-18T17:00:00.000Z\",\"first_communion_date\":\"2007-12-23T17:00:00.000Z\",\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":\"Phạm Văn Sơn\",\"emergency_contact_phone\":\"0934567890\",\"notes\":\"Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":2,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":\"2025-12-23T04:22:51.000Z\",\"documents\":\"[{\\\"id\\\":1766374397592,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766374397588-4o89ln.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T03:33:17.592Z\\\"}]\"}', '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-06T17:00:00.000Z\",\"place_of_birth\":\"Quảng Trị\",\"hometown\":\"Quảng Trị\",\"permanent_address\":\"789 Phố Mọ Cỏ, Quảng Trị\",\"current_address\":\"Nha Tho Trung Tam, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-16T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":\"Phạm Văn Hậu\",\"father_occupation\":\"Nông dân\",\"mother_name\":\"Vũ Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Mọ Cỏ, Quảng Trị\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1996-10-12T17:00:00.000Z\",\"baptism_place\":\"Nha Tho Quang Tri\",\"confirmation_date\":\"2005-05-17T17:00:00.000Z\",\"first_communion_date\":\"2007-12-22T17:00:00.000Z\",\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":\"Phạm Văn Sơn\",\"emergency_contact_phone\":\"0934567890\",\"notes\":\"Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":2,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":\"2025-12-24T02:55:13.000Z\",\"documents\":\"[{\\\"id\\\":1766374397592,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766374397588-4o89ln.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T03:33:17.592Z\\\"}]\"}', '127.0.0.1', '2025-12-24 02:55:13'),
(214, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-24 08:34:42'),
(215, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-24 08:34:42'),
(216, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[1,2]}', '127.0.0.1', '2025-12-24 08:34:42'),
(217, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-24 08:48:47'),
(218, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-24 08:48:47'),
(219, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[1,2]}', '127.0.0.1', '2025-12-24 08:48:47'),
(220, 2, 'DELETE', 'vocation_journey', 8, NULL, '{\"id\":8,\"sister_id\":1,\"stage\":\"novice\",\"start_date\":\"2024-02-14T17:00:00.000Z\",\"end_date\":\"2025-08-13T17:00:00.000Z\",\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện là thời kỳ đào tạo toàn diện về lời sống tu sĩ, các kỹ năng hoàn thiện tinh thần cống hiến đầy đủ cho Chúa và Giáo hội với sự hướng dẫn kỹ lưỡng\",\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 08:50:19'),
(221, 2, 'DELETE', 'vocation_journey', 6, NULL, '{\"id\":6,\"sister_id\":1,\"stage\":\"aspirant\",\"start_date\":\"2023-02-13T17:00:00.000Z\",\"end_date\":\"2023-08-12T17:00:00.000Z\",\"location\":\"Nhà Dòng Hà Nội, Quốc Tử Giám, Hà Nội\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên nhận lời mời từ Hội Dòng, quyết định theo đuổi con đường tu sĩ với sự cầu nguyện của gia đình\",\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 08:50:23'),
(222, 2, 'DELETE', 'vocation_journey', 1, NULL, '{\"id\":1,\"sister_id\":3,\"stage\":\"aspirant\",\"start_date\":\"1996-10-17T17:00:00.000Z\",\"end_date\":\"2005-05-16T17:00:00.000Z\",\"location\":\"Đức Mẹ Núi Cúi\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên, bắt đầu từ năm 1996 với các bài tập tinh thần cơ bản.\",\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 08:50:27'),
(223, 2, 'DELETE', 'vocation_journey', 7, NULL, '{\"id\":7,\"sister_id\":1,\"stage\":\"temporary_vows\",\"start_date\":\"2023-08-12T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh tập trung vào việc học tập các điều chỉnh lời sống, chuẩn bị cho việc khấn thề tạm thời và những học hỏi sâu sắc về tinh thần Hội Dòng\",\"documents\":\"[]\"}', NULL, '127.0.0.1', '2025-12-24 08:51:40'),
(224, 2, 'DELETE', 'vocation_journey', 2, NULL, '{\"id\":2,\"sister_id\":3,\"stage\":\"novice\",\"start_date\":\"2005-05-10T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà thờ Con Gà\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với nhiều thử thách và sự trưởng thành trong đạo sư phạm, từ 2005 đến 2008.\",\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 08:51:42'),
(225, NULL, 'error', 'system', NULL, NULL, NULL, '{\"type\":\"server\",\"message\":\"Not Found - /uploads/1766333233177-gczzjn.jpg\",\"path\":\"/uploads/1766333233177-gczzjn.jpg\"}', '127.0.0.1', '2025-12-24 08:52:15'),
(226, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-24 09:07:57'),
(227, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-24 09:07:57'),
(228, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[]}', '127.0.0.1', '2025-12-24 09:07:57'),
(229, 1, 'UPDATE', 'users', 2, NULL, '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '{\"id\":2,\"username\":\"tester01\",\"email\":\"test@example.com\",\"full_name\":\"Trần Tín\",\"phone\":null,\"avatar\":\"\",\"last_login\":\"2025-12-24T08:28:39.000Z\",\"is_active\":1,\"created_at\":\"2025-12-23T03:39:14.000Z\",\"updated_at\":\"2025-12-24T08:28:39.000Z\",\"is_admin\":0,\"data_scope\":\"community\",\"is_super_admin\":0}', '127.0.0.1', '2025-12-24 09:08:13'),
(230, 1, 'UPDATE_PERMISSIONS', 'users', 2, NULL, NULL, '{\"permissionIds\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,90,91,93,94,95,96,97,98,99,100,101,105,107,108,109,112,116,118,121,123,124,125,126,127,128,131,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,162,163,164,165,166,167,169,170,171,172,427,428,429,430]}', '127.0.0.1', '2025-12-24 09:08:13'),
(231, 1, 'ASSIGN_COMMUNITIES', 'users', 2, NULL, NULL, '{\"community_ids\":[3]}', '127.0.0.1', '2025-12-24 09:08:13'),
(232, 1, 'DELETE', 'sisters', 2, NULL, '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-18T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":\"Nam Định\",\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-08T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-22T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-06T17:00:00.000Z\",\"first_communion_date\":\"2009-12-19T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-21T16:41:07.000Z\",\"documents\":null}', '{\"id\":2,\"code\":\"NT-002\",\"saint_name\":\"Théclè\",\"birth_name\":\"Lê Thị Mỹ Hạnh\",\"date_of_birth\":\"1998-08-18T17:00:00.000Z\",\"place_of_birth\":\"Nam Định\",\"hometown\":\"Nam Định\",\"permanent_address\":\"456 Phố Lế Công, Nam Định\",\"current_address\":\"Nha Tho Trung Tam, Hà Nội\",\"nationality\":\"Việt Nam\",\"id_card\":\"123456789012\",\"id_card_date\":\"2021-02-08T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Nam Định\",\"father_name\":\"Lê Văn Bịnh\",\"father_occupation\":\"Thợ công\",\"mother_name\":\"Trần Thị Ngôc\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":2,\"family_address\":\"456 Phố Lẽ Công, Nam Định\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1998-09-22T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Nam Định\",\"confirmation_date\":\"2007-05-06T17:00:00.000Z\",\"first_communion_date\":\"2009-12-19T17:00:00.000Z\",\"phone\":\"0981234567\",\"email\":\"lehanhanh@example.com\",\"emergency_contact_name\":\"Lê Văn Tó\",\"emergency_contact_phone\":\"0912345678\",\"notes\":\"Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.\",\"photo_url\":null,\"status\":\"left\",\"current_stage\":null,\"current_community_id\":null,\"created_by\":1,\"created_at\":\"2025-12-21T16:21:08.000Z\",\"updated_at\":\"2025-12-24T09:08:28.000Z\",\"documents\":null}', '127.0.0.1', '2025-12-24 09:08:28'),
(233, 1, 'DELETE', 'sisters', 3, NULL, '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-06T17:00:00.000Z\",\"place_of_birth\":\"Quảng Trị\",\"hometown\":\"Quảng Trị\",\"permanent_address\":\"789 Phố Mọ Cỏ, Quảng Trị\",\"current_address\":\"Nha Tho Trung Tam, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-16T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":\"Phạm Văn Hậu\",\"father_occupation\":\"Nông dân\",\"mother_name\":\"Vũ Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Mọ Cỏ, Quảng Trị\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1996-10-12T17:00:00.000Z\",\"baptism_place\":\"Nha Tho Quang Tri\",\"confirmation_date\":\"2005-05-17T17:00:00.000Z\",\"first_communion_date\":\"2007-12-22T17:00:00.000Z\",\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":\"Phạm Văn Sơn\",\"emergency_contact_phone\":\"0934567890\",\"notes\":\"Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.\",\"photo_url\":null,\"status\":\"active\",\"current_stage\":null,\"current_community_id\":2,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":\"2025-12-24T02:55:13.000Z\",\"documents\":\"[{\\\"id\\\":1766374397592,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766374397588-4o89ln.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T03:33:17.592Z\\\"}]\"}', '{\"id\":3,\"code\":\"NT-003\",\"saint_name\":\"Băong\",\"birth_name\":\"Phạm Thị Thanh Hương\",\"date_of_birth\":\"1996-06-06T17:00:00.000Z\",\"place_of_birth\":\"Quảng Trị\",\"hometown\":\"Quảng Trị\",\"permanent_address\":\"789 Phố Mọ Cỏ, Quảng Trị\",\"current_address\":\"Nha Tho Trung Tam, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"234567890123\",\"id_card_date\":\"2021-03-16T17:00:00.000Z\",\"id_card_place\":\"Cảnh sát Quảng Trị\",\"father_name\":\"Phạm Văn Hậu\",\"father_occupation\":\"Nông dân\",\"mother_name\":\"Vũ Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Mọ Cỏ, Quảng Trị\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"1996-10-12T17:00:00.000Z\",\"baptism_place\":\"Nha Tho Quang Tri\",\"confirmation_date\":\"2005-05-17T17:00:00.000Z\",\"first_communion_date\":\"2007-12-22T17:00:00.000Z\",\"phone\":\"0923456789\",\"email\":\"phamhuong@example.com\",\"emergency_contact_name\":\"Phạm Văn Sơn\",\"emergency_contact_phone\":\"0934567890\",\"notes\":\"Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.\",\"photo_url\":null,\"status\":\"left\",\"current_stage\":null,\"current_community_id\":2,\"created_by\":1,\"created_at\":\"2025-12-21T16:24:00.000Z\",\"updated_at\":\"2025-12-24T09:08:32.000Z\",\"documents\":\"[{\\\"id\\\":1766374397592,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766374397588-4o89ln.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T03:33:17.592Z\\\"}]\"}', '127.0.0.1', '2025-12-24 09:08:32'),
(234, 1, 'DELETE', 'sisters', 1, NULL, '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-11T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"hometown\":\"Hưng Yên\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-06T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-17T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-15T17:00:00.000Z\",\"first_communion_date\":\"2010-12-22T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":\"/uploads/1766333233177-gczzjn.jpg\",\"status\":\"active\",\"current_stage\":null,\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-23T13:59:57.000Z\",\"documents\":\"[{\\\"id\\\":1766333230557,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766333230548-837iw9.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-21T16:07:10.557Z\\\"}]\"}', '{\"id\":1,\"code\":\"NT-001\",\"saint_name\":\"Thérèse\",\"birth_name\":\"Nguyễn Thị Mỹ Linh\",\"date_of_birth\":\"1995-03-11T17:00:00.000Z\",\"place_of_birth\":\"Hà Nội\",\"hometown\":\"Hưng Yên\",\"permanent_address\":\"Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"current_address\":\"Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi\",\"nationality\":\"Việt Nam\",\"id_card\":\"012345678901\",\"id_card_date\":\"2020-06-06T17:00:00.000Z\",\"id_card_place\":\"Cảnh Sát Cấp Hà Nội\",\"father_name\":\"Nguyễn Văn An\",\"father_occupation\":\"Công nhân\",\"mother_name\":\"Trần Thị Hoa\",\"mother_occupation\":\"Nội trợ\",\"siblings_count\":3,\"family_address\":\"123 Phố Liễu Giai, Quận Ba Đình, Hà Nội\",\"family_religion\":\"Công Giáo\",\"baptism_date\":\"2000-04-17T17:00:00.000Z\",\"baptism_place\":\"Nhà Thờ Công Giáo Ba Đình\",\"confirmation_date\":\"2008-05-15T17:00:00.000Z\",\"first_communion_date\":\"2010-12-22T17:00:00.000Z\",\"phone\":\"0987654321\",\"email\":\"therese@example.com\",\"emergency_contact_name\":\"Nguyễn Văn Bình\",\"emergency_contact_phone\":\"0912345678\",\"notes\":null,\"photo_url\":\"/uploads/1766333233177-gczzjn.jpg\",\"status\":\"left\",\"current_stage\":null,\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-21T16:02:40.000Z\",\"updated_at\":\"2025-12-24T09:08:35.000Z\",\"documents\":\"[{\\\"id\\\":1766333230557,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766333230548-837iw9.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-21T16:07:10.557Z\\\"}]\"}', '127.0.0.1', '2025-12-24 09:08:35'),
(235, 1, 'REMOVE_MEMBER', 'communities', 3, NULL, '{\"id\":9,\"sister_id\":2,\"community_id\":3,\"role\":\"member\",\"start_date\":\"2025-12-23T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:02'),
(236, 1, 'REMOVE_MEMBER', 'communities', 2, NULL, '{\"id\":6,\"sister_id\":3,\"community_id\":2,\"role\":\"tong_quyen\",\"start_date\":\"2024-12-21T17:00:00.000Z\",\"end_date\":null,\"decision_number\":\"123\",\"decision_date\":null,\"decision_file_url\":\"/uploads/1766399029513-t79qvf.docx\",\"notes\":\"456\"}', NULL, '127.0.0.1', '2025-12-24 09:09:05'),
(237, 1, 'REMOVE_MEMBER', 'communities', 1, NULL, '{\"id\":8,\"sister_id\":1,\"community_id\":1,\"role\":\"member\",\"start_date\":\"2025-12-22T17:00:00.000Z\",\"end_date\":null,\"decision_number\":null,\"decision_date\":null,\"decision_file_url\":null,\"notes\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:07'),
(238, 1, 'REMOVE_MEMBER', 'communities', 1, NULL, '{\"id\":3,\"sister_id\":2,\"community_id\":1,\"role\":\"assistant\",\"start_date\":\"2024-12-31T17:00:00.000Z\",\"end_date\":\"1899-11-29T16:53:30.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', NULL, '127.0.0.1', '2025-12-24 09:09:08'),
(239, 1, 'REMOVE_MEMBER', 'communities', 1, NULL, '{\"id\":7,\"sister_id\":1,\"community_id\":1,\"role\":\"superior\",\"start_date\":\"2024-12-29T17:00:00.000Z\",\"end_date\":\"2025-12-31T17:00:00.000Z\",\"decision_number\":\"\",\"decision_date\":null,\"decision_file_url\":null,\"notes\":\"\"}', NULL, '127.0.0.1', '2025-12-24 09:09:09'),
(240, 1, 'DELETE', 'education', 2, NULL, '{\"id\":2,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Thương Mại Quốc Tế\",\"institution\":\"Trường Đại Học Ngoại Thương\",\"start_date\":\"2018-08-23T17:00:00.000Z\",\"end_date\":null,\"certificate_url\":null,\"graduation_year\":2022,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.7/4.0\",\"thesis_title\":\"Phân tích các vấn đề thương mại điện tử của các doanh nghiệp xuất khẩu Việt Nam\",\"notes\":\"Hoàn thành xuất sắc, được công bố 1 bài báo chuyên ngành, đề tài có tính ứng dụng cao cho các DN nhỏ vừa\",\"documents\":\"[{\\\"id\\\":1766405675638,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766405675624-sjid8k.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-22T12:14:35.638Z\\\"}]\"}', NULL, '127.0.0.1', '2025-12-24 09:09:20');
INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `table_name`, `record_id`, `description`, `old_value`, `new_value`, `ip_address`, `created_at`) VALUES
(241, 1, 'DELETE', 'education', 3, NULL, '{\"id\":3,\"sister_id\":2,\"level\":\"master\",\"major\":\"Kế Toán Tài Chính\",\"institution\":\"Trường Cao Đẳng Tài Chính - Kế Toán\",\"start_date\":\"2015-08-12T17:00:00.000Z\",\"end_date\":\"2018-06-07T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2024,\"status\":\"da_tot_nghiep\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:22'),
(242, 1, 'DELETE', 'education', 1, NULL, '{\"id\":1,\"sister_id\":2,\"level\":\"bachelor\",\"major\":\"Kế Toán\",\"institution\":\"Trường Đại Học Kinh Tế Thành Phố Hồ Chí Minh\",\"start_date\":null,\"end_date\":null,\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:24'),
(243, 1, 'DELETE', 'education', 6, NULL, '{\"id\":6,\"sister_id\":1,\"level\":\"doctorate\",\"major\":\"Khoa học Dữ liệu\",\"institution\":\"Đại học Công Nghệ\",\"start_date\":\"2021-08-31T17:00:00.000Z\",\"end_date\":\"2024-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:26'),
(244, 1, 'DELETE', 'education', 5, NULL, '{\"id\":5,\"sister_id\":1,\"level\":\"master\",\"major\":\"Quản lý Doanh nghiệp\",\"institution\":\"Đại học Kinh Tế Thương Mại\",\"start_date\":\"2019-08-31T17:00:00.000Z\",\"end_date\":\"2021-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:28'),
(245, 1, 'DELETE', 'education', 4, NULL, '{\"id\":4,\"sister_id\":1,\"level\":\"bachelor\",\"major\":\"Công nghệ Thông tin\",\"institution\":\"Đại học Quốc Gia Hà Nội\",\"start_date\":\"2015-08-31T17:00:00.000Z\",\"end_date\":\"2019-06-29T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":null,\"status\":\"dang_hoc\",\"gpa\":null,\"thesis_title\":null,\"notes\":null,\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:29'),
(246, 1, 'DELETE', 'education', 7, NULL, '{\"id\":7,\"sister_id\":3,\"level\":\"cap_1\",\"major\":\"Kế toán\",\"institution\":\"Trường Cao đẳng Kinh Tế\",\"start_date\":\"2018-08-27T17:00:00.000Z\",\"end_date\":\"2020-06-25T17:00:00.000Z\",\"certificate_url\":null,\"graduation_year\":2020,\"status\":\"da_tot_nghiep\",\"gpa\":\"3.2/4.0\",\"thesis_title\":\"Kỹ năng quản lý tài chính cá nhân\",\"notes\":\"Hoàn thành khóa học năm 2020 với kết quả tốt\",\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:31'),
(247, 1, 'DELETE', 'vocation_journey', 5, NULL, '{\"id\":5,\"sister_id\":2,\"stage\":\"tu_xuat\",\"start_date\":\"2024-12-14T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Sài Gòn, Thành phố Hồ Chí Minh\",\"superior\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"formation_director\":\"1_Thérèse Nguyễn Thị Mỹ Linh\",\"community_id\":1,\"supervisor_id\":null,\"notes\":\"Giai đoạn tập sinh viện với đào tạo sâu về lời sống và dạy dỗ tâm linh chuyên sâu\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/1766491758093-rgz2hn.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-23T12:09:18.168Z\\\"}]\"}', NULL, '127.0.0.1', '2025-12-24 09:09:40'),
(248, 1, 'DELETE', 'vocation_journey', 4, NULL, '{\"id\":4,\"sister_id\":2,\"stage\":\"temporary_vows\",\"start_date\":\"2024-06-27T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà Dòng Đà Lạt, Lâm Đồng\",\"superior\":\"2_Théclè Lê Thị Mỹ Hạnh\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":2,\"supervisor_id\":null,\"notes\":\"Giai đoạn tiền ứng sinh với các bài học tâm linh và kỷ luật tu sinh viện\",\"documents\":\"[]\"}', NULL, '127.0.0.1', '2025-12-24 09:09:43'),
(249, 1, 'DELETE', 'vocation_journey', 3, NULL, '{\"id\":3,\"sister_id\":2,\"stage\":\"aspirant\",\"start_date\":\"2023-12-30T17:00:00.000Z\",\"end_date\":null,\"location\":\"Nhà dòng Hà Nội, Việt Nam\",\"superior\":\"3_Băong Phạm Thị Thanh Hương\",\"formation_director\":\"3_Băong Phạm Thị Thanh Hương\",\"community_id\":3,\"supervisor_id\":null,\"notes\":\"Giai đoạn ứng sinh đầu tiên với sự hướng dẫn của Ban Tuyển Chọn\",\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:09:45'),
(250, 1, 'DELETE', 'missions', 2, NULL, '{\"id\":2,\"sister_id\":2,\"field\":\"Y Tế - Chăm Sóc Sức Khỏe\",\"specific_role\":\"Y Tá - Điều dưỡng Viện\",\"organization\":null,\"address\":null,\"start_date\":\"2023-02-24T17:00:00.000Z\",\"end_date\":\"2024-02-24T17:00:00.000Z\",\"notes\":\"Phân công công tác tại Bệnh viện Tâm Thần Thành phố. Chịu trách nhiệm điều dưỡng cho bệnh nhân, hỗ trợ các cuộc khám bệnh định kỳ, quản lý thuốc và theo dõi tình trạng sức khỏe. Hoàn thành tất cả các mục tiêu đề ra trong năm.\",\"documents\":\"[{\\\"url\\\":\\\"/uploads/certificates/1766422314934-5r02u7.docx\\\",\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"uploaded_at\\\":\\\"2025-12-22T16:51:54.955Z\\\"},{\\\"url\\\":\\\"/uploads/certificates/1766422314945-unmm5j.jpg\\\",\\\"name\\\":\\\"Anh-gai-xinh-Facebook-Tiktok.jpg\\\",\\\"size\\\":164609,\\\"uploaded_at\\\":\\\"2025-12-22T16:51:54.955Z\\\"}]\"}', NULL, '127.0.0.1', '2025-12-24 09:10:04'),
(251, 1, 'DELETE', 'missions', 3, NULL, '{\"id\":3,\"sister_id\":1,\"field\":\"Xuất Bản\",\"specific_role\":null,\"organization\":null,\"address\":null,\"start_date\":\"2024-01-12T17:00:00.000Z\",\"end_date\":null,\"notes\":null,\"documents\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:05'),
(252, 1, 'DELETE', 'health_records', 2, NULL, '{\"id\":2,\"sister_id\":2,\"general_health\":\"average\",\"chronic_diseases\":\"Viêm mũi dị ứng, mệt mỏi\",\"work_limitations\":\"Tránh không khí lạnh, giảm các hoạt động ngoài trời khi có gió\",\"checkup_date\":\"2025-11-08T17:00:00.000Z\",\"next_checkup_date\":\"2025-12-08T17:00:00.000Z\",\"checkup_place\":\"Phòng khám Đa khoa Cộng Hòa\",\"doctor\":\"PGS. TS. Trương Minh Tuấn\",\"blood_pressure\":\"118/76\",\"heart_rate\":\"72\",\"weight\":\"58.00\",\"height\":\"162.00\",\"diagnosis\":\"Viêm mũi dị ứng mùa (Allergic Rhinitis)\",\"treatment\":\"Thuốc kháng histamine Loratadin 10mg/ngày, xịt mũi Mometasone Furoate 2 lần/ngày\",\"notes\":\"Tình trạng ổn định, cần tiếp tục dùng thuốc theo đơn\",\"documents\":\"[{\\\"id\\\":1766451214404,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766451214388-afrbhk.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-23T00:53:34.404Z\\\"}]\",\"created_at\":\"2025-12-22T17:50:44.000Z\",\"updated_at\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:11'),
(253, 1, 'DELETE', 'health_records', 1, NULL, '{\"id\":1,\"sister_id\":3,\"general_health\":\"good\",\"chronic_diseases\":\"Cao huyết áp, béo phì\",\"work_limitations\":\"Hạn chế công việc nặng, tránh leo cầu thang nhiều\",\"checkup_date\":\"2025-12-14T17:00:00.000Z\",\"next_checkup_date\":\"2026-01-14T17:00:00.000Z\",\"checkup_place\":\"Bệnh viện Quân Y 175 Hà Nội\",\"doctor\":\"ThS. BS Nguyễn Văn A\",\"blood_pressure\":\"140/90\",\"heart_rate\":\"78\",\"weight\":\"73.50\",\"height\":\"165.00\",\"diagnosis\":\"Cao huyết áp độ 1, chỉ số BMI 29.5 (thừa cân)\",\"treatment\":\"Uống thuốc Lisinopril 10mg 1 lần/ngày, tập thể dục 30 phút/ngày 5 lần/tuần, giảm muối trong ăn\",\"notes\":\"Cần theo dõi huyết áp hàng ngày, tái khám sau 1 tháng để kiểm tra lại kết quả\",\"documents\":null,\"created_at\":\"2025-12-23T00:48:29.000Z\",\"updated_at\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:13'),
(254, 1, 'DELETE', 'health_records', 3, NULL, '{\"id\":3,\"sister_id\":2,\"general_health\":\"weak\",\"chronic_diseases\":\"Thiếu hụt canxi, thiếu máu nhẹ\",\"work_limitations\":\"Cần bổ sung canxi, hạn chế hoạt động quá sức, cần hỗ trợ quang y\",\"checkup_date\":\"2025-12-21T17:00:00.000Z\",\"next_checkup_date\":\"2026-01-21T17:00:00.000Z\",\"checkup_place\":\"Bệnh viện Nhi Đồng 1 Hồ Chí Minh\",\"doctor\":\"TS. BS Đỗ Thị Hoa\",\"blood_pressure\":\"110/70\",\"heart_rate\":\"76\",\"weight\":\"54.00\",\"height\":\"158.00\",\"diagnosis\":\"Thiếu canxi, thiếu máu nhẹ (Hemoglobin: 10.2 g/dL)\",\"treatment\":\"Bổ sung Canxi và Vitamin D3, thuốc tăng cơ hemoglobin (Ferrous Sulfate 325mg/ngày), chế độ ăn giàu sắt và đạm\",\"notes\":\"Tình trạng sức khỏe yếu, cần bổ sung dinh dưỡng, xét nghiệm lại sau 3 tháng\",\"documents\":null,\"created_at\":\"2025-12-23T00:52:55.000Z\",\"updated_at\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:15'),
(255, 1, 'DELETE', 'departure_records', 2, NULL, '{\"id\":2,\"sister_id\":2,\"departure_date\":\"2025-12-16T17:00:00.000Z\",\"type\":\"Phép ốm\",\"expected_return_date\":\"2025-12-18T17:00:00.000Z\",\"return_date\":\"1899-11-29T16:53:30.000Z\",\"destination\":\"Phòng khám Đa khoa Cộng Hòa, Hà Nội\",\"contact_phone\":\"0912345678\",\"contact_address\":\"Số 78, Đường Hoa Mỹ, Phường Bắc Sơn, Hà Nội\",\"approved_by\":null,\"notes\":null,\"documents\":\"[{\\\"id\\\":1766453604485,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766453604467-sswmyb.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-23T01:33:24.485Z\\\"}]\",\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Bị cảm cúm, sốt cao, cần đi khám và điều trị tại phòng khám\",\"support_notes\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:21'),
(256, 1, 'DELETE', 'departure_records', 1, NULL, '{\"id\":1,\"sister_id\":3,\"departure_date\":\"2025-12-23T17:00:00.000Z\",\"type\":\"Phép thường\",\"expected_return_date\":\"2025-12-26T17:00:00.000Z\",\"return_date\":null,\"destination\":\"Nhà họ hàng ở Hà Nội\",\"contact_phone\":\"0987654321\",\"contact_address\":\"Số 45, Ngõ 123, Phố Hàng Bông, Hà Nội\",\"approved_by\":null,\"notes\":null,\"documents\":\"[{\\\"id\\\":1766451613704,\\\"name\\\":\\\"24210089_Tran Tin.docx\\\",\\\"size\\\":1273432,\\\"type\\\":\\\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\\\",\\\"url\\\":\\\"/uploads/certificates/1766451613686-w2vjd5.docx\\\",\\\"uploadedAt\\\":\\\"2025-12-23T01:00:13.704Z\\\"}]\",\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Về thăm gia đình nhân dịp Lễ Giáng sinh và năm mới\",\"support_notes\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:22'),
(257, 1, 'DELETE', 'departure_records', 3, NULL, '{\"id\":3,\"sister_id\":1,\"departure_date\":\"2026-01-04T17:00:00.000Z\",\"type\":\"Phép không lương\",\"expected_return_date\":\"2026-01-14T17:00:00.000Z\",\"return_date\":null,\"destination\":\"Thăm thân nhân ở Quảng Ninh\",\"contact_phone\":\"0938765432\",\"contact_address\":\"Số 28, Đường Hải Yên, Thành phố Hạ Long, Quảng Ninh\",\"approved_by\":null,\"notes\":null,\"documents\":null,\"stage_at_departure\":\"temporary_vows\",\"reason\":\"Đi thăm gia đình nhân kỳ nghỉ Tết Nguyên đán, cần thời gian để quy tụ gia đình\",\"support_notes\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:23'),
(258, 1, 'DELETE', 'evaluations', 1, NULL, '{\"id\":1,\"sister_id\":2,\"evaluation_type\":\"annual\",\"period\":\"Năm 2024\",\"evaluation_date\":\"2025-12-22T17:00:00.000Z\",\"evaluator\":\"3\",\"spiritual_life\":85,\"community_life\":80,\"apostolic_work\":82,\"personal_development\":80,\"overall_rating\":82,\"strengths\":\"Có năng lực quản lý tốt, tinh thần trách nhiệm cao, có khả năng lãnh đạo đội ngũ tốt\",\"weaknesses\":\"Cần cải thiện kỹ năng giao tiếp, thỉnh thoảng thiếu kiên nhẫn\",\"evaluation_period\":\"\",\"evaluator_id\":null,\"spiritual_life_score\":85,\"community_life_score\":80,\"mission_score\":null,\"personality_score\":null,\"obedience_score\":null,\"general_comments\":null,\"recommendations\":\"Nên tham gia khóa đào tạo về kỹ năng giao tiếp, tiếp tục phát triển năng lực lãnh đạo\",\"notes\":null,\"documents\":null,\"created_at\":\"2025-12-23T01:36:31.000Z\",\"updated_at\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:28'),
(259, 1, 'DELETE', 'evaluations', 2, NULL, '{\"id\":2,\"sister_id\":3,\"evaluation_type\":\"quarterly\",\"period\":\"Quý 4/2024\",\"evaluation_date\":\"2025-12-22T17:00:00.000Z\",\"evaluator\":\"2\",\"spiritual_life\":78,\"community_life\":75,\"apostolic_work\":76,\"personal_development\":77,\"overall_rating\":77,\"strengths\":\"Làm việc cẩn thận, có trách nhiệm cao, hỗ trợ tốt cho đội\",\"weaknesses\":\"Cần cải thiện kỹ năng lãnh đạo, thỉnh thoảng gặp khó khăn trong việc ra quyết định\",\"evaluation_period\":\"\",\"evaluator_id\":null,\"spiritual_life_score\":78,\"community_life_score\":75,\"mission_score\":null,\"personality_score\":null,\"obedience_score\":null,\"general_comments\":null,\"recommendations\":null,\"notes\":null,\"documents\":null,\"created_at\":\"2025-12-23T01:38:53.000Z\",\"updated_at\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:29'),
(260, 1, 'DELETE', 'evaluations', 3, NULL, '{\"id\":3,\"sister_id\":3,\"evaluation_type\":\"monthly\",\"period\":\"Tháng 12/2025\",\"evaluation_date\":\"2025-12-22T17:00:00.000Z\",\"evaluator\":\"1\",\"spiritual_life\":88,\"community_life\":85,\"apostolic_work\":86,\"personal_development\":87,\"overall_rating\":87,\"strengths\":\"Có ý thức cao, tích cực công tác, sáng tạo trong công việc\",\"weaknesses\":\"Cần cải thiện kỹ năng quản lý thời gian, thỉnh thoảng quá tập trung vào chi tiết\",\"evaluation_period\":\"\",\"evaluator_id\":null,\"spiritual_life_score\":88,\"community_life_score\":85,\"mission_score\":null,\"personality_score\":null,\"obedience_score\":null,\"general_comments\":null,\"recommendations\":null,\"notes\":null,\"documents\":null,\"created_at\":\"2025-12-23T01:40:48.000Z\",\"updated_at\":null}', NULL, '127.0.0.1', '2025-12-24 09:10:31'),
(261, 1, 'DELETE', 'communities', 2, NULL, '{\"id\":2,\"code\":\"CD002\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"789 Duong Pho doc Thang, Thanh pho Da Lat\",\"phone\":\"0633123456\",\"email\":\"congdoan.dalat@example.com\",\"established_date\":\"2016-03-09T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Đà Lạt thành lập năm 2016 ở thành phố Đà Lạt. Cộng đoàn hoạt động nhằm giúp đỡ các em về phát triển tân thế, có khoảng 35 chị em. Hàng năm có các chương trình hỗ trợ gia đình và hào phỗ.\",\"created_at\":\"2025-12-21T16:15:02.000Z\",\"updated_at\":\"2025-12-21T16:17:30.000Z\",\"history\":\"<p>Cộng Đoàn Đà Lạt đầu tiên được thành lập vào năm 2016, ở thành phố Đà Lạt - thành phố được biết đến với khí hậu dị dự và phợng cảnh thiên nhiên đẹp lĩ.</p><p><br></p><p>Hiện nay, Cộng đoàn có khoảng 35 chị em tham gia học tập, Đão tạo và phục vụ các em có hoàn cảnh nghèo khó. Cộng đoàn có tổ chéc nhiều chương trình đóc sắc để hỗ trợ các chị em phát triển toàn diện về tâm lý và đức ãn.</p>\"}', NULL, '127.0.0.1', '2025-12-24 09:13:12'),
(262, 1, 'DELETE', 'communities', 3, NULL, '{\"id\":3,\"code\":\"CD003\",\"name\":\"Cộng Đoàn Hà Nội\",\"address\":\"234 Duong Thach Thi Thanh, Quan Hoan Kiem, Ha Noi\",\"phone\":\"0434567890\",\"email\":\"congdoan.hanoi@example.com\",\"established_date\":\"2014-05-19T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cộng Đoàn Hà Nội thành lập năm 2014, là một trong những cộng đoàn cổ xưa nhất của Hội Động OSP. Cộng đoàn có khoảng 55 chị em đang hoạt động. Một số hoạt động chính: đãy dỡ đức vỞ quốc, hỗ trợ tài chính cho các em và gia đình nghèo khó.\",\"created_at\":\"2025-12-21T16:16:21.000Z\",\"updated_at\":\"2025-12-21T16:18:55.000Z\",\"history\":\"<p>Cộng Đoàn Hà Nội được thành lập vào năm 2014, là một trong những cộng đoàn cổ xưa nhất của Hội Động OSP. Cộng đoàn có truyền thống mạnh mẽ về đọc Đão cáo và phục vụ ăn quàng yếu.</p><p><br></p><p>Hiện nay, Cộng đoàn có khoảng 55 chị em đang hoạt động, tham gia các hoạt động giáo dục, đào tạo kỹ năng và hỗ trợ nghềo khó. Cộng đoàn thường xuyên tổ chéc các chương trình hỗ trợ tài chính, hướng dẫn nhân đức và phục vụ cộng đồng.</p>\"}', NULL, '127.0.0.1', '2025-12-24 09:13:14'),
(263, 1, 'DELETE', 'communities', 1, NULL, '{\"id\":1,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Sài Gòn\",\"address\":\"456 Duong Le Loi, Quan 1, TP Ho Chi Minh\",\"phone\":\"0283456789\",\"email\":\"congdoan.saigon@example.com\",\"established_date\":\"2015-01-14T17:00:00.000Z\",\"status\":\"active\",\"description\":\"Cong doan tai Thanh pho Ho Chi Minh, thanh lap nam 2015, chuyen co tu luc dung linh duc duong theo tien chi tham nhat cua Hoi dong OSP. Co khoang 45 chi em dang tap khon, hoc tap va dung cop tu do thuc hanh Tin Loi.\",\"created_at\":\"2025-12-21T16:09:03.000Z\",\"updated_at\":\"2025-12-21T16:12:42.000Z\",\"history\":\"<p>Cộng Đoàn Sài Gòn là một cộng đoàn có lịch sử hình thành vào năm 2015, ở thành phố Hồ Chí Minh. Cộng đoàn có mục đích chữ sóc và phục vụ những người nghèo, bọ mẹc bệnh tát và bị cơ đơn.</p><p><br></p><p>Hiện tại, Cộng đoàn có khoảng 45 chị em đang hoạt động. Một số hoạt động chính bao gồm: Tập học hàng tuần, chương trình dạy dự lý thế hệ, hỗ trợ tài chính và trợ giúp các gia đình khó khăn.</p><p><br></p><p>Hàng năm, Cộng đoàn có những chương trình tìm kiếm và phục vụ các gia đình có hoàn cảnh khó đõi, đồng thời phủc vụ văn hóa xã hội cộng đồng.</p>\"}', NULL, '127.0.0.1', '2025-12-24 09:13:15');

-- --------------------------------------------------------

--
-- Table structure for table `backups`
--

CREATE TABLE `backups` (
  `id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) DEFAULT 0,
  `backup_type` enum('manual','auto') DEFAULT 'manual',
  `status` enum('completed','failed','in_progress') DEFAULT 'completed',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `chat_conversations`
--

CREATE TABLE `chat_conversations` (
  `id` int(11) NOT NULL,
  `conversation_id` varchar(36) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_message` text NOT NULL,
  `ai_response` text NOT NULL,
  `context_used` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`context_used`)),
  `entities_extracted` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`entities_extracted`)),
  `intent` varchar(50) DEFAULT NULL,
  `tokens_used` int(11) DEFAULT 0,
  `cost` decimal(10,6) DEFAULT 0.000000,
  `is_helpful` tinyint(1) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chat_conversations`
--

INSERT INTO `chat_conversations` (`id`, `conversation_id`, `user_id`, `user_message`, `ai_response`, `context_used`, `entities_extracted`, `intent`, `tokens_used`, `cost`, `is_helpful`, `feedback`, `created_at`, `updated_at`) VALUES
(1, '162a1c9b-5bc3-4a56-ab86-728650decb3b', 1, 'Có bao nhiêu nữ tu?', '📋 **Thông tin từ hệ thống:**\n\n👥 Thông tin chung về các nữ tu:\n\nTổng số nữ tu đang hoạt động: 15\n\nPhân bổ theo cộng đoàn:\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\n- Cộng đoàn Cần Thơ: 3 nữ tu\n- Cộng đoàn Đà Nẵng: 2 nữ tu\n- Cộng đoàn Hà Nội: 2 nữ tu\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\n- Cộng Đoàn Đà Lạt: 0 nữ tu\n', '{\"text\":\"👥 Thông tin chung về các nữ tu:\\n\\nTổng số nữ tu đang hoạt động: 15\\n\\nPhân bổ theo cộng đoàn:\\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\\n- Cộng đoàn Cần Thơ: 3 nữ tu\\n- Cộng đoàn Đà Nẵng: 2 nữ tu\\n- Cộng đoàn Hà Nội: 2 nữ tu\\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\\n- Cộng Đoàn Đà Lạt: 0 nữ tu\\n\",\"data\":{\"total\":15,\"byCommunity\":[{\"name\":\"Cộng đoàn Sài Gòn 1\",\"count\":3},{\"name\":\"Nhà Mẹ - Thủ Đức\",\"count\":3},{\"name\":\"Cộng đoàn Cần Thơ\",\"count\":3},{\"name\":\"Cộng đoàn Đà Nẵng\",\"count\":2},{\"name\":\"Cộng đoàn Hà Nội\",\"count\":2},{\"name\":\"Cộng đoàn Sài Gòn 2\",\"count\":2},{\"name\":\"Cộng Đoàn Đà Lạt\",\"count\":0}]},\"sources\":[]}', '{}', 'sister_info', 0, 0.000000, NULL, NULL, '2025-12-16 12:29:15', '2025-12-16 12:29:15'),
(2, '162a1c9b-5bc3-4a56-ab86-728650decb3b', 1, 'kể tên các nữ tu ở cộng đoàn hà nội', '📋 **Thông tin từ hệ thống:**\n\n👥 Thông tin chung về các nữ tu:\n\nTổng số nữ tu đang hoạt động: 15\n\nPhân bổ theo cộng đoàn:\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\n- Cộng đoàn Cần Thơ: 3 nữ tu\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\n- Cộng đoàn Đà Nẵng: 2 nữ tu\n- Cộng đoàn Hà Nội: 2 nữ tu\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\n- Cộng Đoàn Đà Lạt: 0 nữ tu\n', '{\"text\":\"👥 Thông tin chung về các nữ tu:\\n\\nTổng số nữ tu đang hoạt động: 15\\n\\nPhân bổ theo cộng đoàn:\\n- Nhà Mẹ - Thủ Đức: 3 nữ tu\\n- Cộng đoàn Cần Thơ: 3 nữ tu\\n- Cộng đoàn Sài Gòn 1: 3 nữ tu\\n- Cộng đoàn Đà Nẵng: 2 nữ tu\\n- Cộng đoàn Hà Nội: 2 nữ tu\\n- Cộng đoàn Sài Gòn 2: 2 nữ tu\\n- Cộng Đoàn Đà Lạt: 0 nữ tu\\n\",\"data\":{\"total\":15,\"byCommunity\":[{\"name\":\"Nhà Mẹ - Thủ Đức\",\"count\":3},{\"name\":\"Cộng đoàn Cần Thơ\",\"count\":3},{\"name\":\"Cộng đoàn Sài Gòn 1\",\"count\":3},{\"name\":\"Cộng đoàn Đà Nẵng\",\"count\":2},{\"name\":\"Cộng đoàn Hà Nội\",\"count\":2},{\"name\":\"Cộng đoàn Sài Gòn 2\",\"count\":2},{\"name\":\"Cộng Đoàn Đà Lạt\",\"count\":0}]},\"sources\":[]}', '{\"community_id\":5,\"community_name\":\"Cộng đoàn Hà Nội\"}', 'sister_info', 0, 0.000000, NULL, NULL, '2025-12-16 12:29:38', '2025-12-16 12:29:38'),
(3, '162a1c9b-5bc3-4a56-ab86-728650decb3b', 1, 'công đoàn đà lạt địa chỉ', '📋 **Thông tin từ hệ thống:**\n\n🏠 Danh sách các cộng đoàn:\n\nTổng số: 7 cộng đoàn\n\n📍 Cộng đoàn Cần Thơ\n   - Mã: CT01\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\n   - Số thành viên: 3\n\n📍 Cộng đoàn Hà Nội\n   - Mã: HN01\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\n   - Số thành viên: 2\n\n📍 Cộng đoàn Sài Gòn 1\n   - Mã: SG01\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\n   - Số thành viên: 3\n\n📍 Cộng đoàn Sài Gòn 2\n   - Mã: SG02\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\n   - Số thành viên: 2\n\n📍 Cộng Đoàn Đà Lạt\n   - Mã: CD001\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\n   - Số thành viên: 0\n\n📍 Cộng đoàn Đà Nẵng\n   - Mã: DN01\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\n   - Số thành viên: 2\n\n📍 Nhà Mẹ - Thủ Đức\n   - Mã: MH\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n   - Số thành viên: 3\n\n', '{\"text\":\"🏠 Danh sách các cộng đoàn:\\n\\nTổng số: 7 cộng đoàn\\n\\n📍 Cộng đoàn Cần Thơ\\n   - Mã: CT01\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Hà Nội\\n   - Mã: HN01\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2\\n\\n📍 Cộng đoàn Sài Gòn 1\\n   - Mã: SG01\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Sài Gòn 2\\n   - Mã: SG02\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2\\n\\n📍 Cộng Đoàn Đà Lạt\\n   - Mã: CD001\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0\\n\\n📍 Cộng đoàn Đà Nẵng\\n   - Mã: DN01\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2\\n\\n📍 Nhà Mẹ - Thủ Đức\\n   - Mã: MH\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3\\n\\n\",\"data\":{\"communities\":[{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:26:59.000Z\",\"history\":null,\"member_count\":3},{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},{\"id\":3,\"code\":\"SG02\",\"name\":\"Cộng đoàn Sài Gòn 2\",\"address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\",\"phone\":\"028-3456789\",\"email\":\"sg02@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},{\"id\":4,\"code\":\"DN01\",\"name\":\"Cộng đoàn Đà Nẵng\",\"address\":\"12 Đường Trần Phú, Hải Châu, Đà Nẵng\",\"phone\":\"0236-123456\",\"email\":\"dn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":1,\"code\":\"MH\",\"name\":\"Nhà Mẹ - Thủ Đức\",\"address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\",\"phone\":\"028-1234567\",\"email\":\"nhame@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3}]},\"sources\":[]}', '{}', 'community_info', 0, 0.000000, NULL, NULL, '2025-12-16 12:30:40', '2025-12-16 12:30:40'),
(4, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'thông tin Nguyễn Thị Mai', 'Xin lỗi, nhưng hiện tại tôi không có thông tin về Nguyễn Thị Mai. Nếu bạn có câu hỏi khác hoặc cần thông tin về một chủ đề nào đó, hãy cho tôi biết! 📚😊', '{\"text\":\"Không thể truy xuất dữ liệu từ hệ thống.\",\"data\":{},\"sources\":[]}', '{\"sister_id\":1,\"sister_name\":\"Nguyễn Thị Mai\",\"saint_name\":\"Maria\",\"match_confidence\":1}', 'journey_info', 790, 0.000137, NULL, NULL, '2025-12-16 12:50:10', '2025-12-16 12:50:10'),
(5, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'cộng đoàn sài gòn có mấy người?', 'Cộng đoàn Sài Gòn có tổng cộng 5 thành viên, được chia thành hai nhóm như sau:\n\n1. **Cộng đoàn Sài Gòn 1**: 3 thành viên\n2. **Cộng đoàn Sài Gòn 2**: 2 thành viên\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết! 📍😊', '{\"text\":\"🏠 Danh sách các cộng đoàn:\\n\\nTổng số: 7 cộng đoàn\\n\\n📍 Cộng đoàn Cần Thơ\\n   - Mã: CT01\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Hà Nội\\n   - Mã: HN01\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2\\n\\n📍 Cộng đoàn Sài Gòn 1\\n   - Mã: SG01\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Sài Gòn 2\\n   - Mã: SG02\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2\\n\\n📍 Cộng Đoàn Đà Lạt\\n   - Mã: CD001\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0\\n\\n📍 Cộng đoàn Đà Nẵng\\n   - Mã: DN01\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2\\n\\n📍 Nhà Mẹ - Thủ Đức\\n   - Mã: MH\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3\\n\\n\",\"data\":{\"communities\":[{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:26:59.000Z\",\"history\":null,\"member_count\":3},{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},{\"id\":3,\"code\":\"SG02\",\"name\":\"Cộng đoàn Sài Gòn 2\",\"address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\",\"phone\":\"028-3456789\",\"email\":\"sg02@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},{\"id\":4,\"code\":\"DN01\",\"name\":\"Cộng đoàn Đà Nẵng\",\"address\":\"12 Đường Trần Phú, Hải Châu, Đà Nẵng\",\"phone\":\"0236-123456\",\"email\":\"dn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":1,\"code\":\"MH\",\"name\":\"Nhà Mẹ - Thủ Đức\",\"address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\",\"phone\":\"028-1234567\",\"email\":\"nhame@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3}]},\"sources\":[]}', '{}', 'community_info', 1268, 0.000225, NULL, NULL, '2025-12-16 12:50:58', '2025-12-16 12:50:58'),
(6, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'Cộng đoàn Sài Gòn 1 có những ai, ai làm bề trên', 'Cộng đoàn Sài Gòn 1 có 3 thành viên như sau:\n\n1. **Clara Hoàng Thị Đào** (SR005)\n2. **Rosa Phạm Thị Cúc** (SR004)\n3. **Agnes Vũ Thị Hồng** (SR006)\n\nHiện tại, tôi không có thông tin về ai là bề trên của cộng đoàn này. Nếu bạn cần thêm thông tin khác hoặc có câu hỏi nào khác, hãy cho tôi biết! 🏠😊', '{\"text\":\"🏠 Thông tin cộng đoàn Cộng đoàn Sài Gòn 1:\\n\\n- Mã: SG01\\n- Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n- Điện thoại: 028-2345678\\n- Email: sg01@osp.vn\\n- Số thành viên: 3\\n\\n👥 Danh sách thành viên:\\n1. Clara Hoàng Thị Đào (SR005)\\n2. Rosa Phạm Thị Cúc (SR004)\\n3. Agnes Vũ Thị Hồng (SR006)\\n\",\"data\":{\"community\":{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},\"members\":[{\"id\":5,\"birth_name\":\"Hoàng Thị Đào\",\"saint_name\":\"Clara\",\"code\":\"SR005\"},{\"id\":4,\"birth_name\":\"Phạm Thị Cúc\",\"saint_name\":\"Rosa\",\"code\":\"SR004\"},{\"id\":6,\"birth_name\":\"Vũ Thị Hồng\",\"saint_name\":\"Agnes\",\"code\":\"SR006\"}]},\"sources\":[]}', '{\"community_id\":2,\"community_name\":\"Cộng đoàn Sài Gòn 1\"}', 'community_info', 1136, 0.000219, NULL, NULL, '2025-12-16 12:51:22', '2025-12-16 12:51:22'),
(7, '9c9441f0-714c-48de-aa77-759d0e174bc0', 1, 'Clara Hoàng Thị Đào thông tin cơ bản', 'Xin lỗi, hiện tại tôi không có thông tin cơ bản về chị Clara Hoàng Thị Đào. Nếu bạn có câu hỏi khác hoặc cần thông tin về một chủ đề nào khác, hãy cho tôi biết! 📚😊', '{\"text\":\"Không thể truy xuất dữ liệu từ hệ thống.\",\"data\":{},\"sources\":[]}', '{\"sister_id\":5,\"sister_name\":\"Hoàng Thị Đào\",\"saint_name\":\"Clara\",\"match_confidence\":1}', 'journey_info', 1089, 0.000185, NULL, NULL, '2025-12-16 12:51:46', '2025-12-16 12:51:46'),
(8, 'df9dc990-d362-4cb6-b9bc-b6b7c25770db', 1, 'thông tin Nguyễn Thị Mai', 'Dưới đây là thông tin chi tiết về nữ tu Maria Nguyễn Thị Mai:\n\n👤 **Thông tin cơ bản:**\n- **Mã số:** SR001\n- **Tên thánh:** Maria\n- **Họ tên:** Nguyễn Thị Mai\n- **Ngày sinh:** 15/03/1985\n- **Nơi sinh:** TP.HCM\n- **Quốc tịch:** Việt Nam\n- **Email:** N/A\n- **Điện thoại:** N/A\n\n🏠 **Cộng đoàn hiện tại:**\n- **Tên:** Nhà Mẹ - Thủ Đức\n- **Địa chỉ:** 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n\n📍 **Hành trình ơn gọi:**\n- **Khấn trọn:** 15/08/2010 → Hiện tại\n\n✅ **Giai đoạn hiện tại:** Khấn trọn\n\n📚 **Học vấn:**\n- **Bằng cấp:** Thạc sĩ Thần học\n  - **Trường:** Học viện Công giáo Việt Nam\n\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\n\n🔄 **Lịch sử phân bổ cộng đoàn:**\n- **Nhà Mẹ - Thủ Đức:** 01/01/2020 → Hiện tại\n\nNếu bạn cần thêm thông tin nào khác, hãy cho tôi biết! 😊', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ MARIA NGUYỄN THỊ MAI**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR001\\n- Tên thánh: Maria\\n- Họ tên: Nguyễn Thị Mai\\n- Ngày sinh: 15/3/1985\\n- Nơi sinh: TP.HCM\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Nhà Mẹ - Thủ Đức\\n- Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2010 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. master: Thần học\\n   🏫 Trường: Học viện Công giáo Việt Nam\\n\\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Nhà Mẹ - Thủ Đức: 1/1/2020 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":1,\"code\":\"SR001\",\"saint_name\":\"Maria\",\"birth_name\":\"Nguyễn Thị Mai\",\"date_of_birth\":\"1985-03-14T17:00:00.000Z\",\"place_of_birth\":\"TP.HCM\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Nhà Mẹ - Thủ Đức\",\"community_address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":1,\"name\":\"Maria Nguyễn Thị Mai\"}]}', '{\"sister_id\":1,\"sister_name\":\"Nguyễn Thị Mai\",\"saint_name\":\"Maria\",\"match_confidence\":1}', 'journey_info', 1303, 0.000327, NULL, NULL, '2025-12-16 12:57:27', '2025-12-16 12:57:27'),
(9, '193de521-7acd-4141-8999-279348796743', 1, 'thông tin Nguyễn Thị Mai', 'Dưới đây là thông tin chi tiết về chị Maria Nguyễn Thị Mai:\n\n👤 **Thông tin cơ bản:**\n- **Mã số:** SR001\n- **Tên thánh:** Maria\n- **Họ tên:** Nguyễn Thị Mai\n- **Ngày sinh:** 15/03/1985\n- **Nơi sinh:** TP.HCM\n- **Quốc tịch:** Việt Nam\n- **Email:** N/A\n- **Điện thoại:** N/A\n\n🏠 **Cộng đoàn hiện tại:**\n- **Tên:** Nhà Mẹ - Thủ Đức\n- **Địa chỉ:** 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n\n📍 **Hành trình ơn gọi:**\n- **Khấn trọn:** 15/08/2010 → Hiện tại\n\n✅ **Giai đoạn hiện tại:** Khấn trọn\n\n📚 **Học vấn:**\n- **Bằng cấp:** Thạc sĩ Thần học\n- **Trường:** Học viện Công giáo Việt Nam\n\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\n\n🔄 **Lịch sử phân bổ cộng đoàn:**\n- **Nhà Mẹ - Thủ Đức:** Từ 01/01/2020 → Hiện tại\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết nhé! 😊', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ MARIA NGUYỄN THỊ MAI**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR001\\n- Tên thánh: Maria\\n- Họ tên: Nguyễn Thị Mai\\n- Ngày sinh: 15/3/1985\\n- Nơi sinh: TP.HCM\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Nhà Mẹ - Thủ Đức\\n- Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2010 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. master: Thần học\\n   🏫 Trường: Học viện Công giáo Việt Nam\\n\\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Nhà Mẹ - Thủ Đức: 1/1/2020 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":1,\"code\":\"SR001\",\"saint_name\":\"Maria\",\"birth_name\":\"Nguyễn Thị Mai\",\"date_of_birth\":\"1985-03-14T17:00:00.000Z\",\"place_of_birth\":\"TP.HCM\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":1,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Nhà Mẹ - Thủ Đức\",\"community_address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":1,\"name\":\"Maria Nguyễn Thị Mai\"}]}', '{\"sister_id\":1,\"sister_name\":\"Nguyễn Thị Mai\",\"saint_name\":\"Maria\",\"match_confidence\":1}', 'journey_info', 1304, 0.000327, NULL, NULL, '2025-12-16 12:59:51', '2025-12-16 12:59:51'),
(10, '193de521-7acd-4141-8999-279348796743', 1, 'có mấy cộng đoàn?', 'Chưa có thông tin về số lượng cộng đoàn trong hệ thống. Bạn có thể kiểm tra lại sau hoặc hỏi thông tin khác mà bạn cần nhé! 😊\n\n💡 *Bạn có thể hỏi thêm về chi tiết của từng cộng đoàn hoặc giai đoạn cụ thể.*', '{\"text\":\"Không thể truy xuất dữ liệu từ hệ thống.\",\"data\":{},\"sources\":[]}', '{}', 'statistics', 1088, 0.000178, NULL, NULL, '2025-12-16 13:00:02', '2025-12-16 13:00:02'),
(11, '193de521-7acd-4141-8999-279348796743', 1, 'Danh sách các cộng đoàn', 'Dưới đây là danh sách các cộng đoàn trong hệ thống:\n\n1. **Cộng đoàn Cần Thơ**\n   - **Mã:** CT01\n   - **Địa chỉ:** 56 Đường 30/4, Ninh Kiều, Cần Thơ\n   - **Số thành viên:** 3\n\n2. **Cộng đoàn Hà Nội**\n   - **Mã:** HN01\n   - **Địa chỉ:** 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\n   - **Số thành viên:** 2\n\n3. **Cộng đoàn Sài Gòn 1**\n   - **Mã:** SG01\n   - **Địa chỉ:** 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\n   - **Số thành viên:** 3\n\n4. **Cộng đoàn Sài Gòn 2**\n   - **Mã:** SG02\n   - **Địa chỉ:** 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\n   - **Số thành viên:** 2\n\n5. **Cộng Đoàn Đà Lạt**\n   - **Mã:** CD001\n   - **Địa chỉ:** 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\n   - **Số thành viên:** 0\n\n6. **Cộng đoàn Đà Nẵng**\n   - **Mã:** DN01\n   - **Địa chỉ:** 12 Đường Trần Phú, Hải Châu, Đà Nẵng\n   - **Số thành viên:** 2\n\n7. **Nhà Mẹ - Thủ Đức**\n   - **Mã:** MH\n   - **Địa chỉ:** 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\n   - **Số thành viên:** 3\n\nNếu bạn cần thêm thông tin chi tiết về từng cộng đoàn, hãy cho tôi biết nhé! 😊', '{\"text\":\"🏠 Danh sách các cộng đoàn:\\n\\nTổng số: 7 cộng đoàn\\n\\n📍 Cộng đoàn Cần Thơ\\n   - Mã: CT01\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Hà Nội\\n   - Mã: HN01\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2\\n\\n📍 Cộng đoàn Sài Gòn 1\\n   - Mã: SG01\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3\\n\\n📍 Cộng đoàn Sài Gòn 2\\n   - Mã: SG02\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2\\n\\n📍 Cộng Đoàn Đà Lạt\\n   - Mã: CD001\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0\\n\\n📍 Cộng đoàn Đà Nẵng\\n   - Mã: DN01\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2\\n\\n📍 Nhà Mẹ - Thủ Đức\\n   - Mã: MH\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3\\n\\n\",\"data\":{\"communities\":[{\"id\":6,\"code\":\"CT01\",\"name\":\"Cộng đoàn Cần Thơ\",\"address\":\"56 Đường 30/4, Ninh Kiều, Cần Thơ\",\"phone\":\"0292-123456\",\"email\":\"ct01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-15T13:26:59.000Z\",\"history\":null,\"member_count\":3},{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":2,\"code\":\"SG01\",\"name\":\"Cộng đoàn Sài Gòn 1\",\"address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\",\"phone\":\"028-2345678\",\"email\":\"sg01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3},{\"id\":3,\"code\":\"SG02\",\"name\":\"Cộng đoàn Sài Gòn 2\",\"address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\",\"phone\":\"028-3456789\",\"email\":\"sg02@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},{\"id\":4,\"code\":\"DN01\",\"name\":\"Cộng đoàn Đà Nẵng\",\"address\":\"12 Đường Trần Phú, Hải Châu, Đà Nẵng\",\"phone\":\"0236-123456\",\"email\":\"dn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},{\"id\":1,\"code\":\"MH\",\"name\":\"Nhà Mẹ - Thủ Đức\",\"address\":\"123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\",\"phone\":\"028-1234567\",\"email\":\"nhame@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":3}]},\"sources\":[]}', '{}', 'community_info', 1939, 0.000487, NULL, NULL, '2025-12-16 13:00:22', '2025-12-16 13:00:22'),
(12, '193de521-7acd-4141-8999-279348796743', 1, 'kể tên nữ tu ở cộng đoàn đà lạt', 'Hiện tại, cộng đoàn Đà Lạt có số thành viên là 0, do đó không có nữ tu nào đang hoạt động tại cộng đoàn này. \n\nNếu bạn cần thông tin về các cộng đoàn khác hoặc bất kỳ câu hỏi nào khác, hãy cho tôi biết nhé! 😊', '{\"text\":\"🏠 Thông tin cộng đoàn Cộng Đoàn Đà Lạt:\\n\\n- Mã: CD001\\n- Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n- Điện thoại: 0987654321\\n- Email: dalat@gmail.com\\n- Số thành viên: 0\\n\",\"data\":{\"community\":{\"id\":7,\"code\":\"CD001\",\"name\":\"Cộng Đoàn Đà Lạt\",\"address\":\"12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\",\"phone\":\"0987654321\",\"email\":\"dalat@gmail.com\",\"established_date\":\"2015-08-11T17:00:00.000Z\",\"status\":\"active\",\"description\":\"\",\"created_at\":\"2025-12-15T12:36:24.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":0},\"members\":[]},\"sources\":[]}', '{\"community_id\":7,\"community_name\":\"Cộng Đoàn Đà Lạt\"}', 'community_info', 1705, 0.000282, NULL, NULL, '2025-12-16 13:01:30', '2025-12-16 13:01:30'),
(13, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'Có mấy cộng đoàn?', 'Hiện tại, có tổng cộng **7 cộng đoàn**. Dưới đây là danh sách các cộng đoàn:\n\n1. Cộng đoàn Cần Thơ\n2. Cộng đoàn Hà Nội\n3. Cộng đoàn Sài Gòn 1\n4. Cộng đoàn Sài Gòn 2\n5. Cộng Đoàn Đà Lạt\n6. Cộng đoàn Đà Nẵng\n7. Nhà Mẹ - Thủ Đức\n\n💡 *Bạn có thể hỏi thêm về chi tiết của từng cộng đoàn hoặc giai đoạn cụ thể.*', '{\"text\":\"📊 **Thông tin hệ thống:**\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\n🏠 **Danh sách 7 cộng đoàn:**\\n\\n1. **Cộng đoàn Cần Thơ** (Mã: CT01)\\n   - Địa chỉ: 56 Đường 30/4, Ninh Kiều, Cần Thơ\\n   - Số thành viên: 3 nữ tu\\n\\n2. **Cộng đoàn Hà Nội** (Mã: HN01)\\n   - Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n   - Số thành viên: 2 nữ tu\\n\\n3. **Cộng đoàn Sài Gòn 1** (Mã: SG01)\\n   - Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n   - Số thành viên: 3 nữ tu\\n\\n4. **Cộng đoàn Sài Gòn 2** (Mã: SG02)\\n   - Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n   - Số thành viên: 2 nữ tu\\n\\n5. **Cộng Đoàn Đà Lạt** (Mã: CD001)\\n   - Địa chỉ: 12 Xô Viết Nghệ Tĩnh, Đà Lạt, Lâm Đồng\\n   - Số thành viên: 0 nữ tu\\n\\n6. **Cộng đoàn Đà Nẵng** (Mã: DN01)\\n   - Địa chỉ: 12 Đường Trần Phú, Hải Châu, Đà Nẵng\\n   - Số thành viên: 2 nữ tu\\n\\n7. **Nhà Mẹ - Thủ Đức** (Mã: MH)\\n   - Địa chỉ: 123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM\\n   - Số thành viên: 3 nữ tu\\n\\n\",\"data\":{},\"sources\":[{\"type\":\"communities\",\"count\":7}]}', '{\"count_question\":true,\"age_question\":false,\"list_question\":false}', 'statistics', 1260, 0.000233, NULL, NULL, '2025-12-16 13:08:54', '2025-12-16 13:08:54'),
(14, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'Cộng đoàn Hà Nội có những ai', 'Cộng đoàn Hà Nội hiện có **2 thành viên**. Dưới đây là danh sách các thành viên:\n\n1. **Josephine Hồ Thị Yến** (Mã: SR012)\n2. **Bernadette Lý Thị Thảo** (Mã: SR011)\n\n🏠 Nếu bạn cần thêm thông tin về cộng đoàn hoặc các thành viên, hãy cho tôi biết!', '{\"text\":\"🏠 Thông tin cộng đoàn Cộng đoàn Hà Nội:\\n\\n- Mã: HN01\\n- Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n- Điện thoại: 024-1234567\\n- Email: hn01@osp.vn\\n- Số thành viên: 2\\n\\n👥 Danh sách thành viên:\\n1. Josephine Hồ Thị Yến (SR012)\\n2. Bernadette Lý Thị Thảo (SR011)\\n\",\"data\":{\"community\":{\"id\":5,\"code\":\"HN01\",\"name\":\"Cộng đoàn Hà Nội\",\"address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\",\"phone\":\"024-1234567\",\"email\":\"hn01@osp.vn\",\"established_date\":null,\"status\":\"active\",\"description\":null,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":null,\"history\":null,\"member_count\":2},\"members\":[{\"id\":12,\"birth_name\":\"Hồ Thị Yến\",\"saint_name\":\"Josephine\",\"code\":\"SR012\"},{\"id\":11,\"birth_name\":\"Lý Thị Thảo\",\"saint_name\":\"Bernadette\",\"code\":\"SR011\"}]},\"sources\":[]}', '{\"community_name\":\"Cộng đoàn Hà Nội\",\"list_question\":true,\"community_id\":5,\"age_question\":false,\"count_question\":false}', 'community_info', 1065, 0.000197, NULL, NULL, '2025-12-16 13:09:16', '2025-12-16 13:09:16'),
(15, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'Hồ Thị Yến bao nhiêu tuổi, cha mẹ tên gì?', '**Hồ Thị Yến**, tên thánh là **Josephine**, sinh ngày **03/10/1988**, hiện tại chị **35 tuổi** (tính đến tháng 10 năm 2023).\n\nVề thông tin cha mẹ của chị, rất tiếc, tôi không có dữ liệu cụ thể về tên của cha mẹ chị. Nếu bạn cần thêm thông tin khác, hãy cho tôi biết! 📚', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ JOSEPHINE HỒ THỊ YẾN**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR012\\n- Tên thánh: Josephine\\n- Họ tên: Hồ Thị Yến\\n- Ngày sinh: 3/10/1988\\n- Nơi sinh: Quảng Nam\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Hà Nội\\n- Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn tạm: 15/8/2019 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn tạm\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Hà Nội: 1/1/2022 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":12,\"code\":\"SR012\",\"saint_name\":\"Josephine\",\"birth_name\":\"Hồ Thị Yến\",\"date_of_birth\":\"1988-10-02T17:00:00.000Z\",\"place_of_birth\":\"Quảng Nam\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"temporary_vows\",\"current_community_id\":5,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Hà Nội\",\"community_address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\"}},\"sources\":[{\"type\":\"sister\",\"id\":12,\"name\":\"Josephine Hồ Thị Yến\"}]}', '{\"person_name\":\"Hồ Thị Yến\",\"age_question\":true,\"sister_id\":12,\"sister_name\":\"Hồ Thị Yến\",\"saint_name\":\"Josephine\",\"match_confidence\":1,\"count_question\":true,\"list_question\":false}', 'sister_info', 1292, 0.000233, NULL, NULL, '2025-12-16 13:09:42', '2025-12-16 13:09:42'),
(16, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'tính đến hôm nay, Hồ Thị Yến, bao nhiêu tuổi?', 'Tính đến hôm nay, **Hồ Thị Yến** (tên thánh là **Josephine**), sinh ngày **03/10/1988**, hiện tại chị **35 tuổi**. Chị sẽ tròn **36 tuổi** vào ngày **03/10/2024**. 🎉\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết! 📚', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ JOSEPHINE HỒ THỊ YẾN**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR012\\n- Tên thánh: Josephine\\n- Họ tên: Hồ Thị Yến\\n- Ngày sinh: 3/10/1988\\n- Nơi sinh: Quảng Nam\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Hà Nội\\n- Địa chỉ: 34 Đường Hoàng Diệu, Ba Đình, Hà Nội\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn tạm: 15/8/2019 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn tạm\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Hà Nội: 1/1/2022 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":12,\"code\":\"SR012\",\"saint_name\":\"Josephine\",\"birth_name\":\"Hồ Thị Yến\",\"date_of_birth\":\"1988-10-02T17:00:00.000Z\",\"place_of_birth\":\"Quảng Nam\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"temporary_vows\",\"current_community_id\":5,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Hà Nội\",\"community_address\":\"34 Đường Hoàng Diệu, Ba Đình, Hà Nội\"}},\"sources\":[{\"type\":\"sister\",\"id\":12,\"name\":\"Josephine Hồ Thị Yến\"}]}', '{\"person_name\":\"Hồ Thị Yến\",\"age_question\":true,\"sister_id\":12,\"sister_name\":\"Hồ Thị Yến\",\"saint_name\":\"Josephine\",\"match_confidence\":1,\"count_question\":true,\"list_question\":false}', 'sister_info', 1399, 0.000247, NULL, NULL, '2025-12-16 13:10:35', '2025-12-16 13:10:35'),
(17, '5083270e-62fb-45b4-b0ee-8f115b427db6', 1, 'sức khỏe của chị thế nào?', 'Rất tiếc, tôi không có thông tin cụ thể về tình trạng sức khỏe của chị Hồ Thị Yến. Nếu bạn có thắc mắc khác hoặc cần thông tin về các vấn đề khác liên quan đến nữ tu hoặc cộng đoàn, hãy cho tôi biết! 📚', '{\"text\":\"📋 Thông tin hệ thống:\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.\",\"data\":{\"totalSisters\":15,\"totalCommunities\":7},\"sources\":[]}', '{\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'health_info', 1303, 0.000221, NULL, NULL, '2025-12-16 13:11:16', '2025-12-16 13:11:16'),
(18, '25475a46-5104-4e32-bf05-1a2e626aa8eb', 1, 'xin chào', 'Xin chào! 🙏 Tôi có thể giúp gì cho bạn hôm nay?', '{\"text\":\"📋 Thông tin hệ thống:\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.\",\"data\":{\"totalSisters\":15,\"totalCommunities\":7},\"sources\":[]}', '{\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'greeting', 805, 0.000128, NULL, NULL, '2025-12-17 13:25:46', '2025-12-17 13:25:46'),
(19, '25475a46-5104-4e32-bf05-1a2e626aa8eb', 1, 'đặng thị tuyết mấy tuổi, ở cộng đoàn nào', 'Chị Monica Đặng Thị Tuyết sinh ngày 18/04/1993, nên hiện tại chị đang 30 tuổi. 🎉\n\nChị đang ở cộng đoàn Sài Gòn 2, địa chỉ tại 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM. 🏠', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ MONICA ĐẶNG THỊ TUYẾT**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR007\\n- Tên thánh: Monica\\n- Họ tên: Đặng Thị Tuyết\\n- Ngày sinh: 18/4/1993\\n- Nơi sinh: Bình Dương\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Sài Gòn 2\\n- Địa chỉ: 789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2014 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. bachelor: Điều dưỡng\\n   🏫 Trường: Đại học Y Dược TP.HCM\\n\\n🏥 **Hồ sơ sức khỏe:** Có 1 bản ghi\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Sài Gòn 2: 1/1/2021 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":7,\"code\":\"SR007\",\"saint_name\":\"Monica\",\"birth_name\":\"Đặng Thị Tuyết\",\"date_of_birth\":\"1993-04-17T17:00:00.000Z\",\"place_of_birth\":\"Bình Dương\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":3,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Sài Gòn 2\",\"community_address\":\"789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":7,\"name\":\"Monica Đặng Thị Tuyết\"}]}', '{\"person_name\":\"đặng thị tuyết\",\"age_question\":true,\"sister_id\":7,\"sister_name\":\"Đặng Thị Tuyết\",\"saint_name\":\"Monica\",\"match_confidence\":1,\"count_question\":true,\"list_question\":false}', 'sister_info', 1123, 0.000200, NULL, NULL, '2025-12-17 13:26:09', '2025-12-17 13:26:09'),
(20, '6fa5aab7-dd49-45dc-8bc9-9d2e345db71f', 1, 'xin chào', 'Xin chào! 🙏 Tôi rất vui được gặp bạn. Bạn cần hỏi gì về nữ tu, hành trình ơn gọi, hoặc cộng đoàn?', '{\"text\":\"📋 Thông tin hệ thống:\\n- Tổng số nữ tu: 15\\n- Tổng số cộng đoàn: 7\\n\\nBạn có thể hỏi tôi về thông tin nữ tu, hành trình ơn gọi, cộng đoàn, thống kê, và nhiều nội dung khác.\",\"data\":{\"totalSisters\":15,\"totalCommunities\":7},\"sources\":[]}', '{\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'greeting', 820, 0.000137, NULL, NULL, '2025-12-18 12:42:39', '2025-12-18 12:42:39'),
(21, '6fa5aab7-dd49-45dc-8bc9-9d2e345db71f', 1, 'thông tin phạm thị cúc', 'Dưới đây là thông tin chi tiết về chị Rosa Phạm Thị Cúc:\n\n👤 **Thông tin cơ bản:**\n- **Mã số:** SR004\n- **Tên thánh:** Rosa\n- **Họ tên:** Phạm Thị Cúc\n- **Ngày sinh:** 30/05/1992\n- **Nơi sinh:** Cần Thơ\n- **Quốc tịch:** Việt Nam\n- **Email:** N/A\n- **Điện thoại:** N/A\n\n🏠 **Cộng đoàn hiện tại:**\n- **Tên:** Cộng đoàn Sài Gòn 1\n- **Địa chỉ:** 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\n\n📍 **Hành trình ơn gọi:**\n- **Khấn trọn:** 15/08/2012 → Hiện tại\n\n✅ **Giai đoạn hiện tại:** Khấn trọn\n\n📚 **Học vấn:**\n- **Bằng thạc sĩ:** Quản trị giáo dục\n  - **Trường:** Đại học Giáo dục - ĐHQG Hà Nội\n\n🔄 **Lịch sử phân bổ cộng đoàn:**\n- **Cộng đoàn Sài Gòn 1:** Từ 01/09/2019 → Hiện tại\n\nNếu bạn cần thêm thông tin gì khác, hãy cho tôi biết nhé! 😊', '{\"text\":\"👤 **THÔNG TIN CHI TIẾT VỀ ROSA PHẠM THỊ CÚC**\\n\\n📋 **Thông tin cơ bản:**\\n- Mã số: SR004\\n- Tên thánh: Rosa\\n- Họ tên: Phạm Thị Cúc\\n- Ngày sinh: 30/5/1992\\n- Nơi sinh: Cần Thơ\\n- Quốc tịch: Việt Nam\\n- Email: N/A\\n- Điện thoại: N/A\\n\\n🏠 **Cộng đoàn hiện tại:**\\n- Tên: Cộng đoàn Sài Gòn 1\\n- Địa chỉ: 456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\\n\\n📍 **Hành trình ơn gọi:**\\n1. Khấn trọn: 15/8/2012 → Hiện tại\\n\\n✅ **Giai đoạn hiện tại:** Khấn trọn\\n\\n📚 **Học vấn:**\\n1. master: Quản trị giáo dục\\n   🏫 Trường: Đại học Giáo dục - ĐHQG Hà Nội\\n\\n🔄 **Lịch sử phân bổ cộng đoàn:**\\n1. Cộng đoàn Sài Gòn 1: 1/9/2019 → Hiện tại\\n\",\"data\":{\"sister\":{\"id\":4,\"code\":\"SR004\",\"saint_name\":\"Rosa\",\"birth_name\":\"Phạm Thị Cúc\",\"date_of_birth\":\"1992-05-29T17:00:00.000Z\",\"place_of_birth\":\"Cần Thơ\",\"permanent_address\":null,\"current_address\":null,\"nationality\":null,\"id_card\":null,\"id_card_date\":null,\"id_card_place\":null,\"father_name\":null,\"father_occupation\":null,\"mother_name\":null,\"mother_occupation\":null,\"siblings_count\":null,\"family_address\":null,\"family_religion\":null,\"baptism_date\":null,\"baptism_place\":null,\"confirmation_date\":null,\"first_communion_date\":null,\"phone\":null,\"email\":null,\"emergency_contact_name\":null,\"emergency_contact_phone\":null,\"notes\":null,\"photo_url\":null,\"status\":\"active\",\"current_stage\":\"perpetual_vows\",\"current_community_id\":2,\"created_by\":1,\"created_at\":\"2025-12-14T15:27:02.000Z\",\"updated_at\":\"2025-12-14T15:27:02.000Z\",\"documents\":null,\"community_name\":\"Cộng đoàn Sài Gòn 1\",\"community_address\":\"456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM\"}},\"sources\":[{\"type\":\"sister\",\"id\":4,\"name\":\"Rosa Phạm Thị Cúc\"}]}', '{\"person_name\":\"Phạm Thị Cúc\",\"sister_id\":4,\"sister_name\":\"Phạm Thị Cúc\",\"saint_name\":\"Rosa\",\"match_confidence\":1,\"age_question\":false,\"count_question\":false,\"list_question\":false}', 'sister_info', 1344, 0.000333, NULL, NULL, '2025-12-18 12:42:54', '2025-12-18 12:42:54');

-- --------------------------------------------------------

--
-- Table structure for table `communities`
--

CREATE TABLE `communities` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(30) NOT NULL,
  `name` varchar(150) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `established_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `history` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `community_assignments`
--

CREATE TABLE `community_assignments` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `community_id` int(10) UNSIGNED NOT NULL,
  `role` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `decision_number` varchar(50) DEFAULT NULL,
  `decision_date` date DEFAULT NULL,
  `decision_file_url` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `community_members`
--

CREATE TABLE `community_members` (
  `id` int(11) NOT NULL,
  `community_id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `role` enum('superior','assistant','treasurer','secretary','member') NOT NULL DEFAULT 'member',
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_members`
--

INSERT INTO `community_members` (`id`, `community_id`, `sister_id`, `role`, `start_date`, `end_date`, `notes`, `created_at`, `updated_at`) VALUES
(12, 4, 1, 'superior', '2020-01-01', '2025-12-31', 'Nhiệm kỳ 2020-2025', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(13, 4, 2, 'assistant', '2016-01-01', '2020-12-31', 'Nhiệm kỳ 2016-2020', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(14, 4, 3, 'treasurer', '2015-01-01', '2020-12-31', 'Nhiệm kỳ 2015-2020', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(15, 4, 4, 'secretary', '2020-01-01', '2024-12-31', 'Nhiệm kỳ 2020-2024', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(16, 5, 1, 'superior', '2021-01-01', '2025-12-31', 'Nhiệm kỳ 2021-2025', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(17, 5, 2, 'assistant', '2015-01-01', '2019-12-31', 'Nhiệm kỳ 2015-2019', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(18, 5, 3, 'treasurer', '2022-01-01', '2027-12-31', 'Nhiệm kỳ 2022-2027', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(19, 6, 1, 'superior', '2022-01-01', '2026-12-31', 'Nhiệm kỳ 2022-2026', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(20, 6, 2, 'assistant', '2018-01-01', '2022-12-31', 'Nhiệm kỳ 2018-2022', '2025-12-20 02:55:09', '2025-12-20 02:55:09'),
(21, 6, 3, 'treasurer', '2018-01-01', '2022-12-31', 'Nhiệm kỳ 2018-2022', '2025-12-20 02:55:09', '2025-12-20 02:55:09');

-- --------------------------------------------------------

--
-- Table structure for table `community_roles`
--

CREATE TABLE `community_roles` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_default` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `community_roles`
--

INSERT INTO `community_roles` (`id`, `code`, `name`, `description`, `display_order`, `color`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'superior', 'Bề trên', NULL, 1, '#d63031', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(2, 'assistant', 'Phó bề trên', NULL, 2, '#2d3436', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(3, 'secretary', 'Thư ký', NULL, 3, '#6c5ce7', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(4, 'treasurer', 'Thủ quỹ', NULL, 4, '#e84393', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(5, 'member', 'Thành viên', NULL, 5, '#0984e3', 1, 1, '2025-12-18 14:09:13', '2025-12-18 14:09:13'),
(10, 'tong_quyen', 'Tổng quyền', NULL, 6, '#d63031', 0, 1, '2025-12-22 16:00:21', '2025-12-22 16:00:21');

-- --------------------------------------------------------

--
-- Table structure for table `departures`
--

CREATE TABLE `departures` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `type` varchar(100) NOT NULL,
  `departure_date` date NOT NULL,
  `expected_return_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `destination` varchar(255) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `contact_address` text DEFAULT NULL,
  `approved_by` int(10) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departures`
--

INSERT INTO `departures` (`id`, `sister_id`, `type`, `departure_date`, `expected_return_date`, `return_date`, `destination`, `reason`, `contact_phone`, `contact_address`, `approved_by`, `notes`, `documents`, `created_at`, `updated_at`) VALUES
(1, 1, 'Về thăm gia đình', '2020-12-11', '2020-12-15', '2020-12-14', 'Giáo phận Đà Lạt', 'Chăm sóc cha mẹ già yếu', '0867013741', 'Giáo phận Đà Lạt', 4, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:14:59', NULL),
(2, 1, 'Nghỉ dưỡng', '2021-10-14', '2021-10-15', '2021-10-15', 'Tu viện Roma', 'Nghỉ ngơi phục hồi sức khỏe', '0431028659', 'Tu viện Roma', 6, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(3, 1, 'Điều trị y tế', '2022-11-25', '2022-12-06', '2022-12-05', 'Học viện Công giáo Việt Nam', 'Phẫu thuật', '0792334954', 'Học viện Công giáo Việt Nam', 2, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(4, 1, 'Khóa tu học', '2023-08-17', '2023-08-28', '2023-08-27', 'Giáo phận Đà Lạt', 'Khóa học Kinh thánh', '0343979080', 'Giáo phận Đà Lạt', 5, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:14:59', NULL),
(5, 2, 'Học tập - Bồi dưỡng', '2020-05-19', '2020-06-04', '2020-06-04', 'Bệnh viện Chợ Rẫy', 'Khóa đào tạo kỹ năng mục vụ', '0476629383', 'Bệnh viện Chợ Rẫy', 1, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(6, 2, 'Nghỉ dưỡng', '2021-05-17', '2021-05-22', '2021-05-22', 'Cộng đoàn Bảo Lộc', 'Thư giãn tinh thần', '0601315354', 'Cộng đoàn Bảo Lộc', 1, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(7, 2, 'Khóa tu học', '2022-04-06', '2022-04-17', '2022-04-17', 'Nhà riêng (Hà Nội)', 'Khóa học Kinh thánh', '0162569012', 'Nhà riêng (Hà Nội)', 5, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:14:59', NULL),
(8, 2, 'Hoạt động mục vụ', '2023-09-08', '2023-09-11', NULL, 'Học viện Công giáo Việt Nam', 'Công tác xã hội', '0478547264', 'Học viện Công giáo Việt Nam', 5, 'Đang trong chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:14:59', NULL),
(9, 3, 'Tham dự hội nghị', '2020-03-01', '2020-03-04', '2020-03-04', 'Nhà riêng (Sài Gòn)', 'Hội nghị mục vụ', '0603310173', 'Nhà riêng (Sài Gòn)', 7, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(10, 3, 'Tham dự hội nghị', '2021-09-06', '2021-09-15', '2021-09-15', 'Nhà riêng (quê nhà)', 'Hội nghị mục vụ', '0806791050', 'Nhà riêng (quê nhà)', 4, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(11, 3, 'Điều trị y tế', '2022-08-08', '2022-08-20', '2022-08-20', 'Học viện Công giáo Việt Nam', 'Phẫu thuật', '0227058313', 'Học viện Công giáo Việt Nam', 5, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(12, 3, 'Công việc hội dòng', '2023-08-02', '2023-08-05', '2023-08-05', 'Tu viện Manila', 'Họp hội đồng hội dòng', '0547562566', 'Tu viện Manila', 6, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(13, 4, 'Công tác', '2020-01-11', '2020-01-14', '2020-01-12', 'Nhà riêng (quê nhà)', 'Làm việc tại cộng đoàn khác', '0613102668', 'Nhà riêng (quê nhà)', 1, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(14, 4, 'Công việc hội dòng', '2021-03-19', '2021-03-25', '2021-03-25', 'Nhà riêng (Hà Nội)', 'Công tác quản lý', '0520196052', 'Nhà riêng (Hà Nội)', 7, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(15, 4, 'Nghỉ dưỡng', '2022-12-16', '2022-12-23', '2022-12-23', 'Bệnh viện Chợ Rẫy', 'Nghỉ dưỡng định kỳ', '0907935512', 'Bệnh viện Chợ Rẫy', 7, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(16, 4, 'Tham gia khóa tĩnh tâm', '2023-06-24', '2023-07-01', '2023-07-01', 'Tu viện Manila', 'Khóa tĩnh tâm Ignatius', '0727724081', 'Tu viện Manila', 3, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:14:59', NULL),
(17, 5, 'Công tác', '2020-01-26', '2020-01-28', '2020-01-28', 'Tu viện Manila', 'Công tác tại giáo xứ', '0546543044', 'Tu viện Manila', 3, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(18, 5, 'Tham dự hội nghị', '2021-03-01', '2021-03-03', '2021-03-03', 'Cộng đoàn Đà Lạt', 'Đại hội đại biểu', '0684186907', 'Cộng đoàn Đà Lạt', 3, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(19, 5, 'Công việc hội dòng', '2022-07-27', '2022-08-01', '2022-08-01', 'Trung tâm Tĩnh tâm Đức Mẹ', 'Kiểm tra cộng đoàn', '0656584977', 'Trung tâm Tĩnh tâm Đức Mẹ', 7, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(20, 5, 'Học tập - Bồi dưỡng', '2023-02-19', '2023-03-04', '2023-03-05', 'Trung tâm Mục vụ Linh mục', 'Tham gia khóa học thần học', '0290405404', 'Trung tâm Mục vụ Linh mục', 6, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(21, 5, 'Điều trị y tế', '2024-03-15', '2024-04-04', '2024-04-04', 'Cộng đoàn Bảo Lộc', 'Khám và điều trị bệnh', '0221745974', 'Cộng đoàn Bảo Lộc', 4, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(22, 6, 'Học tập - Bồi dưỡng', '2020-06-25', '2020-07-24', '2020-07-24', 'Bệnh viện Đà Lạt', 'Khóa đào tạo kỹ năng mục vụ', '0906483845', 'Bệnh viện Đà Lạt', 5, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(23, 6, 'Điều trị y tế', '2021-06-28', '2021-07-08', '2021-07-08', 'Cộng đoàn Sài Gòn', 'Phẫu thuật', '0595134821', 'Cộng đoàn Sài Gòn', 2, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(24, 6, 'Điều trị y tế', '2022-12-27', '2023-01-17', '2023-01-17', 'Tu viện Roma', 'Điều trị chuyên khoa', '0600123712', 'Tu viện Roma', 7, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(25, 6, 'Tham gia khóa tĩnh tâm', '2023-04-26', '2023-05-02', '2023-05-02', 'Bệnh viện Đà Lạt', 'Tĩnh tâm hàng năm', '0480070574', 'Bệnh viện Đà Lạt', 1, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:14:59', NULL),
(26, 6, 'Tham gia khóa tĩnh tâm', '2024-12-22', '2024-12-28', NULL, 'Bệnh viện Chợ Rẫy', 'Tĩnh tâm đặc biệt', '0256679778', 'Bệnh viện Chợ Rẫy', 7, 'Đang trong chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:14:59', NULL),
(27, 7, 'Tham quan hành hương', '2020-08-19', '2020-08-20', '2020-08-20', 'Nhà riêng (Hà Nội)', 'Tham quan tu viện', '0518855261', 'Nhà riêng (Hà Nội)', 5, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:14:59', NULL),
(28, 7, 'Công tác', '2021-08-11', '2021-08-13', '2021-08-13', 'Nhà riêng (Đà Lạt)', 'Tham gia dự án xã hội', '0361589433', 'Nhà riêng (Đà Lạt)', 6, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(29, 7, 'Thăm viếng cộng đoàn khác', '2022-04-10', '2022-04-13', '2022-04-13', 'Tu viện Manila', 'Thăm viếng chị em', '0187838767', 'Tu viện Manila', 2, 'Đã hoàn thành chuyến đi vắng thăm viếng cộng đoàn khác', NULL, '2025-12-20 03:14:59', NULL),
(30, 7, 'Nghỉ dưỡng', '2023-07-25', '2023-08-01', NULL, 'Cộng đoàn Hà Nội', 'Điều dưỡng sau ốm', '0376021233', 'Cộng đoàn Hà Nội', 6, 'Đang trong chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(31, 8, 'Công việc hội dòng', '2020-11-10', '2020-11-15', '2020-11-16', 'Cộng đoàn Hà Nội', 'Công tác quản lý', '0994103130', 'Cộng đoàn Hà Nội', 6, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:14:59', NULL),
(32, 8, 'Công tác', '2021-01-04', '2021-01-12', '2021-01-12', 'Nhà riêng (Hà Nội)', 'Hỗ trợ công tác hội dòng', '0973121884', 'Nhà riêng (Hà Nội)', 1, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:14:59', NULL),
(33, 8, 'Điều trị y tế', '2022-07-23', '2022-07-30', '2022-07-30', 'Tu viện Manila', 'Điều trị chuyên khoa', '0511395502', 'Tu viện Manila', 3, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:14:59', NULL),
(34, 8, 'Tham dự hội nghị', '2023-04-04', '2023-04-13', NULL, 'Tu viện Manila', 'Hội nghị mục vụ', '0262239561', 'Tu viện Manila', 4, 'Đang trong chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(35, 9, 'Thăm viếng cộng đoàn khác', '2020-03-11', '2020-03-12', '2020-03-12', 'Trung tâm Mục vụ Linh mục', 'Kỷ niệm đặc biệt', '0562748061', 'Trung tâm Mục vụ Linh mục', 6, 'Đã hoàn thành chuyến đi vắng thăm viếng cộng đoàn khác', NULL, '2025-12-20 03:14:59', NULL),
(36, 9, 'Tham dự hội nghị', '2021-01-07', '2021-01-10', '2021-01-10', 'Tu viện Roma', 'Hội nghị mục vụ', '0597280596', 'Tu viện Roma', 5, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(37, 9, 'Tham dự hội nghị', '2022-07-04', '2022-07-09', '2022-07-09', 'Cộng đoàn Sài Gòn', 'Hội nghị mục vụ', '0962962783', 'Cộng đoàn Sài Gòn', 2, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:14:59', NULL),
(38, 9, 'Học tập - Bồi dưỡng', '2023-04-27', '2023-05-14', NULL, 'Giáo phận Sài Gòn', 'Nghiên cứu sau đại học', '0581592097', 'Giáo phận Sài Gòn', 3, 'Đang trong chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:14:59', NULL),
(39, 10, 'Nghỉ dưỡng', '2020-05-25', '2020-05-28', '2020-05-26', 'Bệnh viện Đà Lạt', 'Điều dưỡng sau ốm', '0978120233', 'Bệnh viện Đà Lạt', 1, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(40, 10, 'Tham gia khóa tĩnh tâm', '2021-08-09', '2021-08-23', '2021-08-23', 'Trung tâm Tĩnh tâm Đức Mẹ', 'Tĩnh tâm dòng', '0369832897', 'Trung tâm Tĩnh tâm Đức Mẹ', 7, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:15:00', NULL),
(41, 10, 'Học tập - Bồi dưỡng', '2022-12-27', '2023-01-22', NULL, 'Tu viện Manila', 'Tham gia khóa học thần học', '0219684766', 'Tu viện Manila', 7, 'Đang trong chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(42, 11, 'Tham quan hành hương', '2020-06-01', '2020-06-08', '2020-06-08', 'Học viện Công giáo Việt Nam', 'Hành hương Đức Mẹ', '0464194664', 'Học viện Công giáo Việt Nam', 4, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(43, 11, 'Tham gia khóa tĩnh tâm', '2021-06-12', '2021-06-18', '2021-06-17', 'Nhà riêng (Đà Lạt)', 'Tĩnh tâm chuẩn bị khấn', '0755905222', 'Nhà riêng (Đà Lạt)', 6, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:15:00', NULL),
(44, 11, 'Tham dự hội nghị', '2022-07-03', '2022-07-10', '2022-07-10', 'Bệnh viện Chợ Rẫy', 'Hội nghị mục vụ', '0495928825', 'Bệnh viện Chợ Rẫy', 4, 'Đã hoàn thành chuyến đi vắng tham dự hội nghị', NULL, '2025-12-20 03:15:00', NULL),
(45, 11, 'Tham quan hành hương', '2023-10-11', '2023-10-12', '2023-10-12', 'Tu viện Manila', 'Viếng các thánh địa', '0880101020', 'Tu viện Manila', 6, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(46, 12, 'Hoạt động mục vụ', '2020-09-20', '2020-09-25', '2020-09-25', 'Cộng đoàn Đà Lạt', 'Hoạt động Caritas', '0256441001', 'Cộng đoàn Đà Lạt', 7, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(47, 12, 'Về thăm gia đình', '2021-11-07', '2021-11-09', '2021-11-11', 'Trung tâm Mục vụ Linh mục', 'Về thăm gia đình dịp lễ', '0438743219', 'Trung tâm Mục vụ Linh mục', 7, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(48, 12, 'Học tập - Bồi dưỡng', '2022-04-20', '2022-05-03', '2022-05-03', 'Nhà riêng (quê nhà)', 'Nghiên cứu sau đại học', '0334371357', 'Nhà riêng (quê nhà)', 3, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(49, 12, 'Điều trị y tế', '2023-05-20', '2023-06-07', '2023-06-07', 'Tu viện Manila', 'Tái khám định kỳ', '0792465437', 'Tu viện Manila', 2, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:15:00', NULL),
(50, 13, 'Khóa tu học', '2020-07-27', '2020-08-08', '2020-08-08', 'Giáo phận Sài Gòn', 'Tu học về đời sống thánh hiến', '0851463169', 'Giáo phận Sài Gòn', 6, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(51, 13, 'Nghỉ dưỡng', '2021-04-08', '2021-04-13', '2021-04-13', 'Cộng đoàn Đà Lạt', 'Chăm sóc sức khỏe', '0761568201', 'Cộng đoàn Đà Lạt', 2, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(52, 13, 'Về thăm gia đình', '2022-01-06', '2022-01-13', '2022-01-13', 'Nhà riêng (quê nhà)', 'Về thăm gia đình dịp lễ', '0789752219', 'Nhà riêng (quê nhà)', 4, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(53, 14, 'Công tác', '2020-10-16', '2020-10-25', '2020-10-25', 'Bệnh viện Đà Lạt', 'Tham gia dự án xã hội', '0665607440', 'Bệnh viện Đà Lạt', 7, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:15:00', NULL),
(54, 14, 'Điều trị y tế', '2021-02-08', '2021-02-18', '2021-02-18', 'Tu viện Sài Gòn', 'Điều trị chuyên khoa', '0204387465', 'Tu viện Sài Gòn', 1, 'Đã hoàn thành chuyến đi vắng điều trị y tế', NULL, '2025-12-20 03:15:00', NULL),
(55, 14, 'Tham quan hành hương', '2022-12-21', '2022-12-26', NULL, 'Học viện Công giáo Việt Nam', 'Hành hương La Vang', '0960289520', 'Học viện Công giáo Việt Nam', 7, 'Đang trong chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(56, 15, 'Hoạt động mục vụ', '2020-08-11', '2020-08-18', '2020-08-19', 'Cộng đoàn Sài Gòn', 'Phục vụ giới trẻ', '0586996674', 'Cộng đoàn Sài Gòn', 3, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(57, 15, 'Công tác', '2021-05-09', '2021-05-13', '2021-05-13', 'Cộng đoàn Hà Nội', 'Hỗ trợ công tác giáo dục', '0197399332', 'Cộng đoàn Hà Nội', 6, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:15:00', NULL),
(58, 15, 'Học tập - Bồi dưỡng', '2022-11-02', '2022-11-20', '2022-11-20', 'Nhà riêng (quê nhà)', 'Tham gia khóa học thần học', '0652710664', 'Nhà riêng (quê nhà)', 2, 'Đã hoàn thành chuyến đi vắng học tập - bồi dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(59, 16, 'Khóa tu học', '2022-08-05', '2022-08-16', '2022-08-16', 'Cộng đoàn Sài Gòn', 'Khóa tu học mục vụ', '0179926706', 'Cộng đoàn Sài Gòn', 6, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(60, 16, 'Nghỉ dưỡng', '2023-12-07', '2023-12-10', '2023-12-10', 'Trung tâm Mục vụ Linh mục', 'Chăm sóc sức khỏe', '0253773310', 'Trung tâm Mục vụ Linh mục', 4, 'Đã hoàn thành chuyến đi vắng nghỉ dưỡng', NULL, '2025-12-20 03:15:00', NULL),
(61, 16, 'Khóa tu học', '2024-08-23', '2024-09-01', '2024-09-01', 'Tu viện Roma', 'Đào tạo liên tu hội', '0711604417', 'Tu viện Roma', 5, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(62, 17, 'Về thăm gia đình', '2024-03-24', '2024-03-29', '2024-03-29', 'Cộng đoàn Bảo Lộc', 'Về thăm gia đình dịp lễ', '0945923780', 'Cộng đoàn Bảo Lộc', 4, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(63, 17, 'Tham gia khóa tĩnh tâm', '2025-02-01', '2025-02-11', '2025-02-11', 'Giáo phận Đà Lạt', 'Tĩnh tâm hàng năm', '0862474006', 'Giáo phận Đà Lạt', 2, 'Đã hoàn thành chuyến đi vắng tham gia khóa tĩnh tâm', NULL, '2025-12-20 03:15:00', NULL),
(64, 17, 'Thăm viếng cộng đoàn khác', '2026-04-14', '2026-04-18', NULL, 'Bệnh viện Chợ Rẫy', 'Hỗ trợ cộng đoàn mới', '0831277704', 'Bệnh viện Chợ Rẫy', 4, 'Đang trong chuyến đi vắng thăm viếng cộng đoàn khác', NULL, '2025-12-20 03:15:00', NULL),
(65, 18, 'Công việc hội dòng', '2025-06-11', '2025-06-14', '2025-06-14', 'Học viện Công giáo Việt Nam', 'Kiểm tra cộng đoàn', '0560527473', 'Học viện Công giáo Việt Nam', 5, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:15:00', NULL),
(66, 18, 'Khóa tu học', '2026-06-13', '2026-06-19', '2026-06-19', 'Tu viện Sài Gòn', 'Khóa tu học mục vụ', '0155257893', 'Tu viện Sài Gòn', 4, 'Đã hoàn thành chuyến đi vắng khóa tu học', NULL, '2025-12-20 03:15:00', NULL),
(67, 18, 'Tham quan hành hương', '2027-09-11', '2027-09-12', '2027-09-12', 'Trung tâm Tĩnh tâm Đức Mẹ', 'Hành hương Đức Mẹ', '0655504271', 'Trung tâm Tĩnh tâm Đức Mẹ', 6, 'Đã hoàn thành chuyến đi vắng tham quan hành hương', NULL, '2025-12-20 03:15:00', NULL),
(68, 19, 'Về thăm gia đình', '2026-03-05', '2026-03-07', '2026-03-07', 'Cộng đoàn Hà Nội', 'Về thăm gia đình dịp lễ', '0563443496', 'Cộng đoàn Hà Nội', 3, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL),
(69, 19, 'Công việc hội dòng', '2027-12-01', '2027-12-07', '2027-12-07', 'Bệnh viện Chợ Rẫy', 'Tổ chức sự kiện', '0276824667', 'Bệnh viện Chợ Rẫy', 6, 'Đã hoàn thành chuyến đi vắng công việc hội dòng', NULL, '2025-12-20 03:15:00', NULL),
(70, 19, 'Hoạt động mục vụ', '2028-01-17', '2028-01-23', '2028-01-23', 'Nhà riêng (Sài Gòn)', 'Hoạt động Caritas', '0719266391', 'Nhà riêng (Sài Gòn)', 4, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(71, 20, 'Hoạt động mục vụ', '2028-06-21', '2028-06-25', '2028-06-25', 'Tu viện Manila', 'Phục vụ mục vụ giáo xứ', '0206418659', 'Tu viện Manila', 1, 'Đã hoàn thành chuyến đi vắng hoạt động mục vụ', NULL, '2025-12-20 03:15:00', NULL),
(72, 20, 'Công tác', '2029-10-09', '2029-10-17', '2029-10-17', 'Tu viện Roma', 'Hỗ trợ công tác hội dòng', '0204211244', 'Tu viện Roma', 7, 'Đã hoàn thành chuyến đi vắng công tác', NULL, '2025-12-20 03:15:00', NULL),
(73, 20, 'Về thăm gia đình', '2030-07-03', '2030-07-07', '2030-07-05', 'Bệnh viện Chợ Rẫy', 'Chăm sóc cha mẹ già yếu', '0794339211', 'Bệnh viện Chợ Rẫy', 5, 'Đã hoàn thành chuyến đi vắng về thăm gia đình', NULL, '2025-12-20 03:15:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departure_records`
--

CREATE TABLE `departure_records` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `departure_date` date NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `expected_return_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `destination` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(50) DEFAULT NULL,
  `contact_address` text DEFAULT NULL,
  `approved_by` int(10) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `stage_at_departure` enum('inquiry','postulant','aspirant','novice','temporary_vows','perpetual_vows','left') DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `support_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `level` varchar(50) NOT NULL,
  `major` varchar(150) DEFAULT NULL,
  `institution` varchar(200) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `certificate_url` varchar(255) DEFAULT NULL,
  `graduation_year` int(11) DEFAULT NULL,
  `status` enum('dang_hoc','da_tot_nghiep','tam_nghi','da_nghi') DEFAULT 'dang_hoc',
  `gpa` varchar(20) DEFAULT NULL,
  `thesis_title` varchar(500) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `education_levels`
--

CREATE TABLE `education_levels` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `education_levels`
--

INSERT INTO `education_levels` (`id`, `code`, `name`, `description`, `display_order`, `color`, `is_active`, `created_at`, `updated_at`) VALUES
(5, 'bachelor', 'Đại học', NULL, 5, '#0d6efd', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(6, 'master', 'Thạc sĩ', NULL, 6, '#6f42c1', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(7, 'doctorate', 'Tiến sĩ', NULL, 7, '#dc3545', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(9, 'other', 'Khác', NULL, 99, '#adb5bd', 1, '2025-12-18 14:33:15', '2025-12-18 14:33:15'),
(13, 'cap_1', 'Cấp 1', NULL, 5, '#17a2b8', 1, '2025-12-22 15:30:52', '2025-12-22 15:30:52');

-- --------------------------------------------------------

--
-- Table structure for table `evaluations`
--

CREATE TABLE `evaluations` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `evaluation_type` varchar(50) DEFAULT NULL,
  `period` varchar(100) DEFAULT NULL,
  `evaluation_date` date DEFAULT NULL,
  `evaluator` varchar(255) DEFAULT NULL,
  `spiritual_life` tinyint(3) UNSIGNED DEFAULT NULL,
  `community_life` tinyint(3) UNSIGNED DEFAULT NULL,
  `apostolic_work` tinyint(3) UNSIGNED DEFAULT NULL,
  `personal_development` tinyint(3) UNSIGNED DEFAULT NULL,
  `overall_rating` tinyint(3) UNSIGNED DEFAULT NULL,
  `strengths` text DEFAULT NULL,
  `weaknesses` text DEFAULT NULL,
  `evaluation_period` varchar(50) NOT NULL,
  `evaluator_id` int(10) UNSIGNED DEFAULT NULL,
  `spiritual_life_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `community_life_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `mission_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `personality_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `obedience_score` tinyint(3) UNSIGNED DEFAULT NULL,
  `general_comments` text DEFAULT NULL,
  `recommendations` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `health_records`
--

CREATE TABLE `health_records` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `general_health` varchar(50) NOT NULL DEFAULT 'good',
  `chronic_diseases` text DEFAULT NULL,
  `work_limitations` text DEFAULT NULL,
  `checkup_date` date DEFAULT NULL,
  `next_checkup_date` date DEFAULT NULL,
  `checkup_place` varchar(150) DEFAULT NULL,
  `doctor` varchar(150) DEFAULT NULL,
  `blood_pressure` varchar(20) DEFAULT NULL,
  `heart_rate` varchar(20) DEFAULT NULL,
  `weight` decimal(5,2) DEFAULT NULL,
  `height` decimal(5,2) DEFAULT NULL,
  `diagnosis` text DEFAULT NULL,
  `treatment` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `journey_stages`
--

CREATE TABLE `journey_stages` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `journey_stages`
--

INSERT INTO `journey_stages` (`id`, `code`, `name`, `description`, `display_order`, `color`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'de_tu', 'Đệ tử', NULL, 7, '#6f42c1', 1, '2025-12-18 13:30:37', '2025-12-18 13:39:24'),
(2, 'aspirant', 'Ứng sinh', NULL, 1, '#17a2b8', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(3, 'pre_aspirant', 'Tiền ứng sinh', NULL, 2, '#20c997', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(5, 'novice', 'Tập sinh viện', NULL, 4, '#ffc107', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(6, 'temporary_vows', 'Khấn tạm', NULL, 5, '#fd7e14', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(7, 'perpetual_vows', 'Khấn trọn', NULL, 6, '#dc3545', 1, '2025-12-18 13:39:24', '2025-12-18 13:39:24'),
(11, 'tu_xuat', 'Tu xuất', NULL, 7, '#6c757d', 1, '2025-12-22 15:39:55', '2025-12-22 15:39:55');

-- --------------------------------------------------------

--
-- Table structure for table `missions`
--

CREATE TABLE `missions` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(100) NOT NULL,
  `specific_role` varchar(150) DEFAULT NULL,
  `organization` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('info','warning','success','error','birthday','anniversary','reminder') DEFAULT 'info',
  `title` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `read_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'Tên permission (vd: users.view, sisters.create)',
  `display_name` varchar(255) NOT NULL COMMENT 'Tên hiển thị',
  `description` text DEFAULT NULL COMMENT 'Mô tả permission',
  `module` varchar(50) NOT NULL COMMENT 'Module/nhóm chức năng (users, sisters, evaluations...)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_active` tinyint(1) DEFAULT 1,
  `sort_order` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `display_name`, `description`, `module`, `created_at`, `updated_at`, `is_active`, `sort_order`) VALUES
(1, 'sisters.view', 'Xem danh sách nữ tu', 'Quyền xem danh sách nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(2, 'sisters.create', 'Tạo hồ sơ mới', 'Tạo hồ sơ nữ tu mới', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(3, 'sisters.edit', 'Chỉnh sửa thông tin nữ tu', 'Quyền chỉnh sửa thông tin nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(4, 'sisters.delete', 'Xóa hồ sơ', 'Xóa hồ sơ nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(5, 'sisters.export', 'Xuất dữ liệu nữ tu', 'Quyền xuất dữ liệu nữ tu', 'Nữ tu', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(6, 'communities.view', 'Xem danh sách cộng đoàn', 'Quyền xem danh sách cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(7, 'communities.create', 'Tạo mới', 'Tạo cộng đoàn mới', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(8, 'communities.edit', 'Chỉnh sửa cộng đoàn', 'Quyền chỉnh sửa cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(9, 'communities.delete', 'Xóa', 'Xóa cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(10, 'communities.assign', 'Phân công nữ tu vào cộng đoàn', 'Quyền phân công nữ tu vào cộng đoàn', 'Cộng đoàn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(11, 'journey.view', 'Xem hành trình ơn gọi', 'Quyền xem hành trình ơn gọi', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(12, 'journey.create', 'Thêm giai đoạn ơn gọi', 'Quyền thêm giai đoạn ơn gọi', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(13, 'journey.edit', 'Chỉnh sửa hành trình', 'Quyền chỉnh sửa hành trình', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(14, 'journey.delete', 'Xóa giai đoạn', 'Quyền xóa giai đoạn', 'Hành trình ơn gọi', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(15, 'health.view', 'Xem hồ sơ sức khỏe', 'Quyền xem hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(16, 'health.create', 'Thêm hồ sơ sức khỏe', 'Quyền thêm hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(17, 'health.edit', 'Chỉnh sửa sức khỏe', 'Quyền chỉnh sửa sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(18, 'health.delete', 'Xóa hồ sơ sức khỏe', 'Quyền xóa hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(19, 'education.view', 'Xem học vấn', 'Xem thông tin học vấn', 'Học vấn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(20, 'education.create', 'Thêm học vấn', 'Thêm học vấn mới', 'Học vấn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(21, 'education.edit', 'Chỉnh sửa học vấn', 'Quyền chỉnh sửa học vấn', 'Học vấn', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(22, 'education.delete', 'Xóa học vấn', 'Xóa học vấn', 'Học vấn', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(23, 'missions.view', 'Xem sứ vụ', 'Xem thông tin sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(24, 'missions.create', 'Thêm sứ vụ', 'Thêm sứ vụ mới', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(25, 'missions.edit', 'Chỉnh sửa sứ vụ', 'Quyền chỉnh sửa sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(26, 'missions.delete', 'Xóa sứ vụ', 'Xóa sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(27, 'missions.assign', 'Phân công sứ vụ', 'Quyền phân công sứ vụ', 'Sứ vụ', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(28, 'evaluations.view', 'Xem đánh giá', 'Xem phiếu đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(29, 'evaluations.create', 'Tạo phiếu', 'Tạo phiếu đánh giá mới', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(30, 'evaluations.edit', 'Chỉnh sửa đánh giá', 'Quyền chỉnh sửa đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(31, 'evaluations.delete', 'Xóa phiếu', 'Xóa phiếu đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(32, 'evaluations.approve', 'Phê duyệt đánh giá', 'Quyền phê duyệt đánh giá', 'Đánh giá', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(33, 'reports.view', 'Xem báo cáo', 'Quyền xem báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(34, 'reports.create', 'Tạo báo cáo', 'Quyền tạo báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(35, 'reports.export', 'Xuất báo cáo', 'Quyền xuất báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(36, 'reports.print', 'In báo cáo', 'Quyền in báo cáo', 'Báo cáo', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(37, 'users.view', 'Xem danh sách người dùng', 'Quyền xem danh sách người dùng', 'Người dùng', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(38, 'users.create', 'Tạo user', 'Tạo người dùng mới', 'Người dùng', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(39, 'users.edit', 'Chỉnh sửa người dùng', 'Quyền chỉnh sửa người dùng', 'Người dùng', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(40, 'users.delete', 'Xóa user', 'Xóa người dùng', 'Người dùng', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(41, 'users.manage_permissions', 'Quản lý phân quyền', 'Quyền quản lý phân quyền', 'Người dùng', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(42, 'users.assign_communities', 'Gán cộng đoàn', 'Gán vào cộng đoàn', 'Người dùng', '2025-12-14 15:27:02', '2025-12-15 15:12:02', 1, 0),
(43, 'settings.view', 'Xem cài đặt', 'Quyền xem cài đặt', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(44, 'settings.edit', 'Thay đổi cài đặt', 'Quyền thay đổi cài đặt', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(45, 'settings.backup', 'Sao lưu & khôi phục', 'Quyền sao lưu & khôi phục', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(46, 'settings.audit', 'Xem nhật ký hoạt động', 'Quyền xem nhật ký hoạt động', 'Cài đặt', '2025-12-14 15:27:02', '2025-12-14 15:47:31', 1, 0),
(47, 'sisters.view_list', 'Xem danh sách nữ tu', 'Xem danh sách nữ tu', 'Nữ tu', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(48, 'sisters.view_detail', 'Xem chi tiết hồ sơ', 'Xem chi tiết hồ sơ nữ tu', 'Nữ tu', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(49, 'communities.view_list', 'Xem danh sách', 'Xem danh sách cộng đoàn', 'Cộng đoàn', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(50, 'communities.view_detail', 'Xem chi tiết', 'Xem chi tiết cộng đoàn', 'Cộng đoàn', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(51, 'journey.view_list', 'Xem danh sách hành trình', 'Quyền xem danh sách hành trình', 'Hành trình ơn gọi', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(52, 'journey.view_detail', 'Xem chi tiết hành trình', 'Quyền xem chi tiết hành trình', 'Hành trình ơn gọi', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(53, 'health.view_list', 'Xem danh sách hồ sơ sức khỏe', 'Quyền xem danh sách hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(54, 'health.view_detail', 'Xem chi tiết hồ sơ sức khỏe', 'Quyền xem chi tiết hồ sơ sức khỏe', 'Sức khỏe', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(55, 'education.view_list', 'Xem danh sách học vấn', 'Quyền xem danh sách học vấn', 'Học vấn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(56, 'education.view_detail', 'Xem chi tiết học vấn', 'Quyền xem chi tiết học vấn', 'Học vấn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(57, 'missions.view_list', 'Xem danh sách sứ vụ', 'Quyền xem danh sách sứ vụ', 'Sứ vụ', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(58, 'missions.view_detail', 'Xem chi tiết sứ vụ', 'Quyền xem chi tiết sứ vụ', 'Sứ vụ', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(59, 'evaluations.view_list', 'Xem danh sách đánh giá', 'Quyền xem danh sách đánh giá', 'Đánh giá', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(60, 'evaluations.view_detail', 'Xem chi tiết đánh giá', 'Quyền xem chi tiết đánh giá', 'Đánh giá', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(61, 'users.view_list', 'Xem danh sách', 'Xem danh sách người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(62, 'users.view_detail', 'Xem chi tiết', 'Xem chi tiết người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(63, 'users.update', 'Sửa thông tin', 'Sửa thông tin người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(64, 'users.lock_unlock', 'Khóa/Mở user', 'Khóa hoặc mở khóa', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(65, 'users.reset_password', 'Reset mật khẩu', 'Reset mật khẩu', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(66, 'users.assign_permissions', 'Gán quyền', 'Gán quyền cho người dùng', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(67, 'users.revoke_permissions', 'Thu hồi quyền', 'Thu hồi quyền', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(68, 'users.view_permissions', 'Xem quyền', 'Xem quyền của user', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(69, 'users.view_activity', 'Xem lịch sử', 'Xem lịch sử hoạt động', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(70, 'users.remove_communities', 'Gỡ cộng đoàn', 'Gỡ khỏi cộng đoàn', 'Người dùng', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(71, 'reports.view_list', 'Xem danh sách báo cáo', 'Quyền xem danh sách báo cáo', 'Báo cáo', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(72, 'reports.view_detail', 'Xem chi tiết báo cáo', 'Quyền xem chi tiết báo cáo', 'Báo cáo', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(73, 'departure.view', 'Xem hồ sơ nghỉ', 'Quyền xem hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(74, 'departure.create', 'Tạo hồ sơ nghỉ', 'Quyền tạo hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(75, 'departure.edit', 'Chỉnh sửa hồ sơ nghỉ', 'Quyền chỉnh sửa hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(76, 'departure.delete', 'Xóa hồ sơ nghỉ', 'Quyền xóa hồ sơ nghỉ', 'Nghỉ việc', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(77, 'training.view', 'Xem thường huấn', 'Xem thông tin thường huấn', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(78, 'training.create', 'Thêm khóa học', 'Thêm khóa học mới', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(79, 'training.edit', 'Chỉnh sửa khóa đào tạo', 'Quyền chỉnh sửa khóa đào tạo', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(80, 'training.delete', 'Xóa khóa học', 'Xóa khóa học', 'Đào tạo', '2025-12-14 15:43:12', '2025-12-15 15:12:02', 1, 0),
(81, 'community_assignment.view', 'Xem phân công cộng đoàn', 'Quyền xem phân công cộng đoàn', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(82, 'community_assignment.create', 'Tạo phân công', 'Quyền tạo phân công', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(83, 'community_assignment.edit', 'Chỉnh sửa phân công', 'Quyền chỉnh sửa phân công', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(84, 'community_assignment.delete', 'Xóa phân công', 'Quyền xóa phân công', 'Phân công cộng đoàn', '2025-12-14 15:43:12', '2025-12-14 15:47:31', 1, 0),
(85, 'communities.history_view', 'Xem lịch sử hình thành', 'Quyền xem lịch sử hình thành cộng đoàn', 'Cộng đoàn', '2025-12-15 13:32:45', '2025-12-15 13:32:45', 1, 0),
(86, 'communities.history_edit', 'Chỉnh sửa lịch sử hình thành', 'Quyền chỉnh sửa lịch sử hình thành cộng đoàn', 'Cộng đoàn', '2025-12-15 13:32:45', '2025-12-15 13:32:45', 1, 0),
(90, 'sisters.update_basic', 'Sửa thông tin cơ bản', 'Sửa thông tin cơ bản', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(91, 'sisters.update_sensitive', 'Sửa thông tin nhạy cảm', 'Sửa CMND, hộ chiếu...', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(93, 'sisters.upload_avatar', 'Upload ảnh', 'Upload ảnh chân dung', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(94, 'sisters.upload_documents', 'Upload tài liệu', 'Upload tài liệu', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(95, 'sisters.export_excel', 'Xuất Excel', 'Xuất danh sách Excel', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(96, 'sisters.export_pdf', 'Xuất PDF', 'Xuất hồ sơ PDF', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(97, 'sisters.print', 'In hồ sơ', 'In hồ sơ nữ tu', 'sisters', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(98, 'vocation.view', 'Xem hành trình', 'Xem hành trình ơn gọi', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(99, 'vocation.create', 'Thêm mốc', 'Thêm mốc hành trình', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(100, 'vocation.update', 'Sửa mốc', 'Sửa mốc hành trình', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(101, 'vocation.delete', 'Xóa mốc', 'Xóa mốc hành trình', 'vocation', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(105, 'communities.update', 'Sửa thông tin', 'Sửa thông tin cộng đoàn', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(107, 'communities.assign_sister', 'Gán nữ tu', 'Gán nữ tu vào cộng đoàn', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(108, 'communities.remove_sister', 'Gỡ nữ tu', 'Gỡ nữ tu khỏi cộng đoàn', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(109, 'communities.upload_decision', 'Upload quyết định', 'Upload quyết định bổ nhiệm', 'communities', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(112, 'missions.update', 'Sửa sứ vụ', 'Sửa thông tin sứ vụ', 'missions', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(116, 'education.update', 'Sửa học vấn', 'Sửa thông tin học vấn', 'education', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(118, 'education.upload_certificate', 'Upload bằng cấp', 'Upload file bằng cấp', 'education', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(121, 'training.update', 'Sửa khóa học', 'Sửa thông tin khóa học', 'training', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(123, 'health.view_basic', 'Xem sức khỏe cơ bản', 'Xem thông tin sức khỏe cơ bản', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(124, 'health.view_full', 'Xem đầy đủ sức khỏe', 'Xem đầy đủ thông tin sức khỏe nhạy cảm', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(125, 'health.update', 'Cập nhật sức khỏe', 'Cập nhật thông tin sức khỏe', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(126, 'health.add_record', 'Thêm bản ghi', 'Thêm bản ghi khám bệnh', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(127, 'health.update_record', 'Sửa bản ghi', 'Sửa bản ghi khám bệnh', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(128, 'health.delete_record', 'Xóa bản ghi', 'Xóa bản ghi khám bệnh', 'health', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(131, 'evaluations.update', 'Sửa phiếu', 'Sửa phiếu đánh giá', 'evaluations', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(133, 'evaluations.export_pdf', 'Xuất PDF', 'Xuất phiếu PDF', 'evaluations', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(134, 'departures.view', 'Xem tu xuất', 'Xem thông tin tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(135, 'departures.create', 'Ghi nhận', 'Ghi nhận tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(136, 'departures.update', 'Sửa thông tin', 'Sửa thông tin tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(137, 'departures.delete', 'Xóa bản ghi', 'Xóa bản ghi tu xuất', 'departures', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(138, 'reports.view_dashboard', 'Xem dashboard', 'Xem dashboard tổng quan', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(139, 'reports.view_by_age', 'Báo cáo độ tuổi', 'Xem báo cáo theo độ tuổi', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(140, 'reports.view_by_stage', 'Báo cáo giai đoạn', 'Xem báo cáo theo giai đoạn', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(141, 'reports.view_by_community', 'Báo cáo cộng đoàn', 'Xem báo cáo theo cộng đoàn', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(142, 'reports.view_by_mission', 'Báo cáo sứ vụ', 'Xem báo cáo theo sứ vụ', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(143, 'reports.view_by_education', 'Báo cáo trình độ', 'Xem báo cáo theo trình độ', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(144, 'reports.export_excel', 'Xuất Excel', 'Xuất báo cáo Excel', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(145, 'reports.export_pdf', 'Xuất PDF', 'Xuất báo cáo PDF', 'reports', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(146, 'search.basic', 'Tìm kiếm cơ bản', 'Sử dụng tìm kiếm cơ bản', 'search', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(147, 'search.advanced', 'Tìm kiếm nâng cao', 'Sử dụng tìm kiếm nâng cao', 'search', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(148, 'search.export', 'Xuất kết quả', 'Xuất kết quả tìm kiếm', 'search', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(162, 'audit.view', 'Xem audit log', 'Xem audit log hệ thống', 'audit', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(163, 'audit.export', 'Xuất audit log', 'Xuất audit log', 'audit', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(164, 'system.backup', 'Backup DB', 'Sao lưu database', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(165, 'system.restore', 'Restore DB', 'Khôi phục database', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(166, 'system.view_settings', 'Xem cấu hình', 'Xem cấu hình hệ thống', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(167, 'system.update_settings', 'Sửa cấu hình', 'Sửa cấu hình hệ thống', 'system', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(168, 'admin.full_access', 'Quyền tối cao', 'Quyền tối cao - bypass mọi kiểm tra', 'admin', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(169, 'posts.view', 'Xem bài đăng', 'Xem danh sách và chi tiết bài đăng', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(170, 'posts.create', 'Tạo bài đăng', 'Tạo bài đăng mới', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(171, 'posts.update', 'Sửa bài đăng', 'Chỉnh sửa bài đăng', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(172, 'posts.delete', 'Xóa bài đăng', 'Xóa bài đăng', 'posts', '2025-12-15 15:12:02', '2025-12-15 15:12:02', 1, 0),
(427, 'dashboard.view', 'Xem trang chủ', 'Xem trang chủ và thống kê tổng quan', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0),
(428, 'dashboard.view_stats', 'Xem thống kê', 'Xem các số liệu thống kê', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0),
(429, 'dashboard.view_activities', 'Xem hoạt động gần đây', 'Xem lịch sử hoạt động hệ thống', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0),
(430, 'dashboard.view_posts', 'Xem bài đăng gần đây', 'Xem các bài đăng mới nhất', 'dashboard', '2025-12-15 16:22:47', '2025-12-15 16:22:47', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `category` enum('thong-bao','su-kien','huong-dan','chia-se','khac') NOT NULL DEFAULT 'thong-bao',
  `summary` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `is_important` tinyint(1) DEFAULT 0,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`tags`)),
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `author_id` int(11) DEFAULT NULL,
  `view_count` int(11) DEFAULT 0,
  `status` enum('draft','published') DEFAULT 'published',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sisters`
--

CREATE TABLE `sisters` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(30) NOT NULL,
  `saint_name` varchar(120) DEFAULT NULL,
  `birth_name` varchar(120) NOT NULL,
  `date_of_birth` date NOT NULL,
  `place_of_birth` varchar(150) DEFAULT NULL,
  `hometown` varchar(150) DEFAULT NULL,
  `permanent_address` varchar(255) DEFAULT NULL,
  `current_address` varchar(255) DEFAULT NULL,
  `nationality` varchar(80) DEFAULT NULL,
  `id_card` varchar(20) DEFAULT NULL,
  `id_card_date` date DEFAULT NULL,
  `id_card_place` varchar(150) DEFAULT NULL,
  `father_name` varchar(120) DEFAULT NULL,
  `father_occupation` varchar(100) DEFAULT NULL,
  `mother_name` varchar(120) DEFAULT NULL,
  `mother_occupation` varchar(100) DEFAULT NULL,
  `siblings_count` int(11) DEFAULT NULL,
  `family_address` varchar(255) DEFAULT NULL,
  `family_religion` varchar(80) DEFAULT NULL,
  `baptism_date` date DEFAULT NULL,
  `baptism_place` varchar(150) DEFAULT NULL,
  `confirmation_date` date DEFAULT NULL,
  `first_communion_date` date DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `email` varchar(120) DEFAULT NULL,
  `emergency_contact_name` varchar(120) DEFAULT NULL,
  `emergency_contact_phone` varchar(30) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `photo_url` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'active',
  `current_stage` varchar(50) DEFAULT NULL,
  `current_community_id` int(10) UNSIGNED DEFAULT NULL,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'JSON array of document files' CHECK (json_valid(`documents`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sisters`
--

INSERT INTO `sisters` (`id`, `code`, `saint_name`, `birth_name`, `date_of_birth`, `place_of_birth`, `hometown`, `permanent_address`, `current_address`, `nationality`, `id_card`, `id_card_date`, `id_card_place`, `father_name`, `father_occupation`, `mother_name`, `mother_occupation`, `siblings_count`, `family_address`, `family_religion`, `baptism_date`, `baptism_place`, `confirmation_date`, `first_communion_date`, `phone`, `email`, `emergency_contact_name`, `emergency_contact_phone`, `notes`, `photo_url`, `status`, `current_stage`, `current_community_id`, `created_by`, `created_at`, `updated_at`, `documents`) VALUES
(1, 'NT-001', 'Thérèse', 'Nguyễn Thị Mỹ Linh', '1995-03-12', 'Hà Nội', 'Hưng Yên', 'Số 123 Phố Liễu Giai, Quận Ba Đình, Hà Nội', 'Nha Tho Trung Tam, Duong Lao Cay, Quan Hai Ba Trung, Ha Noi', 'Việt Nam', '012345678901', '2020-06-07', 'Cảnh Sát Cấp Hà Nội', 'Nguyễn Văn An', 'Công nhân', 'Trần Thị Hoa', 'Nội trợ', 3, '123 Phố Liễu Giai, Quận Ba Đình, Hà Nội', 'Công Giáo', '2000-04-18', 'Nhà Thờ Công Giáo Ba Đình', '2008-05-16', '2010-12-23', '0987654321', 'therese@example.com', 'Nguyễn Văn Bình', '0912345678', NULL, '/uploads/1766333233177-gczzjn.jpg', 'left', NULL, NULL, 1, '2025-12-21 16:02:40', '2025-12-24 09:08:35', '[{\"id\":1766333230557,\"name\":\"24210089_Tran Tin.docx\",\"size\":1273432,\"type\":\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"url\":\"/uploads/certificates/1766333230548-837iw9.docx\",\"uploadedAt\":\"2025-12-21T16:07:10.557Z\"}]'),
(2, 'NT-002', 'Théclè', 'Lê Thị Mỹ Hạnh', '1998-08-19', 'Nam Định', 'Nam Định', '456 Phố Lế Công, Nam Định', 'Nha Tho Trung Tam, Hà Nội', 'Việt Nam', '123456789012', '2021-02-09', 'Cảnh sát Nam Định', 'Lê Văn Bịnh', 'Thợ công', 'Trần Thị Ngôc', 'Nội trợ', 2, '456 Phố Lẽ Công, Nam Định', 'Công Giáo', '1998-09-23', 'Nhà Thờ Nam Định', '2007-05-07', '2009-12-20', '0981234567', 'lehanhanh@example.com', 'Lê Văn Tó', '0912345678', 'Nữ tu có tành tính vui vẻ, many hệ tợ em nhỏ. KỬn trì trong học tập và thực hành đức ãn.', NULL, 'left', NULL, NULL, 1, '2025-12-21 16:21:08', '2025-12-24 09:08:28', NULL),
(3, 'NT-003', 'Băong', 'Phạm Thị Thanh Hương', '1996-06-07', 'Quảng Trị', 'Quảng Trị', '789 Phố Mọ Cỏ, Quảng Trị', 'Nha Tho Trung Tam, Ha Noi', 'Việt Nam', '234567890123', '2021-03-17', 'Cảnh sát Quảng Trị', 'Phạm Văn Hậu', 'Nông dân', 'Vũ Thị Hoa', 'Nội trợ', 3, '123 Phố Mọ Cỏ, Quảng Trị', 'Công Giáo', '1996-10-13', 'Nha Tho Quang Tri', '2005-05-18', '2007-12-23', '0923456789', 'phamhuong@example.com', 'Phạm Văn Sơn', '0934567890', 'Nữ tu có tành tính thiển nhân, thành tĩnh dận đạo. Hợc tập tực thế hệ rất kến.', NULL, 'left', NULL, NULL, 1, '2025-12-21 16:24:00', '2025-12-24 09:08:32', '[{\"id\":1766374397592,\"name\":\"24210089_Tran Tin.docx\",\"size\":1273432,\"type\":\"application/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"url\":\"/uploads/certificates/1766374397588-4o89ln.docx\",\"uploadedAt\":\"2025-12-22T03:33:17.592Z\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `sister_statuses`
--

CREATE TABLE `sister_statuses` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `color` varchar(20) DEFAULT '#6c757d',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_group` varchar(50) DEFAULT 'general',
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`id`, `setting_key`, `setting_value`, `setting_group`, `description`, `created_at`, `updated_at`) VALUES
(1, 'siteName', 'Hệ Thống Quản Lý Hội Dòng OSP - Updated', 'general', 'Tên hệ thống', '2025-12-15 16:52:01', '2025-12-15 16:55:06'),
(2, 'siteDescription', 'Quản lý thông tin nữ tu và hoạt động của Hội Dòng', 'general', 'Mô tả hệ thống', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(3, 'timezone', 'Asia/Ho_Chi_Minh', 'general', 'Múi giờ', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(4, 'dateFormat', 'DD/MM/YYYY', 'general', 'Định dạng ngày', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(5, 'language', 'en', 'general', 'Ngôn ngữ', '2025-12-15 16:52:01', '2025-12-16 12:37:14'),
(6, 'congregationName', 'Dòng Nữ Tu OSP', 'general', 'Tên Hội Dòng', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(7, 'foundingDate', '', 'general', 'Ngày thành lập', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(8, 'mainAddress', '', 'general', 'Địa chỉ chính', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(9, 'phone', '', 'general', 'Số điện thoại', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(10, 'email', '', 'general', 'Email', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(11, 'website', '', 'general', 'Website', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(12, 'smtpHost', '', 'system', 'SMTP Host', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(13, 'smtpPort', '587', 'system', 'SMTP Port', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(14, 'smtpUser', '', 'system', 'SMTP User', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(15, 'smtpPassword', '', 'system', 'SMTP Password', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(16, 'smtpSecure', 'tls', 'system', 'SMTP Secure', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(17, 'emailFromName', 'Hệ Thống Quản Lý Hội Dòng', 'system', 'Email From Name', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(18, 'emailFromAddress', '', 'system', 'Email From Address', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(19, 'sessionTimeout', '60', 'system', 'Session timeout (phút)', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(20, 'minPasswordLength', '8', 'system', 'Độ dài tối thiểu mật khẩu', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(21, 'requireStrongPassword', 'true', 'system', 'Yêu cầu mật khẩu mạnh', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(22, 'maxLoginAttempts', '5', 'system', 'Số lần đăng nhập tối đa', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(23, 'lockoutDuration', '30', 'system', 'Thời gian khóa (phút)', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(24, 'enableTwoFactor', 'false', 'system', 'Bật xác thực 2 yếu tố', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(25, 'enableCache', 'true', 'system', 'Bật cache', '2025-12-15 16:52:01', '2025-12-15 16:52:01'),
(26, 'cacheExpiry', '3600', 'system', 'Thời gian cache (giây)', '2025-12-15 16:52:01', '2025-12-15 16:52:01');

-- --------------------------------------------------------

--
-- Table structure for table `training_courses`
--

CREATE TABLE `training_courses` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `course_name` varchar(180) NOT NULL,
  `organizer` varchar(180) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `content` text DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(120) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `avatar` varchar(500) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `is_admin` tinyint(1) DEFAULT 0,
  `data_scope` enum('all','community','own') DEFAULT 'community' COMMENT 'Data access scope: all=see all, community=assigned communities only, own=own data only',
  `is_super_admin` tinyint(1) DEFAULT 0 COMMENT 'Super admin bypasses all permission checks'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `full_name`, `phone`, `avatar`, `last_login`, `is_active`, `created_at`, `updated_at`, `is_admin`, `data_scope`, `is_super_admin`) VALUES
(1, 'admin', '$2a$10$Sca06wWN.32wbl0U6U5srernzEqsI.NGH8/8CiCV6qQ.gLSofwovC', 'admin@osp.vn', 'Quản trị viên', NULL, '', '2025-12-24 21:11:13', 1, '2025-12-14 15:27:02', '2025-12-24 14:11:13', 1, 'all', 1),
(2, 'tester01', '$2a$10$he8V9wO5WSw7Ij1LoNrsq.9WeUFztETRZdoO34JFh10xF592fONFS', 'test@example.com', 'Trần Tín', NULL, '', '2025-12-24 21:11:48', 1, '2025-12-23 03:39:14', '2025-12-24 14:11:48', 0, 'community', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_communities`
--

CREATE TABLE `user_communities` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `community_id` int(10) UNSIGNED NOT NULL,
  `is_primary` tinyint(1) DEFAULT 0 COMMENT 'Đánh dấu cộng đoàn chính',
  `granted_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'ID admin gán',
  `granted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Gán user vào cộng đoàn - xác định phạm vi dữ liệu';

--
-- Dumping data for table `user_communities`
--

INSERT INTO `user_communities` (`id`, `user_id`, `community_id`, `is_primary`, `granted_by`, `granted_at`, `created_at`, `updated_at`) VALUES
(121, 1, 6, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(122, 1, 5, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(125, 1, 7, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL),
(126, 1, 4, 0, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_permissions`
--

CREATE TABLE `user_permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `permission_id` int(10) UNSIGNED NOT NULL,
  `granted_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'User ID của người gán quyền',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_permissions`
--

INSERT INTO `user_permissions` (`id`, `user_id`, `permission_id`, `granted_by`, `created_at`, `updated_at`) VALUES
(4896, 1, 1, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4897, 1, 2, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4898, 1, 3, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4899, 1, 4, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4900, 1, 5, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4901, 1, 6, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4902, 1, 7, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4903, 1, 8, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4904, 1, 9, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4905, 1, 10, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4906, 1, 11, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4907, 1, 12, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4908, 1, 13, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4909, 1, 14, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4910, 1, 15, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4911, 1, 16, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4912, 1, 17, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4913, 1, 18, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4914, 1, 19, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4915, 1, 20, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4916, 1, 21, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4917, 1, 22, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4918, 1, 23, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4919, 1, 24, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4920, 1, 25, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4921, 1, 26, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4922, 1, 27, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4923, 1, 28, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4924, 1, 29, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4925, 1, 30, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4926, 1, 31, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4927, 1, 32, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4928, 1, 33, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4929, 1, 34, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4930, 1, 35, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4931, 1, 36, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4932, 1, 37, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4933, 1, 38, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4934, 1, 39, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4935, 1, 40, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4936, 1, 41, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4937, 1, 42, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4938, 1, 47, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4939, 1, 48, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4940, 1, 49, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4941, 1, 50, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4942, 1, 51, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4943, 1, 52, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4944, 1, 53, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4945, 1, 54, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4946, 1, 55, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4947, 1, 56, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4948, 1, 57, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4949, 1, 58, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4950, 1, 59, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4951, 1, 60, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4952, 1, 61, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4953, 1, 62, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4954, 1, 63, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4955, 1, 64, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4956, 1, 65, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4957, 1, 66, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4958, 1, 67, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4959, 1, 68, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4960, 1, 69, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4961, 1, 70, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4962, 1, 71, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4963, 1, 72, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4964, 1, 73, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4965, 1, 74, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4966, 1, 75, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4967, 1, 76, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4968, 1, 77, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4969, 1, 78, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4970, 1, 79, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4971, 1, 80, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4972, 1, 81, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4973, 1, 82, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4974, 1, 83, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4975, 1, 84, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4976, 1, 85, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4977, 1, 86, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4978, 1, 90, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4979, 1, 91, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4980, 1, 93, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4981, 1, 94, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4982, 1, 95, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4983, 1, 96, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4984, 1, 97, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4985, 1, 98, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4986, 1, 99, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4987, 1, 100, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4988, 1, 101, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4989, 1, 105, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4990, 1, 107, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4991, 1, 108, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4992, 1, 109, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4993, 1, 112, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4994, 1, 116, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4995, 1, 118, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4996, 1, 121, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4997, 1, 123, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4998, 1, 124, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(4999, 1, 125, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5000, 1, 126, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5001, 1, 127, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5002, 1, 128, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5003, 1, 131, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5004, 1, 133, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5005, 1, 134, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5006, 1, 135, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5007, 1, 136, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5008, 1, 137, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5009, 1, 138, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5010, 1, 139, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5011, 1, 140, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5012, 1, 141, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5013, 1, 142, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5014, 1, 143, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5015, 1, 144, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5016, 1, 145, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5017, 1, 146, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5018, 1, 147, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5019, 1, 148, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5020, 1, 162, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5021, 1, 163, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5022, 1, 168, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5023, 1, 169, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5024, 1, 170, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5025, 1, 171, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5026, 1, 172, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5027, 1, 427, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5028, 1, 428, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5029, 1, 429, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5030, 1, 430, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5031, 1, 46, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5032, 1, 45, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5033, 1, 44, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5034, 1, 43, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5035, 1, 164, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5036, 1, 165, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5037, 1, 167, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(5038, 1, 166, 1, '2025-12-18 12:45:19', '2025-12-18 12:45:19'),
(6189, 2, 1, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6190, 2, 2, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6191, 2, 3, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6192, 2, 4, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6193, 2, 5, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6194, 2, 6, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6195, 2, 7, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6196, 2, 8, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6197, 2, 9, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6198, 2, 10, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6199, 2, 11, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6200, 2, 12, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6201, 2, 13, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6202, 2, 14, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6203, 2, 15, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6204, 2, 16, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6205, 2, 17, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6206, 2, 18, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6207, 2, 19, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6208, 2, 20, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6209, 2, 21, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6210, 2, 22, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6211, 2, 23, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6212, 2, 24, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6213, 2, 25, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6214, 2, 26, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6215, 2, 27, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6216, 2, 28, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6217, 2, 29, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6218, 2, 30, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6219, 2, 31, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6220, 2, 32, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6221, 2, 33, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6222, 2, 34, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6223, 2, 35, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6224, 2, 36, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6225, 2, 37, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6226, 2, 38, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6227, 2, 39, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6228, 2, 40, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6229, 2, 41, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6230, 2, 42, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6231, 2, 43, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6232, 2, 44, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6233, 2, 45, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6234, 2, 46, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6235, 2, 47, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6236, 2, 48, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6237, 2, 49, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6238, 2, 50, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6239, 2, 51, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6240, 2, 52, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6241, 2, 53, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6242, 2, 54, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6243, 2, 55, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6244, 2, 56, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6245, 2, 57, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6246, 2, 58, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6247, 2, 59, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6248, 2, 60, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6249, 2, 61, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6250, 2, 62, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6251, 2, 63, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6252, 2, 64, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6253, 2, 65, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6254, 2, 66, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6255, 2, 67, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6256, 2, 68, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6257, 2, 69, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6258, 2, 70, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6259, 2, 71, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6260, 2, 72, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6261, 2, 73, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6262, 2, 74, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6263, 2, 75, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6264, 2, 76, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6265, 2, 77, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6266, 2, 78, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6267, 2, 79, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6268, 2, 80, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6269, 2, 81, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6270, 2, 82, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6271, 2, 83, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6272, 2, 84, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6273, 2, 85, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6274, 2, 86, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6275, 2, 90, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6276, 2, 91, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6277, 2, 93, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6278, 2, 94, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6279, 2, 95, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6280, 2, 96, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6281, 2, 97, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6282, 2, 98, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6283, 2, 99, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6284, 2, 100, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6285, 2, 101, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6286, 2, 105, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6287, 2, 107, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6288, 2, 108, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6289, 2, 109, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6290, 2, 112, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6291, 2, 116, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6292, 2, 118, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6293, 2, 121, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6294, 2, 123, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6295, 2, 124, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6296, 2, 125, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6297, 2, 126, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6298, 2, 127, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6299, 2, 128, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6300, 2, 131, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6301, 2, 133, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6302, 2, 134, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6303, 2, 135, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6304, 2, 136, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6305, 2, 137, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6306, 2, 138, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6307, 2, 139, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6308, 2, 140, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6309, 2, 141, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6310, 2, 142, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6311, 2, 143, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6312, 2, 144, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6313, 2, 145, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6314, 2, 146, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6315, 2, 147, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6316, 2, 148, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6317, 2, 162, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6318, 2, 163, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6319, 2, 164, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6320, 2, 165, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6321, 2, 166, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6322, 2, 167, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6323, 2, 169, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6324, 2, 170, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6325, 2, 171, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6326, 2, 172, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6327, 2, 427, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6328, 2, 428, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6329, 2, 429, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13'),
(6330, 2, 430, 1, '2025-12-24 09:08:13', '2025-12-24 09:08:13');

-- --------------------------------------------------------

--
-- Table structure for table `user_preferences`
--

CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `preference_key` varchar(100) NOT NULL,
  `preference_value` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vocation_journey`
--

CREATE TABLE `vocation_journey` (
  `id` int(10) UNSIGNED NOT NULL,
  `sister_id` int(10) UNSIGNED NOT NULL,
  `stage` varchar(50) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `superior` varchar(255) DEFAULT NULL,
  `formation_director` varchar(255) DEFAULT NULL,
  `community_id` int(10) UNSIGNED DEFAULT NULL,
  `supervisor_id` int(10) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `documents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`documents`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_table` (`table_name`),
  ADD KEY `idx_audit_user` (`user_id`);

--
-- Indexes for table `backups`
--
ALTER TABLE `backups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_conversation_id` (`conversation_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `communities`
--
ALTER TABLE `communities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `community_assignments`
--
ALTER TABLE `community_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_assignments_role` (`role`),
  ADD KEY `idx_assignments_sister` (`sister_id`),
  ADD KEY `idx_assignments_community` (`community_id`);

--
-- Indexes for table `community_members`
--
ALTER TABLE `community_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_community_date` (`community_id`,`start_date`,`end_date`),
  ADD KEY `idx_sister_date` (`sister_id`,`start_date`,`end_date`),
  ADD KEY `idx_role` (`role`);

--
-- Indexes for table `community_roles`
--
ALTER TABLE `community_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `departures`
--
ALTER TABLE `departures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departures_approver` (`approved_by`),
  ADD KEY `idx_departures_sister` (`sister_id`),
  ADD KEY `idx_departures_date` (`departure_date`);

--
-- Indexes for table `departure_records`
--
ALTER TABLE `departure_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_departure_sister` (`sister_id`),
  ADD KEY `idx_departure_date` (`departure_date`);

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_education_sister` (`sister_id`),
  ADD KEY `idx_education_level` (`level`);

--
-- Indexes for table `education_levels`
--
ALTER TABLE `education_levels`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_evaluations_sister` (`sister_id`),
  ADD KEY `fk_evaluations_evaluator` (`evaluator_id`),
  ADD KEY `idx_evaluations_period` (`evaluation_period`);

--
-- Indexes for table `health_records`
--
ALTER TABLE `health_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_health_sister` (`sister_id`);

--
-- Indexes for table `journey_stages`
--
ALTER TABLE `journey_stages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `missions`
--
ALTER TABLE `missions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_missions_field` (`field`),
  ADD KEY `idx_missions_sister` (`sister_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_is_pinned` (`is_pinned`),
  ADD KEY `idx_is_important` (`is_important`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_deleted_at` (`deleted_at`);

--
-- Indexes for table `sisters`
--
ALTER TABLE `sisters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `fk_sisters_created_by` (`created_by`),
  ADD KEY `idx_sisters_status` (`status`),
  ADD KEY `idx_sisters_dob` (`date_of_birth`),
  ADD KEY `fk_sisters_current_community` (`current_community_id`);

--
-- Indexes for table `sister_statuses`
--
ALTER TABLE `sister_statuses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`),
  ADD KEY `idx_setting_key` (`setting_key`),
  ADD KEY `idx_setting_group` (`setting_group`);

--
-- Indexes for table `training_courses`
--
ALTER TABLE `training_courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_training_courses_sister` (`sister_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_active` (`is_active`),
  ADD KEY `idx_data_scope` (`data_scope`),
  ADD KEY `idx_super_admin` (`is_super_admin`);

--
-- Indexes for table `user_communities`
--
ALTER TABLE `user_communities`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_community` (`user_id`,`community_id`),
  ADD KEY `granted_by` (`granted_by`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_community_id` (`community_id`);

--
-- Indexes for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_permission` (`user_id`,`permission_id`),
  ADD KEY `permission_id` (`permission_id`),
  ADD KEY `granted_by` (`granted_by`);

--
-- Indexes for table `user_preferences`
--
ALTER TABLE `user_preferences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_preference` (`user_id`,`preference_key`),
  ADD KEY `idx_user_id` (`user_id`);

--
-- Indexes for table `vocation_journey`
--
ALTER TABLE `vocation_journey`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_vocation_journey_community` (`community_id`),
  ADD KEY `fk_vocation_journey_supervisor` (`supervisor_id`),
  ADD KEY `idx_vocation_stage` (`stage`),
  ADD KEY `idx_vocation_sister` (`sister_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=264;

--
-- AUTO_INCREMENT for table `backups`
--
ALTER TABLE `backups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `chat_conversations`
--
ALTER TABLE `chat_conversations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `communities`
--
ALTER TABLE `communities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `community_assignments`
--
ALTER TABLE `community_assignments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `community_members`
--
ALTER TABLE `community_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `community_roles`
--
ALTER TABLE `community_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `departures`
--
ALTER TABLE `departures`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `departure_records`
--
ALTER TABLE `departure_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `education_levels`
--
ALTER TABLE `education_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `evaluations`
--
ALTER TABLE `evaluations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `health_records`
--
ALTER TABLE `health_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `journey_stages`
--
ALTER TABLE `journey_stages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `missions`
--
ALTER TABLE `missions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=435;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sisters`
--
ALTER TABLE `sisters`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sister_statuses`
--
ALTER TABLE `sister_statuses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `training_courses`
--
ALTER TABLE `training_courses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_communities`
--
ALTER TABLE `user_communities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=145;

--
-- AUTO_INCREMENT for table `user_permissions`
--
ALTER TABLE `user_permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6331;

--
-- AUTO_INCREMENT for table `user_preferences`
--
ALTER TABLE `user_preferences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `vocation_journey`
--
ALTER TABLE `vocation_journey`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `community_assignments`
--
ALTER TABLE `community_assignments`
  ADD CONSTRAINT `fk_assignments_community` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_assignments_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `community_members`
--
ALTER TABLE `community_members`
  ADD CONSTRAINT `community_members_ibfk_1` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `community_members_ibfk_2` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `departures`
--
ALTER TABLE `departures`
  ADD CONSTRAINT `fk_departures_approver` FOREIGN KEY (`approved_by`) REFERENCES `sisters` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_departures_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `departure_records`
--
ALTER TABLE `departure_records`
  ADD CONSTRAINT `fk_departure_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `education`
--
ALTER TABLE `education`
  ADD CONSTRAINT `fk_education_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `evaluations`
--
ALTER TABLE `evaluations`
  ADD CONSTRAINT `fk_evaluations_evaluator` FOREIGN KEY (`evaluator_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_evaluations_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `health_records`
--
ALTER TABLE `health_records`
  ADD CONSTRAINT `fk_health_records_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `missions`
--
ALTER TABLE `missions`
  ADD CONSTRAINT `fk_missions_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sisters`
--
ALTER TABLE `sisters`
  ADD CONSTRAINT `fk_sisters_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sisters_current_community` FOREIGN KEY (`current_community_id`) REFERENCES `communities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `training_courses`
--
ALTER TABLE `training_courses`
  ADD CONSTRAINT `fk_training_courses_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_communities`
--
ALTER TABLE `user_communities`
  ADD CONSTRAINT `user_communities_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_communities_ibfk_2` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_communities_ibfk_3` FOREIGN KEY (`granted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD CONSTRAINT `user_permissions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_permissions_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_permissions_ibfk_3` FOREIGN KEY (`granted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `vocation_journey`
--
ALTER TABLE `vocation_journey`
  ADD CONSTRAINT `fk_vocation_journey_community` FOREIGN KEY (`community_id`) REFERENCES `communities` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vocation_journey_sister` FOREIGN KEY (`sister_id`) REFERENCES `sisters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_vocation_journey_supervisor` FOREIGN KEY (`supervisor_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
