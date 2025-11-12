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
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getRole() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int maCTSP = Integer.parseInt(request.getParameter("maCTSP"));
            
            // === SỬA TẠI ĐÂY: Chuyển sang int ===
            int maKH = user.getMaKH();
            // ====================================

            GioHangDAO ghDAO = new GioHangDAO();
            ghDAO.removeItem(maKH, maCTSP);

            response.sendRedirect("GioHangServlet");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("GioHangServlet");
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