package Controller;

import DAO.HoaDonDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.HoaDon;
import model.NhanVien;
import model.TrangThaiDonHang;

@WebServlet(name = "QuanLyDonHangServlet", urlPatterns = {"/QuanLyDonHangServlet"})
public class QuanLyDonHangServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra quyền Admin
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");
        Integer role = (Integer) session.getAttribute("role");
        
        if (userObj == null || role == null || role != 2 || !(userObj instanceof NhanVien)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return; 
        }
        
        HoaDonDAO dao = new HoaDonDAO();
        
        // 1. Lấy tất cả đơn hàng
        List<HoaDon> listHoaDon = dao.getAllHoaDon();
        
        // 2. Lấy tất cả trạng thái (cho dropdown)
        List<TrangThaiDonHang> listTrangThai = dao.getAllTrangThai();
        
        // 3. Gửi dữ liệu sang JSP
        request.setAttribute("listHoaDon", listHoaDon);
        request.setAttribute("listTrangThai", listTrangThai);
        
        // 4. Forward
        request.getRequestDispatcher("admin/admin_order_detail.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Xử lý khi Admin nhấn nút "Cập nhật"
        
        // 1. Kiểm tra Admin
        HttpSession session = request.getSession();
        NhanVien admin = (NhanVien) session.getAttribute("user");
        if (admin == null || admin.getRole() != 2) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // 2. Lấy dữ liệu từ form
            int maHD = Integer.parseInt(request.getParameter("maHD"));
            int maTrangThaiMoi = Integer.parseInt(request.getParameter("maTrangThaiMoi"));
            String maNV = admin.getMaNV(); // Lấy mã của Admin đang đăng nhập
            
            // 3. Gọi DAO
            HoaDonDAO dao = new HoaDonDAO();
            dao.updateTrangThaiDonHang(maHD, maTrangThaiMoi, maNV);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // 4. Quay lại trang quản lý đơn hàng
        response.sendRedirect("QuanLyDonHangServlet");
    }
}