package Controller;

import DAO.GioHangDAO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GioHang;
import model.TaiKhoan;
import util.DBConnect;

@WebServlet(name = "PlaceOrderServlet", urlPatterns = {"/PlaceOrderServlet"})
public class PlaceOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan acc = (TaiKhoan) session.getAttribute("user");
        
        // 1. Kiểm tra đăng nhập
        if (acc == null || acc.getVaiTro() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        GioHangDAO ghDAO = new GioHangDAO();
        String maKH = acc.getMaKH();

        // Lấy dữ liệu từ form thanh toán
        String tenNguoiNhan = request.getParameter("hoTenNguoiNhan");
        String diaChiGiaoHang = request.getParameter("diaChiGiaoHang");
        String sdtNguoiNhan = request.getParameter("sdtNguoiNhan");
        String ghiChu = request.getParameter("ghiChu");
        String paymentMethod = request.getParameter("paymentMethod"); // COD hoặc Transfer

        // 2. Lấy giỏ hàng (chứa chi tiết MaCTSP, SoLuong, GiaBan)
        List<GioHang> listGioHang = ghDAO.getListGioHangByMaKH(maKH);

        if (listGioHang == null || listGioHang.isEmpty()) {
            // Nếu giỏ hàng trống, chuyển hướng về trang giỏ hàng (không đặt hàng)
            response.sendRedirect("GioHangServlet");
            return;
        }
        
        Connection con = null;
        try {
            con = new DBConnect().getConnection();
            con.setAutoCommit(false); // Bắt đầu Transaction

            // === 3. INSERT VÀO BẢNG HOADON ===
            String insertHD = "INSERT INTO hoadon (MaKH, TenNguoiNhan, DiaChiGiaoHang, CachThanhToan, MaTrangThai, GhiChu) "
                            + "VALUES (?, ?, ?, ?, ?, ?)";
            
            PreparedStatement psHD = con.prepareStatement(insertHD, PreparedStatement.RETURN_GENERATED_KEYS);
            psHD.setString(1, maKH);
            psHD.setString(2, tenNguoiNhan);
            psHD.setString(3, diaChiGiaoHang);
            psHD.setString(4, paymentMethod.equals("COD") ? "Tiền mặt" : "Chuyển khoản");
            psHD.setInt(5, 0); // MaTrangThai = 0 (Mới đặt hàng)
            psHD.setString(6, ghiChu);
            psHD.executeUpdate();

            // Lấy MaHD vừa được tự động sinh ra
            ResultSet rsHD = psHD.getGeneratedKeys();
            int maHD_moi = -1;
            if (rsHD.next()) {
                maHD_moi = rsHD.getInt(1);
            }

            // === 4. INSERT VÀO BẢNG CHITIETHD ===
            String insertCTHD = "INSERT INTO chitiethd (MaHD, MaCTSP, DonGia, SoLuong) VALUES (?, ?, ?, ?)";
            PreparedStatement psCTHD = con.prepareStatement(insertCTHD);

            for (GioHang item : listGioHang) {
                psCTHD.setInt(1, maHD_moi);
                psCTHD.setInt(2, item.getMaCTSP());
                psCTHD.setDouble(3, item.getGiaBan());
                psCTHD.setInt(4, item.getSoLuong());
                psCTHD.addBatch(); // Thêm vào batch để thực hiện hàng loạt
            }
            psCTHD.executeBatch();
            
            // === 5. XÓA GIỎ HÀNG và CẬP NHẬT CART COUNT ===
            ghDAO.xoaToanBoGioHang(maKH);
            session.setAttribute("cartCount", 0); // Reset số lượng trên header
            
            con.commit(); // Hoàn tất Transaction
            
            // 6. Chuyển hướng đến trang thông báo thành công
            request.setAttribute("maHD", maHD_moi);
            request.getRequestDispatcher("order_success.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (con != null) con.rollback(); // Rollback nếu có lỗi
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            request.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } finally {
            try {
                if (con != null) con.setAutoCommit(true);
                if (con != null) con.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không cho phép truy cập trực tiếp bằng GET
        response.sendRedirect("TrangChu");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}