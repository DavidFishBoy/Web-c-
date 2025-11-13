package Controller;

import DAO.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.NhanVien;

@WebServlet(name = "QuanLyNhanVienServlet", urlPatterns = {"/QuanLyNhanVienServlet"})
public class QuanLyNhanVienServlet extends HttpServlet {

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
        
        TaiKhoanDAO dao = new TaiKhoanDAO();
        String action = request.getParameter("action");
        
        if (action == null || action.equals("list")) {
            // Hiển thị trang
            List<NhanVien> listNV = dao.getAllNhanVien();
            request.setAttribute("listNV", listNV);
            request.getRequestDispatcher("admin/admin_staff.jsp").forward(request, response);
            
        } else if (action.equals("delete")) {
            // Xử lý Xóa
            try {
                String maNV = request.getParameter("maNV");
                // Cẩn thận: Không cho Admin tự xóa chính mình
                NhanVien admin = (NhanVien) userObj;
                if (!admin.getMaNV().equals(maNV)) {
                     dao.deleteNhanVien(maNV);
                } else {
                    // (Có thể thêm thông báo lỗi: "Không thể tự xóa tài khoản của chính mình")
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.sendRedirect("QuanLyNhanVienServlet"); 
        
        } else if (action.equals("edit")) {
            // Tải thông tin để Sửa
            try {
                String maNV = request.getParameter("maNV");
                NhanVien nv = dao.getNhanVienByMaNV(maNV);
                List<NhanVien> listNV = dao.getAllNhanVien();
                
                request.setAttribute("nvToEdit", nv); // Gửi Nhân viên cần sửa
                request.setAttribute("listNV", listNV); // Gửi danh sách
                request.getRequestDispatcher("admin/admin_staff.jsp").forward(request, response);
                
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("QuanLyNhanVienServlet");
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
        TaiKhoanDAO dao = new TaiKhoanDAO();
        
        try {
            // Lấy tất cả thông tin từ form
            String maNV = request.getParameter("maNV");
            String hoTen = request.getParameter("hoTen");
            String email = request.getParameter("email");
            String matKhau = request.getParameter("Password");
            int vaiTro = Integer.parseInt(request.getParameter("role"));
            
            NhanVien nv = new NhanVien(maNV, hoTen, email, matKhau, vaiTro);
            
            if (action.equals("add")) {
                dao.addNhanVien(nv);
            } else if (action.equals("update")) {
                // Nếu mật khẩu để trống -> giữ mật khẩu cũ
                if (matKhau == null || matKhau.trim().isEmpty()) {
                    NhanVien nvCu = dao.getNhanVienByMaNV(maNV);
                    nv.setPassword(nvCu.getPassword());
                }
                dao.updateNhanVien(nv);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect("QuanLyNhanVienServlet"); // Tải lại trang
    }
}