/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import DAO.HoaDonDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.HoaDon;
import model.TaiKhoan;

@WebServlet(name = "LichSuHoaDonServlet", urlPatterns = {"/LichSuHoaDonServlet"})
public class LichSuHoaDonServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // 1. Kiểm tra xem người dùng đã đăng nhập chưa
        if (user == null || user.getRole() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String maKH = user.getMaKH(); 
            
            HoaDonDAO hoaDonDAO = new HoaDonDAO();

            // 2. Gọi DAO để lấy danh sách hóa đơn
            List<HoaDon> listHoaDon = hoaDonDAO.getHoaDonByMaKH(maKH);

            // 3. Đặt danh sách lên request
            request.setAttribute("listHoaDon", listHoaDon);

            // 4. Chuyển tiếp đến trang JSP
            request.getRequestDispatcher("lichsuhoadon.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("TrangChu"); // Về trang chủ nếu có lỗi
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