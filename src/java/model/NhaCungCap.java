/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class NhaCungCap {
    private String maNCC;
    private String tenCty;
    private String tenLH;
    private String email;
    private String phone;
    private String diaChi;
    private String moTa;

    public NhaCungCap() {
    }

    public NhaCungCap(String maNCC, String tenCty, String tenLH, String email, String phone, String diaChi, String moTa) {
        this.maNCC = maNCC;
        this.tenCty = tenCty;
        this.tenLH = tenLH;
        this.email = email;
        this.phone = phone;
        this.diaChi = diaChi;
        this.moTa = moTa;
    }

    // --- Getters and Setters ---
    
    public String getMaNCC() {
        return maNCC;
    }

    public void setMaNCC(String maNCC) {
        this.maNCC = maNCC;
    }

    public String getTenCty() {
        return tenCty;
    }

    public void setTenCty(String tenCty) {
        this.tenCty = tenCty;
    }

    public String getTenLH() {
        return tenLH;
    }

    public void setTenLH(String tenLH) {
        this.tenLH = tenLH;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
}
