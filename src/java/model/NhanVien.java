package model;

public class NhanVien {
    private int maNV; // CSDL là int
    private String hoTen;
    private String email;
    private String dienThoai;
    private String diaChi;
    private String username;
    private String password;
    private int role; // CSDL là Role

    public NhanVien() {
    }

    // Constructor khớp CSDL (8 tham số)
    public NhanVien(int maNV, String hoTen, String email, String dienThoai, String diaChi, String username, String password, int role) {
        this.maNV = maNV;
        this.hoTen = hoTen;
        this.email = email;
        this.dienThoai = dienThoai;
        this.diaChi = diaChi;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    
    public int getMaNV() { 
        return maNV;
    }

    public void setMaNV(int maNV) { 
        this.maNV = maNV;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDienThoai() {
        return dienThoai;
    }

    public void setDienThoai(String dienThoai) {
        this.dienThoai = dienThoai;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
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