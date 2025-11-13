package Controller;

import DAO.SanPhamDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.DanhMuc;
import model.SanPham;

@WebServlet(name = "QuanLySanPhamServlet", urlPatterns = {"/QuanLySanPhamServlet"})
public class QuanLySanPhamServlet extends HttpServlet {

    /**
     * Xử lý các yêu cầu POST (Thêm mới và Cập nhật)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        SanPhamDAO dao = new SanPhamDAO();

        if (action != null && action.equals("add")) {
            // --- XỬ LÝ THÊM MỚI ---
            try {
                String tenSP = request.getParameter("tenSP");
                int maDM = Integer.parseInt(request.getParameter("maDM"));
                double giaCoBan = Double.parseDouble(request.getParameter("giaCoBan"));
                String hinhAnh = request.getParameter("hinhAnh");
                String maNCC = request.getParameter("maNCC");
                String moTa = request.getParameter("moTa");

                SanPham sp = new SanPham();
                sp.setTenSP(tenSP);
                sp.setMaDM(maDM);
                sp.setGiaCoBan(giaCoBan);
                sp.setHinhAnh(hinhAnh); // Giả định model SanPham có setHinhAnh
                sp.setMaNCC(maNCC);
                sp.setMoTa(moTa);
                // sp.setMoTaDonVi(...); // CSDL có nhưng form chưa có
                
                dao.addSanPham(sp); // Bạn cần kiểm tra lại hàm này trong DAO
                
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // SỬA: Redirect về chính servlet này để tải lại trang
            response.sendRedirect("QuanLySanPhamServlet");
            
        } else if (action != null && action.equals("update")) {
            // --- XỬ LÝ CẬP NHẬT ---
            try {
                int maSP = Integer.parseInt(request.getParameter("maSP"));
                String tenSP = request.getParameter("tenSP");
                int maDM = Integer.parseInt(request.getParameter("maDM"));
                double giaCoBan = Double.parseDouble(request.getParameter("giaCoBan"));
                String hinhAnh = request.getParameter("hinhAnh"); // Cần xử lý ảnh chính
                String maNCC = request.getParameter("maNCC");
                String moTa = request.getParameter("moTa");

                SanPham sp = new SanPham();
                sp.setMaSP(maSP);
                sp.setTenSP(tenSP);
                sp.setMaDM(maDM);
                sp.setGiaCoBan(giaCoBan);
                // sp.setHinhAnh(hinhAnh); // Cần logic cập nhật ảnh chính
                sp.setMaNCC(maNCC);
                sp.setMoTa(moTa);

                dao.updateSanPham(sp); 

            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // SỬA: Redirect về chính servlet này để tải lại trang
            response.sendRedirect("QuanLySanPhamServlet");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String id_raw = request.getParameter("id");
        SanPhamDAO dao = new SanPhamDAO();

        try {
            if (action == null) {
                // --- SỬA: HIỂN THỊ TRANG MẶC ĐỊNH ---
                // Đây là hành động khi nhấp vào "Quản lý Sản phẩm"
                loadProductPage(request, response, dao);
                
            } else if (action.equals("delete") && id_raw != null) {
                // --- XỬ LÝ XÓA ---
                int maSP = Integer.parseInt(id_raw);
                dao.deleteSanPham(maSP);
                response.sendRedirect("QuanLySanPhamServlet"); // Tải lại trang
                
            } else if (action.equals("edit") && id_raw != null) {
                // --- XỬ LÝ TẢI FORM SỬA ---
                int maSP = Integer.parseInt(id_raw);
                
                SanPham sp = dao.getSanPhamByMaSP(maSP); 
                List<DanhMuc> listDM = dao.getAllDanhMuc();
                
                request.setAttribute("sanPhamToEdit", sp);
                request.setAttribute("listDM", listDM);
                
                // Chuyển tiếp đến trang edit_product.jsp
                request.getRequestDispatcher("admin/edit_product.jsp").forward(request, response);
                
            } else {
                 // Nếu action lạ, cứ về trang quản lý SP
                loadProductPage(request, response, dao);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/admin.jsp"); // Về trang tổng quan nếu lỗi nặng
        }
    }

    /**
     * SỬA: Hàm trợ giúp để tải dữ liệu và forward sang JSP
     */
    private void loadProductPage(HttpServletRequest request, HttpServletResponse response, SanPhamDAO dao)
            throws ServletException, IOException {
        
        List<SanPham> listSP = dao.getAllSanPhamSortedByDate(); // Lấy SP
        List<DanhMuc> listDM = dao.getAllDanhMuc(); // Lấy DM cho form
        
        request.setAttribute("listSP", listSP);
        request.setAttribute("listDM", listDM);
        
        request.getRequestDispatcher("admin/admin_products.jsp").forward(request, response);
    }
}