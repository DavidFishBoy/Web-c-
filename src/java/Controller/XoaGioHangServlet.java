package Controller;

import DAO.GioHangDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.TaiKhoan;

@WebServlet(name = "XoaGioHangServlet", urlPatterns = {"/XoaGioHangServlet"})
public class XoaGioHangServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // --- BƯỚC KIỂM TRA QUYỀN ---
        Integer role = (Integer) session.getAttribute("role");

        if (role == null || role != 0) {
            response.sendRedirect("login.jsp");
            return; 
        }
        // -----------------------------

        try {
            // Đã xác nhận là Khách hàng
            TaiKhoan kh = (TaiKhoan) session.getAttribute("user");
            String maKH = kh.getMaKH();
            
            // Lấy MaCTSP cần xóa từ request (thường là link GET)
            int maCTSP = Integer.parseInt(request.getParameter("maCTSP"));

            GioHangDAO ghDAO = new GioHangDAO();
            ghDAO.xoaKhoiGioHang(maKH, maCTSP);
            int newCartCount = ghDAO.getSoLuongTrongGio(maKH);
            session.setAttribute("cartCount", newCartCount);

            // Xóa xong, tải lại trang giỏ hàng
            response.sendRedirect("GioHangServlet");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("GioHangServlet"); // Có lỗi cũng về giỏ hàng
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}