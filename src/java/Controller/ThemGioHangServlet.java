package Controller;

import DAO.GioHangDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GioHang;
import model.TaiKhoan;

@WebServlet(name = "ThemGioHangServlet", urlPatterns = {"/ThemGioHangServlet"})
public class ThemGioHangServlet extends HttpServlet {

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
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));
            
            String maKH = user.getMaKH();

            GioHangDAO ghDAO = new GioHangDAO();
            GioHang itemTonTai = ghDAO.checkItemTonTai(maKH, maCTSP);

            if (itemTonTai != null) {
                int soLuongMoi = itemTonTai.getSoLuong() + soLuong;
                ghDAO.updateItem(maKH, maCTSP, soLuongMoi);
            } else {
                ghDAO.addItem(maKH, maCTSP, soLuong);
            }
            
            // Cập nhật lại cartCount trong session
            int cartCount = ghDAO.getSoLuongTrongGio(maKH);
session.setAttribute("cartCount", cartCount);

            // Quay về trang chi tiết sản phẩm (hoặc trang giỏ hàng)
            response.sendRedirect("GioHangServlet"); // Chuyển thẳng về giỏ hàng

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ShopServlet");
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