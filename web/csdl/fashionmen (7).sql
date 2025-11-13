-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 12, 2025 at 04:36 PM
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
-- Database: `fashionmen`
--

-- --------------------------------------------------------

--
-- Table structure for table `chitiethd`
--

CREATE TABLE `chitiethd` (
  `MaCT` int(11) NOT NULL,
  `MaHD` int(11) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `DonGia` double NOT NULL DEFAULT 0,
  `SoLuong` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chitiethd`
--

INSERT INTO `chitiethd` (`MaCT`, `MaHD`, `MaCTSP`, `DonGia`, `SoLuong`) VALUES
(1, 1001, 10001, 150000, 2),
(2, 1001, 10004, 350000, 1),
(3, 1002, 10006, 599000, 1),
(4, 1003, 10009, 780000, 1),
(5, 1003, 10002, 150000, 3),
(6, 1004, 10001, 150000, 8),
(7, 1004, 10011, 320000, 1),
(8, 1005, 10001, 150000, 8),
(9, 1005, 10011, 320000, 1),
(10, 1006, 10011, 320000, 1),
(11, 1007, 10001, 150000, 1),
(12, 1008, 10001, 150000, 1),
(13, 1009, 10001, 150000, 1),
(14, 1010, 10014, 550000, 1),
(15, 1011, 10014, 550000, 1),
(16, 1012, 10006, 599000, 1),
(17, 1013, 10016, 350000, 1),
(18, 1014, 10034, 410000, 2),
(19, 1015, 10029, 1800000, 1),
(20, 1015, 10036, 950000, 1),
(21, 1017, 10024, 250000, 1),
(22, 1018, 10024, 250000, 1),
(23, 1019, 10024, 250000, 1),
(24, 1020, 10041, 1500000, 19),
(25, 1021, 10024, 250000, 1),
(26, 1021, 10038, 490000, 1),
(27, 1022, 10024, 250000, 1),
(28, 1023, 10039, 190000, 3),
(29, 1024, 10041, 1500000, 1),
(30, 1024, 10145, 190000, 1),
(31, 1025, 10145, 190000, 1),
(32, 1026, 10145, 190000, 1);

-- --------------------------------------------------------

--
-- Table structure for table `chitietsp`
--

CREATE TABLE `chitietsp` (
  `MaCTSP` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `MaKC` int(11) NOT NULL,
  `SoLuongTon` int(11) NOT NULL DEFAULT 0,
  `GiaBan` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `chitietsp`
--

INSERT INTO `chitietsp` (`MaCTSP`, `MaSP`, `MaKC`, `SoLuongTon`, `GiaBan`) VALUES
(10001, 101, 1, 50, 150000),
(10002, 101, 2, 120, 150000),
(10003, 101, 3, 80, 150000),
(10004, 102, 2, 40, 350000),
(10005, 102, 3, 60, 350000),
(10006, 103, 3, 45, 599000),
(10007, 103, 4, 20, 599000),
(10008, 104, 3, 30, 420000),
(10009, 105, 4, 25, 780000),
(10010, 106, 5, 15, 290000),
(10011, 107, 2, 50, 320000),
(10012, 108, 2, 50, 380000),
(10013, 109, 3, 60, 250000),
(10014, 110, 2, 30, 550000),
(10015, 111, 2, 80, 350000),
(10016, 111, 3, 65, 350000),
(10017, 112, 2, 40, 450000),
(10018, 112, 3, 30, 450000),
(10019, 113, 3, 50, 680000),
(10020, 114, 2, 70, 480000),
(10021, 114, 3, 55, 480000),
(10022, 115, 3, 45, 520000),
(10023, 116, 5, 100, 180000),
(10024, 117, 4, 120, 250000),
(10025, 118, 2, 60, 390000),
(10026, 119, 3, 35, 720000),
(10027, 120, 2, 50, 550000),
(10028, 120, 3, 40, 550000),
(10029, 121, 4, 15, 1800000),
(10030, 122, 5, 90, 890000),
(10031, 123, 2, 95, 280000),
(10032, 123, 3, 85, 280000),
(10033, 124, 3, 50, 410000),
(10034, 124, 4, 40, 410000),
(10035, 125, 3, 60, 620000),
(10036, 126, 3, 25, 950000),
(10037, 127, 4, 20, 1200000),
(10038, 128, 5, 150, 490000),
(10039, 129, 1, 110, 190000),
(10040, 129, 2, 130, 190000),
(10041, 130, 3, 29, 1500000),
(10042, 130, 4, 25, 1500000),
(10043, 101, 4, 24, 150000),
(10044, 101, 5, 24, 150000),
(10045, 102, 1, 24, 350000),
(10046, 102, 4, 24, 350000),
(10047, 102, 5, 24, 350000),
(10048, 103, 1, 24, 599000),
(10049, 103, 2, 24, 599000),
(10050, 103, 5, 24, 599000),
(10051, 104, 1, 24, 420000),
(10052, 104, 2, 24, 420000),
(10053, 104, 4, 24, 420000),
(10054, 104, 5, 24, 420000),
(10055, 105, 1, 24, 780000),
(10056, 105, 2, 24, 780000),
(10057, 105, 3, 24, 780000),
(10058, 105, 5, 24, 780000),
(10059, 106, 1, 24, 290000),
(10060, 106, 2, 24, 290000),
(10061, 106, 3, 24, 290000),
(10062, 106, 4, 24, 290000),
(10063, 107, 1, 24, 320000),
(10064, 107, 3, 24, 320000),
(10065, 107, 4, 24, 320000),
(10066, 107, 5, 24, 320000),
(10067, 108, 1, 24, 380000),
(10068, 108, 3, 24, 380000),
(10069, 108, 4, 24, 380000),
(10070, 108, 5, 24, 380000),
(10071, 109, 1, 24, 250000),
(10072, 109, 2, 24, 250000),
(10073, 109, 4, 24, 250000),
(10074, 109, 5, 24, 250000),
(10075, 110, 1, 24, 550000),
(10076, 110, 3, 24, 550000),
(10077, 110, 4, 24, 550000),
(10078, 110, 5, 24, 550000),
(10079, 111, 1, 24, 350000),
(10080, 111, 4, 24, 350000),
(10081, 111, 5, 24, 350000),
(10082, 112, 1, 24, 450000),
(10083, 112, 4, 24, 450000),
(10084, 112, 5, 24, 450000),
(10085, 113, 1, 24, 680000),
(10086, 113, 2, 24, 680000),
(10087, 113, 4, 24, 680000),
(10088, 113, 5, 24, 680000),
(10089, 114, 1, 24, 480000),
(10090, 114, 4, 24, 480000),
(10091, 114, 5, 24, 480000),
(10092, 115, 1, 24, 520000),
(10093, 115, 2, 24, 520000),
(10094, 115, 4, 24, 520000),
(10095, 115, 5, 24, 520000),
(10096, 116, 1, 24, 180000),
(10097, 116, 2, 24, 180000),
(10098, 116, 3, 24, 180000),
(10099, 116, 4, 24, 180000),
(10100, 117, 1, 24, 250000),
(10101, 117, 2, 24, 250000),
(10102, 117, 3, 24, 250000),
(10103, 117, 5, 24, 250000),
(10104, 118, 1, 24, 390000),
(10105, 118, 3, 24, 390000),
(10106, 118, 4, 24, 390000),
(10107, 118, 5, 24, 390000),
(10108, 119, 1, 24, 720000),
(10109, 119, 2, 24, 720000),
(10110, 119, 4, 24, 720000),
(10111, 119, 5, 24, 720000),
(10112, 120, 1, 24, 550000),
(10113, 120, 4, 24, 550000),
(10114, 120, 5, 24, 550000),
(10115, 121, 1, 24, 1800000),
(10116, 121, 2, 24, 1800000),
(10117, 121, 3, 24, 1800000),
(10118, 121, 5, 24, 1800000),
(10119, 122, 1, 24, 890000),
(10120, 122, 2, 24, 890000),
(10121, 122, 3, 24, 890000),
(10122, 122, 4, 24, 890000),
(10123, 123, 1, 24, 280000),
(10124, 123, 4, 24, 280000),
(10125, 123, 5, 24, 280000),
(10126, 124, 1, 24, 410000),
(10127, 124, 2, 24, 410000),
(10128, 124, 5, 24, 410000),
(10129, 125, 1, 24, 620000),
(10130, 125, 2, 24, 620000),
(10131, 125, 4, 24, 620000),
(10132, 125, 5, 24, 620000),
(10133, 126, 1, 24, 950000),
(10134, 126, 2, 24, 950000),
(10135, 126, 4, 24, 950000),
(10136, 126, 5, 24, 950000),
(10137, 127, 1, 24, 1200000),
(10138, 127, 2, 24, 1200000),
(10139, 127, 3, 24, 1200000),
(10140, 127, 5, 24, 1200000),
(10141, 128, 1, 24, 490000),
(10142, 128, 2, 24, 490000),
(10143, 128, 3, 24, 490000),
(10144, 128, 4, 24, 490000),
(10145, 129, 3, 21, 190000),
(10146, 129, 4, 24, 190000),
(10147, 129, 5, 24, 190000),
(10148, 130, 1, 24, 1500000),
(10149, 130, 2, 24, 1500000),
(10150, 130, 5, 24, 1500000);

-- --------------------------------------------------------

--
-- Table structure for table `danhmuc`
--

CREATE TABLE `danhmuc` (
  `MaDM` int(11) NOT NULL,
  `TenDM` varchar(50) NOT NULL,
  `MoTa` text DEFAULT NULL,
  `Hinh` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `danhmuc`
--

INSERT INTO `danhmuc` (`MaDM`, `TenDM`, `MoTa`, `Hinh`) VALUES
(1, 'Áo Thun', 'Các loại áo phông, áo thun ngắn/dài tay', 'tshirt.jpg'),
(2, 'Áo Sơ Mi', 'Các loại áo sơ mi công sở và thường ngày', 'shirt.jpg'),
(3, 'Quần Jeans', 'Các loại quần bò, quần denim', 'jeans.jpg'),
(4, 'Quần Kaki', 'Các loại quần âu, quần kaki lịch sự', 'trousers.jpg'),
(5, 'Áo Khoác', 'Các loại áo khoác bomber, jacket, hoodie', 'jacket.jpg'),
(6, 'Phụ kiện', 'Cà vạt, thắt lưng, khăn, v.v.', 'accessories.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `giohang`
--

CREATE TABLE `giohang` (
  `MaGH` int(11) NOT NULL,
  `MaKH` varchar(20) NOT NULL,
  `MaCTSP` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL DEFAULT 1,
  `NgayChon` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `giohang`
--

INSERT INTO `giohang` (`MaGH`, `MaKH`, `MaCTSP`, `SoLuong`, `NgayChon`) VALUES
(34, 'KH3922b', 10041, 1, '2025-11-12 21:26:24');

-- --------------------------------------------------------

--
-- Table structure for table `hinhanhsanpham`
--

CREATE TABLE `hinhanhsanpham` (
  `MaHinhAnh` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `URLHinhAnh` varchar(255) NOT NULL,
  `IsDefault` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hinhanhsanpham`
--

INSERT INTO `hinhanhsanpham` (`MaHinhAnh`, `MaSP`, `URLHinhAnh`, `IsDefault`) VALUES
(1, 101, 'tshirt_white.webp', 1),
(2, 102, 'shirt_navy.webp', 1),
(3, 103, 'jeans_black.webp', 1),
(4, 104, 'kaki_straight.webp', 1),
(5, 105, 'bomber_black.webp', 1),
(6, 106, 'belt_leather.webp', 1),
(7, 107, 'product-1.webp', 1),
(8, 108, 'product-5.webp', 1),
(9, 109, 'product-6.webp', 1),
(10, 110, 'product-7.webp', 1),
(11, 111, 'product-15.webp', 1),
(12, 112, 'product-16.webp', 1),
(13, 113, 'product-17.webp', 1),
(14, 114, 'product-18.webp', 1),
(15, 115, 'product-19.webp', 1),
(16, 116, 'product-20.webp', 1),
(17, 117, 'product-21.webp', 1),
(18, 118, 'somi_denim_hien_dai.webp', 1),
(19, 119, 'jean_selvedge_raw.webp', 1),
(20, 120, 'khaki_nhat_slim.webp', 1),
(21, 121, 'product-22.webp', 1),
(22, 122, 'that_lung_ca_sau.webp', 1),
(23, 123, 'product-23.webp', 1),
(24, 124, 'somi_oxford_trang.webp', 1),
(25, 125, 'jean_xam_co_gian.webp', 1),
(26, 126, 'quan_tay_pleated.webp', 1),
(27, 127, 'blazer_linen_ke.webp', 1),
(28, 128, 'vi_da_bo_y.webp', 1),
(29, 129, 'product-24.webp', 1),
(30, 130, 'trench_coat_beige.webp', 1),
(32, 101, 'product-101-1.webp', 0),
(33, 101, 'product-101-2.webp', 0),
(34, 101, 'product-101-3.webp', 0),
(35, 101, 'product-101-4.webp', 0),
(36, 102, 'product-102-1.webp', 0),
(37, 102, 'product-102-2.webp', 0),
(38, 102, 'product-102-3.webp', 0),
(39, 102, 'product-102-4.webp', 0),
(40, 103, 'product-103-1.webp', 0),
(41, 103, 'product-103-2.webp', 0),
(42, 103, 'product-103-3.webp', 0),
(43, 103, 'product-103-4.webp', 0),
(44, 104, 'product-104-1.webp', 0),
(45, 104, 'product-104-2.webp', 0),
(46, 104, 'product-104-3.webp', 0),
(47, 104, 'product-104-4.webp', 0),
(48, 105, 'product-105-1.webp', 0),
(49, 105, 'product-105-2.webp', 0),
(50, 105, 'product-105-3.webp', 0),
(51, 105, 'product-105-4.webp', 0),
(52, 106, 'product-106-1.webp', 0),
(53, 106, 'product-106-2.webp', 0),
(54, 106, 'product-106-3.webp', 0),
(55, 106, 'product-106-4.webp', 0),
(56, 107, 'product-107-1.webp', 0),
(57, 107, 'product-107-2.webp', 0),
(58, 107, 'product-107-3.webp', 0),
(59, 107, 'product-107-4.webp', 0),
(60, 108, 'product-108-1.webp', 0),
(61, 108, 'product-108-2.webp', 0),
(62, 108, 'product-108-3.webp', 0),
(63, 108, 'product-108-4.webp', 0),
(64, 109, 'product-109-1.webp', 0),
(65, 109, 'product-109-2.webp', 0),
(66, 109, 'product-109-3.webp', 0),
(67, 109, 'product-109-4.webp', 0),
(68, 110, 'product-110-1.webp', 0),
(69, 110, 'product-110-2.webp', 0),
(70, 110, 'product-110-3.webp', 0),
(71, 110, 'product-110-4.webp', 0),
(72, 111, 'product-111-1.webp', 0),
(73, 111, 'product-111-2.webp', 0),
(74, 111, 'product-111-3.webp', 0),
(75, 111, 'product-111-4.webp', 0),
(76, 112, 'product-112-1.webp', 0),
(77, 112, 'product-112-2.webp', 0),
(78, 112, 'product-112-3.webp', 0),
(79, 112, 'product-112-4.webp', 0),
(80, 113, 'product-113-1.webp', 0),
(81, 113, 'product-113-2.webp', 0),
(82, 113, 'product-113-3.webp', 0),
(83, 113, 'product-113-4.webp', 0),
(84, 114, 'product-114-1.webp', 0),
(85, 114, 'product-114-2.webp', 0),
(86, 114, 'product-114-3.webp', 0),
(87, 114, 'product-114-4.webp', 0),
(88, 115, 'product-115-1.webp', 0),
(89, 115, 'product-115-2.webp', 0),
(90, 115, 'product-115-3.webp', 0),
(91, 115, 'product-115-4.webp', 0),
(92, 116, 'product-116-1.webp', 0),
(93, 116, 'product-116-2.webp', 0),
(94, 116, 'product-116-3.webp', 0),
(95, 116, 'product-116-4.webp', 0),
(96, 117, 'product-117-1.webp', 0),
(97, 117, 'product-117-2.webp', 0),
(98, 117, 'product-117-3.webp', 0),
(99, 117, 'product-117-4.webp', 0),
(100, 118, 'product-118-1.webp', 0),
(101, 118, 'product-118-2.webp', 0),
(102, 118, 'product-118-3.webp', 0),
(103, 118, 'product-118-4.webp', 0),
(104, 119, 'product-119-1.webp', 0),
(105, 119, 'product-119-2.webp', 0),
(106, 119, 'product-119-3.webp', 0),
(107, 119, 'product-119-4.webp', 0),
(108, 120, 'product-120-1.webp', 0),
(109, 120, 'product-120-2.webp', 0),
(110, 120, 'product-120-3.webp', 0),
(111, 120, 'product-120-4.webp', 0),
(112, 121, 'product-121-1.webp', 0),
(113, 121, 'product-121-2.webp', 0),
(114, 121, 'product-121-3.webp', 0),
(115, 121, 'product-121-4.webp', 0),
(116, 122, 'product-122-1.webp', 0),
(117, 122, 'product-122-2.webp', 0),
(118, 122, 'product-122-3.webp', 0),
(119, 122, 'product-122-4.webp', 0),
(120, 123, 'product-123-1.webp', 0),
(121, 123, 'product-123-2.webp', 0),
(122, 123, 'product-123-3.webp', 0),
(123, 123, 'product-123-4.webp', 0),
(124, 124, 'product-124-1.webp', 0),
(125, 124, 'product-124-2.webp', 0),
(126, 124, 'product-124-3.webp', 0),
(127, 124, 'product-124-4.webp', 0),
(128, 125, 'product-125-1.webp', 0),
(129, 125, 'product-125-2.webp', 0),
(130, 125, 'product-125-3.webp', 0),
(131, 125, 'product-125-4.webp', 0),
(132, 126, 'product-126-1.webp', 0),
(133, 126, 'product-126-2.webp', 0),
(134, 126, 'product-126-3.webp', 0),
(135, 126, 'product-126-4.webp', 0),
(136, 127, 'product-127-1.webp', 0),
(137, 127, 'product-127-2.webp', 0),
(138, 127, 'product-127-3.webp', 0),
(139, 127, 'product-127-4.webp', 0),
(140, 128, 'product-128-1.webp', 0),
(141, 128, 'product-128-2.webp', 0),
(142, 128, 'product-128-3.webp', 0),
(143, 128, 'product-128-4.webp', 0),
(144, 129, 'product-129-1.webp', 0),
(145, 129, 'product-129-2.webp', 0),
(146, 129, 'product-129-3.webp', 0),
(147, 129, 'product-129-4.webp', 0),
(148, 130, 'product-130-1.webp', 0),
(149, 130, 'product-130-2.webp', 0),
(150, 130, 'product-130-3.webp', 0),
(151, 130, 'product-130-4.webp', 0);

-- --------------------------------------------------------

--
-- Table structure for table `hoadon`
--

CREATE TABLE `hoadon` (
  `MaHD` int(11) NOT NULL,
  `MaKH` varchar(20) NOT NULL,
  `NgayDat` datetime NOT NULL DEFAULT current_timestamp(),
  `NgayCan` datetime DEFAULT NULL,
  `NgayGiao` datetime DEFAULT NULL,
  `TenNguoiNhan` varchar(50) DEFAULT NULL,
  `DiaChiGiaoHang` varchar(60) NOT NULL,
  `CachThanhToan` varchar(50) NOT NULL DEFAULT 'Tiền mặt',
  `CachVanChuyen` varchar(50) NOT NULL DEFAULT 'Chuyển phát nhanh',
  `PhiVanChuyen` double NOT NULL DEFAULT 0,
  `MaTrangThai` int(11) NOT NULL DEFAULT 0,
  `MaNV` varchar(50) DEFAULT NULL,
  `GhiChu` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hoadon`
--

INSERT INTO `hoadon` (`MaHD`, `MaKH`, `NgayDat`, `NgayCan`, `NgayGiao`, `TenNguoiNhan`, `DiaChiGiaoHang`, `CachThanhToan`, `CachVanChuyen`, `PhiVanChuyen`, `MaTrangThai`, `MaNV`, `GhiChu`) VALUES
(1001, 'KH001', '2025-10-26 10:00:00', '2025-10-30 00:00:00', '2025-10-28 00:00:00', 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Chuyển khoản', 'Giao hàng nhanh', 30000, 3, 'nv01', 'Gọi trước khi giao'),
(1002, 'KH003', '2025-10-28 15:30:00', '2025-11-05 00:00:00', '2025-10-31 00:00:00', 'Hoàng Minh Trung', '789 Nguyễn Văn Linh, Đà Nẵng', 'Tiền mặt', 'Giao hàng tiêu chuẩn', 45000, 3, 'nv02', ''),
(1003, 'KH001', '2025-11-03 09:00:00', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Giao hàng nhanh', 30000, 0, 'nv01', 'Đơn hàng mới nhất'),
(1004, 'KH001', '2025-11-04 09:50:43', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, ''),
(1005, 'KH001', '2025-11-04 09:54:05', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1006, 'KH001', '2025-11-04 09:57:47', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Chuyển khoản', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1007, 'KH001', '2025-11-04 10:09:39', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1008, 'KH001', '2025-11-04 10:10:29', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1009, 'KH001', '2025-11-04 10:12:40', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1010, 'KH001', '2025-11-04 10:14:37', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1011, 'KH001', '2025-11-04 10:15:41', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, ''),
(1012, 'KH001', '2025-11-04 10:16:03', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, ''),
(1013, 'KH004', '2025-11-04 15:00:00', '2025-11-08 00:00:00', NULL, 'Trần Văn Kiên', '30 Đường Lê Lợi, Huế', 'Tiền mặt', 'Chuyển phát nhanh', 40000, 1, 'nv01', 'Đã thanh toán'),
(1014, 'KH005', '2025-11-04 16:30:00', '2025-11-07 00:00:00', NULL, 'Nguyễn Thị Hương', '678 Phố Hàng Bài, Hoàn Kiếm, Hà Nội', 'Chuyển khoản', 'Giao hàng nhanh', 35000, 0, NULL, ''),
(1015, 'KH003', '2025-11-04 17:00:00', '2025-11-10 00:00:00', '2025-11-07 00:00:00', 'Hoàng Minh Trung', '789 Nguyễn Văn Linh, Đà Nẵng', 'Tiền mặt', 'Giao hàng tiêu chuẩn', 45000, 3, 'nv02', 'Đơn hàng lớn'),
(1016, 'KH001', '2025-11-04 17:30:00', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, ''),
(1017, 'KH002', '2025-11-04 18:00:00', NULL, NULL, 'Đào Thị Linh', '456 Phố Tràng Tiền, Hoàn Kiếm, Hà Nội', 'Chuyển khoản', 'Giao hàng nhanh', 30000, 2, 'nv01', 'Cần đóng gói cẩn thận'),
(1018, 'KH001', '2025-11-06 12:56:05', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1019, 'KH001', '2025-11-06 13:26:18', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1020, 'KH001', '2025-11-06 13:30:54', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1021, 'KH001', '2025-11-12 08:42:30', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'priiiii'),
(1022, 'KH001', '2025-11-12 08:44:47', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1023, 'KH001', '2025-11-12 09:22:26', NULL, NULL, 'Lê Văn Phát', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1024, 'KH3922b', '2025-11-12 20:00:01', NULL, NULL, 'Nguyễn Thị Thu', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'giao trong thời gian ngắn'),
(1025, 'KH3922b', '2025-11-12 20:02:25', NULL, NULL, 'Nguyễn Thị Thu', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'jk'),
(1026, 'KH3922b', '2025-11-12 20:10:37', NULL, NULL, 'Nguyễn Thị Thu', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', 'Tiền mặt', 'Chuyển phát nhanh', 0, 0, NULL, 'jk');

-- --------------------------------------------------------

--
-- Table structure for table `khachhang`
--

CREATE TABLE `khachhang` (
  `MaKH` varchar(20) NOT NULL,
  `MatKhau` varchar(50) DEFAULT NULL,
  `HoTen` varchar(50) NOT NULL,
  `GioiTinh` tinyint(1) NOT NULL DEFAULT 0,
  `NgaySinh` datetime NOT NULL DEFAULT current_timestamp(),
  `DiaChi` varchar(60) DEFAULT NULL,
  `DienThoai` varchar(24) DEFAULT NULL,
  `Email` varchar(50) NOT NULL,
  `HieuLuc` tinyint(1) NOT NULL DEFAULT 0,
  `VaiTro` int(11) NOT NULL DEFAULT 0 COMMENT '0: Khach Hang'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `khachhang`
--

INSERT INTO `khachhang` (`MaKH`, `MatKhau`, `HoTen`, `GioiTinh`, `NgaySinh`, `DiaChi`, `DienThoai`, `Email`, `HieuLuc`, `VaiTro`) VALUES
('KH001', 'pass123', 'Lê Văn Phát', 0, '1995-12-01 00:00:00', '123 Đường Nam Kỳ Khởi Nghĩa, Q.3, TP.HCM', '0901112223', 'phatle@mail.com', 1, 0),
('KH002', 'pass123', 'Đào Thị Linh', 1, '2000-05-15 00:00:00', '456 Phố Tràng Tiền, Hoàn Kiếm, Hà Nội', '0987334455', 'linhdao@mail.com', 1, 0),
('KH003', 'pass123', 'Hoàng Minh Trung', 0, '1990-01-20 00:00:00', '789 Nguyễn Văn Linh, Đà Nẵng', '0912667788', 'trunghm@mail.com', 1, 0),
('KH004', 'pass123', 'Trần Văn Kiên', 0, '1998-08-25 00:00:00', '30 Đường Lê Lợi, Huế', '0919445566', 'kientv@mail.com', 1, 0),
('KH005', 'pass123', 'Nguyễn Thị Hương', 1, '1992-03-10 00:00:00', '678 Phố Hàng Bài, Hoàn Kiếm, Hà Nội', '0977889900', 'huongnt@mail.com', 1, 0),
('KH3922b', '123456', 'Nguyễn Thị Thu', 0, '2000-01-01 00:00:00', '', '', 'hoang@gmail.com', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `kichco`
--

CREATE TABLE `kichco` (
  `MaKC` int(11) NOT NULL,
  `TenKichCo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kichco`
--

INSERT INTO `kichco` (`MaKC`, `TenKichCo`) VALUES
(3, 'L'),
(2, 'M'),
(1, 'S'),
(4, 'XL'),
(5, 'XXL');

-- --------------------------------------------------------

--
-- Table structure for table `lienhe`
--

CREATE TABLE `lienhe` (
  `MaLienHe` int(11) NOT NULL,
  `TenNguoiGui` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `NoiDung` text NOT NULL,
  `NgayGui` timestamp NOT NULL DEFAULT current_timestamp(),
  `DaDoc` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0=Chưa đọc, 1=Đã đọc'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lienhe`
--

INSERT INTO `lienhe` (`MaLienHe`, `TenNguoiGui`, `Email`, `NoiDung`, `NgayGui`, `DaDoc`) VALUES
(1, 'BÙi trường Linh', 'tva@shop.com', 'iregyedhgfjhd d', '2025-11-09 11:19:11', 0),
(2, 'Bùi trường thọ', 'Tho12121@gmail.com', 'mee keep that vai ca chưởng\r\n', '2025-11-12 13:41:58', 0),
(3, 'Bùi trường thọ', 'Tho12121@gmail.com', 'mee keep that vai ca chưởng\r\n', '2025-11-12 13:43:32', 0);

-- --------------------------------------------------------

--
-- Table structure for table `nhacc`
--

CREATE TABLE `nhacc` (
  `MaNCC` varchar(50) NOT NULL,
  `TenCty` varchar(50) NOT NULL,
  `TenLH` varchar(50) DEFAULT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(50) DEFAULT NULL,
  `DiaChi` varchar(50) DEFAULT NULL,
  `MoTa` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhacc`
--

INSERT INTO `nhacc` (`MaNCC`, `TenCty`, `TenLH`, `Email`, `Phone`, `DiaChi`, `MoTa`) VALUES
('AP', 'Vải Sợi Miền Nam', 'Petter Pike', 'pike@fashion.com', '0987345876', '765 Fashion Place, HCM, VN', 'Chuyên cung cấp vải và phụ liệu cao cấp'),
('NK', 'Garment NK Corp', 'Okawa', 'okawa@nokiag.com', '0913745789', '123 Revenue, Tokyo, Japan', 'Chuyên cung cấp quần áo nhập khẩu'),
('SM', 'May Mặc Seamen', 'David Brown', 'brown@seamen.com', '0987456876', '23 New World, Ha Noi, VN', 'Công ty thời trang may mặc lớn');

-- --------------------------------------------------------

--
-- Table structure for table `nhanvien`
--

CREATE TABLE `nhanvien` (
  `MaNV` varchar(50) NOT NULL,
  `HoTen` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `MatKhau` varchar(50) DEFAULT NULL,
  `VaiTro` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhanvien`
--

INSERT INTO `nhanvien` (`MaNV`, `HoTen`, `Email`, `MatKhau`, `VaiTro`) VALUES
('admin01', 'Quản Trị Viên', 'admin@shop.com', 'adminpass', 2),
('nv01', 'Trần Văn A', 'tva@shop.com', '123456', 2),
('nv02', 'Nguyễn Thị B', 'ntb@shop.com', '123456', 2);

-- --------------------------------------------------------

--
-- Table structure for table `sanpham`
--

CREATE TABLE `sanpham` (
  `MaSP` int(11) NOT NULL,
  `TenSP` varchar(50) NOT NULL,
  `MaDM` int(11) NOT NULL,
  `MoTaDonVi` varchar(50) DEFAULT NULL,
  `GiaCoBan` double DEFAULT 0,
  `NgaySanXuat` datetime NOT NULL DEFAULT current_timestamp(),
  `LuotXem` int(11) NOT NULL DEFAULT 0,
  `MoTa` text DEFAULT NULL,
  `MaNCC` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sanpham`
--

INSERT INTO `sanpham` (`MaSP`, `TenSP`, `MaDM`, `MoTaDonVi`, `GiaCoBan`, `NgaySanXuat`, `LuotXem`, `MoTa`, `MaNCC`) VALUES
(101, 'Áo Thun Cổ Tròn Trắng', 1, '1 cái', 150000, '2025-10-01 10:00:00', 300, 'Áo thun cổ tròn trắng được chế tác từ 100% cotton tự nhiên cao cấp, mang đến cảm giác mềm mại và thoáng mát tuyệt đối. Kiểu dáng tối giản nhưng tinh tế, tôn lên vẻ thanh lịch của phái mạnh. Phù hợp cho mọi hoàn cảnh – từ dạo phố nhẹ nhàng đến những buổi hẹn sang trọng.', 'AP'),
(102, 'Sơ Mi Dài Tay Xanh Navy', 2, '1 cái', 350000, '2025-10-05 10:00:00', 300, 'Áo sơ mi dài tay xanh navy được may từ vải Oxford nhập khẩu, bề mặt mịn và đứng form tự nhiên. Màu xanh trầm mang lại vẻ lịch lãm, trưởng thành. Sản phẩm lý tưởng cho những quý ông yêu thích phong cách tinh gọn, hiện đại và đầy tự tin.', 'SM'),
(103, 'Quần Jeans Slimfit Đen', 3, '1 cái', 599000, '2025-10-10 10:00:00', 200, 'Quần jeans đen dáng slimfit được dệt từ denim Nhật cao cấp, độ co giãn hoàn hảo giúp ôm vừa vặn nhưng vẫn thoải mái. Màu đen tuyền sang trọng dễ phối đồ, thích hợp cho cả môi trường công sở lẫn các buổi gặp gỡ thân mật. Một biểu tượng của sự nam tính tinh tế.', 'AP'),
(104, 'Quần Kaki Ống Đứng Be', 4, '1 cái', 420000, '2025-10-15 10:00:00', 50, 'Quần kaki ống đứng màu be trung tính, được chế tác từ cotton pha spandex mịn nhẹ. Đường may tỉ mỉ, dáng quần đứng thanh thoát giúp tôn dáng người mặc. Mẫu thiết kế lý tưởng cho phong cách smart-casual đậm chất quý ông thành đạt.', 'SM'),
(105, 'Áo Khoác Bomber Đen', 5, '1 cái', 780000, '2025-10-20 10:00:00', 120, 'Áo khoác bomber đen làm từ chất liệu vải dệt dày cao cấp, lớp lót mềm mại tạo cảm giác ấm áp. Phong cách thiết kế đậm hơi thở châu Âu, vừa năng động vừa tinh tế. Một lựa chọn hoàn hảo cho những buổi tối sang trọng nhưng vẫn trẻ trung.', 'AP'),
(106, 'Thắt Lưng Da Nâu', 6, '1 dây', 290000, '2025-10-25 10:00:00', 250, 'Thắt lưng da bò thật màu nâu trầm, được chế tác thủ công từ da Ý với mặt khóa kim loại mạ sáng sang trọng. Đường cắt gọn gàng, tinh xảo thể hiện sự tỉ mỉ và đẳng cấp. Phù hợp hoàn hảo cho bộ vest hoặc trang phục công sở cao cấp.', 'NK'),
(107, 'Áo Polo Thể Thao', 1, NULL, 320000, '2025-11-03 10:00:00', 0, 'Áo polo thể thao được dệt từ sợi cotton premium co giãn bốn chiều, mang lại cảm giác nhẹ nhàng và thoáng mát. Kiểu cổ polo cổ điển được làm mới với form dáng tinh tế, thích hợp cho quý ông yêu thích sự năng động nhưng vẫn giữ phong thái thanh lịch.', 'SM'),
(108, 'Áo Len Cổ Lọ Cũ', 1, NULL, 380000, '2025-09-01 10:00:00', 10, 'Áo len cổ lọ được dệt từ sợi len tự nhiên pha cashmere, đem đến sự mềm mại, ấm áp và sang trọng. Thiết kế ôm dáng vừa vặn, tôn lên nét lịch lãm và tự tin của người đàn ông hiện đại. Hoàn hảo khi phối cùng blazer hoặc trench coat cao cấp.', 'AP'),
(109, 'Quần Short Kaki Cũ', 4, NULL, 250000, '2025-09-05 10:00:00', 20, 'Quần short kaki cao cấp với phom dáng vừa vặn, được may từ vải cotton mềm mịn giúp cử động linh hoạt. Tông màu trung tính dễ phối, mang lại vẻ thanh thoát và phóng khoáng cho mùa hè. Một thiết kế tinh tế cho phong cách nghỉ dưỡng sang trọng.', 'SM'),
(110, 'Áo Hoodie Nỉ Mới', 5, NULL, 550000, '2025-11-05 10:00:00', 5, 'Áo hoodie nỉ được dệt từ cotton dày mịn kết hợp với polyester chống nhăn. Thiết kế tối giản với những đường may ẩn tinh tế, mang đến vẻ hiện đại và đẳng cấp. Lý tưởng cho những buổi dạo phố thu – đông mang phong cách Âu châu thanh lịch.', 'AP'),
(111, 'Áo Thun Polo Kẻ Sọc', 1, '1 cái', 350000, '2025-11-06 10:00:00', 150, 'Áo polo kẻ sọc làm từ sợi cotton cao cấp, mềm mại và giữ form tuyệt vời. Họa tiết kẻ nhỏ tinh tế kết hợp cổ bẻ cứng cáp tạo nên phong thái nam tính, thanh lịch. Dành cho người đàn ông đề cao sự tinh gọn và gu thẩm mỹ hiện đại.', 'SM'),
(112, 'Sơ Mi Lụa Họa Tiết Hoa', 2, '1 cái', 450000, '2025-11-06 11:00:00', 80, 'Áo sơ mi lụa họa tiết hoa độc bản, được dệt từ sợi lụa cao cấp mang độ bóng nhẹ và cảm giác mượt mà. Mẫu thiết kế mang hơi hướng Ý, giúp tôn lên nét nghệ sĩ và phong độ của quý ông tinh tế. Phù hợp cho những buổi tiệc tối hoặc sự kiện đặc biệt.', 'NK'),
(113, 'Quần Jeans Rách Gối Xanh Nhạt', 3, '1 cái', 680000, '2025-11-07 09:00:00', 220, 'Quần jeans rách gối xanh nhạt, chế tác từ denim cao cấp wash nhẹ tạo hiệu ứng tự nhiên. Đường cắt tinh xảo, tôn dáng và mang đậm phong cách phóng khoáng. Một thiết kế dành riêng cho quý ông tự tin, hiện đại và có cá tính mạnh mẽ.', 'AP'),
(114, 'Quần Kaki Slimfit Đen', 4, '1 cái', 480000, '2025-11-07 10:00:00', 180, 'Quần kaki đen slimfit được may từ cotton cao cấp pha elastane, co giãn và giữ nếp hoàn hảo. Gam đen kinh điển mang lại vẻ bí ẩn, sang trọng. Là món đồ không thể thiếu cho phong cách tối giản tinh tế của phái mạnh.', 'SM'),
(115, 'Áo Khoác Hoodie Nỉ Xám', 5, '1 cái', 520000, '2025-11-08 12:00:00', 110, 'Áo khoác hoodie nỉ xám dày dặn, mang đến cảm giác ấm áp và mềm mại tuyệt đối. Thiết kế tối giản tinh tế, màu xám nhã nhặn phù hợp với phong cách tối giản Bắc Âu. Một lựa chọn tinh tế cho mùa lạnh, vừa tiện dụng vừa đẳng cấp.', 'AP'),
(116, 'Cà Vạt Lụa Chấm Bi Xanh', 6, '1 dây', 180000, '2025-11-08 13:00:00', 60, 'Cà vạt lụa xanh chấm bi được dệt từ lụa tơ tằm cao cấp, bóng nhẹ và mềm mại. Họa tiết nhỏ tinh tế tạo điểm nhấn thanh lịch cho bộ suit. Món phụ kiện biểu tượng cho gu thẩm mỹ của người đàn ông thành đạt.', 'NK'),
(117, 'Áo Thun Oversize Đen', 1, '1 cái', 250000, '2025-11-09 14:00:00', 350, 'Áo thun oversize đen từ cotton cao cấp co giãn, mềm mại nhưng giữ phom vững vàng. Thiết kế tối giản, tạo vẻ ngoài phóng khoáng mà vẫn tinh tế. Phù hợp cho quý ông yêu thích phong cách đương đại với tinh thần tự do đầy cuốn hút.', 'SM'),
(118, 'Sơ Mi Denim Tay Ngắn', 2, '1 cái', 390000, '2025-11-09 15:00:00', 140, 'Áo sơ mi denim tay ngắn được hoàn thiện tỉ mỉ từ vải denim dày dặn. Màu xanh đậm cổ điển kết hợp cúc kim loại mang lại vẻ mạnh mẽ, lịch lãm. Một lựa chọn hoàn hảo giữa nét cổ điển và tinh thần hiện đại.', 'AP'),
(119, 'Quần Jeans Dáng Suông Selvedge', 3, '1 cái', 720000, '2025-11-10 16:00:00', 90, 'Quần jeans dáng suông Selvedge cao cấp với đường biên nguyên bản đặc trưng. Denim thô Nhật Bản mang lại độ bền vượt trội và phong thái trầm tĩnh. Thiết kế tôn dáng, tạo nên vẻ đẹp nam tính, mạnh mẽ nhưng vẫn tinh tế.', 'SM'),
(120, 'Quần Kaki Jogger Màu Xanh', 4, '1 cái', 550000, '2025-11-10 17:00:00', 170, 'Quần kaki jogger màu xanh olive được cắt may tỉ mỉ từ vải cotton pha co giãn. Thiết kế bo gấu tinh tế, mang lại sự thoải mái nhưng vẫn giữ phong thái thanh lịch. Một item lý tưởng cho phong cách smart-casual hiện đại.', 'NK'),
(121, 'Áo Khoác Da Biker Cao Cấp', 5, '1 cái', 1800000, '2025-11-11 18:00:00', 40, 'Áo khoác da biker được làm từ da thật 100%, bề mặt mịn tự nhiên và bền bỉ. Đường cắt gọn gàng, khóa kéo kim loại tạo điểm nhấn mạnh mẽ. Mẫu áo biểu trưng cho sự tự tin, bản lĩnh và đẳng cấp phái mạnh.', 'AP'),
(122, 'Thắt Lưng Da Cá Sấu Đen', 6, '1 dây', 890000, '2025-11-11 19:00:00', 70, 'Thắt lưng da cá sấu đen sang trọng, được chế tác thủ công với lớp da tự nhiên mềm mịn và mặt khóa hợp kim sáng bóng. Mỗi chi tiết đều toát lên sự tinh tế và đẳng cấp vượt thời gian. Hoàn hảo khi kết hợp cùng suit cao cấp.', 'SM'),
(123, 'Áo Thun Tay Dài Trắng Basic', 1, '1 cái', 280000, '2025-11-12 20:00:00', 160, 'Áo thun tay dài trắng basic làm từ cotton hữu cơ cao cấp, bề mặt mịn và nhẹ. Phom dáng ôm nhẹ giúp tôn dáng tự nhiên. Một thiết kế tối giản nhưng sang trọng, lý tưởng cho phong cách tinh tế hằng ngày.', 'NK'),
(124, 'Sơ Mi Oxford Kẻ Caro Xanh', 2, '1 cái', 410000, '2025-11-12 21:00:00', 130, 'Áo sơ mi Oxford kẻ caro xanh, vải dày dặn nhập khẩu, giữ form tốt và thoáng khí. Họa tiết caro tinh tế mang đậm phong cách quý ông châu Âu. Phối cùng quần kaki hoặc jeans để hoàn thiện vẻ ngoài thanh lịch và tự tin.', 'AP'),
(125, 'Quần Jeans Xám Co Giãn', 3, '1 cái', 620000, '2025-11-13 10:00:00', 200, 'Quần jeans xám cao cấp với độ co giãn hoàn hảo, mang đến cảm giác thoải mái và dáng đứng thanh lịch. Màu xám trung tính tạo nên phong cách trầm ổn, hiện đại. Một lựa chọn tinh tế cho người đàn ông biết mình muốn gì.', 'SM'),
(126, 'Quần Tây Wool Pleated Xám', 4, '1 cái', 950000, '2025-11-13 11:00:00', 55, 'Quần tây wool xám được may từ vải wool nhập khẩu, bề mặt mịn, nhẹ và thoáng. Nếp ly tinh tế tạo điểm nhấn cổ điển sang trọng. Sự kết hợp hoàn hảo giữa phong cách Anh quốc và tinh thần hiện đại.', 'NK'),
(127, 'Áo Blazer Linen Kẻ Sọc', 5, '1 cái', 1200000, '2025-11-14 12:00:00', 45, 'Áo blazer linen kẻ sọc được dệt từ sợi linen tự nhiên cao cấp, mang lại cảm giác thoáng mát và tinh tế. Kiểu dáng slimfit giúp tôn dáng, các chi tiết được may đo chuẩn xác. Phù hợp cho doanh nhân hoặc các buổi gặp gỡ sang trọng.', 'AP'),
(128, 'Ví Da Bò Ý Cao Cấp', 6, '1 cái', 490000, '2025-11-14 13:00:00', 190, 'Ví da bò Ý cao cấp được làm từ da thật nguyên tấm, bề mặt mịn tự nhiên với độ bóng nhẹ. Thiết kế tối giản, thanh thoát, mang hơi hướng cổ điển. Một phụ kiện nhỏ nhưng thể hiện rõ gu thẩm mỹ và đẳng cấp phái mạnh.', 'SM'),
(129, 'Áo Thun Basic Xanh Navy', 1, '1 cái', 190000, '2025-11-15 14:00:00', 270, 'Áo thun basic xanh navy được chế tác từ cotton co giãn cao cấp, bề mặt mịn, thấm hút tốt. Tông màu navy trầm tinh tế dễ phối, tạo nên vẻ thanh lịch nhẹ nhàng. Lý tưởng cho phong cách tối giản đậm chất châu Âu.', 'NK'),
(130, 'Áo Khoác Trench Coat Beige', 5, '1 cái', 1500000, '2025-11-15 15:00:00', 75, 'Áo khoác trench coat màu beige cổ điển, được may từ vải cotton chống thấm nhẹ, đường may tinh xảo. Form dáng dài kết hợp đai eo tôn dáng sang trọng. Một biểu tượng vượt thời gian của phong cách quý ông thanh lịch.', 'AP');

-- --------------------------------------------------------

--
-- Table structure for table `trangthaidonhang`
--

CREATE TABLE `trangthaidonhang` (
  `MaTrangThai` int(11) NOT NULL,
  `TenTrangThai` varchar(50) NOT NULL,
  `MoTa` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `trangthaidonhang`
--

INSERT INTO `trangthaidonhang` (`MaTrangThai`, `TenTrangThai`, `MoTa`) VALUES
(-1, 'Khách hàng hủy', 'Đơn hàng bị khách hàng hủy'),
(0, 'Mới đặt hàng', 'Đơn hàng vừa được tạo, chờ xác nhận'),
(1, 'Đã thanh toán', 'Đã nhận được thanh toán từ khách hàng'),
(2, 'Chờ giao hàng', 'Đã chuẩn bị xong hàng, chờ đơn vị vận chuyển'),
(3, 'Đã giao hàng', 'Hoàn tất giao và nhận hàng');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chitiethd`
--
ALTER TABLE `chitiethd`
  ADD PRIMARY KEY (`MaCT`),
  ADD UNIQUE KEY `UK_ChiTietHD` (`MaHD`,`MaCTSP`),
  ADD KEY `FK_ChiTietHD_MaCTSP` (`MaCTSP`);

--
-- Indexes for table `chitietsp`
--
ALTER TABLE `chitietsp`
  ADD PRIMARY KEY (`MaCTSP`),
  ADD UNIQUE KEY `UK_chitietsp` (`MaSP`,`MaKC`),
  ADD KEY `FK_chitietsp_MaKC` (`MaKC`);

--
-- Indexes for table `danhmuc`
--
ALTER TABLE `danhmuc`
  ADD PRIMARY KEY (`MaDM`);

--
-- Indexes for table `giohang`
--
ALTER TABLE `giohang`
  ADD PRIMARY KEY (`MaGH`),
  ADD UNIQUE KEY `UK_GioHang` (`MaKH`,`MaCTSP`),
  ADD KEY `FK_GioHang_CTSP` (`MaCTSP`);

--
-- Indexes for table `hinhanhsanpham`
--
ALTER TABLE `hinhanhsanpham`
  ADD PRIMARY KEY (`MaHinhAnh`),
  ADD KEY `FK_HinhAnh_SanPham` (`MaSP`);

--
-- Indexes for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD PRIMARY KEY (`MaHD`),
  ADD KEY `FK_HoaDon_KhachHang` (`MaKH`),
  ADD KEY `FK_HoaDon_TrangThai` (`MaTrangThai`),
  ADD KEY `FK_HoaDon_NhanVien` (`MaNV`);

--
-- Indexes for table `khachhang`
--
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`MaKH`),
  ADD UNIQUE KEY `UK_KhachHang_Email` (`Email`);

--
-- Indexes for table `kichco`
--
ALTER TABLE `kichco`
  ADD PRIMARY KEY (`MaKC`),
  ADD UNIQUE KEY `UK_TenKichCo` (`TenKichCo`);

--
-- Indexes for table `lienhe`
--
ALTER TABLE `lienhe`
  ADD PRIMARY KEY (`MaLienHe`);

--
-- Indexes for table `nhacc`
--
ALTER TABLE `nhacc`
  ADD PRIMARY KEY (`MaNCC`);

--
-- Indexes for table `nhanvien`
--
ALTER TABLE `nhanvien`
  ADD PRIMARY KEY (`MaNV`),
  ADD UNIQUE KEY `UK_NhanVien_Email` (`Email`);

--
-- Indexes for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSP`),
  ADD KEY `FK_SanPhams_DanhMuc` (`MaDM`),
  ADD KEY `FK_SanPhams_NhaCungCap` (`MaNCC`);

--
-- Indexes for table `trangthaidonhang`
--
ALTER TABLE `trangthaidonhang`
  ADD PRIMARY KEY (`MaTrangThai`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chitiethd`
--
ALTER TABLE `chitiethd`
  MODIFY `MaCT` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `chitietsp`
--
ALTER TABLE `chitietsp`
  MODIFY `MaCTSP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10151;

--
-- AUTO_INCREMENT for table `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `MaDM` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `giohang`
--
ALTER TABLE `giohang`
  MODIFY `MaGH` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `hinhanhsanpham`
--
ALTER TABLE `hinhanhsanpham`
  MODIFY `MaHinhAnh` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT for table `hoadon`
--
ALTER TABLE `hoadon`
  MODIFY `MaHD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1027;

--
-- AUTO_INCREMENT for table `kichco`
--
ALTER TABLE `kichco`
  MODIFY `MaKC` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lienhe`
--
ALTER TABLE `lienhe`
  MODIFY `MaLienHe` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `MaSP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chitiethd`
--
ALTER TABLE `chitiethd`
  ADD CONSTRAINT `FK_ChiTietHD_ChiTietSP` FOREIGN KEY (`MaCTSP`) REFERENCES `chitietsp` (`MaCTSP`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_ChiTietHD_HoaDon` FOREIGN KEY (`MaHD`) REFERENCES `hoadon` (`MaHD`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `chitietsp`
--
ALTER TABLE `chitietsp`
  ADD CONSTRAINT `FK_chitietsp_MaKC` FOREIGN KEY (`MaKC`) REFERENCES `kichco` (`MaKC`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_chitietsp_MaSP` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `giohang`
--
ALTER TABLE `giohang`
  ADD CONSTRAINT `FK_GioHang_CTSP` FOREIGN KEY (`MaCTSP`) REFERENCES `chitietsp` (`MaCTSP`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_GioHang_KhachHang` FOREIGN KEY (`MaKH`) REFERENCES `khachhang` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hinhanhsanpham`
--
ALTER TABLE `hinhanhsanpham`
  ADD CONSTRAINT `FK_HinhAnh_SanPham` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD CONSTRAINT `FK_HoaDon_KhachHang` FOREIGN KEY (`MaKH`) REFERENCES `khachhang` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_HoaDon_NhanVien` FOREIGN KEY (`MaNV`) REFERENCES `nhanvien` (`MaNV`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_HoaDon_TrangThai` FOREIGN KEY (`MaTrangThai`) REFERENCES `trangthaidonhang` (`MaTrangThai`) ON UPDATE CASCADE;

--
-- Constraints for table `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `FK_SanPhams_DanhMuc` FOREIGN KEY (`MaDM`) REFERENCES `danhmuc` (`MaDM`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_SanPhams_nhacc` FOREIGN KEY (`MaNCC`) REFERENCES `nhacc` (`MaNCC`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
