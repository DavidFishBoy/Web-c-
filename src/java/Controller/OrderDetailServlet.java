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
import model.HoaDon; 
import model.TaiKhoan;

@WebServlet(name = "OrderDetailServlet", urlPatterns = {"/OrderDetailServlet"})
public class OrderDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        TaiKhoan acc = (TaiKhoan) session.getAttribute("user");
        
        // 1. Kiểm tra đăng nhập (BÂY GIỜ CHỈ CẦN ĐĂNG NHẬP LÀ ĐƯỢC)
        if (acc == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Lấy MaHD từ URL (Giữ nguyên)
        String maHD_raw = request.getParameter("maHD");
        
        if (maHD_raw == null || maHD_raw.isEmpty()) {
            // Nếu không có MaHD, chuyển hướng về trang chủ hoặc dashboard
            if (acc.getRole() == 1) { // Admin về dashboard
                response.sendRedirect("admin/admin.jsp"); 
            } else { // Khách hàng về trang chủ
                response.sendRedirect("TrangChuServlet"); 
            }
            return;
        }

        try {
            int maHD = Integer.parseInt(maHD_raw);
            HoaDonDAO hdDAO = new HoaDonDAO();
            
            // 3. Lấy chi tiết các sản phẩm trong hóa đơn (Giữ nguyên)
            List<ChiTietHD> listChiTiet = hdDAO.getChiTietHDByMaHD(maHD);
            
            // 4. LẤY THÔNG TIN CHUNG CỦA HÓA ĐƠN (BƯỚC MỚI)
            // Sử dụng phương thức DAO mới tạo
            HoaDon hoaDon = hdDAO.getHoaDonChiTietByMaHD(maHD);

            // 5. Lấy tổng tiền (đã được tính sẵn trong đối tượng hoaDon)
            double tongTien = (hoaDon != null) ? hoaDon.getTongTien() : 0;
            
            // Nếu không tìm thấy hóa đơn (ví dụ: người dùng nhập sai maHD)
            if (hoaDon == null) {
                 // Có thể thêm 1 trang báo lỗi
                 if (acc.getRole() == 1) {
                     response.sendRedirect("admin/admin.jsp"); 
                 } else {
                     response.sendRedirect("TrangChuServlet"); 
                 }
                 return;
            }

            // 6. Đặt dữ liệu vào request
            request.setAttribute("maHD", maHD);
            request.setAttribute("listChiTiet", listChiTiet);
            request.setAttribute("tongTien", tongTien);
            request.setAttribute("hoaDon", hoaDon); // <-- GỬI TOÀN BỘ HÓA ĐƠN QUA

            // 7. Chuyển tiếp đến trang JSP tương ứng
            if (acc.getRole() == 1) { // Nếu là Admin
                // Tên file JSP cho admin, ví dụ: "admin/admin_order_detail.jsp"
                request.getRequestDispatcher("admin/admin_order_detail.jsp").forward(request, response);
            } else { // Nếu là Khách hàng (Role == 0)
                request.getRequestDispatcher("order_detail.jsp").forward(request, response);
            }
            
        } catch (NumberFormatException e) {
             if (acc.getRole() == 1) {
                 response.sendRedirect("admin/admin.jsp"); 
             } else {
                 response.sendRedirect("TrangChuServlet"); 
             }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}