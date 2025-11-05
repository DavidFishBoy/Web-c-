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

    // =========================================================================
    // CÁC HÀM CRUD MỚI CHO TRANG ADMIN
    // =========================================================================

    /**
     * HÀM MỚI: Thêm một sản phẩm mới vào CSDL
     * (Sử dụng cho trang admin.jsp)
     */
    public void addSanPham(SanPham sp) {
        // Câu lệnh SQL INSERT
        // NgaySanXuat sẽ tự động lấy ngày giờ hiện tại
        String sql = "INSERT INTO sanpham (TenSP, MaDM, GiaCoBan, HinhAnh, MoTa, MaNCC, NgaySanXuat, LuotXem) "
                   + "VALUES (?, ?, ?, ?, ?, ?, NOW(), 0)";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            
            // Set các tham số cho câu lệnh SQL
            ps.setString(1, sp.getTenSP());
            ps.setInt(2, sp.getMaDM());
            ps.setDouble(3, sp.getGiaCoBan());
            ps.setString(4, sp.getHinhAnh());
            ps.setString(5, sp.getMoTa());
            ps.setString(6, sp.getMaNCC()); // Giả sử bạn đã thêm MaNCC vào model SanPham
            
            // Thực thi câu lệnh
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * HÀM MỚI: Xóa một sản phẩm khỏi CSDL theo MaSP
     * (Sử dụng cho trang admin.jsp)
     */
    public void deleteSanPham(int maSP) {
        String sql = "DELETE FROM sanpham WHERE MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maSP);
            
            // Thực thi câu lệnh
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    /**
     * HÀM MỚI: Cập nhật thông tin một sản phẩm
     * (Sử dụng cho trang admin.jsp)
     */
    public void updateSanPham(SanPham sp) {
        String sql = "UPDATE sanpham SET TenSP = ?, MaDM = ?, GiaCoBan = ?, HinhAnh = ?, MoTa = ?, MaNCC = ? "
                   + "WHERE MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            
            // Set các tham số
            ps.setString(1, sp.getTenSP());
            ps.setInt(2, sp.getMaDM());
            ps.setDouble(3, sp.getGiaCoBan());
            ps.setString(4, sp.getHinhAnh());
            ps.setString(5, sp.getMoTa());
            ps.setString(6, sp.getMaNCC());
            ps.setInt(7, sp.getMaSP()); // Tham số cho WHERE
            
            // Thực thi
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
     * HÀM MỚI: Lấy tất cả KÍCH CỠ
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
    
    public List<SanPham> getAllSanPhamSortedByDate() {
        List<SanPham> listSP = new ArrayList<>();
        String sql = "SELECT * FROM sanpham ORDER BY NgaySanXuat DESC";
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
    
    public List<SanPham> getSanPhamByFilter(String maDM_raw, String maKC_raw, String sort_raw) {
        List<SanPham> listSP = new ArrayList<>();

        // (1) Bảng và JOIN
        // Dùng DISTINCT để không bị trùng sản phẩm khi JOIN với chitietsp
        StringBuilder sql = new StringBuilder("SELECT DISTINCT sp.* FROM sanpham sp ");

        // Nếu có lọc theo Size, chúng ta BẮT BUỘC phải JOIN
        if (maKC_raw != null && !maKC_raw.isEmpty()) {
            sql.append(" JOIN chitietsp ct ON sp.MaSP = ct.MaSP ");
        }

        // (2) Điều kiện WHERE
        sql.append(" WHERE 1=1 "); // Luôn đúng để dễ nối AND

        // Thêm điều kiện lọc Danh Mục
        if (maDM_raw != null && !maDM_raw.isEmpty()) {
            sql.append(" AND sp.MaDM = ? ");
        }

        // Thêm điều kiện lọc Size
        if (maKC_raw != null && !maKC_raw.isEmpty()) {
            sql.append(" AND ct.MaKC = ? ");
        }

        // (3) Sắp xếp ORDER BY
        if ("price_asc".equals(sort_raw)) {
            sql.append(" ORDER BY sp.GiaCoBan ASC");
        } else if ("price_desc".equals(sort_raw)) {
            sql.append(" ORDER BY sp.GiaCoBan DESC");
        } else {
            // Mặc định sắp xếp theo mới nhất
            sql.append(" ORDER BY sp.NgaySanXuat DESC");
        }

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql.toString());

            // (4) Set tham số (quan trọng)
            // Chúng ta cần một biến đếm vị trí tham số
            int paramIndex = 1;

            if (maDM_raw != null && !maDM_raw.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(maDM_raw));
            }

            if (maKC_raw != null && !maKC_raw.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(maKC_raw));
            }

            // (5) Thực thi
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
    
    // Hàm lấy Top sản phẩm xem nhiều (CHO HERO SLIDER)
    public List<SanPham> getTopViewed(int topN) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT * FROM sanpham ORDER BY LuotXem DESC LIMIT ?";
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
     * Lấy tất cả DANH MỤC
     */
    public List<DanhMuc> getAllDanhMuc() {
        List<DanhMuc> listDM = new ArrayList<>();
        String sql = "SELECT * FROM danhmuc";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                listDM.add(new DanhMuc(
                        rs.getInt("MaDM"),
                        rs.getString("TenDM")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listDM;
    }
    
    // Hàm lấy 1 sản phẩm theo MaSP (CHO TRANG CHI TIẾT)
    public SanPham getSanPhamByMaSP(int maSP) {
        // Cập nhật câu lệnh JOIN để lấy MaNCC
        String sql = "SELECT sp.*, dm.TenDM, ncc.TenCty "
                   + "FROM sanpham sp "
                   + "JOIN danhmuc dm ON sp.MaDM = dm.MaDM "
                   + "JOIN nhacc ncc ON sp.MaNCC = ncc.MaNCC "
                   + "WHERE sp.MaSP = ?";
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
                        rs.getString("HinhAnh"),
                        rs.getString("MoTa"),
                        rs.getInt("LuotXem")
                );
                // Set 2 trường mới lấy từ JOIN
                sp.setTenDanhMuc(rs.getString("TenDM"));
                sp.setTenNhaCungCap(rs.getString("TenCty"));
                sp.setMaNCC(rs.getString("MaNCC")); // Thêm MaNCC
                return sp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

    // Hàm lấy các size của 1 sản phẩm (CHO TRANG CHI TIẾT)
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
    
    public List<SanPham> getSanPhamLienQuan(int maDM, int maSP_hienTai) {
        List<SanPham> listSP = new ArrayList<>();
        // Lấy 4 sản phẩm cùng MaDM, loại trừ sản phẩm đang xem (maSP_hienTai)
        String sql = "SELECT * FROM sanpham "
                   + "WHERE MaDM = ? AND MaSP != ? "
                   + "ORDER BY NgaySanXuat DESC " // Sắp xếp mới nhất
                   + "LIMIT 4"; // Giới hạn 4 sản phẩm
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