package Controller;

import DAO.TaiKhoanDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TaiKhoan;

@WebServlet(name = "QuanLyKhachHangServlet", urlPatterns = {"/QuanLyKhachHangServlet"})
public class QuanLyKhachHangServlet extends HttpServlet {

    /**
     * Lấy danh sách khách hàng và hiển thị ra admin_users.jsp
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        TaiKhoanDAO tkDAO = new TaiKhoanDAO();
        
        // Lấy danh sách khách hàng (dùng hàm bạn đã có)
        List<TaiKhoan> listKH = tkDAO.getAllKhachHang(); 
        
        // Đặt danh sách vào request
        request.setAttribute("listKH", listKH);
        
        // Chuyển tiếp đến trang JSP
        request.getRequestDispatcher("admin/admin_users.jsp").forward(request, response);
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