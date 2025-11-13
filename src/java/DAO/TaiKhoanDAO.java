package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.NhanVien;
import model.TaiKhoan;
import util.DBConnect;

public class TaiKhoanDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    public TaiKhoan checkKhachHangLogin(String userOrEmail, String pass) {
        String sql = "SELECT * FROM khachhang WHERE email = ? AND MatKhau = ?"; 
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userOrEmail);
            ps.setString(2, pass); 
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return new TaiKhoan(
                        rs.getString("MaKH"), 
                        rs.getString("HoTen"),
                        rs.getString("DiaChi"),
                        rs.getString("DienThoai"),
                        rs.getString("Email"),
                        rs.getString("Email"),      
                        rs.getString("MatKhau"),    
                        rs.getInt("VaiTro")       
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }
    
    public NhanVien checkNhanVienLogin(String userOrEmail, String pass) {
        String sql = "SELECT * FROM nhanvien WHERE (MaNV = ? OR email = ?) AND MatKhau = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userOrEmail);
            ps.setString(2, userOrEmail);
            ps.setString(3, pass); 
            
            rs = ps.executeQuery();
            if (rs.next()) {
                return new NhanVien(
                        rs.getString("MaNV"), 
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        null, 
                        null, 
                        rs.getString("MaNV"),     
                        rs.getString("MatKhau"),  
                        rs.getInt("VaiTro")     
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

   
    public TaiKhoan checkTaiKhoanTonTai(String email) {
        String sql = "SELECT * FROM khachhang WHERE email = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new TaiKhoan(
                        rs.getString("MaKH"), 
                        rs.getString("HoTen"),
                        rs.getString("DiaChi"),
                        rs.getString("DienThoai"),
                        rs.getString("Email"),
                        rs.getString("Email"),      
                        rs.getString("MatKhau"),    
                        rs.getInt("VaiTro")       
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

public boolean signup(String user, String pass, String email, String ten, String sdt, String diaChi) {
        // BƯỚC 1: SINH MÃ KHÁCH HÀNG (MaKH)
        String maKH = generateMaKH();
        
        // SỬA SQL: Thêm MaKH vào danh sách cột cần INSERT và thêm 1 placeholder '?'
        String sql = "INSERT INTO khachhang (MaKH, HoTen, DiaChi, DienThoai, Email, MatKhau, VaiTro, HieuLuc) "
                   + "VALUES (?, ?, ?, ?, ?, ?, 0, ?)"; 
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            
            // CÁC THAM SỐ SQL (Đúng thứ tự trong câu lệnh INSERT)
            ps.setString(1, maKH);    
            ps.setString(2, ten);      
            ps.setString(3, diaChi);  
            ps.setString(4, sdt);     
            ps.setString(5, email);   
            ps.setString(6, pass);    
            // ps.setInt(7, 0);          
            ps.setBoolean(7, true);     
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; 
        } catch (Exception e) {
            // Lỗi SQL thực sự sẽ được in ra console server (ví dụ: duplicate key)
            e.printStackTrace(); 
            return false; 
        } finally {
            closeConnections();
        }
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
    public List<TaiKhoan> getAllKhachHang() {
        List<TaiKhoan> list = new ArrayList<>();
        // Lấy tất cả khách hàng (VaiTro = 0)
        String sql = "SELECT * FROM khachhang WHERE VaiTro = 0";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                // Sử dụng constructor 8 tham số của model TaiKhoan
                // (Truyền Email 2 lần, 1 cho email, 1 cho username)
                list.add(new TaiKhoan(
                        rs.getString("MaKH"),
                        rs.getString("HoTen"),
                        rs.getString("DiaChi"),
                        rs.getString("DienThoai"),
                        rs.getString("Email"),
                        rs.getString("Email"), // Dùng Email cho trường username
                        rs.getString("MatKhau"),
                        rs.getInt("VaiTro"),
                        rs.getBoolean("HieuLuc") // Thêm HieuLuc
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    /**
     * MỚI: Cập nhật trạng thái HieuLuc (Active/Inactive) của tài khoản
     */
    public boolean updateHieuLuc(String maKH, boolean hieuLucMoi) {
        String sql = "UPDATE khachhang SET HieuLuc = ? WHERE MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, hieuLucMoi);
            ps.setString(2, maKH);
            
            return ps.executeUpdate() > 0; // Trả về true nếu thành công
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeConnections();
        }}
    // Dán 5 hàm này vào cuối file DAO/TaiKhoanDAO.java

    /**
     * MỚI: Lấy tất cả tài khoản Nhân viên
     */
    public List<NhanVien> getAllNhanVien() {
        List<NhanVien> list = new ArrayList<>();
        String sql = "SELECT * FROM nhanvien";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new NhanVien(
                        rs.getString("MaNV"),
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        rs.getString("MatKhau"),
                        rs.getInt("VaiTro")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    /**
     * MỚI: Lấy tổng doanh thu (cho Stat Card)
     */
    public double getTongDoanhThu() {
        // Lấy doanh thu của đơn (1) Đã thanh toán và (3) Đã giao hàng
        String sql = "SELECT SUM(ct.DonGia * ct.SoLuong) " +
                     "FROM chitiethd ct JOIN hoadon hd ON ct.MaHD = hd.MaHD " +
                     "WHERE hd.MaTrangThai IN (1, 3)";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return 0;
    }
public TaiKhoan getKhachHangByMaKH(String maKH) {
    // Sửa: Dùng bảng "khachhang"
    String sql = "SELECT * FROM khachhang WHERE MaKH = ?";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    
    try {
        con = new DBConnect().getConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, maKH);
        rs = ps.executeQuery();
        
        if (rs.next()) {
            TaiKhoan tk = new TaiKhoan();
            tk.setMaKH(rs.getString("MaKH"));
            tk.setHoTen(rs.getString("HoTen"));
            tk.setEmail(rs.getString("Email"));
            tk.setDienThoai(rs.getString("DienThoai")); // Sửa: Cột "DienThoai"
            tk.setDiaChi(rs.getString("DiaChi"));
            tk.setRole(rs.getInt("VaiTro"));       // Sửa: Cột "VaiTro"
            tk.setHieuLuc(rs.getBoolean("HieuLuc"));   // Sửa: Dùng getBoolean
            
            // Bạn có thể cần set cả MatKhau nếu model của bạn yêu cầu
            tk.setPassword(rs.getString("MatKhau")); 
            return tk;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Tự thêm hàm closeConnections của bạn
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
    return null;
}

/**
 * MỚI: Cập nhật thông tin khách hàng (dùng cho trang Sửa)
 * (Phiên bản đã sửa đúng tên bảng và tên cột)
 */
public boolean updateKhachHang(TaiKhoan kh) {
    // Sửa: Dùng bảng "khachhang" và cột "DienThoai"
    String sql = "UPDATE khachhang SET HoTen = ?, Email = ?, DienThoai = ?, DiaChi = ? WHERE MaKH = ?";
    Connection con = null;
    PreparedStatement ps = null;
    
    try {
        con = new DBConnect().getConnection();
        ps = con.prepareStatement(sql);
        ps.setString(1, kh.getHoTen());
        ps.setString(2, kh.getEmail());
        ps.setString(3, kh.getDienThoai()); // Sửa: getDienThoai
        ps.setString(4, kh.getDiaChi());
        ps.setString(5, kh.getMaKH());
        
        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    } finally {
        // Tự thêm hàm closeConnections của bạn
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (con != null) con.close(); } catch (Exception e) {}
    }
}
  /**
     * MỚI: Lấy tổng số đơn hàng đã bán (cho Stat Card)
     */
    public int getTongSoDonHang() {
        String sql = "SELECT COUNT(*) FROM hoadon WHERE MaTrangThai IN (1, 3)";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return 0;
    }
    /**
     * MỚI: Lấy tổng số khách hàng (cho Stat Card)
     */
    public int getTongSoKhachHang() {
        String sql = "SELECT COUNT(*) FROM khachhang WHERE VaiTro = 0";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return 0;
    }

    /**
     * MỚI: Lấy một Nhân viên theo MaNV
     */
    public NhanVien getNhanVienByMaNV(String maNV) {
        String sql = "SELECT * FROM nhanvien WHERE MaNV = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maNV);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new NhanVien(
                        rs.getString("MaNV"),
                        rs.getString("HoTen"),
                        rs.getString("Email"),
                        rs.getString("MatKhau"),
                        rs.getInt("VaiTro")
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
     * MỚI: Thêm một Nhân viên mới
     */
    public void addNhanVien(NhanVien nv) {
        String sql = "INSERT INTO nhanvien (MaNV, HoTen, Email, MatKhau, VaiTro) VALUES (?, ?, ?, ?, ?)";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, nv.getMaNV());
            ps.setString(2, nv.getHoTen());
            ps.setString(3, nv.getEmail());
            ps.setString(4, nv.getPassword());
            ps.setInt(5, nv.getRole());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * MỚI: Cập nhật một Nhân viên
     */
    public void updateNhanVien(NhanVien nv) {
        // Cập nhật cả mật khẩu nếu nó được cung cấp
        String sql = "UPDATE nhanvien SET HoTen = ?, Email = ?, MatKhau = ?, VaiTro = ? WHERE MaNV = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, nv.getHoTen());
            ps.setString(2, nv.getEmail());
            ps.setString(3, nv.getPassword());
            ps.setInt(4, nv.getRole());
            ps.setString(5, nv.getMaNV());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * MỚI: Xóa một Nhân viên
     */
    public void deleteNhanVien(String maNV) {
        String sql = "DELETE FROM nhanvien WHERE MaNV = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maNV);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    private String generateMaKH() {
        // Tạo chuỗi MaKH có tiền tố "KH" + 15 chữ số cuối của System.currentTimeMillis()
        // Đảm bảo MaKH duy nhất và nằm trong giới hạn VARCHAR(20)
        String timestamp = String.valueOf(System.currentTimeMillis());
        return "KH" + timestamp; 
    }
}