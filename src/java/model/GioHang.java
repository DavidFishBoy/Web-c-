package model;

public class GioHang {

    private int MaGH;
    private int maKH; 
    private int maCTSP;
    private int soLuong;

    // Các trường này dùng để JOIN hiển thị
    private String tenSP;
    private String tenKichCo;
    private double giaBan;
    private String hinhAnh;

    public GioHang() {
    }

    // Constructor dùng trong DAO khi check item tồn tại
    public GioHang(int MaGH, int maKH, int maCTSP, int soLuong) {
        this.MaGH = MaGH;
        this.maKH = maKH; // SỬA: Tham số là int
        this.maCTSP = maCTSP;
        this.soLuong = soLuong;
    }

    // Constructor đầy đủ dùng trong getGioHangByMaKH
    public GioHang(int MaGH, int maKH, int maCTSP, int soLuong, String tenSP, String tenKichCo, double giaBan, String hinhAnh) {
        this.MaGH = MaGH;
        this.maKH = maKH; // SỬA: Tham số là int
        this.maCTSP = maCTSP;
        this.soLuong = soLuong;
        this.tenSP = tenSP;
        this.tenKichCo = tenKichCo;
        this.giaBan = giaBan;
        this.hinhAnh = hinhAnh;
    }

    // Getters and Setters (Đã cập nhật)
    public int getMaGH() {
        return MaGH;
    }

    public void setMaGH(int MaGH) {
        this.MaGH = MaGH;
    }

    public int getMaKH() { // SỬA: Trả về int
        return maKH;
    }

    public void setMaKH(int maKH) { // SỬA: Nhận tham số int
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