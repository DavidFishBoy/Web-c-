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

@WebServlet(name = "CapNhatGioHangServlet", urlPatterns = {"/CapNhatGioHangServlet"})
public class CapNhatGioHangServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Kiểm tra quyền (Chỉ khách hàng)
        Integer role = (Integer) session.getAttribute("role");
        if (role == null || role != 0) {
            response.sendRedirect("login.jsp");
            return; 
        }

        try {
            // Lấy thông tin từ session và form
            TaiKhoan kh = (TaiKhoan) session.getAttribute("user");
            String maKH = kh.getMaKH();
            int maCTSP = Integer.parseInt(request.getParameter("maCTSP"));
            int soLuongMoi = Integer.parseInt(request.getParameter("soLuong"));

            GioHangDAO ghDAO = new GioHangDAO();

            if (soLuongMoi <= 0) {
                // Nếu số lượng mới là 0 hoặc âm, thì xóa sản phẩm
                ghDAO.xoaKhoiGioHang(maKH, maCTSP);
            } else {
                // Ngược lại, cập nhật số lượng mới
                ghDAO.capNhatSoLuong(maKH, maCTSP, soLuongMoi);
            }
            
            // Cập nhật lại số lượng trên icon giỏ hàng
            int newCartCount = ghDAO.getSoLuongTrongGio(maKH);
            session.setAttribute("cartCount", newCartCount);

            // Tải lại trang giỏ hàng để hiển thị giá mới
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}