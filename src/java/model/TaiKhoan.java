package model;

public class TaiKhoan {

    private String maKH;
    private String matKhau;
    private String hoTen;
    private int gioiTinh;
    private String ngaySinh;
    private String diaChi;
    private String soDT;
    private String email;
    private int hieuLuc;
    private int vaiTro;
    private String dienThoai;

    public String getDienThoai() {
        return dienThoai;
    }

    public void setDienThoai(String dienThoai) {
        this.dienThoai = dienThoai;
    }

    public TaiKhoan(String maKH, String matKhau, String hoTen, int gioiTinh, String ngaySinh,
            String diaChi, String soDT, String email, int hieuLuc, int vaiTro) {
        this.maKH = maKH;
        this.matKhau = matKhau;
        this.hoTen = hoTen;
        this.gioiTinh = gioiTinh;
        this.ngaySinh = ngaySinh;
        this.diaChi = diaChi;
        this.soDT = soDT;
        this.email = email;
        this.hieuLuc = hieuLuc;
        this.vaiTro = vaiTro;
    }

    // getter & setter
    public String getMaKH() {
        return maKH;
    }

    public void setMaKH(String maKH) {
        this.maKH = maKH;
    }

    public String getMatKhau() {
        return matKhau;
    }

    public void setMatKhau(String matKhau) {
        this.matKhau = matKhau;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public int getGioiTinh() {
        return gioiTinh;
    }

    public void setGioiTinh(int gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getSoDT() {
        return soDT;
    }

    public void setSoDT(String soDT) {
        this.soDT = soDT;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getHieuLuc() {
        return hieuLuc;
    }

    public void setHieuLuc(int hieuLuc) {
        this.hieuLuc = hieuLuc;
    }

    public int getVaiTro() {
        return vaiTro;
    }

    public void setVaiTro(int vaiTro) {
        this.vaiTro = vaiTro;
    }
}
