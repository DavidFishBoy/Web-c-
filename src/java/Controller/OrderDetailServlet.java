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
import model.ChiTietHD;
import model.TaiKhoan;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/OrderDetailServlet"})
public class OrderDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        TaiKhoan acc = (TaiKhoan) session.getAttribute("user");
        
        // 1. Kiểm tra đăng nhập (chỉ khách hàng mới xem được)
        if (acc == null || acc.getRole()!= 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Lấy MaHD từ URL (ví dụ: OrderDetailServlet?maHD=1003)
        String maHD_raw = request.getParameter("maHD");
        
        if (maHD_raw == null || maHD_raw.isEmpty()) {
            // Nếu không có MaHD, chuyển hướng về trang chủ
            response.sendRedirect("TrangChuServlet"); 
            return;
        }

        try {
            int maHD = Integer.parseInt(maHD_raw);
            HoaDonDAO hdDAO = new HoaDonDAO();
            
            // 3. Lấy chi tiết các sản phẩm trong hóa đơn
            List<ChiTietHD> listChiTiet = hdDAO.getChiTietHDByMaHD(maHD);
            
            // 4. Tính toán tổng tiền
            double tongTien = 0;
            for(ChiTietHD item : listChiTiet) {
                tongTien += (item.getDonGia() * item.getSoLuong());
            }

            // 5. Đặt dữ liệu vào request
            request.setAttribute("maHD", maHD);
            request.setAttribute("listChiTiet", listChiTiet);
            request.setAttribute("tongTien", tongTien);
            
            // 6. Chuyển tiếp đến trang order_detail.jsp
            request.getRequestDispatcher("order_detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("TrangChuServlet");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}