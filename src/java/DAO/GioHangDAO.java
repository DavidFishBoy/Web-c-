package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.GioHang;
import util.DBConnect;

public class GioHangDAO {

    // 1. XÓA CÁC BIẾN CHUNG (con, ps, rs) KHỎI ĐÂY

    /**
     * Lấy danh sách giỏ hàng KÈM THÔNG TIN CHI TIẾT (Tên, Ảnh, Size, Giá)
     */
    public List<GioHang> getListGioHangByMaKH(String maKH) {
        List<GioHang> listGioHang = new ArrayList<>();
        
        String sql = "SELECT gh.MaGH, gh.MaKH, gh.MaCTSP, gh.SoLuong, "
                + "sp.TenSP, sp.HinhAnh, kc.TenKichCo, ct.GiaBan "
                + "FROM giohang gh "
                + "JOIN chitietsp ct ON gh.MaCTSP = ct.MaCTSP "
                + "JOIN sanpham sp ON ct.MaSP = sp.MaSP "
                + "JOIN kichco kc ON ct.MaKC = kc.MaKC "
                + "WHERE gh.MaKH = ? "
                + "ORDER BY gh.NgayChon DESC";
        
        // 2. SỬA LỖI: Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                listGioHang.add(new GioHang(
                        rs.getInt("MaGH"),
                        rs.getString("MaKH"),
                        rs.getInt("MaCTSP"),
                        rs.getInt("SoLuong"),
                        rs.getString("TenSP"),
                        rs.getString("HinhAnh"),
                        rs.getString("TenKichCo"),
                        rs.getDouble("GiaBan")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 3. SỬA LỖI: Tự đóng kết nối
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return listGioHang;
    }

    /**
     * Tính tổng tiền trong giỏ hàng của khách
     */
    public double getTongTienByMaKH(String maKH) {
        double tongTien = 0;
        String sql = "SELECT SUM(gh.SoLuong * ct.GiaBan) "
                + "FROM giohang gh "
                + "JOIN chitietsp ct ON gh.MaCTSP = ct.MaCTSP "
                + "WHERE gh.MaKH = ?";
        
        // 2. SỬA LỖI: Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            rs = ps.executeQuery();
            if (rs.next()) {
                tongTien = rs.getDouble(1); // Lấy kết quả SUM
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 3. SỬA LỖI: Tự đóng kết nối
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return tongTien;
    }

    // Thêm sản phẩm vào giỏ (hoặc cập nhật)
    public void themVaoGioHang(String maKH, int maCTSP, int soLuong) {
        String checkSql = "SELECT * FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        String updateSql = "UPDATE giohang SET SoLuong = SoLuong + ? WHERE MaKH = ? AND MaCTSP = ?";
        String insertSql = "INSERT INTO giohang (MaKH, MaCTSP, SoLuong, NgayChon) VALUES (?, ?, ?, CURDATE())";

        // 2. SỬA LỖI: Khai báo biến cục bộ
        Connection con = null;
        // Dùng các PreparedStatement riêng biệt cho an toàn
        PreparedStatement psCheck = null;
        PreparedStatement psUpdate = null;
        PreparedStatement psInsert = null;
        ResultSet rs = null;

        try {
            con = new DBConnect().getConnection();
            
            // Bước 1: Kiểm tra
            psCheck = con.prepareStatement(checkSql);
            psCheck.setString(1, maKH);
            psCheck.setInt(2, maCTSP);
            rs = psCheck.executeQuery();

            if (rs.next()) {
                // Bước 2a: Nếu có -> Cập nhật (cộng dồn)
                psUpdate = con.prepareStatement(updateSql);
                psUpdate.setInt(1, soLuong);
                psUpdate.setString(2, maKH);
                psUpdate.setInt(3, maCTSP);
                psUpdate.executeUpdate();
            } else {
                // Bước 2b: Nếu không -> Thêm mới
                psInsert = con.prepareStatement(insertSql);
                psInsert.setString(1, maKH);
                psInsert.setInt(2, maCTSP);
                psInsert.setInt(3, soLuong);
                psInsert.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 3. SỬA LỖI: Tự đóng TẤT CẢ kết nối
            try {
                if (rs != null) rs.close();
                if (psCheck != null) psCheck.close();
                if (psUpdate != null) psUpdate.close();
                if (psInsert != null) psInsert.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Cập nhật số lượng (dùng cho trang giohang.jsp)
    public void capNhatSoLuong(String maKH, int maCTSP, int soLuongMoi) {
        String sql = "UPDATE giohang SET SoLuong = ? WHERE MaKH = ? AND MaCTSP = ?";
        
        // 2. SỬA LỖI: Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, soLuongMoi);
            ps.setString(2, maKH);
            ps.setInt(3, maCTSP);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 3. SỬA LỖI: Tự đóng kết nối
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * ĐỔI TÊN HÀM: từ 'xoaToanBoGioHang' thành 'clearGioHang'
     * để khớp với hàm gọi từ HoaDonDAO (khi đặt hàng)
     */
    public void clearGioHang(String maKH) {
        String sql = "DELETE FROM giohang WHERE MaKH = ?";
        
        // 2. SỬA LỖI: Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 3. SỬA LỖI: Tự đóng kết nối
             try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Xóa khỏi giỏ hàng
    public void xoaKhoiGioHang(String maKH, int maCTSP) {
        String sql = "DELETE FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        
        // 2. SỬA LỖI: Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            ps.setInt(2, maCTSP);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 3. SỬA LỖI: Tự đóng kết nối
             try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    // Đếm số lượng sản phẩm khác nhau trong giỏ (cho icon header)
    public int getSoLuongTrongGio(String maKH) {
        String sql = "SELECT count(*) FROM giohang WHERE MaKH = ?";
        
        // 2. SỬA LỖI: Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về kết quả đếm
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 3. SỬA LỖI: Tự đóng kết nối
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return 0; // Trả về 0 nếu có lỗi
    }

    // 4. XÓA HÀM `closeConnections()` KHỎI ĐÂY
}