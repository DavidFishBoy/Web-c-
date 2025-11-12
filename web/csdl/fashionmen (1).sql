-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 05, 2025 at 02:31 PM
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
(21, 1017, 10024, 250000, 1);

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
(10041, 130, 3, 30, 1500000),
(10042, 130, 4, 25, 1500000);

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
(1, 'Áo Thun', 'Các loại áo phông, áo thun ngắn/dài tay', 'tshirt.png'),
(2, 'Áo Sơ Mi', 'Các loại áo sơ mi công sở và thường ngày', 'shirt.png'),
(3, 'Quần Jeans', 'Các loại quần bò, quần denim', 'jeans.png'),
(4, 'Quần Kaki', 'Các loại quần âu, quần kaki lịch sự', 'trousers.png'),
(5, 'Áo Khoác', 'Các loại áo khoác bomber, jacket, hoodie', 'jacket.png'),
(6, 'Phụ kiện', 'Cà vạt, thắt lưng, khăn, v.v.', 'accessories.png');

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

-- --------------------------------------------------------

--
-- Table structure for table `hinhanhsanpham`
--

CREATE TABLE `hinhanhsanpham` (
  `MaHinhAnh` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `URLHinhAnh` varchar(255) NOT NULL,
  `LaAnhChinh` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_esperanto_ci;

--
-- Dumping data for table `hinhanhsanpham`
--

INSERT INTO `hinhanhsanpham` (`MaHinhAnh`, `MaSP`, `URLHinhAnh`, `LaAnhChinh`) VALUES
(1, 101, 'img/shop-details/thumb-2.png', 0),
(2, 101, 'img/shop-details/thumb-3.png', 0),
(3, 101, 'img/shop-details/thumb-4.png', 0),
(4, 111, 'img/product/product-15-main.jpg', 1),
(5, 112, 'img/product/product-16-main.jpg', 1),
(6, 113, 'img/product/product-17-main.jpg', 1),
(7, 114, 'img/product/product-18-main.jpg', 1),
(8, 115, 'img/product/product-19-main.jpg', 1),
(9, 117, 'img/product/product-21-main.jpg', 1),
(10, 118, 'img/somi_denim_main.jpg', 1),
(11, 121, 'img/product/product-22-main.jpg', 1),
(12, 123, 'img/product/product-23-main.jpg', 1),
(13, 124, 'img/somi_oxford_caro_main.jpg', 1),
(14, 125, 'img/jean_xam_main.jpg', 1),
(15, 127, 'img/blazer_linen_ke_main.jpg', 1),
(16, 129, 'img/product/product-24-main.jpg', 1),
(17, 130, 'img/trench_coat_beige_main.jpg', 1);

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
(1017, 'KH002', '2025-11-04 18:00:00', NULL, NULL, 'Đào Thị Linh', '456 Phố Tràng Tiền, Hoàn Kiếm, Hà Nội', 'Chuyển khoản', 'Giao hàng nhanh', 30000, 2, 'nv01', 'Cần đóng gói cẩn thận');

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
('KH005', 'pass123', 'Nguyễn Thị Hương', 1, '1992-03-10 00:00:00', '678 Phố Hàng Bài, Hoàn Kiếm, Hà Nội', '0977889900', 'huongnt@mail.com', 1, 0);

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
-- Table structure for table `nhacc`
--

CREATE TABLE `nhacc` (
  `MaNCC` varchar(50) NOT NULL,
  `TenCty` varchar(50) NOT NULL,
  `Logo` varchar(50) NOT NULL,
  `TenLH` varchar(50) DEFAULT NULL,
  `Email` varchar(50) NOT NULL,
  `Phone` varchar(50) DEFAULT NULL,
  `DiaChi` varchar(50) DEFAULT NULL,
  `MoTa` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhacc`
--

INSERT INTO `nhacc` (`MaNCC`, `TenCty`, `Logo`, `TenLH`, `Email`, `Phone`, `DiaChi`, `MoTa`) VALUES
('AP', 'Vải Sợi Miền Nam', 'logo_ap.gif', 'Petter Pike', 'pike@fashion.com', '0987345876', '765 Fashion Place, HCM, VN', 'Chuyên cung cấp vải và phụ liệu cao cấp'),
('NK', 'Garment NK Corp', 'logo_nk.gif', 'Okawa', 'okawa@nokiag.com', '0913745789', '123 Revenue, Tokyo, Japan', 'Chuyên cung cấp quần áo nhập khẩu'),
('SM', 'May Mặc Seamen', 'logo_sm.gif', 'David Brown', 'brown@seamen.com', '0987456876', '23 New World, Ha Noi, VN', 'Công ty thời trang may mặc lớn');

-- --------------------------------------------------------

--
-- Table structure for table `nhanvien`
--

CREATE TABLE `nhanvien` (
  `MaNV` varchar(50) NOT NULL,
  `HoTen` varchar(50) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `MatKhau` varchar(50) DEFAULT NULL,
  `VaiTro` int(11) NOT NULL DEFAULT 1 COMMENT '1: Nhan Vien, 2: Admin'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nhanvien`
--

INSERT INTO `nhanvien` (`MaNV`, `HoTen`, `Email`, `MatKhau`, `VaiTro`) VALUES
('admin01', 'Quản Trị Viên', 'admin@shop.com', 'adminpass', 2),
('nv01', 'Trần Văn A', 'tva@shop.com', '123456', 1),
('nv02', 'Nguyễn Thị B', 'ntb@shop.com', '123456', 1);

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
  `HinhAnh` varchar(50) DEFAULT NULL,
  `NgaySanXuat` datetime NOT NULL DEFAULT current_timestamp(),
  `LuotXem` int(11) NOT NULL DEFAULT 0,
  `MoTa` text DEFAULT NULL,
  `MaNCC` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sanpham`
--

INSERT INTO `sanpham` (`MaSP`, `TenSP`, `MaDM`, `MoTaDonVi`, `GiaCoBan`, `HinhAnh`, `NgaySanXuat`, `LuotXem`, `MoTa`, `MaNCC`) VALUES
(101, 'Áo Thun Cổ Tròn Trắng', 1, '1 cái', 150000, 'tshirt_white.jpg', '2025-10-01 10:00:00', 300, 'Áo thun cotton co giãn, thoải mái', 'AP'),
(102, 'Sơ Mi Dài Tay Xanh Navy', 2, '1 cái', 350000, 'shirt_navy.jpg', '2025-10-05 10:00:00', 300, 'Sơ mi dài tay, chất liệu Oxford cao cấp', 'SM'),
(103, 'Quần Jeans Slimfit Đen', 3, '1 cái', 599000, 'jeans_black.jpg', '2025-10-10 10:00:00', 200, 'Quần jeans co giãn, kiểu dáng Slimfit', 'AP'),
(104, 'Quần Kaki Ống Đứng Be', 4, '1 cái', 420000, 'kaki_straight.jpg', '2025-10-15 10:00:00', 50, 'Quần Kaki ống đứng, màu Be trung tính', 'SM'),
(105, 'Áo Khoác Bomber Đen', 5, '1 cái', 780000, 'bomber_black.jpg', '2025-10-20 10:00:00', 120, 'Áo khoác Bomber phong cách thể thao', 'AP'),
(106, 'Thắt Lưng Da Nâu', 6, '1 dây', 290000, 'belt_leather.jpg', '2025-10-25 10:00:00', 250, 'Thắt lưng da bò thật, mặt khóa kim loại', 'NK'),
(107, 'Áo Polo Thể Thao', 1, NULL, 320000, 'product-1.jpg', '2025-11-03 10:00:00', 0, 'Áo polo chất liệu thoáng mát', 'SM'),
(108, 'Áo Len Cổ Lọ Cũ', 1, NULL, 380000, 'product-5.jpg', '2025-09-01 10:00:00', 10, 'Sản phẩm cũ', 'AP'),
(109, 'Quần Short Kaki Cũ', 4, NULL, 250000, 'product-6.jpg', '2025-09-05 10:00:00', 20, 'Sản phẩm cũ', 'SM'),
(110, 'Áo Hoodie Nỉ Mới', 5, NULL, 550000, 'product-7.jpg', '2025-11-05 10:00:00', 5, 'Sản phẩm rất mới', 'AP'),
(111, 'Áo Thun Polo Kẻ Sọc', 1, '1 cái', 350000, 'product-15.jpg', '2025-11-06 10:00:00', 150, 'Áo Polo chất liệu cotton cao cấp, kẻ sọc thời trang.', 'SM'),
(112, 'Sơ Mi Lụa Họa Tiết Hoa', 2, '1 cái', 450000, 'product-16.jpg', '2025-11-06 11:00:00', 80, 'Sơ mi lụa thoáng mát, họa tiết hoa văn độc đáo.', 'NK'),
(113, 'Quần Jeans Rách Gối Xanh Nhạt', 3, '1 cái', 680000, 'product-17.jpg', '2025-11-07 09:00:00', 220, 'Jeans phong cách rách gối cá tính, wash xanh nhạt.', 'AP'),
(114, 'Quần Kaki Slimfit Đen', 4, '1 cái', 480000, 'product-18.jpg', '2025-11-07 10:00:00', 180, 'Quần kaki co giãn, form slimfit trẻ trung.', 'SM'),
(115, 'Áo Khoác Hoodie Nỉ Xám', 5, '1 cái', 520000, 'product-19.jpg', '2025-11-08 12:00:00', 110, 'Áo khoác hoodie nỉ dày dặn, ấm áp cho mùa lạnh.', 'AP'),
(116, 'Cà Vạt Lụa Chấm Bi Xanh', 6, '1 dây', 180000, 'product-20.jpg', '2025-11-08 13:00:00', 60, 'Cà vạt lụa cao cấp, họa tiết chấm bi lịch sự.', 'NK'),
(117, 'Áo Thun Oversize Đen', 1, '1 cái', 250000, 'product-21.jpg', '2025-11-09 14:00:00', 350, 'Áo thun form rộng thoải mái, chất liệu cotton 100%.', 'SM'),
(118, 'Sơ Mi Denim Tay Ngắn', 2, '1 cái', 390000, 'somi_denim_hien_dai.jpg', '2025-11-09 15:00:00', 140, 'Sơ mi denim kiểu dáng hiện đại, năng động.', 'AP'),
(119, 'Quần Jeans Dáng Suông Selvedge', 3, '1 cái', 720000, 'jean_selvedge_raw.jpg', '2025-11-10 16:00:00', 90, 'Jeans Selvedge Raw, dáng suông cổ điển, chất liệu cao cấp.', 'SM'),
(120, 'Quần Kaki Jogger Màu Xanh', 4, '1 cái', 550000, 'khaki_nhat_slim.jpg', '2025-11-10 17:00:00', 170, 'Quần kaki jogger năng động, thoải mái, có bo gấu.', 'NK'),
(121, 'Áo Khoác Da Biker Cao Cấp', 5, '1 cái', 1800000, 'product-22.jpg', '2025-11-11 18:00:00', 40, 'Áo khoác da thật 100% phong cách biker mạnh mẽ.', 'AP'),
(122, 'Thắt Lưng Da Cá Sấu Đen', 6, '1 dây', 890000, 'that_lung_ca_sau.jpg', '2025-11-11 19:00:00', 70, 'Thắt lưng da cá sấu thật, khóa kim loại sang trọng.', 'SM'),
(123, 'Áo Thun Tay Dài Trắng Basic', 1, '1 cái', 280000, 'product-23.jpg', '2025-11-12 20:00:00', 160, 'Áo thun tay dài cotton mỏng nhẹ, phù hợp mọi mùa.', 'NK'),
(124, 'Sơ Mi Oxford Kẻ Caro Xanh', 2, '1 cái', 410000, 'somi_oxford_trang.jpg', '2025-11-12 21:00:00', 130, 'Sơ mi Oxford chất liệu dày dặn, họa tiết kẻ caro trẻ trung.', 'AP'),
(125, 'Quần Jeans Xám Co Giãn', 3, '1 cái', 620000, 'jean_xam_co_gian.jpg', '2025-11-13 10:00:00', 200, 'Quần jeans màu xám bụi bặm, chất liệu co giãn tốt.', 'SM'),
(126, 'Quần Tây Wool Pleated Xám', 4, '1 cái', 950000, 'quan_tay_pleated.jpeg', '2025-11-13 11:00:00', 55, 'Quần tây vải Wool cao cấp, có xếp ly, form đứng.', 'NK'),
(127, 'Áo Blazer Linen Kẻ Sọc', 5, '1 cái', 1200000, 'blazer_linen_ke.jpg', '2025-11-14 12:00:00', 45, 'Blazer chất liệu Linen thoáng mát, họa tiết kẻ lịch lãm.', 'AP'),
(128, 'Ví Da Bò Ý Cao Cấp', 6, '1 cái', 490000, 'vi_da_bo_y.jpg', '2025-11-14 13:00:00', 190, 'Ví da bò nhập khẩu từ Ý, thiết kế mỏng gọn và bền bỉ.', 'SM'),
(129, 'Áo Thun Basic Xanh Navy', 1, '1 cái', 190000, 'product-24.jpg', '2025-11-15 14:00:00', 270, 'Áo thun trơn cơ bản, màu xanh navy dễ phối đồ.', 'NK'),
(130, 'Áo Khoác Trench Coat Beige', 5, '1 cái', 1500000, 'trench_coat_beige.jpg', '2025-11-15 15:00:00', 75, 'Áo khoác Trench Coat cổ điển, chất liệu chống nước nhẹ, màu be thanh lịch.', 'AP');

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

-- --------------------------------------------------------

--
-- Table structure for table `yeuthich`
--

CREATE TABLE `yeuthich` (
  `MaYT` int(11) NOT NULL,
  `MaSP` int(11) DEFAULT NULL,
  `MaKH` varchar(20) DEFAULT NULL,
  `NgayChon` datetime DEFAULT current_timestamp(),
  `MoTa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `yeuthich`
--

INSERT INTO `yeuthich` (`MaYT`, `MaSP`, `MaKH`, `NgayChon`, `MoTa`) VALUES
(1, 101, 'KH001', '2025-11-03 16:45:50', 'Áo mặc hàng ngày'),
(2, 105, 'KH003', '2025-11-03 16:45:50', 'Áo khoác cho mùa đông'),
(3, 104, 'KH001', '2025-11-03 22:51:14', 'Quần này đẹp'),
(4, 111, 'KH004', '2025-11-05 10:00:00', 'Thích kiểu kẻ sọc này'),
(5, 121, 'KH004', '2025-11-05 11:30:00', 'Áo da đẹp'),
(6, 126, 'KH005', '2025-11-05 12:45:00', 'Quần tây công sở');

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
  ADD KEY `MaSP` (`MaSP`);

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
-- Indexes for table `yeuthich`
--
ALTER TABLE `yeuthich`
  ADD PRIMARY KEY (`MaYT`),
  ADD UNIQUE KEY `UK_YeuThich` (`MaSP`,`MaKH`),
  ADD KEY `FK_YeuThich_KhachHang` (`MaKH`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chitiethd`
--
ALTER TABLE `chitiethd`
  MODIFY `MaCT` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `chitietsp`
--
ALTER TABLE `chitietsp`
  MODIFY `MaCTSP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10043;

--
-- AUTO_INCREMENT for table `danhmuc`
--
ALTER TABLE `danhmuc`
  MODIFY `MaDM` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `giohang`
--
ALTER TABLE `giohang`
  MODIFY `MaGH` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `hinhanhsanpham`
--
ALTER TABLE `hinhanhsanpham`
  MODIFY `MaHinhAnh` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `hoadon`
--
ALTER TABLE `hoadon`
  MODIFY `MaHD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1018;

--
-- AUTO_INCREMENT for table `kichco`
--
ALTER TABLE `kichco`
  MODIFY `MaKC` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `MaSP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT for table `yeuthich`
--
ALTER TABLE `yeuthich`
  MODIFY `MaYT` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  ADD CONSTRAINT `hinhanhsanpham_ibfk_1` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

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

--
-- Constraints for table `yeuthich`
--
ALTER TABLE `yeuthich`
  ADD CONSTRAINT `FK_YeuThich_KhachHang` FOREIGN KEY (`MaKH`) REFERENCES `khachhang` (`MaKH`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_YeuThich_SanPhams` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
