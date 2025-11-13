package Controller;

import DAO.SanPhamDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.NhaCungCap;
import model.NhanVien;

@WebServlet(name = "QuanLyNhaCungCapServlet", urlPatterns = {"/QuanLyNhaCungCapServlet"})
public class QuanLyNhaCungCapServlet extends HttpServlet {

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
        
        SanPhamDAO dao = new SanPhamDAO();
        String action = request.getParameter("action");
        
        if (action == null || action.equals("list")) {
            // Hiển thị trang
            List<NhaCungCap> listNCC = dao.getAllNhaCungCap();
            request.setAttribute("listNCC", listNCC);
            request.getRequestDispatcher("admin/admin_suppliers.jsp").forward(request, response);
            
        } else if (action.equals("delete")) {
            // Xử lý Xóa
            try {
                String maNCC = request.getParameter("maNCC");
                dao.deleteNhaCungCap(maNCC);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("QuanLyNhaCungCapServlet"); 
        
        } else if (action.equals("edit")) {
            // Tải thông tin để Sửa
            try {
                String maNCC = request.getParameter("maNCC");
                NhaCungCap ncc = dao.getNhaCungCapByMaNCC(maNCC);
                List<NhaCungCap> listNCC = dao.getAllNhaCungCap();
                
                request.setAttribute("nccToEdit", ncc); // Gửi NCC cần sửa
                request.setAttribute("listNCC", listNCC); // Gửi danh sách
                request.getRequestDispatcher("admin/admin_suppliers.jsp").forward(request, response);
                
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("QuanLyNhaCungCapServlet");
            }
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
        
        // Kiểm tra quyền Admin
        HttpSession session = request.getSession();
        Object userObj = session.getAttribute("user");
        Integer role = (Integer) session.getAttribute("role");
        
        if (userObj == null || role == null || role != 2 || !(userObj instanceof NhanVien)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return; 
        }
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        SanPhamDAO dao = new SanPhamDAO();
        
        try {
            // Lấy tất cả thông tin từ form
            String maNCC = request.getParameter("maNCC");
            String tenCty = request.getParameter("tenCty");
            String tenLH = request.getParameter("tenLH");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String diaChi = request.getParameter("diaChi");
            String moTa = request.getParameter("moTa");
            
            NhaCungCap ncc = new NhaCungCap(maNCC, tenCty, tenLH, email, phone, diaChi, moTa);
            
            if (action.equals("add")) {
                dao.addNhaCungCap(ncc);
            } else if (action.equals("update")) {
                dao.updateNhaCungCap(ncc);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("QuanLyNhaCungCapServlet"); // Tải lại trang
    }
}