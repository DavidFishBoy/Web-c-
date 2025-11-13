package Controller;

import DAO.SanPhamDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.HinhAnhSanPham;
import model.SanPham;
import model.SanPhamSize;

// ...
@WebServlet(name = "ShopDetailsServlet", urlPatterns = {"/ShopDetailsServlet"})
public class ShopDetailsServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Lấy maSP từ URL (do người dùng bấm vào)
        String maSP_raw = request.getParameter("maSP");
        
      try {
            int maSP = Integer.parseInt(maSP_raw);
            SanPhamDAO spDAO = new SanPhamDAO();
            
            // Lấy thông tin chi tiết của 1 sản phẩm (Dùng hàm gốc của bạn)
            SanPham sp = spDAO.getSanPhamByMaSP(maSP);
            
            // Lấy các size/chi tiết của sản phẩm đó
            List<SanPhamSize> listSize = spDAO.getChiTietSPByMaSP(maSP);
            List<HinhAnhSanPham> listAnh = spDAO.getListHinhAnhByMaSP(maSP);
            
            // Kiểm tra xem có tìm thấy sản phẩm không
            if (sp != null) {
                // Lấy MaDM từ sản phẩm (model SanPham của bạn CÓ hàm getMaDM())
                int maDM = sp.getMaDM(); 
                
                // Gọi hàm MỚI để lấy 4 sản phẩm liên quan
                List<SanPham> listSP_LienQuan = spDAO.getSanPhamLienQuan(maDM, maSP);
                
                // Đặt danh sách liên quan vào request
                request.setAttribute("listSP_LienQuan", listSP_LienQuan);
                request.setAttribute("listAnh", listAnh); // Gửi list ảnh sang JSP
            }

            request.setAttribute("sp", sp);
            request.setAttribute("listSize", listSize);
            
            request.getRequestDispatcher("ShopDetails.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("TrangChu");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}