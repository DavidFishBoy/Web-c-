package model;

public class KichCo {
    private int maKC;
    private String tenKichCo;

    public KichCo() {
    }

    public KichCo(int maKC, String tenKichCo) {
        this.maKC = maKC;
        this.tenKichCo = tenKichCo;
    }

    // --- Getter và Setter ---
    public int getMaKC() {
        return maKC;
    }

    public void setMaKC(int maKC) {
        this.maKC = maKC;
    }

    public String getTenKichCo() {
        return tenKichCo;
    }

    public void setTenKichCo(String tenKichCo) {
        this.tenKichCo = tenKichCo;
    }
}