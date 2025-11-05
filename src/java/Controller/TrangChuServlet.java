package Controller;

import DAO.SanPhamDAO;
import java.io.IOException;
import java.util.ArrayList; 
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.SanPham;

@WebServlet(name = "TrangChuServlet", urlPatterns = {"/TrangChu"})
public class TrangChuServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        SanPhamDAO spDAO = new SanPhamDAO();
        int topNewProducts = 8; // Vẫn dùng để set cờ 'laSPMoi'

        // 1. Lấy Top 2 sản phẩm cho Hero
        List<SanPham> listHero = spDAO.getTopViewed(2); 
        
        // 2. Lấy TẤT CẢ sản phẩm
        List<SanPham> allProducts = spDAO.getAllSanPhamSortedByDate();
        
        // 3. SET CỜ 'laSPMoi' VÀ TÍNH TỔNG (cho filter)
        int totalNewSP = 0;
        int totalOtherSP = 0;
        
        for (int i = 0; i < allProducts.size(); i++) {
            SanPham sp = allProducts.get(i);
            if (i < topNewProducts) {
                sp.setLaSPMoi(true);
                totalNewSP++;
            } else {
                sp.setLaSPMoi(false);
                totalOtherSP++;
            }
        }
        
        // 4. Gửi TẤT CẢ sản phẩm lên JSP (Không còn phân trang)
        request.setAttribute("listHero", listHero); 
        request.setAttribute("allProducts", allProducts); // Gửi toàn bộ danh sách
        
        // Gửi thông tin cho Filter (vẫn cần thiết)
        request.setAttribute("totalSP", allProducts.size());
        request.setAttribute("totalNewSP", totalNewSP); 
        request.setAttribute("totalOtherSP", totalOtherSP); 
        
        request.getRequestDispatcher("index.jsp").forward(request, response);
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