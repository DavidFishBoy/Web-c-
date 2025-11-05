package Controller;

import DAO.GioHangDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GioHang;
import model.TaiKhoan;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        // SỬA: Lấy tài khoản bằng key "user" (khớp với DangNhapServlet)
        TaiKhoan acc = (TaiKhoan) session.getAttribute("user");

        // 1. Kiểm tra đăng nhập
        if (acc == null || acc.getVaiTro() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String maKH = acc.getMaKH();
        GioHangDAO ghDAO = new GioHangDAO();
        
        // 2. Lấy thông tin giỏ hàng
        List<GioHang> listGioHang = ghDAO.getListGioHangByMaKH(maKH);
        
        // === SỬA LỖI TRỌNG YẾU: Kiểm tra giỏ hàng và chuyển hướng hợp lý ===
        if (listGioHang == null || listGioHang.isEmpty()) { 
            // Nếu giỏ hàng trống, chuyển hướng về trang Giỏ hàng (chứ không phải Trang chủ) 
            response.sendRedirect("GioHangServlet"); 
            return;
        }
        
        // 3. Tính tổng tiền
        double tongTien = ghDAO.getTongTienByMaKH(maKH);
        
        // 4. Đặt thông tin lên request
        request.setAttribute("listGioHang", listGioHang);
        request.setAttribute("tongTien", tongTien);

        // 5. Chuyển tiếp đến trang checkout.jsp
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}