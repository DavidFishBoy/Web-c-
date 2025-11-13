package Controller;

import DAO.SanPhamDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DanhMuc;
import model.SanPham;

@WebServlet(name = "ShopServlet", urlPatterns = {"/ShopServlet"})
public class ShopServlet extends HttpServlet {

    // SỬA: Đặt PAGE_SIZE ở đây
    private static final int PAGE_SIZE = 9;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        SanPhamDAO dao = new SanPhamDAO();

        try {
            // 1. LẤY TẤT CẢ THAM SỐ TỪ URL
            String maDM = request.getParameter("maDM");
            String keyword = request.getParameter("keyword"); // SỬA: Lấy từ khóa
            String sort = request.getParameter("sort"); // SỬA: Lấy sắp xếp
            String pageStr = request.getParameter("page");
            int page;
            try {
                page = (pageStr == null) ? 1 : Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
            
            // 2. GỌI DAO VỚI ĐẦY ĐỦ THAM SỐ LỌC
            // SỬA: Gọi hàm DAO đã được sửa (hàm này sẽ được sửa ở bước 2)
            List<SanPham> listSP = dao.getSanPhamByFilter(maDM, keyword, sort, page, PAGE_SIZE);
            int totalProducts = dao.countSanPhamByFilter(maDM, keyword); // SỬA: Hàm count cũng phải lọc
            
            // 3. TÍNH TOÁN PHÂN TRANG
            int totalPages = (int) Math.ceil((double) totalProducts / PAGE_SIZE);

            // 4. LẤY DANH MỤC (Giữ nguyên)
            List<DanhMuc> listDM = dao.getAllDanhMuc();

            // 5. GỬI DỮ LIỆU SANG JSP
            request.setAttribute("listSP", listSP);
            request.setAttribute("listDM", listDM);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
            // SỬA: Gửi lại các tham số lọc để JSP "nhớ"
            request.setAttribute("maDM", maDM);
            request.setAttribute("keyword", keyword);
            request.setAttribute("sort", sort);

            request.getRequestDispatcher("shop.jsp").forward(request, response);

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