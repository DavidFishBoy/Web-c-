package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.HinhAnhSanPham;
import model.SanPham;
import model.SanPhamSize; 
import util.DBConnect;
import model.DanhMuc;
import model.KichCo;

public class SanPhamDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public void addSanPham(SanPham sp) {
        String sql = "INSERT INTO sanpham (TenSP, MaDM, GiaCoBan, MoTa, MaNCC, NgaySanXuat, LuotXem) "
                   + "VALUES (?, ?, ?, ?, ?, NOW(), 0)";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, sp.getTenSP());
            ps.setInt(2, sp.getMaDM());
            ps.setDouble(3, sp.getGiaCoBan());
            ps.setString(4, sp.getMoTa());
            ps.setString(5, sp.getMaNCC()); 
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    
    // HÀM getNewSanPham (ĐÃ SỬA LỖI SQL)
    public List<SanPham> getNewSanPham(int topN) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.MaDM, sp.GiaCoBan, sp.MoTa, sp.LuotXem, " +
                     " (SELECT ha.URLHinhAnh FROM hinhanhsanpham ha WHERE ha.MaSP = sp.MaSP LIMIT 1) AS HinhAnh " +
                     "FROM sanpham sp " +
                     "ORDER BY sp.NgaySanXuat DESC LIMIT ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, topN); 
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getDouble("GiaCoBan"),
                        rs.getString("HinhAnh"), 
                        rs.getString("MoTa"),
                        rs.getInt("LuotXem")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    /**
     * HÀM MỚI: Xóa một sản phẩm khỏi CSDL theo MaSP
     */
    public void deleteSanPham(int maSP) {
        String sql = "DELETE FROM sanpham WHERE MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maSP);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * HÀM MỚI: Cập nhật thông tin một sản phẩm (Đã xóa HinhAnh)
     */
    public void updateSanPham(SanPham sp) {
        String sql = "UPDATE sanpham SET TenSP = ?, MaDM = ?, GiaCoBan = ?, MoTa = ?, MaNCC = ? "
                   + "WHERE MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, sp.getTenSP());
            ps.setInt(2, sp.getMaDM());
            ps.setDouble(3, sp.getGiaCoBan());
            ps.setString(4, sp.getMoTa());
            ps.setString(5, sp.getMaNCC());
            ps.setInt(6, sp.getMaSP()); // Tham số cho WHERE
            
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    
    // =========================================================================
    // CÁC HÀM CŨ ĐÃ CÓ
    // =========================================================================

    /**
     * HÀM MỚI: Lấy tất cả KÍCH CỠ (Không đổi)
     */
    public List<KichCo> getAllKichCo() {
        List<KichCo> listKC = new ArrayList<>();
        String sql = "SELECT * FROM kichco ORDER BY MaKC";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                listKC.add(new KichCo(
                        rs.getInt("MaKC"),
                        rs.getString("TenKichCo")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listKC;
    }
    
    // HÀM getAllSanPhamSortedByDate (ĐÃ SỬA LỖI SQL)
    public List<SanPham> getAllSanPhamSortedByDate() {
        List<SanPham> listSP = new ArrayList<>();
        // SỬA SQL: Thêm cột ảo HinhAnh
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.MaDM, sp.GiaCoBan, sp.MoTa, sp.LuotXem, " +
                     " (SELECT ha.URLHinhAnh FROM hinhanhsanpham ha WHERE ha.MaSP = sp.MaSP LIMIT 1) AS HinhAnh " +
                     "FROM sanpham sp " +
                     "ORDER BY sp.NgaySanXuat DESC";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                listSP.add(new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getDouble("GiaCoBan"),
                        rs.getString("HinhAnh"),
                        rs.getString("MoTa"),
                        rs.getInt("LuotXem")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listSP;
    }
    
    // HÀM getSanPhamByFilter (ĐÃ SỬA LỖI SQL)
    public List<SanPham> getSanPhamByFilter(String maDM_raw, String maKC_raw, String sort_raw) {
        List<SanPham> listSP = new ArrayList<>();

        // SỬA SQL:
        // 1. Dùng DISTINCT
        // 2. Thêm cột ảo HinhAnh
        StringBuilder sql = new StringBuilder("SELECT DISTINCT sp.MaSP, sp.TenSP, sp.MaDM, sp.GiaCoBan, sp.MoTa, sp.LuotXem, ")
                                .append(" (SELECT ha.URLHinhAnh FROM hinhanhsanpham ha WHERE ha.MaSP = sp.MaSP LIMIT 1) AS HinhAnh ")
                                .append("FROM sanpham sp ");

        if (maKC_raw != null && !maKC_raw.isEmpty()) {
            sql.append(" JOIN chitietsp ct ON sp.MaSP = ct.MaSP ");
        }
        sql.append(" WHERE 1=1 "); 

        if (maDM_raw != null && !maDM_raw.isEmpty()) {
            sql.append(" AND sp.MaDM = ? ");
        }

        if (maKC_raw != null && !maKC_raw.isEmpty()) {
            sql.append(" AND ct.MaKC = ? ");
        }

        if ("price_asc".equals(sort_raw)) {
            sql.append(" ORDER BY sp.GiaCoBan ASC");
        } else if ("price_desc".equals(sort_raw)) {
            sql.append(" ORDER BY sp.GiaCoBan DESC");
        } else {
            sql.append(" ORDER BY sp.NgaySanXuat DESC");
        }

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql.toString());

            int paramIndex = 1;
            if (maDM_raw != null && !maDM_raw.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(maDM_raw));
            }
            if (maKC_raw != null && !maKC_raw.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(maKC_raw));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                listSP.add(new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getDouble("GiaCoBan"),
                        rs.getString("HinhAnh"),
                        rs.getString("MoTa"),
                        rs.getInt("LuotXem")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listSP;
    }    
    
    // HÀM getTopViewed (ĐÃ SỬA LỖI SQL)
    public List<SanPham> getTopViewed(int topN) {
        List<SanPham> list = new ArrayList<>();
        // SỬA SQL: Thêm cột ảo HinhAnh
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.MaDM, sp.GiaCoBan, sp.MoTa, sp.LuotXem, " +
                     " (SELECT ha.URLHinhAnh FROM hinhanhsanpham ha WHERE ha.MaSP = sp.MaSP LIMIT 1) AS HinhAnh " +
                     "FROM sanpham sp " +
                     "ORDER BY sp.LuotXem DESC LIMIT ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, topN); 
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getDouble("GiaCoBan"),
                        rs.getString("HinhAnh"),
                        rs.getString("MoTa"),
                        rs.getInt("LuotXem")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    /**
     * Lấy tất cả DANH MỤC (Không đổi)
     */
    public List<DanhMuc> getAllDanhMuc() {
        List<DanhMuc> listDM = new ArrayList<>();
        String sql = "SELECT MaDM, TenDM, Hinh FROM danhmuc";
        try {
            con = new DBConnect().getConnection(); 
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                listDM.add(new DanhMuc(
                        rs.getInt("MaDM"),
                        rs.getString("TenDM"),
                        rs.getString("Hinh") 
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listDM;
    }
    
    // HÀM getSanPhamByMaSP (ĐÃ SỬA LỖI SQL)
    public SanPham getSanPhamByMaSP(int maSP) {
        // SỬA SQL: Không SELECT sp.* nữa, chỉ chọn cột cụ thể
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.MaDM, sp.GiaCoBan, sp.MoTa, sp.LuotXem, sp.MaNCC, " +
                     " dm.TenDM, ncc.TenCty " +
                     "FROM sanpham sp " +
                     "JOIN danhmuc dm ON sp.MaDM = dm.MaDM " +
                     "JOIN nhacc ncc ON sp.MaNCC = ncc.MaNCC " +
                     "WHERE sp.MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maSP);
            rs = ps.executeQuery();
            if (rs.next()) {
                SanPham sp = new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getDouble("GiaCoBan"),
                        null, // <-- SỬA: Đặt là null, vì ảnh sẽ được lấy riêng
                        rs.getString("MoTa"),
                        rs.getInt("LuotXem")
                );
                
                sp.setTenDanhMuc(rs.getString("TenDM"));
                sp.setTenNhaCungCap(rs.getString("TenCty"));
                sp.setMaNCC(rs.getString("MaNCC")); 
                return sp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

    // Hàm lấy các size của 1 sản phẩm (Không đổi)
    public List<SanPhamSize> getChiTietSPByMaSP(int maSP) {
        List<SanPhamSize> listSize = new ArrayList<>();
        String sql = "SELECT ct.MaCTSP, ct.MaSP, kc.TenKichCo, ct.SoLuongTon, ct.GiaBan "
                   + "FROM chitietsp ct "
                   + "JOIN kichco kc ON ct.MaKC = kc.MaKC "
                   + "WHERE ct.MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maSP);
            rs = ps.executeQuery();
            while (rs.next()) {
                listSize.add(new SanPhamSize(
                        rs.getInt("MaCTSP"),
                        rs.getInt("MaSP"),
                        rs.getString("TenKichCo"),
                        rs.getInt("SoLuongTon"),
                        rs.getDouble("GiaBan")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listSize;
    }
    
    // Hàm lấy gallery ảnh (Không đổi)
    public List<HinhAnhSanPham> getListHinhAnhByMaSP(int maSP) {
        List<HinhAnhSanPham> listAnh = new ArrayList<>();
        String sql = "SELECT * FROM hinhanhsanpham WHERE MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maSP);
            rs = ps.executeQuery();
            while (rs.next()) {
                listAnh.add(new HinhAnhSanPham(
                        rs.getInt("MaHinhAnh"),
                        rs.getInt("MaSP"),
                        rs.getString("URLHinhAnh")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listAnh;
    }
    
    // HÀM getSanPhamLienQuan (ĐÃ SỬA LỖI SQL)
    public List<SanPham> getSanPhamLienQuan(int maDM, int maSP_hienTai) {
        List<SanPham> listSP = new ArrayList<>();
        // SỬA SQL: Thêm cột ảo HinhAnh
        String sql = "SELECT sp.MaSP, sp.TenSP, sp.MaDM, sp.GiaCoBan, sp.MoTa, sp.LuotXem, " +
                     " (SELECT ha.URLHinhAnh FROM hinhanhsanpham ha WHERE ha.MaSP = sp.MaSP LIMIT 1) AS HinhAnh " +
                     "FROM sanpham sp "
                   + "WHERE MaDM = ? AND MaSP != ? "
                   + "ORDER BY NgaySanXuat DESC " 
                   + "LIMIT 4";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maDM);
            ps.setInt(2, maSP_hienTai);
            rs = ps.executeQuery();
            while (rs.next()) {
                listSP.add(new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getDouble("GiaCoBan"),
                        rs.getString("HinhAnh"),
                        rs.getString("MoTa"),
                        rs.getInt("LuotXem")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listSP;
    }

    // Hàm đóng kết nối (Không đổi)
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