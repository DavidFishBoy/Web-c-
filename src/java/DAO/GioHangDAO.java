package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.GioHang;
import util.DBConnect;

public class GioHangDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * SỬA: Đổi tham số từ String maKH -> int maKH
     */
    public List<GioHang> getGioHangByMaKH(int maKH) {
        List<GioHang> list = new ArrayList<>();
        String sql = "SELECT gh.MaGH, gh.MaKH, gh.MaCTSP, gh.SoLuong, "
                + "sp.TenSP, kc.TenKichCo, ctsp.GiaBan, sp.HinhAnh "
                + "FROM giohang gh "
                + "JOIN chitietsp ctsp ON gh.MaCTSP = ctsp.MaCTSP "
                + "JOIN sanpham sp ON ctsp.MaSP = sp.MaSP "
                + "JOIN kichco kc ON ctsp.MaKC = kc.MaKC "
                + "WHERE gh.MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH); // SỬA: setInt
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new GioHang(
                        rs.getInt("MaGH"),
                        rs.getInt("MaKH"),
                        rs.getInt("MaCTSP"),
                        rs.getInt("SoLuong"),
                        rs.getString("TenSP"),
                        rs.getString("TenKichCo"),
                        rs.getDouble("GiaBan"),
                        rs.getString("HinhAnh")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
    public int getSoLuongTrongGio(int maKH) {
        String sql = "SELECT SUM(SoLuong) AS TongSoLuong FROM giohang WHERE MaKH = ?";
        int soLuong = 0;
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH);
            rs = ps.executeQuery();
            if (rs.next()) {
                soLuong = rs.getInt("TongSoLuong");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(); // Dùng hàm tiện ích đã có của bạn
        }
        return soLuong;
    }

    /**
     * SỬA: Đổi tham số từ String maKH -> int maKH
     */
    public GioHang checkItemTonTai(int maKH, int maCTSP) {
        String sql = "SELECT * FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH); // SỬA: setInt
            ps.setInt(2, maCTSP);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new GioHang(
                        rs.getInt("MaGH"),
                        rs.getInt("MaKH"),
                        rs.getInt("MaCTSP"),
                        rs.getInt("SoLuong")
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
     * SỬA: Đổi tham số từ String maKH -> int maKH
     */
    public void addItem(int maKH, int maCTSP, int soLuong) {
        String sql = "INSERT INTO giohang (MaKH, MaCTSP, SoLuong) VALUES (?, ?, ?)";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH); // SỬA: setInt
            ps.setInt(2, maCTSP);
            ps.setInt(3, soLuong);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * SỬA: Đổi tham số từ String maKH -> int maKH
     */
    public void updateItem(int maKH, int maCTSP, int soLuongMoi) {
        String sql = "UPDATE giohang SET SoLuong = ? WHERE MaCTSP = ? AND MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, soLuongMoi);
            ps.setInt(2, maCTSP);
            ps.setInt(3, maKH); // SỬA: setInt
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * SỬA: Đổi tham số từ String maKH -> int maKH
     */
    public void removeItem(int maKH, int maCTSP) {
        String sql = "DELETE FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH); // SỬA: setInt
            ps.setInt(2, maCTSP);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * SỬA: Đổi tham số từ String maKH -> int maKH
     * Đây là hàm gây lỗi ban đầu của bạn.
     */
    public void clearGioHang(int maKH) {
        String sql = "DELETE FROM giohang WHERE MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, maKH); // SỬA: setInt
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    // Hàm tiện ích để đóng kết nối
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