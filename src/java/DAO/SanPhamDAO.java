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
import model.NhaCungCap;
import model.ThongKeSanPham;

public class SanPhamDAO {

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // --- HÀM ĐÓNG KẾT NỐI (DÙNG CHUNG) ---
    private void closeConnections() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // --- CÁC HÀM CỦA SẢN PHẨM ---
    public void addSanPham(SanPham sp) {
        String sql = "INSERT INTO sanpham (TenSP, MaDM, MoTaDonVi, GiaCoBan, NgaySanXuat, LuotXem, MoTa, MaNCC) "
                + "VALUES (?, ?, ?, ?, NOW(), 0, ?, ?)";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, sp.getTenSP());
            ps.setInt(2, sp.getMaDM());
            ps.setString(3, sp.getMoTaDonVi());
            ps.setDouble(4, sp.getGiaCoBan());
            ps.setString(5, sp.getMoTa());
            ps.setString(6, sp.getMaNCC());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    public List<SanPham> getNewSanPham(int topN) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.*, hinhsp.URLHinhAnh "
                + "FROM sanpham sp "
                + "LEFT JOIN hinhanhsanpham hinhsp ON sp.MaSP = hinhsp.MaSP AND hinhsp.IsDefault = 1 "
                + "ORDER BY sp.NgaySanXuat DESC LIMIT ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, topN);
            rs = ps.executeQuery();
            while (rs.next()) {
                SanPham sp = new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getString("MoTaDonVi"),
                        rs.getDouble("GiaCoBan"),
                        rs.getDate("NgaySanXuat"),
                        rs.getInt("LuotXem"),
                        rs.getString("MoTa"),
                        rs.getString("MaNCC")
                );
                sp.setHinhAnh(rs.getString("URLHinhAnh")); // Set ảnh
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

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

