package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.ChiTietHD;
import util.DBConnect;

public class HoaDonDAO {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /**
     * HÀM QUAN TRỌNG: Lấy chi tiết các sản phẩm trong 1 hóa đơn
     * (Join 4 bảng: chitiethd, chitietsp, sanpham, kichco)
     */
    public List<ChiTietHD> getChiTietHDByMaHD(int maHD) {
        List<ChiTietHD> listCT = new ArrayList<>();
        
        String sql = "SELECT ct.MaCT, ct.MaHD, ct.MaCTSP, ct.DonGia, ct.SoLuong, "
                   + "sp.TenSP, kc.TenKichCo "
                   + "FROM chitiethd ct "
                   + "JOIN chitietsp ctsp ON ct.MaCTSP = ctsp.MaCTSP "
                   + "JOIN sanpham sp ON ctsp.MaSP = sp.MaSP "
                   + "JOIN kichco kc ON ctsp.MaKC = kc.MaKC "
                   + "WHERE ct.MaHD = ?";
        
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
            closeConnections();
        }
        return listCT;
    }
    

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