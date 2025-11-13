package model;

public class GioHang {

    private int MaGH;
    private String maKH; 
    private int maCTSP;
    private int soLuong;

    private String tenSP;
    private String tenKichCo;
    private double giaBan;
    private String hinhAnh;

    public GioHang() {
    }

    public GioHang(int MaGH, String maKH, int maCTSP, int soLuong) {
        this.MaGH = MaGH;
        this.maKH = maKH; 
        this.maCTSP = maCTSP;
        this.soLuong = soLuong;
    }

    public GioHang(int MaGH, String maKH, int maCTSP, int soLuong, String tenSP, String tenKichCo, double giaBan, String hinhAnh) {
        this.MaGH = MaGH;
        this.maKH = maKH; 
        this.maCTSP = maCTSP;
        this.soLuong = soLuong;
        this.tenSP = tenSP;
        this.tenKichCo = tenKichCo;
        this.giaBan = giaBan;
        this.hinhAnh = hinhAnh;
    }

    public int getMaGH() {
        return MaGH;
    }

    public void setMaGH(int MaGH) {
        this.MaGH = MaGH;
    }

    public String getMaKH() { 
        return maKH;
    }

    public void setMaKH(String maKH) { 
    }

    public int getMaCTSP() {
        return maCTSP;
    }

    public void setMaCTSP(int maCTSP) {
        this.maCTSP = maCTSP;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getTenSP() {
        return tenSP;
    }

    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }

    public String getTenKichCo() {
        return tenKichCo;
    }

    public void setTenKichCo(String tenKichCo) {
        this.tenKichCo = tenKichCo;
    }

    public double getGiaBan() {
        return giaBan;
    }

    public void setGiaBan(double giaBan) {
        this.giaBan = giaBan;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }
}