package model;

public class DanhMuc {

    private int maDM;
    private String tenDM;
    private String hinhAnh;
    

    public DanhMuc() {
    }

    public DanhMuc(int maDM, String tenDM) {
        this.maDM = maDM;
        this.tenDM = tenDM;
    }
    public DanhMuc(int maDM, String tenDM, String hinhAnh) {
        this.maDM = maDM;
        this.tenDM = tenDM;
        this.hinhAnh = hinhAnh;
    }

    public int getMaDM() {
        return maDM;
    }

    public void setMaDM(int maDM) {
        this.maDM = maDM;
    }

    public String getTenDM() {
        return tenDM;
    }

    public void setTenDM(String tenDM) {
        this.tenDM = tenDM;
    }
    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }
}
