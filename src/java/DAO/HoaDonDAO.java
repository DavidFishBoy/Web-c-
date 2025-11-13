package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException; 
import java.sql.Statement; 
import java.util.ArrayList;
import java.util.List;
import model.ChiTietHD;
import model.GioHang;
import model.HoaDon;
import model.ThongKeDoanhThu;
import model.TrangThaiDonHang;
import util.DBConnect;

public class HoaDonDAO {
    
    private void closeConnections(Connection con, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<ChiTietHD> getChiTietHDByMaHD(int maHD) {
        List<ChiTietHD> listCT = new ArrayList<>();

        String sql = "SELECT ct.MaCT, ct.MaHD, ct.MaCTSP, ct.DonGia, ct.SoLuong, "
                + "sp.TenSP, kc.TenKichCo, hinhsp.URLHinhAnh "
                + "FROM chitiethd ct "
                + "JOIN chitietsp ctsp ON ct.MaCTSP = ctsp.MaCTSP "
                + "JOIN sanpham sp ON ctsp.MaSP = sp.MaSP "
                + "JOIN kichco kc ON ctsp.MaKC = kc.MaKC "
                + "LEFT JOIN hinhanhsanpham hinhsp ON sp.MaSP = hinhsp.MaSP AND hinhsp.IsDefault = 1 "
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
                 ChiTietHD ct = new ChiTietHD(
                        rs.getInt("MaCT"),
                        rs.getInt("MaHD"),
                        rs.getInt("MaCTSP"),
                        rs.getDouble("DonGia"),
                        rs.getInt("SoLuong"),
                        rs.getString("TenSP"),
                        rs.getString("TenKichCo")
                );
                ct.setHinhAnh(rs.getString("URLHinhAnh")); 
                listCT.add(ct);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(con, ps, rs); 
        }
        return listCT;
    }
public List<TrangThaiDonHang> getAllTrangThai() {
        List<TrangThaiDonHang> list = new ArrayList<>();
        String sql = "SELECT * FROM trangthaidonhang";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()) {
                list.add(new TrangThaiDonHang(
                        rs.getInt("MaTrangThai"), 
                        rs.getString("TenTrangThai"), 
                        rs.getString("MoTa")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(con, ps, rs);
        }
        return list;
    }
public List<HoaDon> getAllHoaDon() { 
        List<HoaDon> list = new ArrayList<>();
        
        String sql = "SELECT hd.*, tt.TenTrangThai, " +
                     " (SELECT SUM(ct.DonGia * ct.SoLuong) + hd.PhiVanChuyen FROM chitiethd ct WHERE ct.MaHD = hd.MaHD) AS TongTienHoaDon " +
                     " FROM hoadon hd " +
                     " JOIN trangthaidonhang tt ON hd.MaTrangThai = tt.MaTrangThai " +
                     " ORDER BY hd.NgayDat DESC"; // Sắp xếp mới nhất lên đầu
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                HoaDon hd = new HoaDon();
                hd.setMaHD(rs.getInt("MaHD"));
                hd.setMaKH(rs.getString("MaKH")); 
                hd.setNgayDatHang(rs.getDate("NgayDat")); 
                hd.setTongTien(rs.getDouble("TongTienHoaDon")); 
                hd.setDiaChiGiaoHang(rs.getString("DiaChiGiaoHang"));
                hd.setHoTenNguoiNhan(rs.getString("TenNguoiNhan"));
                hd.setGhiChu(rs.getString("GhiChu"));
                hd.setMaTrangThai(rs.getInt("MaTrangThai"));
                hd.setMaNV(rs.getString("MaNV")); 
                
                // Set trường mới mà chúng ta đã JOIN
                hd.setTenTrangThai(rs.getString("TenTrangThai"));

                list.add(hd);
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {
            closeConnections(con, ps, rs); 
        }
        return list;
    }
    
    /**
     * MỚI: Cập nhật trạng thái của một đơn hàng
     */
    public boolean updateTrangThaiDonHang(int maHD, int maTrangThaiMoi, String maNV) {
        String sql = "UPDATE hoadon SET MaTrangThai = ?, MaNV = ? WHERE MaHD = ?";
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maTrangThaiMoi);
            ps.setString(2, maNV); // Ghi lại Admin nào đã cập nhật
            ps.setInt(3, maHD);
            
            return ps.executeUpdate() > 0; // Trả về true nếu thành công
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnections(con, ps, null);
        }
    }
