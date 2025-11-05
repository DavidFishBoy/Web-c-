package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.NhanVien; 
import model.TaiKhoan;
import util.DBConnect;

public class TaiKhoanDAO {
    
    // Xóa các biến thành viên (member variables) con, ps, rs khỏi đây.

    public TaiKhoan checkKhachHangLogin(String email, String pass) {
        String sql = "SELECT * FROM khachhang WHERE Email = ? AND MatKhau = ?";
        // Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new TaiKhoan(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10)); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng kết nối
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    // 2. Thêm hàm mới để check NhanVien/Admin
    public NhanVien checkNhanVienLogin(String email, String pass) {
        String sql = "SELECT * FROM nhanvien WHERE Email = ? AND MatKhau = ?";
        // Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new NhanVien(
                        rs.getString("MaNV"),
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        rs.getString("MatKhau"),
                        rs.getInt("VaiTro")); // Cột VaiTro
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng kết nối
             try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    // Hàm checkTaiKhoan (dùng cho đăng ký)
    public TaiKhoan checkTaiKhoan(String email) {
        String sql = "SELECT * FROM khachhang WHERE Email = ?";
        // Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new TaiKhoan(
                        rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getInt(9),
                        rs.getInt(10));
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
        return null;
    }

    public void insertTaiKhoan(String maKH, String matKhau, String hoTen, int gioiTinh, String ngaySinh, String diaChi, String dienThoai, String email, int hieuLuc, int vaiTro) {
        String sql = "INSERT INTO khachhang VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        // Khai báo biến cục bộ
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            ps.setString(2, matKhau);
            ps.setString(3, hoTen);
            ps.setInt(4, gioiTinh);
            ps.setString(5, ngaySinh);
            ps.setString(6, diaChi);
            ps.setString(7, dienThoai);
            ps.setString(8, email);
            ps.setInt(9, hieuLuc); 
            ps.setInt(10, vaiTro); 
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
             try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    // Xóa phương thức closeConnections() không dùng đến
}