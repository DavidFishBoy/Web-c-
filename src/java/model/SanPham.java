package model;

import java.sql.Date;

public class SanPham {

    private int maSP;
    private String tenSP;
    private int maDM;
    private String moTaDonVi;
    private double giaCoBan;
    private Date ngaySanXuat; 
    private int luotXem;
    private String moTa;
    private String maNCC;
    private String hinhAnh; 

    private String tenDanhMuc;
    private String tenNhaCungCap;

    public SanPham() {
    }

    public SanPham(int maSP, String tenSP, int maDM, String moTaDonVi, double giaCoBan, 
                   Date ngaySanXuat, int luotXem, String moTa, String maNCC) {
        this.maSP = maSP;
        this.tenSP = tenSP;
        this.maDM = maDM;
        this.moTaDonVi = moTaDonVi;
        this.giaCoBan = giaCoBan;
        this.ngaySanXuat = ngaySanXuat;
        this.luotXem = luotXem;
        this.moTa = moTa;
        this.maNCC = maNCC;
    }


    public int getMaSP() { return maSP; }
    public void setMaSP(int maSP) { this.maSP = maSP; }
    public String getTenSP() { return tenSP; }
    public void setTenSP(String tenSP) { this.tenSP = tenSP; }
    public int getMaDM() { return maDM; }
    public void setMaDM(int maDM) { this.maDM = maDM; }
    public String getMoTaDonVi() { return moTaDonVi; }
    public void setMoTaDonVi(String moTaDonVi) { this.moTaDonVi = moTaDonVi; }
    public double getGiaCoBan() { return giaCoBan; }
    public void setGiaCoBan(double giaCoBan) { this.giaCoBan = giaCoBan; }
    public Date getNgaySanXuat() { return ngaySanXuat; }
    public void setNgaySanXuat(Date ngaySanXuat) { this.ngaySanXuat = ngaySanXuat; }
    public int getLuotXem() { return luotXem; }
    public void setLuotXem(int luotXem) { this.luotXem = luotXem; }
    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
    public String getMaNCC() { return maNCC; }
    public void setMaNCC(String maNCC) { this.maNCC = maNCC; }
    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }


    // SỬA: Thêm Getters/Setters cho 2 trường JOIN
    public String getTenDanhMuc() {
        return tenDanhMuc;
    }

    public void setTenDanhMuc(String tenDanhMuc) {
        this.tenDanhMuc = tenDanhMuc;
    }

    public String getTenNhaCungCap() {
        return tenNhaCungCap;
    }

    public void setTenNhaCungCap(String tenNhaCungCap) {
        this.tenNhaCungCap = tenNhaCungCap;
    }
}