public int createHoaDon(HoaDon hd, List<GioHang> cartItems) { 
    Connection con = null;
    PreparedStatement ps_hd = null;
    PreparedStatement ps_cthd = null;
    PreparedStatement ps_stock = null;
    ResultSet rs_key = null;
    
    int maHD = 0; 

    String sql_hd = "INSERT INTO hoadon (MaKH, NgayDat, TenNguoiNhan, DiaChiGiaoHang, GhiChu, MaTrangThai, PhiVanChuyen, CachThanhToan, CachVanChuyen) "
            + "VALUES (?, NOW(), ?, ?, ?, 0, ?, ?, ?)";

    String sql_cthd = "INSERT INTO chitiethd (MaHD, MaCTSP, DonGia, SoLuong) VALUES (?, ?, ?, ?)";

    String sql_update_stock = "UPDATE chitietsp SET SoLuongTon = SoLuongTon - ? WHERE MaCTSP = ?";

    try {
        con = new DBConnect().getConnection();
        con.setAutoCommit(false);

        ps_hd = con.prepareStatement(sql_hd, java.sql.Statement.RETURN_GENERATED_KEYS);
        
        ps_hd.setString(1, hd.getMaKH());            
        ps_hd.setString(2, hd.getHoTenNguoiNhan());  
        ps_hd.setString(3, hd.getDiaChiGiaoHang());
        ps_hd.setString(4, hd.getGhiChu());          
        ps_hd.setDouble(5, 0); 
        ps_hd.setString(6, "Tiền mặt"); 
        ps_hd.setString(7, "Chuyển phát nhanh");
        
        ps_hd.executeUpdate();

        rs_key = ps_hd.getGeneratedKeys();
        
        if (rs_key.next()) {
            maHD = rs_key.getInt(1); 
        } else {
            throw new Exception("Không thể tạo hóa đơn.");
        }

        ps_cthd = con.prepareStatement(sql_cthd);
        ps_stock = con.prepareStatement(sql_update_stock);

        for (GioHang item : cartItems) {
            ps_cthd.setInt(1, maHD);
            ps_cthd.setInt(2, item.getMaCTSP());
            ps_cthd.setDouble(3, item.getGiaBan());
            ps_cthd.setInt(4, item.getSoLuong());
            ps_cthd.addBatch();

            ps_stock.setInt(1, item.getSoLuong());
            ps_stock.setInt(2, item.getMaCTSP());
            ps_stock.addBatch();
        }

        ps_cthd.executeBatch();
        ps_stock.executeBatch();

        GioHangDAO ghDAO = new GioHangDAO();
        ghDAO.clearGioHang(hd.getMaKH()); 

        con.commit();
        
        return maHD; 

    } catch (Exception e) {
        e.printStackTrace();
        try {
            if (con != null) con.rollback();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0; 
    } finally {
        try {
            if (rs_key != null) rs_key.close();
            if (ps_hd != null) ps_hd.close();
            if (ps_cthd != null) ps_cthd.close();
            if (ps_stock != null) ps_stock.close();
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

    /**
     * Hàm thống kê 
     */
    public List<ThongKeDoanhThu> getThongKeDoanhThu7NgayQua() {
        List<ThongKeDoanhThu> list = new ArrayList<>();
        
        String sql = "SELECT " +
                     "    DATE(hd.NgayDat) AS Ngay, " + 
                     "    SUM(ct.DonGia * ct.SoLuong) AS TongDoanhThu " +
                     "FROM " +
                     "    hoadon hd " +
                     "JOIN " +
                     "    chitiethd ct ON hd.MaHD = ct.MaHD " +
                     "WHERE " +
                     "    hd.MaTrangThai IN(1,3)  " +
                     "    AND hd.NgayDat >= CURDATE() - INTERVAL 7 DAY " +
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
            closeConnections(con, ps, rs); 
        }
        
        return list;
    }

  
    public List<HoaDon> getHoaDonByMaKH(String maKH) { 
        List<HoaDon> list = new ArrayList<>();
        
        // Chúng ta phải tính tổng tiền từ chitiethd
        String sql = "SELECT hd.*, tt.TenTrangThai, " +
                     " (SELECT SUM(ct.DonGia * ct.SoLuong) + hd.PhiVanChuyen FROM chitiethd ct WHERE ct.MaHD = hd.MaHD) AS TongTienHoaDon " +
                     " FROM hoadon hd " +
                     " JOIN trangthaidonhang tt ON hd.MaTrangThai = tt.MaTrangThai " +
                     " WHERE hd.MaKH = ? ORDER BY hd.NgayDat DESC";
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH); 
            
            rs = ps.executeQuery();

            while (rs.next()) {
                HoaDon hd = new HoaDon();
                hd.setMaHD(rs.getInt("MaHD"));
                hd.setMaKH(rs.getString("MaKH")); 
                hd.setNgayDatHang(rs.getDate("NgayDat")); 
                
                hd.setTongTien(rs.getDouble("TongTienHoaDon")); 
                
                hd.setDiaChiGiaoHang(rs.getString("DiaChiGiaoHang"));
                
                // hd.setSdtNguoiNhan(rs.getString("SDTNguoiNhan")); 
                
                hd.setHoTenNguoiNhan(rs.getString("TenNguoiNhan"));
                
                // hd.setEmailNguoiNhan(rs.getString("EmailNguoiNhan"));
                
                hd.setGhiChu(rs.getString("GhiChu"));
                hd.setMaTrangThai(rs.getInt("MaTrangThai"));
                
                // hd.setTenTrangThai(rs.getString("TenTrangThai"));
                
                hd.setMaNV(rs.getString("MaNV")); 

                list.add(hd);
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi lấy lịch sử hóa đơn: " + e.getMessage());
            e.printStackTrace(); 
        } finally {
            closeConnections(con, ps, rs); 
        }
        return list;
    }
    /**
     * MỚI: Lấy tổng doanh thu (chỉ tính các đơn đã hoàn thành)
     */
    public double getTongDoanhThu() {
        // Câu SQL này SUM tiền từ bảng chi tiết,
        // và chỉ tính các hóa đơn có trạng thái 1 hoặc 3 (giống logic thống kê 7 ngày)
        String sql = "SELECT SUM(ct.DonGia * ct.SoLuong) " +
                     "FROM chitiethd ct " +
                     "JOIN hoadon hd ON ct.MaHD = hd.MaHD " +
                     "WHERE hd.MaTrangThai IN (1, 3)"; 
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        double tongDoanhThu = 0.0; // Mặc định là 0

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            // Truy vấn SUM luôn trả về 1 hàng, kể cả là 0 hoặc NULL
            if (rs.next()) {
                tongDoanhThu = rs.getDouble(1); // Lấy kết quả từ cột đầu tiên
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(con, ps, rs); // Dùng lại hàm helper
        }
        return tongDoanhThu;
    }

    /**
     * MỚI: Lấy tổng số đơn hàng (tất cả trạng thái)
     */
    public int getTongSoDonHang() {
        String sql = "SELECT COUNT(*) FROM hoadon"; // Đếm tất cả hóa đơn
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int tongSoDonHang = 0; // Mặc định là 0

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                tongSoDonHang = rs.getInt(1); // Lấy kết quả từ cột đầu tiên
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(con, ps, rs); // Dùng lại hàm helper
        }
        return tongSoDonHang;
    }
    public HoaDon getHoaDonChiTietByMaHD(int maHD) {
        HoaDon hd = null;
        // Câu lệnh này JOIN để lấy Tên trạng thái và tính Tổng tiền
        String sql = "SELECT hd.*, tt.TenTrangThai, " +
                     " (SELECT SUM(ct.DonGia * ct.SoLuong) FROM chitiethd ct WHERE ct.MaHD = hd.MaHD) AS TongTienHoaDon " +
                     " FROM hoadon hd " +
                     " JOIN trangthaidonhang tt ON hd.MaTrangThai = tt.MaTrangThai " +
                     " WHERE hd.MaHD = ?";
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maHD);
            rs = ps.executeQuery();

            if (rs.next()) {
                hd = new HoaDon();
                hd.setMaHD(rs.getInt("MaHD"));
                hd.setMaKH(rs.getString("MaKH")); 
                hd.setNgayDatHang(rs.getDate("NgayDat")); 
                hd.setTongTien(rs.getDouble("TongTienHoaDon")); // Lấy tổng tiền đã tính
                hd.setDiaChiGiaoHang(rs.getString("DiaChiGiaoHang"));
                hd.setHoTenNguoiNhan(rs.getString("TenNguoiNhan"));
                hd.setGhiChu(rs.getString("GhiChu"));
                hd.setMaTrangThai(rs.getInt("MaTrangThai"));
                hd.setMaNV(rs.getString("MaNV")); 
                hd.setTenTrangThai(rs.getString("TenTrangThai")); // Lấy tên trạng thái
            }
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {
            closeConnections(con, ps, rs); 
        }
        return hd;
    }
    
}