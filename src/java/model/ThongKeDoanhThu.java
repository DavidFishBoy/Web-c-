/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class ThongKeDoanhThu {
    
    private String ngay;
    private double tongDoanhThu;

    public ThongKeDoanhThu(String ngay, double tongDoanhThu) {
        this.ngay = ngay;
        this.tongDoanhThu = tongDoanhThu;
    }

    // Getters
    public String getNgay() {
        return ngay;
    }

    public double getTongDoanhThu() {
        return tongDoanhThu;
    }
}