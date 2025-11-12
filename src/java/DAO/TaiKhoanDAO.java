package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.NhanVien;
import model.TaiKhoan;
import util.DBConnect;

public class TaiKhoanDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * SỬA: 
     * 1. Cập nhật SQL để dùng cột 'Email' và 'MatKhau' (từ CSDL).
     * 2. Bỏ cột 'username' vì không tồn tại trong CSDL.
     * 3. Sửa phần mapping khi new TaiKhoan để khớp với các cột CSDL.
     */
    public TaiKhoan checkKhachHangLogin(String userOrEmail, String pass) {
        // Giả sử đăng nhập khách hàng chỉ dùng Email
        String sql = "SELECT * FROM khachhang WHERE email = ? AND MatKhau = ?"; 
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userOrEmail);
            ps.setString(2, pass); // 'pass' giờ sẽ so sánh với 'MatKhau'
            
            rs = ps.executeQuery();
            if (rs.next()) {
                // SỬA: Cần đảm bảo model TaiKhoan của bạn chấp nhận các cột này.
                // Ở đây chúng ta giả định 'username' trong model sẽ lấy từ Email
                // và 'password' trong model sẽ lấy từ MatKhau.
                return new TaiKhoan(
                        rs.getInt("MaKH"), 
                        rs.getString("HoTen"),
                        rs.getString("DiaChi"),
                        rs.getString("DienThoai"),
                        rs.getString("Email"),
                        rs.getString("Email"),      // Giả lập username = email
                        rs.getString("MatKhau"),    // Lấy MatKhau
                        rs.getInt("VaiTro")       // Lấy VaiTro
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }
    
    /**
     * SỬA:
     * 1. Cập nhật SQL để dùng 'MaNV', 'email', và 'MatKhau'.
     * 2. Cập nhật mapping để đọc 'MaNV', 'MatKhau', và 'VaiTro'.
     */
    public NhanVien checkNhanVienLogin(String userOrEmail, String pass) {
        // 'userOrEmail' có thể là MaNV hoặc Email
        String sql = "SELECT * FROM nhanvien WHERE (MaNV = ? OR email = ?) AND MatKhau = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userOrEmail);
            ps.setString(2, userOrEmail);
            ps.setString(3, pass); // So sánh với MatKhau
            
            rs = ps.executeQuery();
            if (rs.next()) {
                // SỬA: Đảm bảo model NhanVien của bạn khớp
                return new NhanVien(
                        rs.getInt("MaNV"), // Giả sử MaNV là Int, nếu là String thì dùng rs.getString
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        null, // CSDL nhanvien không có DienThoai
                        null, // CSDL nhanvien không có DiaChi
                        rs.getString("MaNV"),     // Dùng MaNV làm username
                        rs.getString("MatKhau"),  // Dùng MatKhau
                        rs.getInt("VaiTro")     // Dùng VaiTro (thay vì Role)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

    /**
     * Check tài khoản tồn tại (dùng cho Đăng Ký)
     * SỬA: Check Email (vì username không có)
     */
    public TaiKhoan checkTaiKhoanTonTai(String email) {
        String sql = "SELECT * FROM khachhang WHERE email = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new TaiKhoan(
                        rs.getInt("MaKH"), 
                        rs.getString("HoTen"),
                        rs.getString("DiaChi"),
                        rs.getString("DienThoai"),
                        rs.getString("Email"),
                        rs.getString("Email"),      // Giả lập username = email
                        rs.getString("MatKhau"),    // Lấy MatKhau
                        rs.getInt("VaiTro")       // Lấy VaiTro
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

    /**
     * SỬA: Khớp với CSDL (dùng MatKhau, VaiTro, và bỏ username)
     */
    public void signup(String user, String pass, String email, String ten, String sdt, String diaChi) {
        // Bỏ 'username', thay 'password' bằng 'MatKhau', thay 'role' bằng 'VaiTro'
        String sql = "INSERT INTO khachhang (HoTen, DiaChi, DienThoai, Email, MatKhau, VaiTro) "
                   + "VALUES (?, ?, ?, ?, ?, 0)"; // Gán VaiTro=0 (user) mặc định
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, ten);
            ps.setString(2, diaChi);
            ps.setString(3, sdt);
            ps.setString(4, email);
            ps.setString(5, pass); // Đây là MatKhau
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    // Hàm lấy tài khoản bằng MaKH (Giả sử đã đúng và khớp với model TaiKhoan)
    public TaiKhoan getTaiKhoanByMaKH(int maKH) {
        String sql = "SELECT * FROM khachhang WHERE MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH); 
            rs = ps.executeQuery();
            if (rs.next()) {
                return new TaiKhoan(
                        rs.getInt("MaKH"), 
                        rs.getString("HoTen"),
                        rs.getString("DiaChi"),
                        rs.getString("DienThoai"),
                        rs.getString("Email"),
                        rs.getString("Email"),     // Giả lập username = email
                        rs.getString("MatKhau"),   // Lấy MatKhau
                        rs.getInt("VaiTro")      // Lấy VaiTro
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

    // Hàm đóng kết nối
    private void closeConnections() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}