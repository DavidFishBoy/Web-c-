package model;

import java.sql.Date; 

public class HoaDon {
    private String tenTrangThai;
    
    private int maHD;
    private String maKH; 
    private Date ngayDatHang;       
    private double tongTien;        
    private String hoTenNguoiNhan;
    private String diaChiGiaoHang;
    private String sdtNguoiNhan;    
    private String emailNguoiNhan; 
    private String ghiChu;
    private int maTrangThai;
    
   
    private String maNV; 

    public HoaDon() {
    }

    public HoaDon(int maHD, String maKH, Date ngayDatHang, double tongTien, String hoTenNguoiNhan,
                  String diaChiGiaoHang, String sdtNguoiNhan, String emailNguoiNhan,
                  String ghiChu, int maTrangThai, String maNV) { // SỬA: String maNV
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

    public String getTenTrangThai() {
        return tenTrangThai;
    }

    public void setTenTrangThai(String tenTrangThai) {
        this.tenTrangThai = tenTrangThai;
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

    public String getMaNV() { 
        return maNV;
    }

    public void setMaNV(String maNV) { 
        this.maNV = maNV;
    }
}