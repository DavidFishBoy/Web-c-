package model;

public class GioHang {
    private int maGH;
    private String maKH;
    private int maCTSP;
    private int soLuong;

    private String tenSP;
    private String hinhAnh;
    private String tenKichCo;
    private double giaBan;

    public GioHang() {
    }

    public GioHang(int maGH, String maKH, int maCTSP, int soLuong) {
        this.maGH = maGH;
        this.maKH = maKH;
        this.maCTSP = maCTSP;
        this.soLuong = soLuong;
    }

    public GioHang(int maGH, String maKH, int maCTSP, int soLuong, String tenSP, String hinhAnh, String tenKichCo, double giaBan) {
        this.maGH = maGH;
        this.maKH = maKH;
        this.maCTSP = maCTSP;
        this.soLuong = soLuong;
        this.tenSP = tenSP;
        this.hinhAnh = hinhAnh;
        this.tenKichCo = tenKichCo;
        this.giaBan = giaBan;
    }


    public int getMaGH() {
        return maGH;
    }

    public void setMaGH(int maGH) {
        this.maGH = maGH;
    }

    public String getMaKH() {
        return maKH;
    }

    public void setMaKH(String maKH) {
        this.maKH = maKH;
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

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
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
}