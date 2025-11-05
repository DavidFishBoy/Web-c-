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

@WebServlet(name = "GioHangServlet", urlPatterns = {"/GioHangServlet"})
public class GioHangServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        
        // --- BƯỚC KIỂM TRA QUYỀN ---
        Integer role = (Integer) session.getAttribute("role");

        if (role == null || role != 0) {
            response.sendRedirect("login.jsp");
            return; 
        }
        // -----------------------------

        // Đã xác nhận là Khách hàng
        TaiKhoan kh = (TaiKhoan) session.getAttribute("user");
        
        // SỬA 1: Thêm kiểm tra null để tránh lỗi
        if (kh == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String maKH = kh.getMaKH();
        GioHangDAO ghDAO = new GioHangDAO();
        
        // Lấy danh sách giỏ hàng (Hàm này đã đúng)
        List<GioHang> listGH = ghDAO.getListGioHangByMaKH(maKH);

        // SỬA 2: Lấy tổng tiền trực tiếp từ DAO (hiệu quả hơn)
        double tongTien = ghDAO.getTongTienByMaKH(maKH);
        
        // Gửi dữ liệu sang giohang.jsp
        request.setAttribute("listGH", listGH);
        request.setAttribute("tongTien", tongTien);
        request.getRequestDispatcher("giohang.jsp").forward(request, response);
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