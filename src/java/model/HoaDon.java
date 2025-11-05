package model;

// Sử dụng java.sql.Date cho các trường ngày tháng
import java.sql.Date; 

public class HoaDon {

    private int maHD;
    private String maKH;
    private Date ngayDat;
    private Date ngayCan;
    private Date ngayGiao;
    private String tenNguoiNhan;
    private String diaChiGiaoHang;
    private String cachThanhToan;
    private String cachVanChuyen;
    private double phiVanChuyen;
    private int maTrangThai;
    private String maNV;
    private String ghiChu;

    // Constructors
    public HoaDon() {
    }

    // Constructor đầy đủ (bạn có thể thêm/bớt tùy nhu cầu)
    public HoaDon(int maHD, String maKH, Date ngayDat, Date ngayCan, Date ngayGiao, 
                  String tenNguoiNhan, String diaChiGiaoHang, String cachThanhToan, 
                  String cachVanChuyen, double phiVanChuyen, int maTrangThai, 
                  String maNV, String ghiChu) {
        this.maHD = maHD;
        this.maKH = maKH;
        this.ngayDat = ngayDat;
        this.ngayCan = ngayCan;
        this.ngayGiao = ngayGiao;
        this.tenNguoiNhan = tenNguoiNhan;
        this.diaChiGiaoHang = diaChiGiaoHang;
        this.cachThanhToan = cachThanhToan;
        this.cachVanChuyen = cachVanChuyen;
        this.phiVanChuyen = phiVanChuyen;
        this.maTrangThai = maTrangThai;
        this.maNV = maNV;
        this.ghiChu = ghiChu;
    }

    // Getters and Setters
    public int getMaHD() {
        return maHD;
    }

    public void setMaHD(int maHD) {
        this.maHD = maHD;
    }

    public String getMaKH() {
        return maKH;
    }

    public void setMaKH(String maKH) {
        this.maKH = maKH;
    }

    public Date getNgayDat() {
        return ngayDat;
    }

    public void setNgayDat(Date ngayDat) {
        this.ngayDat = ngayDat;
    }

    public Date getNgayCan() {
        return ngayCan;
    }

    public void setNgayCan(Date ngayCan) {
        this.ngayCan = ngayCan;
    }

    public Date getNgayGiao() {
        return ngayGiao;
    }

    public void setNgayGiao(Date ngayGiao) {
        this.ngayGiao = ngayGiao;
    }

    public String getTenNguoiNhan() {
        return tenNguoiNhan;
    }

    public void setTenNguoiNhan(String tenNguoiNhan) {
        this.tenNguoiNhan = tenNguoiNhan;
    }

    public String getDiaChiGiaoHang() {
        return diaChiGiaoHang;
    }

    public void setDiaChiGiaoHang(String diaChiGiaoHang) {
        this.diaChiGiaoHang = diaChiGiaoHang;
    }

    public String getCachThanhToan() {
        return cachThanhToan;
    }

    public void setCachThanhToan(String cachThanhToan) {
        this.cachThanhToan = cachThanhToan;
    }

    public String getCachVanChuyen() {
        return cachVanChuyen;
    }

    public void setCachVanChuyen(String cachVanChuyen) {
        this.cachVanChuyen = cachVanChuyen;
    }

    public double getPhiVanChuyen() {
        return phiVanChuyen;
    }

    public void setPhiVanChuyen(double phiVanChuyen) {
        this.phiVanChuyen = phiVanChuyen;
    }

    public int getMaTrangThai() {
        return maTrangThai;
    }

    public void setMaTrangThai(int maTrangThai) {
        this.maTrangThai = maTrangThai;
    }

    public String getMaNV() {
        return maNV;
    }

    public void setMaNV(String maNV) {
        this.maNV = maNV;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }
}