package model;

public class TaiKhoan {

    private int maKH; // CSDL là int
    private String hoTen;
    private String diaChi;
    private String dienThoai;
    private String email;
    private String username;
    private String password;
    private int role; // CSDL là role

    public TaiKhoan() {
    }

    // Constructor khớp CSDL
    public TaiKhoan(int maKH, String hoTen, String diaChi, String dienThoai, String email, String username, String password, int role) {
        this.maKH = maKH;
        this.hoTen = hoTen;
        this.diaChi = diaChi;
        this.dienThoai = dienThoai;
        this.email = email;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    
    public int getMaKH() { 
        return maKH;
    }

    public void setMaKH(int maKH) { 
        this.maKH = maKH;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getDienThoai() {
        return dienThoai;
    }

    public void setDienThoai(String dienThoai) {
        this.dienThoai = dienThoai;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}