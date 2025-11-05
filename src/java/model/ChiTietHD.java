package model;

public class ChiTietHD {

    private int maCT;
    private int maHD;
    private int maCTSP;
    private double donGia;
    private int soLuong;

    private String tenSP;
    private String tenKichCo;

    public ChiTietHD() {
    }

    // Constructor cơ bản
    public ChiTietHD(int maCT, int maHD, int maCTSP, double donGia, int soLuong) {
        this.maCT = maCT;
        this.maHD = maHD;
        this.maCTSP = maCTSP;
        this.donGia = donGia;
        this.soLuong = soLuong;
    }

    // Constructor đầy đủ (dùng để hiển thị)
    public ChiTietHD(int maCT, int maHD, int maCTSP, double donGia, int soLuong, String tenSP, String tenKichCo) {
        this.maCT = maCT;
        this.maHD = maHD;
        this.maCTSP = maCTSP;
        this.donGia = donGia;
        this.soLuong = soLuong;
        this.tenSP = tenSP;
        this.tenKichCo = tenKichCo;
    }

    // --- Getter và Setter ---
    public int getMaCT() {
        return maCT;
    }

    public void setMaCT(int maCT) {
        this.maCT = maCT;
    }

    public int getMaHD() {
        return maHD;
    }

    public void setMaHD(int maHD) {
        this.maHD = maHD;
    }

    public int getMaCTSP() {
        return maCTSP;
    }

    public void setMaCTSP(int maCTSP) {
        this.maCTSP = maCTSP;
    }

    public double getDonGia() {
        return donGia;
    }

    public void setDonGia(double donGia) {
        this.donGia = donGia;
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
}
