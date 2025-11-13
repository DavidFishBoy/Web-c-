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
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getRole() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String maKH = user.getMaKH();

            GioHangDAO ghDAO = new GioHangDAO();
            List<GioHang> listGioHang = ghDAO.getGioHangByMaKH(maKH);

            if (listGioHang.isEmpty()) {
                // Giỏ hàng trống, không cho checkout, quay về giỏ
                response.sendRedirect("GioHangServlet");
                return;
            }
            
            // Tính tổng tiền
            double tongTien = 0;
            for (GioHang item : listGioHang) {
                tongTien += item.getGiaBan() * item.getSoLuong();
            }

            request.setAttribute("listGioHang", listGioHang);
            request.setAttribute("tongTien", tongTien);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);

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