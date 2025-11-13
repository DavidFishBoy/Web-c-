/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author toite
 */

public class TrangThaiDonHang {
    private int maTrangThai;
    private String tenTrangThai;
    private String moTa;

    public TrangThaiDonHang() {
    }

    public TrangThaiDonHang(int maTrangThai, String tenTrangThai, String moTa) {
        this.maTrangThai = maTrangThai;
        this.tenTrangThai = tenTrangThai;
        this.moTa = moTa;
    }

    // Getters and Setters
    public int getMaTrangThai() {
        return maTrangThai;
    }

    public void setMaTrangThai(int maTrangThai) {
        this.maTrangThai = maTrangThai;
    }

    public String getTenTrangThai() {
        return tenTrangThai;
    }

    public void setTenTrangThai(String tenTrangThai) {
        this.tenTrangThai = tenTrangThai;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }
}
