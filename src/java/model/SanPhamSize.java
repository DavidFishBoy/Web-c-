package model;

public class SanPhamSize {
    private int MaCTSP;
    private int MaSP;
    private String TenKichCo; 
    private int SoLuongTon; 
    private double GiaBan; 
    public SanPhamSize() {
    }

    public SanPhamSize(int MaCTSP, int MaSP, String TenKichCo, int SoLuongTon, double GiaBan) {
        this.MaCTSP = MaCTSP;
        this.MaSP = MaSP;
        this.TenKichCo = TenKichCo;
        this.SoLuongTon = SoLuongTon;
        this.GiaBan = GiaBan;
    }

    // --- Getter và Setter ---

    public int getMaCTSP() {
        return MaCTSP;
    }

    public void setMaCTSP(int MaCTSP) {
        this.MaCTSP = MaCTSP;
    }

    public int getMaSP() {
        return MaSP;
    }

    public void setMaSP(int MaSP) {
        this.MaSP = MaSP;
    }

    public String getTenKichCo() {
        return TenKichCo;
    }

    public void setTenKichCo(String TenKichCo) {
        this.TenKichCo = TenKichCo;
    }

    public int getSoLuongTon() {
        return SoLuongTon;
    }

    public void setSoLuongTon(int SoLuongTon) {
        this.SoLuongTon = SoLuongTon;
    }

    public double getGiaBan() {
        return GiaBan;
    }

    public void setGiaBan(double GiaBan) {
        this.GiaBan = GiaBan;
    }
}