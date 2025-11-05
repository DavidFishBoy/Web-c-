package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.GioHang; 
import util.DBConnect;

public class GioHangDAO {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * Lấy danh sách giỏ hàng KÈM THÔNG TIN CHI TIẾT (Tên, Ảnh, Size, Giá)
     * (Đây là hàm DUY NHẤT để lấy danh sách giỏ hàng)
     */
    public List<GioHang> getListGioHangByMaKH(String maKH) {
        List<GioHang> listGioHang = new ArrayList<>();
        
        // Câu lệnh SQL JOIN 4 BẢNG: giohang, chitietsp, sanpham, kichco
        String sql = "SELECT gh.MaGH, gh.MaKH, gh.MaCTSP, gh.SoLuong, "
                   + "sp.TenSP, sp.HinhAnh, kc.TenKichCo, ct.GiaBan "
                   + "FROM giohang gh "
                   + "JOIN chitietsp ct ON gh.MaCTSP = ct.MaCTSP "
                   + "JOIN sanpham sp ON ct.MaSP = sp.MaSP "
                   + "JOIN kichco kc ON ct.MaKC = kc.MaKC "
                   + "WHERE gh.MaKH = ? "
                   + "ORDER BY gh.NgayChon DESC";
        
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                // Sử dụng Constructor đầy đủ của model GioHang
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
            closeConnections();
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
            closeConnections();
        }
        return tongTien;
    }

    // Thêm sản phẩm vào giỏ (hoặc cập nhật)
    public void themVaoGioHang(String maKH, int maCTSP, int soLuong) {
        String checkSql = "SELECT * FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        String updateSql = "UPDATE giohang SET SoLuong = SoLuong + ? WHERE MaKH = ? AND MaCTSP = ?";
        String insertSql = "INSERT INTO giohang (MaKH, MaCTSP, SoLuong, NgayChon) VALUES (?, ?, ?, CURDATE())";

        try {
            con = new DBConnect().getConnection();
            
            ps = con.prepareStatement(checkSql);
            ps.setString(1, maKH);
            ps.setInt(2, maCTSP);
            rs = ps.executeQuery();

            if (rs.next()) {
                ps.close();
                ps = con.prepareStatement(updateSql);
                ps.setInt(1, soLuong);
                ps.setString(2, maKH);
                ps.setInt(3, maCTSP);
                ps.executeUpdate();
            } else {
                ps.close();
                ps = con.prepareStatement(insertSql);
                ps.setString(1, maKH);
                ps.setInt(2, maCTSP);
                ps.setInt(3, soLuong);
                ps.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    // Cập nhật số lượng (dùng cho trang giohang.jsp)
    public void capNhatSoLuong(String maKH, int maCTSP, int soLuongMoi) {
        String sql = "UPDATE giohang SET SoLuong = ? WHERE MaKH = ? AND MaCTSP = ?";
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
            closeConnections();
        }
    }
public void xoaToanBoGioHang(String maKH) {
        String sql = "DELETE FROM giohang WHERE MaKH = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    // Xóa khỏi giỏ hàng
    public void xoaKhoiGioHang(String maKH, int maCTSP) {
        String sql = "DELETE FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maKH);
            ps.setInt(2, maCTSP);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    // Đếm số lượng sản phẩm khác nhau trong giỏ (cho icon header)
    public int getSoLuongTrongGio(String maKH) {
        String sql = "SELECT count(*) FROM giohang WHERE MaKH = ?";
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
            closeConnections();
        }
        return 0; // Trả về 0 nếu có lỗi
    }

    // Hàm đóng kết nối
    private void closeConnections() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}