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
            
            // === SỬA TẠI ĐÂY: Chuyển sang int ===
            int maKH = user.getMaKH();
            // ====================================

            GioHangDAO ghDAO = new GioHangDAO();
            GioHang itemTonTai = ghDAO.checkItemTonTai(maKH, maCTSP);

            if (itemTonTai != null) {
                // Sản phẩm đã có, cập nhật số lượng
                int soLuongMoi = itemTonTai.getSoLuong() + soLuong;
                ghDAO.updateItem(maKH, maCTSP, soLuongMoi);
            } else {
                // Sản phẩm chưa có, thêm mới
                ghDAO.addItem(maKH, maCTSP, soLuong);
            }

            // Quay về trang chi tiết sản phẩm (hoặc trang giỏ hàng)
            // Lấy maSP từ maCTSP (Cách này không tối ưu, nhưng dùng tạm)
            // Tốt hơn là bạn nên gửi kèm maSP từ form
            response.sendRedirect("GioHangServlet"); // Chuyển thẳng về giỏ hàng cho đơn giản

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