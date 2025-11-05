package model;

public class SanPham {
    private int maSP;
    private String tenSP;
    private String hinhAnh;
    private double giaCoBan; 
    private String moTa;
    private int maDM;
    private int luotXem;
    private String tenDanhMuc;
    private String tenNhaCungCap;
    private boolean laSPMoi;

    public boolean isLaSPMoi() {
        return laSPMoi;
    }

    public void setLaSPMoi(boolean laSPMoi) {
        this.laSPMoi = laSPMoi;
    }

    // Constructor không tham số
    public SanPham() {}

    public SanPham(int maSP, String tenSP, int maDM, double giaCoBan, String hinhAnh, String moTa, int luotXem) {
        this.maSP = maSP;
        this.tenSP = tenSP;
        this.maDM = maDM;
        this.giaCoBan = giaCoBan;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
        this.luotXem = luotXem;
    }

    // Getter & Setter
    public int getMaSP() {
        return maSP;
    }

    public void setMaSP(int maSP) {
        this.maSP = maSP;
    }

    public String getTenSP() {
        return tenSP;
    }

    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public double getGiaCoBan() {
        return giaCoBan;
    }

    public void setGiaCoBan(double giaCoBan) {
        this.giaCoBan = giaCoBan;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public int getMaDM() {
        return maDM;
    }

    public void setMaDM(int maDM) {
        this.maDM = maDM;
    }

    public int getLuotXem() {
        return luotXem;
    }

    public void setLuotXem(int luotXem) {
        this.luotXem = luotXem;
    }

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
