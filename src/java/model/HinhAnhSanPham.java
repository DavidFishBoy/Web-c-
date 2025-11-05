package model;

public class HinhAnhSanPham {

    private int maHinhAnh;
    private int maSP;
    private String URLHinhAnh;

    public HinhAnhSanPham() {
    }

    public HinhAnhSanPham(int maHinhAnh, int maSP, String URLHinhAnh) {
        this.maHinhAnh = maHinhAnh;
        this.maSP = maSP;
        this.URLHinhAnh = URLHinhAnh;
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

    public String getURLHinhAnh() {
        return URLHinhAnh;
    }

    public void setURLHinhAnh(String URLHinhAnh) {
        this.URLHinhAnh = URLHinhAnh;
    }
}
