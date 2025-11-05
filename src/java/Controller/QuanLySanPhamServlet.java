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
            // --- XỬ LÝ THÊM MỚI (Đã có) ---
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
                sp.setHinhAnh(hinhAnh);
                sp.setMaNCC(maNCC);
                sp.setMoTa(moTa);

                dao.addSanPham(sp);
            } catch (Exception e) {
                e.printStackTrace();
            }
            
            response.sendRedirect("admin.jsp");
            
        } else if (action != null && action.equals("update")) {
            // --- MỚI: XỬ LÝ CẬP NHẬT ---
            try {
                // Lấy thông tin từ form
                int maSP = Integer.parseInt(request.getParameter("maSP"));
                String tenSP = request.getParameter("tenSP");
                int maDM = Integer.parseInt(request.getParameter("maDM"));
                double giaCoBan = Double.parseDouble(request.getParameter("giaCoBan"));
                String hinhAnh = request.getParameter("hinhAnh");
                String maNCC = request.getParameter("maNCC");
                String moTa = request.getParameter("moTa");

                // Tạo đối tượng SanPham
                SanPham sp = new SanPham();
                sp.setMaSP(maSP); // Quan trọng: set MaSP để biết update SP nào
                sp.setTenSP(tenSP);
                sp.setMaDM(maDM);
                sp.setGiaCoBan(giaCoBan);
                sp.setHinhAnh(hinhAnh);
                sp.setMaNCC(maNCC);
                sp.setMoTa(moTa);

                // Gọi DAO để cập nhật CSDL
                dao.updateSanPham(sp); //

            } catch (Exception e) {
                e.printStackTrace();
            }
            
            // Quay lại trang admin
            response.sendRedirect("admin.jsp");
        }
    }

    /**
     * Xử lý các yêu cầu GET (Xóa và Tải form Sửa)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String id_raw = request.getParameter("id");
        SanPhamDAO dao = new SanPhamDAO();

        if (action != null && id_raw != null) {
            try {
                int maSP = Integer.parseInt(id_raw);

                if (action.equals("delete")) {
                    // --- XỬ LÝ XÓA (Đã có) ---
                    dao.deleteSanPham(maSP); //
                    response.sendRedirect("admin.jsp");
                    
                } else if (action.equals("edit")) {
                    // --- MỚI: XỬ LÝ TẢI FORM SỬA ---
                    
                    // 1. Lấy sản phẩm cần sửa từ CSDL
                    SanPham sp = dao.getSanPhamByMaSP(maSP); //
                    // 2. Lấy danh sách danh mục để hiển thị dropdown
                    List<DanhMuc> listDM = dao.getAllDanhMuc(); //
                    
                    // 3. Đặt 2 đối tượng này vào request
                    request.setAttribute("sanPhamToEdit", sp);
                    request.setAttribute("listDM", listDM);
                    
                    // 4. Chuyển tiếp (forward) đến trang edit_product.jsp
                    // (Phải dùng forward để giữ lại data trong request)
                    request.getRequestDispatcher("edit_product.jsp").forward(request, response);
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("admin.jsp");
            }
        } else {
            response.sendRedirect("admin.jsp");
        }
    }
}