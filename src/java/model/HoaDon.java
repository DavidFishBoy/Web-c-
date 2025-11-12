package model;

import java.sql.Date; 
// Bạn có thể dùng java.sql.Timestamp nếu muốn lấy cả giờ phút
// import java.sql.Timestamp; 

public class HoaDon {

    private int maHD;
    private int maKH;               
    private Date ngayDatHang;       
    private double tongTien;        
    private String hoTenNguoiNhan;
    private String diaChiGiaoHang;
    private String sdtNguoiNhan;    
    private String emailNguoiNhan; 
    private String ghiChu;
    private int maTrangThai;
    
   
    private Integer maNV; 

    // Constructors
    public HoaDon() {
    }

    // Constructor đầy đủ (đã cập nhật)
    public HoaDon(int maHD, int maKH, Date ngayDatHang, double tongTien, String hoTenNguoiNhan,
                  String diaChiGiaoHang, String sdtNguoiNhan, String emailNguoiNhan,
                  String ghiChu, int maTrangThai, Integer maNV) {
        this.maHD = maHD;
        this.maKH = maKH;
        this.ngayDatHang = ngayDatHang;
        this.tongTien = tongTien;
        this.hoTenNguoiNhan = hoTenNguoiNhan;
        this.diaChiGiaoHang = diaChiGiaoHang;
        this.sdtNguoiNhan = sdtNguoiNhan;
        this.emailNguoiNhan = emailNguoiNhan;
        this.ghiChu = ghiChu;
        this.maTrangThai = maTrangThai;
        this.maNV = maNV;
    }

    // Getters and Setters (đã cập nhật)

    public int getMaHD() {
        return maHD;
    }

    public void setMaHD(int maHD) {
        this.maHD = maHD;
    }

    public int getMaKH() {
        return maKH;
    }

    public void setMaKH(int maKH) {
        this.maKH = maKH;
    }

    public Date getNgayDatHang() {
        return ngayDatHang;
    }

    public void setNgayDatHang(Date ngayDatHang) {
        this.ngayDatHang = ngayDatHang;
    }

    public double getTongTien() {
        return tongTien;
    }

    public void setTongTien(double tongTien) {
        this.tongTien = tongTien;
    }

    public String getHoTenNguoiNhan() {
        return hoTenNguoiNhan;
    }

    public void setHoTenNguoiNhan(String hoTenNguoiNhan) {
        this.hoTenNguoiNhan = hoTenNguoiNhan;
    }

    public String getDiaChiGiaoHang() {
        return diaChiGiaoHang;
    }

    public void setDiaChiGiaoHang(String diaChiGiaoHang) {
        this.diaChiGiaoHang = diaChiGiaoHang;
    }

    public String getSdtNguoiNhan() {
        return sdtNguoiNhan;
    }

    public void setSdtNguoiNhan(String sdtNguoiNhan) {
        this.sdtNguoiNhan = sdtNguoiNhan;
    }

    public String getEmailNguoiNhan() {
        return emailNguoiNhan;
    }

    public void setEmailNguoiNhan(String emailNguoiNhan) {
        this.emailNguoiNhan = emailNguoiNhan;
    }

    public String getGhiChu() {
        return ghiChu;
    }

    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    public int getMaTrangThai() {
        return maTrangThai;
    }

    public void setMaTrangThai(int maTrangThai) {
        this.maTrangThai = maTrangThai;
    }

    public Integer getMaNV() {
        return maNV;
    }

    public void setMaNV(Integer maNV) {
        this.maNV = maNV;
    }
}