    public void updateSanPham(SanPham sp) {
        String sql = "UPDATE sanpham SET TenSP = ?, MaDM = ?, MoTaDonVi = ?, GiaCoBan = ?, MoTa = ?, MaNCC = ? "
                + "WHERE MaSP = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, sp.getTenSP());
            ps.setInt(2, sp.getMaDM());
            ps.setString(3, sp.getMoTaDonVi());
            ps.setDouble(4, sp.getGiaCoBan());
            ps.setString(5, sp.getMoTa());
            ps.setString(6, sp.getMaNCC());
            ps.setInt(7, sp.getMaSP()); // Tham số cho WHERE

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

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
        String sql = "SELECT sp.*, hinhsp.URLHinhAnh "
                + "FROM sanpham sp "
                + "LEFT JOIN hinhanhsanpham hinhsp ON sp.MaSP = hinhsp.MaSP AND hinhsp.IsDefault = 1 "
                + "ORDER BY sp.NgaySanXuat DESC";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                SanPham sp = new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getString("MoTaDonVi"),
                        rs.getDouble("GiaCoBan"),
                        rs.getDate("NgaySanXuat"),
                        rs.getInt("LuotXem"),
                        rs.getString("MoTa"),
                        rs.getString("MaNCC")
                );
                sp.setHinhAnh(rs.getString("URLHinhAnh"));
                listSP.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listSP;
    }

    public int countSanPhamByFilter(String maDM, String keyword) {
        StringBuilder sql = new StringBuilder("SELECT count(*) FROM sanpham sp");
        List<Object> params = new ArrayList<>();
        List<String> conditions = new ArrayList<>();

        if (maDM != null && !maDM.isEmpty()) {
            conditions.add("sp.MaDM = ?");
            params.add(maDM);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("sp.TenSP LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        if (!conditions.isEmpty()) {
            sql.append(" WHERE ").append(String.join(" AND ", conditions));
        }

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

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

    public List<SanPham> getSanPhamByFilter(String maDM, String keyword, String sort, int page, int pageSize) {
        List<SanPham> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
                "SELECT sp.*, hinhsp.URLHinhAnh "
                + "FROM sanpham sp "
                + "LEFT JOIN hinhanhsanpham hinhsp ON sp.MaSP = hinhsp.MaSP AND hinhsp.IsDefault = 1"
        );

        List<Object> params = new ArrayList<>();
        List<String> conditions = new ArrayList<>();

        if (maDM != null && !maDM.isEmpty()) {
            conditions.add("sp.MaDM = ?");
            params.add(maDM);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            conditions.add("sp.TenSP LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        if (!conditions.isEmpty()) {
            sql.append(" WHERE ").append(String.join(" AND ", conditions));
        }

        if (sort != null && !sort.isEmpty()) {
            if ("price_asc".equals(sort)) {
                sql.append(" ORDER BY sp.GiaCoBan ASC");
            } else if ("price_desc".equals(sort)) {
                sql.append(" ORDER BY sp.GiaCoBan DESC");
            } else if ("name_asc".equals(sort)) {
                sql.append(" ORDER BY sp.TenSP ASC");
            }
        } else {
            sql.append(" ORDER BY sp.MaSP DESC");
        }

        sql.append(" LIMIT ? OFFSET ?");
        params.add(pageSize);
        params.add((page - 1) * pageSize);

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                SanPham sp = new SanPham();
                sp.setMaSP(rs.getInt("MaSP"));
                sp.setTenSP(rs.getString("TenSP"));
                sp.setMaDM(rs.getInt("MaDM"));
                sp.setMoTaDonVi(rs.getString("MoTaDonVi"));
                sp.setGiaCoBan(rs.getDouble("GiaCoBan"));
                sp.setNgaySanXuat(rs.getDate("NgaySanXuat"));
                sp.setLuotXem(rs.getInt("LuotXem"));
                sp.setMoTa(rs.getString("MoTa"));
                sp.setMaNCC(rs.getString("MaNCC"));
                sp.setHinhAnh(rs.getString("URLHinhAnh"));

                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    public List<SanPham> getTopViewed(int topN) {
        List<SanPham> list = new ArrayList<>();
        String sql = "SELECT sp.*, hinhsp.URLHinhAnh "
                + "FROM sanpham sp "
                + "LEFT JOIN hinhanhsanpham hinhsp ON sp.MaSP = hinhsp.MaSP AND hinhsp.IsDefault = 1 "
                + "ORDER BY sp.LuotXem DESC LIMIT ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, topN);
            rs = ps.executeQuery();
            while (rs.next()) {
                SanPham sp = new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getString("MoTaDonVi"),
                        rs.getDouble("GiaCoBan"),
                        rs.getDate("NgaySanXuat"),
                        rs.getInt("LuotXem"),
                        rs.getString("MoTa"),
                        rs.getString("MaNCC")
                );
                sp.setHinhAnh(rs.getString("URLHinhAnh"));
                list.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    public SanPham getSanPhamByMaSP(int maSP) {
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
                        rs.getString("MoTaDonVi"),
                        rs.getDouble("GiaCoBan"),
                        rs.getDate("NgaySanXuat"),
                        rs.getInt("LuotXem"),
                        rs.getString("MoTa"),
                        rs.getString("MaNCC")
                );

                sp.setTenDanhMuc(rs.getString("TenDM"));
                sp.setTenNhaCungCap(rs.getString("TenCty"));
                return sp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

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
                        rs.getString("URLHinhAnh"),
                        rs.getBoolean("IsDefault")
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
        String sql = "SELECT sp.*, hinhsp.URLHinhAnh "
                + "FROM sanpham sp "
                + "LEFT JOIN hinhanhsanpham hinhsp ON sp.MaSP = hinhsp.MaSP AND hinhsp.IsDefault = 1 "
                + "WHERE sp.MaDM = ? AND sp.MaSP != ? "
                + "ORDER BY NgaySanXuat DESC "
                + "LIMIT 4";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maDM);
            ps.setInt(2, maSP_hienTai);
            rs = ps.executeQuery();
            while (rs.next()) {
                SanPham sp = new SanPham(
                        rs.getInt("MaSP"),
                        rs.getString("TenSP"),
                        rs.getInt("MaDM"),
                        rs.getString("MoTaDonVi"),
                        rs.getDouble("GiaCoBan"),
                        rs.getDate("NgaySanXuat"),
                        rs.getInt("LuotXem"),
                        rs.getString("MoTa"),
                        rs.getString("MaNCC")
                );
                sp.setHinhAnh(rs.getString("URLHinhAnh"));
                listSP.add(sp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listSP;
    }

    // --- CÁC HÀM CRUD CHO DANH MỤC (ĐÃ SỬA LỖI) ---
    public List<DanhMuc> getAllDanhMuc() {
        List<DanhMuc> listDM = new ArrayList<>();
        String sql = "SELECT * FROM danhmuc";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                // SỬA: Gọi đúng constructor 4 tham số của bạn
                listDM.add(new DanhMuc(
                        rs.getInt("MaDM"),
                        rs.getString("TenDM"),
                        rs.getString("MoTa"), // CSDL có MoTa
                        rs.getString("Hinh") // CSDL có Hinh
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return listDM;
    }

    public DanhMuc getDanhMucByMaDM(int maDM) {
        String sql = "SELECT * FROM danhmuc WHERE MaDM = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, maDM);
            rs = ps.executeQuery();
            if (rs.next()) {
                // SỬA: Gọi đúng constructor 4 tham số
                return new DanhMuc(
                        rs.getInt("MaDM"),
                        rs.getString("TenDM"),
                        rs.getString("MoTa"),
                        rs.getString("Hinh")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }
    public List<NhaCungCap> getAllNhaCungCap() {
        List<NhaCungCap> list = new ArrayList<>();
        String sql = "SELECT * FROM nhacc";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new NhaCungCap(
                        rs.getString("MaNCC"),
                        rs.getString("TenCty"),
                        rs.getString("TenLH"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("DiaChi"),
                        rs.getString("MoTa")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    public List<ThongKeSanPham> getTopSanPhamBanChay(int limit) {
        List<ThongKeSanPham> list = new ArrayList<>();
        String sql = "SELECT sp.TenSP, SUM(ct.SoLuong) AS TongSoLuongBan "
                + "FROM chitiethd ct "
                + "JOIN chitietsp ctsp ON ct.MaCTSP = ctsp.MaCTSP "
                + "JOIN sanpham sp ON ctsp.MaSP = sp.MaSP "
                + "JOIN hoadon hd ON ct.MaHD = hd.MaHD "
                + "WHERE hd.MaTrangThai IN (1, 3) "
                + // Chỉ tính đơn đã thanh toán/đã giao
                "GROUP BY sp.MaSP, sp.TenSP "
                + "ORDER BY TongSoLuongBan DESC "
                + "LIMIT ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new ThongKeSanPham(
                        rs.getString("TenSP"),
                        rs.getInt("TongSoLuongBan")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return list;
    }

    public NhaCungCap getNhaCungCapByMaNCC(String maNCC) {
        String sql = "SELECT * FROM nhacc WHERE MaNCC = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maNCC);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new NhaCungCap(
                        rs.getString("MaNCC"),
                        rs.getString("TenCty"),
                        rs.getString("TenLH"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getString("DiaChi"),
                        rs.getString("MoTa")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
        return null;
    }

    public void addNhaCungCap(NhaCungCap ncc) {
        String sql = "INSERT INTO nhacc (MaNCC, TenCty, TenLH, Email, Phone, DiaChi, MoTa) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, ncc.getMaNCC());
            ps.setString(2, ncc.getTenCty());
            ps.setString(3, ncc.getTenLH());
            ps.setString(4, ncc.getEmail());
            ps.setString(5, ncc.getPhone());
            ps.setString(6, ncc.getDiaChi());
            ps.setString(7, ncc.getMoTa());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }

    public void updateNhaCungCap(NhaCungCap ncc) {
        String sql = "UPDATE nhacc SET TenCty = ?, TenLH = ?, Email = ?, Phone = ?, DiaChi = ?, MoTa = ? WHERE MaNCC = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, ncc.getTenCty());
            ps.setString(2, ncc.getTenLH());
            ps.setString(3, ncc.getEmail());
            ps.setString(4, ncc.getPhone());
            ps.setString(5, ncc.getDiaChi());
            ps.setString(6, ncc.getMoTa());
            ps.setString(7, ncc.getMaNCC()); // WHERE
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
// BÊN TRONG CLASS DAO/SanPhamDAO.java

    /**
     * MỚI: Đếm tổng số lượng chi tiết sản phẩm (cho phân trang)
     */
    public int getTongSoChiTietSP() {
        String sql = "SELECT COUNT(*) FROM chitietsp";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1); // Trả về tổng số
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Tự gọi hàm closeConnections của bạn
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {}
        }
        return 0;
    }
    /**
     * MỚI: Lấy danh sách tồn kho CÓ PHÂN TRANG (thay cho hàm cũ)
     */
    public List<SanPhamSize> getDanhSachTonKhoTheoTrang(int pageNumber, int pageSize) {
        List<SanPhamSize> list = new ArrayList<>();
        
        // Tính toán OFFSET (vị trí bắt đầu lấy)
        int offset = (pageNumber - 1) * pageSize;
        
        String sql = "SELECT ct.MaCTSP, sp.TenSP, kc.TenKichCo, ct.SoLuongTon " +
                     "FROM chitietsp ct " +
                     "JOIN sanpham sp ON ct.MaSP = sp.MaSP " +
                     "JOIN kichco kc ON ct.MaKC = kc.MaKC " +
                     "ORDER BY sp.TenSP, ct.MaCTSP " +
                     "LIMIT ? OFFSET ?"; // Thêm LIMIT và OFFSET
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, pageSize); // LIMIT
            ps.setInt(2, offset);   // OFFSET
            
            rs = ps.executeQuery();

            while (rs.next()) {
                SanPhamSize sps = new SanPhamSize();
                sps.setMaCTSP(rs.getInt("MaCTSP"));
                sps.setTenSP(rs.getString("TenSP")); // Đã sửa model ở lần trước
                sps.setTenKichCo(rs.getString("TenKichCo"));
                sps.setSoLuongTon(rs.getInt("SoLuongTon"));
                list.add(sps);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Tự gọi hàm closeConnections của bạn
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {}
        }
        return list;
    }
    public void deleteNhaCungCap(String maNCC) {
        String sql = "DELETE FROM nhacc WHERE MaNCC = ?";
        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, maNCC);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeConnections();
        }
    }
    public boolean updateSoLuongTon(int maCTSP, int soLuongMoi) {
        // Câu lệnh SQL update trực tiếp vào bảng chitietsp
        String sql = "UPDATE chitietsp SET SoLuongTon = ? WHERE MaCTSP = ?";
        
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = new DBConnect().getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, soLuongMoi);
            ps.setInt(2, maCTSP);
            
            // Trả về true nếu có ít nhất 1 dòng bị ảnh hưởng (tức là update thành công)
            return ps.executeUpdate() > 0; 
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            // Tự gọi hàm closeConnections của bạn (hoặc đóng thủ công)
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
