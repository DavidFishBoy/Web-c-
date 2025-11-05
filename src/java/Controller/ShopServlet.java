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
import model.KichCo; 
import model.SanPham;

@WebServlet(name = "ShopServlet", urlPatterns = {"/ShopServlet"})
public class ShopServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // 1. Lấy TẤT CẢ tham số filter từ URL
        String maDM_raw = request.getParameter("maDM");
        String maKC_raw = request.getParameter("maKC"); // (MỚI)
        String sort_raw = request.getParameter("sort"); // (MỚI)

        SanPhamDAO dao = new SanPhamDAO();
        
        // 2. Lấy danh sách sản phẩm đã lọc (Sửa lại hàm gọi)
        List<SanPham> listSP = dao.getSanPhamByFilter(maDM_raw, maKC_raw, sort_raw);
        
        // 3. Lấy tất cả danh mục (cho sidebar)
        List<DanhMuc> listDM = dao.getAllDanhMuc();
        
        // 4. Lấy tất cả kích cỡ (cho sidebar)
        List<KichCo> listKC = dao.getAllKichCo();
        
        // 5. Đếm tổng số sản phẩm
        int totalProducts = listSP.size();
        
        // 6. Đặt các danh sách và filter đang active lên request
        request.setAttribute("listSP", listSP);
        request.setAttribute("listDM", listDM);
        request.setAttribute("listKC", listKC);
        request.setAttribute("totalProducts", totalProducts);
        
        // (MỚI) Gửi các filter đang chọn về JSP để highlight
        request.setAttribute("maDM_active", maDM_raw); 
        request.setAttribute("maKC_active", maKC_raw);
        request.setAttribute("sort_active", sort_raw);
        
        // 7. Chuyển tiếp đến trang shop.jsp
        request.getRequestDispatcher("shop.jsp").forward(request, response);
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