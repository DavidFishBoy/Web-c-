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

  
    public List<GioHang> getGioHangByMaKH(String maKH) { 
        List<GioHang> list = new ArrayList<>();
        String sql = "SELECT gh.MaGH, gh.MaKH, gh.MaCTSP, gh.SoLuong, "
                + "sp.TenSP, kc.TenKichCo, ctsp.GiaBan, hinhsp.URLHinhAnh " 
                + "FROM giohang gh "
                + "JOIN chitietsp ctsp ON gh.MaCTSP = ctsp.MaCTSP "
                + "JOIN sanpham sp ON ctsp.MaSP = sp.MaSP "
                + "JOIN kichco kc ON ctsp.MaKC = kc.MaKC "
                // SỬA: JOIN với HinhAnhSanPham để lấy ảnh default
                + "LEFT JOIN hinhanhsanpham hinhsp ON sp.MaSP = hinhsp.MaSP AND hinhsp.IsDefault = 1 "
                + "WHERE gh.MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maKH); 
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new GioHang(
                        rs.getInt("MaGH"),
                        rs.getString("MaKH"), 
                        rs.getInt("MaCTSP"),
                        rs.getInt("SoLuong"),
                        rs.getString("TenSP"),
                        rs.getString("TenKichCo"),
                        rs.getDouble("GiaBan"),
                        rs.getString("URLHinhAnh") 
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }
 
    public int getSoLuongTrongGio(String maKH) { 
        String sql = "SELECT SUM(SoLuong) AS TongSoLuong FROM giohang WHERE MaKH = ?";
        int soLuong = 0;
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maKH); // SỬA
            rs = ps.executeQuery();
            if (rs.next()) {
                soLuong = rs.getInt("TongSoLuong");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections(); 
        }
        return soLuong;
    }


    public GioHang checkItemTonTai(String maKH, int maCTSP) { 
        String sql = "SELECT * FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maKH);
            ps.setInt(2, maCTSP);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new GioHang(
                        rs.getInt("MaGH"),
                        rs.getString("MaKH"), 
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

    public void addItem(String maKH, int maCTSP, int soLuong) { 
        String sql = "INSERT INTO giohang (MaKH, MaCTSP, SoLuong) VALUES (?, ?, ?)";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maKH); 
            ps.setInt(2, maCTSP);
            ps.setInt(3, soLuong);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }


    public void updateItem(String maKH, int maCTSP, int soLuongMoi) { 
        String sql = "UPDATE giohang SET SoLuong = ? WHERE MaCTSP = ? AND MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, soLuongMoi);
            ps.setInt(2, maCTSP);
            ps.setString(3, maKH); 
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    public void removeItem(String maKH, int maCTSP) { // SỬA
        String sql = "DELETE FROM giohang WHERE MaKH = ? AND MaCTSP = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maKH); // SỬA: setString
            ps.setInt(2, maCTSP);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }


    public void clearGioHang(String maKH) { 
        String sql = "DELETE FROM giohang WHERE MaKH = ?";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, maKH); 
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

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