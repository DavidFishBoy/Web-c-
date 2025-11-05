package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.ChiTietHD;
import model.GioHang; 
import model.HoaDon;   
import model.ThongKeDoanhThu; // <-- MỚI: Import model thống kê
import util.DBConnect;

public class HoaDonDAO {
    
    // Đã xóa các biến con, ps, rs chung (Tốt!)

    /**
     * HÀM QUAN TRỌNG: Lấy chi tiết các sản phẩm trong 1 hóa đơn
     */
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

    /**
     * BỔ SUNG PHƯƠNG THỨC: Tạo Hóa Đơn, Cập nhật Kho, Cập nhật Thống kê
     */
    public boolean createHoaDon(HoaDon hd, List<GioHang> cartItems) {
        Connection con = null;
        PreparedStatement ps_hd = null;
        PreparedStatement ps_cthd = null;
        PreparedStatement ps_stock = null;
        PreparedStatement ps_stats = null; 
        ResultSet rs_key = null;
        boolean datHangThanhCong = false;

        String sql_hd = "INSERT INTO hoadon (MaKH, TenNguoiNhan, DiaChiGiaoHang, GhiChu, CachThanhToan, MaTrangThai, NgayDat, PhiVanChuyen) " +
                        "VALUES (?, ?, ?, ?, ?, 0, NOW(), ?)";
        
        String sql_cthd = "INSERT INTO chitiethd (MaHD, MaCTSP, DonGia, SoLuong) VALUES (?, ?, ?, ?)";
        
        String sql_update_stock = "UPDATE chitietsp SET SoLuongTon = SoLuongTon - ? WHERE MaCTSP = ?";
        
        String sql_update_stats = "UPDATE sanpham SET DaBan = DaBan + ? " +
                                  "WHERE MaSP = (SELECT MaSP FROM chitietsp WHERE MaCTSP = ?)";

        try {
            con = new DBConnect().getConnection();
            con.setAutoCommit(false); 

            ps_hd = con.prepareStatement(sql_hd, PreparedStatement.RETURN_GENERATED_KEYS);
            ps_hd.setString(1, hd.getMaKH());
            ps_hd.setString(2, hd.getTenNguoiNhan());
            ps_hd.setString(3, hd.getDiaChiGiaoHang());
            ps_hd.setString(4, hd.getGhiChu());
            ps_hd.setString(5, hd.getCachThanhToan());
            ps_hd.setDouble(6, hd.getPhiVanChuyen()); 
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
                ps_cthd.setInt(1, maHD);
                ps_cthd.setInt(2, item.getMaCTSP());
                ps_cthd.setDouble(3, item.getGiaBan());
                ps_cthd.setInt(4, item.getSoLuong());
                ps_cthd.addBatch();

                ps_stock.setInt(1, item.getSoLuong());
                ps_stock.setInt(2, item.getMaCTSP());
                ps_stock.addBatch();
                
                ps_stats.setInt(1, item.getSoLuong());
                ps_stats.setInt(2, item.getMaCTSP());
                ps_stats.addBatch();
            }

            ps_cthd.executeBatch();
            ps_stock.executeBatch();
            ps_stats.executeBatch(); 

            GioHangDAO ghDAO = new GioHangDAO();
            ghDAO.clearGioHang(hd.getMaKH()); 

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

    // =================================================================
    // MỚI: PHƯƠNG THỨC THỐNG KÊ (ĐÃ SỬA LỖI NULLPOINTER)
    // =================================================================
    /**
     * MỚI: Lấy dữ liệu thống kê doanh thu 7 ngày gần nhất
     * (Chỉ tính các đơn hàng đã giao thành công)
     */
    public List<ThongKeDoanhThu> getThongKeDoanhThu7NgayQua() {
        
        // SỬA LỖI: Khởi tạo danh sách ngay lập tức. 
        // Điều này đảm bảo phương thức KHÔNG BAO GIỜ trả về null.
        List<ThongKeDoanhThu> list = new ArrayList<>(); 
        
        String sql = "SELECT " +
                     "    DATE(hd.NgayDat) AS Ngay, " +
                     "    SUM(ct.DonGia * ct.SoLuong) AS TongDoanhThu " +
                     "FROM " +
                     "    hoadon hd " +
                     "JOIN " +
                     "    chitiethd ct ON hd.MaHD = ct.MaHD " +
                     "WHERE " +
                     "    hd.MaTrangThai = 3  -- Chỉ tính đơn 'Đã giao hàng' " +
                     "    AND hd.NgayDat >= CURDATE() - INTERVAL 7 DAY -- 7 ngày gần nhất " +
                     "GROUP BY " +
                     "    DATE(hd.NgayDat) " +
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
        
        // Phương thức sẽ luôn trả về 'list' (dù rỗng hay có dữ liệu)
        return list; 
    }
}