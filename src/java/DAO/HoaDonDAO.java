package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.ChiTietHD;
import model.GioHang;
import model.HoaDon;
import model.ThongKeDoanhThu;
import util.DBConnect;

public class HoaDonDAO {

    public List<ChiTietHD> getChiTietHDByMaHD(int maHD) {
        List<ChiTietHD> listCT = new ArrayList<>();

        String sql = "SELECT ct.MaCT, ct.MaHD, ct.MaCTSP, ct.DonGia, ct.SoLuong, "
                + "sp.TenSP, kc.TenKichCo, sp.HinhAnh "
                + "FROM chitiethd ct "
                + "JOIN chitietsp ctsp ON ct.MaCTSP = ctsp.MaCTSP "
                + "JOIN sanpham sp ON ctsp.MaSP = sp.MaSP "
                + "JOIN kichco kc ON ctsp.MaKC = kc.MaKC "
                + "WHERE ct.MaHD = ?";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maHD);
            rs = ps.executeQuery();

            while (rs.next()) {
                listCT.add(new ChiTietHD(
                        rs.getInt("MaCT"),
                        rs.getInt("MaHD"),
                        rs.getInt("MaCTSP"),
                        rs.getDouble("DonGia"),
                        rs.getInt("SoLuong"),
                        rs.getString("TenSP"),
                        rs.getString("TenKichCo")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return listCT;
    }

    public boolean createHoaDon(HoaDon hd, List<GioHang> cartItems) {
        Connection con = null;
        PreparedStatement ps_hd = null;
        PreparedStatement ps_cthd = null;
        PreparedStatement ps_stock = null;
        PreparedStatement ps_stats = null;
        ResultSet rs_key = null;
        boolean datHangThanhCong = false;
        String sql_hd = "INSERT INTO hoadon (MaKH, NgayDatHang, TongTien, HoTenNguoiNhan, DiaChiGiaoHang, SDTNguoiNhan, EmailNguoiNhan, GhiChu, MaTrangThai) "
                + "VALUES (?, NOW(), ?, ?, ?, ?, ?, ?, 1)";

        String sql_cthd = "INSERT INTO chitiethd (MaHD, MaCTSP, DonGia, SoLuong) VALUES (?, ?, ?, ?)";
        
        String sql_update_stock = "UPDATE chitietsp SET SoLuong = SoLuong - ? WHERE MaCTSP = ?";
        
  
        String sql_update_stats = "UPDATE sanpham SET DaBan = IFNULL(DaBan, 0) + ? " +
                                  "WHERE MaSP = (SELECT MaSP FROM chitietsp WHERE MaCTSP = ?)";

        try {
            con = new DBConnect().getConnection();
            con.setAutoCommit(false);

            ps_hd = con.prepareStatement(sql_hd, PreparedStatement.RETURN_GENERATED_KEYS);
            // SỬA CÁC THAM SỐ:
            ps_hd.setInt(1, hd.getMaKH());            
            ps_hd.setDouble(2, hd.getTongTien());     
            ps_hd.setString(3, hd.getHoTenNguoiNhan()); 
            ps_hd.setString(4, hd.getDiaChiGiaoHang());
            ps_hd.setString(5, hd.getSdtNguoiNhan());   
            ps_hd.setString(6, hd.getEmailNguoiNhan()); 
            ps_hd.setString(7, hd.getGhiChu());
            
            ps_hd.executeUpdate();

            rs_key = ps_hd.getGeneratedKeys();
            int maHD = 0;
            if (rs_key.next()) {
                maHD = rs_key.getInt(1);
            } else {
                throw new Exception("Không thể tạo hóa đơn.");
            }

            ps_cthd = con.prepareStatement(sql_cthd);
            ps_stock = con.prepareStatement(sql_update_stock);
            ps_stats = con.prepareStatement(sql_update_stats);

            for (GioHang item : cartItems) {
                // Thêm vào chitiethd
                ps_cthd.setInt(1, maHD);
                ps_cthd.setInt(2, item.getMaCTSP());
                ps_cthd.setDouble(3, item.getGiaBan());
                ps_cthd.setInt(4, item.getSoLuong());
                ps_cthd.addBatch();

                // Trừ kho
                ps_stock.setInt(1, item.getSoLuong());
                ps_stock.setInt(2, item.getMaCTSP());
                ps_stock.addBatch();

                // Cập nhật đã bán
                ps_stats.setInt(1, item.getSoLuong());
                ps_stats.setInt(2, item.getMaCTSP());
                ps_stats.addBatch();
            }

            ps_cthd.executeBatch();
            ps_stock.executeBatch();
            ps_stats.executeBatch();

            // Xóa giỏ hàng sau khi đặt hàng thành công
            GioHangDAO ghDAO = new GioHangDAO();
            ghDAO.clearGioHang(hd.getMaKH()); // SỬA: dùng getMaKH() (int)

            con.commit();
            datHangThanhCong = true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (con != null) con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs_key != null) rs_key.close();
                if (ps_hd != null) ps_hd.close();
                if (ps_cthd != null) ps_cthd.close();
                if (ps_stock != null) ps_stock.close();
                if (ps_stats != null) ps_stats.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return datHangThanhCong;
    }

    /**
     * Hàm thống kê (Của bạn đã đúng, giữ nguyên)
     */
    public List<ThongKeDoanhThu> getThongKeDoanhThu7NgayQua() {
        List<ThongKeDoanhThu> list = new ArrayList<>();
        
        // SỬA LỖI: Khởi tạo danh sách ngay lập tức. 
        // Điều này đảm bảo phương thức KHÔNG BAO GIỜ trả về null.
        
        String sql = "SELECT " +
                     "    DATE(hd.NgayDatHang) AS Ngay, " + // Sửa: CSDL dùng NgayDatHang
                     "    SUM(ct.DonGia * ct.SoLuong) AS TongDoanhThu " +
                     "FROM " +
                     "    hoadon hd " +
                     "JOIN " +
                     "    chitiethd ct ON hd.MaHD = ct.MaHD " +
                     "WHERE " +
                     "    hd.MaTrangThai = 3  -- Chỉ tính đơn 'Đã hoàn thành' " +
                     "    AND hd.NgayDatHang >= CURDATE() - INTERVAL 7 DAY -- 7 ngày gần nhất " +
                     "GROUP BY " +
                     "    DATE(hd.NgayDatHang) " +
                     "ORDER BY " +
                     "    Ngay ASC";

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                String ngay = rs.getString("Ngay");
                double tongDoanhThu = rs.getDouble("TongDoanhThu");
                list.add(new ThongKeDoanhThu(ngay, tongDoanhThu));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        return list;
    }

    /**
     * === ĐÃ SỬA LỖI NullPointerException ===
     * Hàm lấy lịch sử hóa đơn theo MaKH
     */
    public List<HoaDon> getHoaDonByMaKH(int maKH) {
        List<HoaDon> list = new ArrayList<>();
        String sql = "SELECT * FROM hoadon WHERE MaKH = ? ORDER BY NgayDatHang DESC";
        
        // SỬA LỖI: Khai báo biến ngoài try-catch để finally có thể thấy
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // SỬA LỖI: Khởi tạo 'con' và 'ps' trước khi sử dụng
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maKH);
            
            rs = ps.executeQuery();

            while (rs.next()) {
                HoaDon hd = new HoaDon();
                hd.setMaHD(rs.getInt("MaHD"));
                hd.setMaKH(rs.getInt("MaKH"));
                hd.setNgayDatHang(rs.getDate("NgayDatHang"));
                hd.setTongTien(rs.getDouble("TongTien"));
                hd.setDiaChiGiaoHang(rs.getString("DiaChiGiaoHang"));
                hd.setSdtNguoiNhan(rs.getString("SDTNguoiNhan"));
                hd.setHoTenNguoiNhan(rs.getString("HoTenNguoiNhan"));
                hd.setEmailNguoiNhan(rs.getString("EmailNguoiNhan"));
                hd.setGhiChu(rs.getString("GhiChu"));
                hd.setMaTrangThai(rs.getInt("MaTrangThai"));
                
                // SỬA: Xử lý MaNV có thể bị NULL trong CSDL
                // Dùng getObject để lấy null, sau đó ép kiểu về Integer
                hd.setMaNV((Integer) rs.getObject("MaNV")); 

                list.add(hd);
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy lịch sử hóa đơn: " + e.getMessage());
            e.printStackTrace(); // In chi tiết lỗi
        } finally {
            // SỬA LỖI: Thêm finally để đảm bảo đóng kết nối
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}