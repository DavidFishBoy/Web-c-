package model;

public class HinhAnhSanPham {
    private int maHinhAnh;
    private int maSP;
    private String urlHinhAnh;
    private boolean isDefault; 

    public HinhAnhSanPham() {
    }

    public HinhAnhSanPham(int maHinhAnh, int maSP, String urlHinhAnh, boolean isDefault) {
        this.maHinhAnh = maHinhAnh;
        this.maSP = maSP;
        this.urlHinhAnh = urlHinhAnh;
        this.isDefault = isDefault; 
    }

    
    public int getMaHinhAnh() {
        return maHinhAnh;
    }

    public void setMaHinhAnh(int maHinhAnh) {
        this.maHinhAnh = maHinhAnh;
    }

    public int getMaSP() {
        return maSP;
    }

    public void setMaSP(int maSP) {
        this.maSP = maSP;
    }

    public String getUrlHinhAnh() {
        return urlHinhAnh;
    }

    public void setUrlHinhAnh(String urlHinhAnh) {
        this.urlHinhAnh = urlHinhAnh;
    }

    public boolean isIsDefault() { 
        return isDefault;
    }

    public void setIsDefault(boolean isDefault) { 
        this.isDefault = isDefault;
    }
}