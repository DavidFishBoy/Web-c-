package Controller;

import DAO.SanPhamDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.SanPhamSize;

@WebServlet(name = "QuanLyKhoServlet", urlPatterns = {"/QuanLyKhoServlet"})
public class QuanLyKhoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        SanPhamDAO spDAO = new SanPhamDAO();
HttpSession session = request.getSession();
// Kiểm tra xem có thông báo thành công/lỗi từ doPost không
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (successMessage != null) {
            request.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage"); // Xóa thông báo sau khi dùng
        }
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage"); // Xóa thông báo sau khi dùng
        }
        // --- LOGIC PHÂN TRANG BẮT ĐẦU ---

        // 1. Xác định số sản phẩm mỗi trang
        int pageSize = 10; // Bạn có thể thay đổi số này (ví dụ: 10, 20)

        // 2. Lấy tổng số sản phẩm
        int totalItems = spDAO.getTongSoChiTietSP();

        // 3. Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        // 4. Lấy số trang hiện tại từ URL (parameter "page")
        String pageParam = request.getParameter("page");
        int currentPage = 1; // Mặc định là trang 1
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
                if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu nhập bậy thì về trang 1
            }
        }

        // 5. Gọi hàm DAO mới để lấy danh sách sản phẩm CỦA TRANG HIỆN TẠI
        List<SanPhamSize> listStock = spDAO.getDanhSachTonKhoTheoTrang(currentPage, pageSize);

        // 6. Gửi các thông tin phân trang sang JSP
        request.setAttribute("listStock", listStock);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", currentPage);

        // --- KẾT THÚC LOGIC PHÂN TRANG ---

        request.getRequestDispatcher("admin/admin_stock.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Lấy dữ liệu từ form submit
        String maCTSP_str = request.getParameter("maCTSP");
        String soLuongMoi_str = request.getParameter("soLuongMoi");
        String currentPage = request.getParameter("currentPage"); // Lấy trang hiện tại để quay về

        HttpSession session = request.getSession();

        try {
            int maCTSP = Integer.parseInt(maCTSP_str);
            int soLuongMoi = Integer.parseInt(soLuongMoi_str);
            
            // Kiểm tra dữ liệu (không cho nhập số âm)
            if (soLuongMoi < 0) {
                 session.setAttribute("errorMessage", "Số lượng không thể là số âm!");
            } else {
                SanPhamDAO spDAO = new SanPhamDAO();
                // Gọi hàm DAO mới tạo ở Bước 1
                boolean updated = spDAO.updateSoLuongTon(maCTSP, soLuongMoi);
                
                if(updated) {
                    session.setAttribute("successMessage", "Cập nhật số lượng cho Mã " + maCTSP + " thành công!");
                } else {
                    session.setAttribute("errorMessage", "Cập nhật thất bại. Vui lòng thử lại.");
                }
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Lỗi: Mã SP hoặc Số lượng không hợp lệ.");
        }
        
        // Quan trọng: Redirect về trang hiện tại (dùng doGet)
        response.sendRedirect("QuanLyKhoServlet?page=" + (currentPage != null ? currentPage : "1"));
    }
}