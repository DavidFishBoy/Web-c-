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
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getRole() != 0) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // Gửi lỗi 401
            return;
        }

        try {
            int maCTSP = Integer.parseInt(request.getParameter("maCTSP"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));
            
            String maKH = user.getMaKH();
            
            GioHangDAO ghDAO = new GioHangDAO();

            if (soLuong > 0) {
                ghDAO.updateItem(maKH, maCTSP, soLuong);
            } else {
                // Nếu số lượng <= 0 (từ logic JS), ta thực hiện xóa
                ghDAO.removeItem(maKH, maCTSP);
            }
            
            // Cập nhật lại cartCount trong session
            int cartCount = ghDAO.getSoLuongTrongGio(maKH);
            session.setAttribute("cartCount", cartCount);

            response.setStatus(HttpServletResponse.SC_OK);

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Gửi 500
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