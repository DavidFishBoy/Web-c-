package model;

public class ThongKeSanPham {
    private String tenSP;
    private int soLuongBan;

    public ThongKeSanPham() {
    }

    public ThongKeSanPham(String tenSP, int soLuongBan) {
        this.tenSP = tenSP;
        this.soLuongBan = soLuongBan;
    }

    // Getters and Setters
    public String getTenSP() {
        return tenSP;
    }

    public void setTenSP(String tenSP) {
        this.tenSP = tenSP;
    }

    public int getSoLuongBan() {
        return soLuongBan;
    }

    public void setSoLuongBan(int soLuongBan) {
        this.soLuongBan = soLuongBan;
    }
}