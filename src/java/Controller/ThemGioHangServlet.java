package Controller;

import DAO.GioHangDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TaiKhoan; // Model Khách Hàng

@WebServlet(name = "ThemGioHangServlet", urlPatterns = {"/ThemGioHangServlet"})
public class ThemGioHangServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // --- BƯỚC KIỂM TRA QUYỀN ---
        Integer role = (Integer) session.getAttribute("role");

        // Nếu chưa đăng nhập (role == null) hoặc không phải khách hàng (role != 0)
        if (role == null || role != 0) {
            // Chuyển về trang đăng nhập
            response.sendRedirect("login.jsp");
            return; // Dừng servlet
        }
        // -----------------------------

        try {
            // Đã xác nhận là Khách hàng (role == 0)
            TaiKhoan kh = (TaiKhoan) session.getAttribute("user");
            String maKH = kh.getMaKH();
            
            // Lấy thông tin từ form (ví dụ: từ ShopDetails.jsp)
            int maCTSP = Integer.parseInt(request.getParameter("maCTSP"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));

            GioHangDAO ghDAO = new GioHangDAO();
            ghDAO.themVaoGioHang(maKH, maCTSP, soLuong);
            int newCartCount = ghDAO.getSoLuongTrongGio(maKH);
            session.setAttribute("cartCount", newCartCount);

            // Thêm xong thì chuyển về trang giỏ hàng
            response.sendRedirect("GioHangServlet");

        } catch (NumberFormatException e) {
            // Lỗi khi người dùng nhập số lượng không hợp lệ
            e.printStackTrace();
            response.sendRedirect("TrangChu"); // Về trang chủ
        }
    }
}