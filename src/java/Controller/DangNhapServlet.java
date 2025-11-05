package Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import DAO.TaiKhoanDAO;
import jakarta.servlet.annotation.WebServlet;
import model.NhanVien;
import model.TaiKhoan; 
import DAO.GioHangDAO;

@WebServlet(name = "DangNhapServlet", urlPatterns = {"/DangNhapServlet"})
public class DangNhapServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        // Lấy thông tin từ form login.jsp
        String email = request.getParameter("tendn"); 
        String mk = request.getParameter("matkhau"); // Giả sử name="matkhau"

        TaiKhoanDAO dao = new TaiKhoanDAO();
        GioHangDAO ghDAO = new GioHangDAO();
        HttpSession session = request.getSession();

        // Bước 1: Kiểm tra xem có phải là Khách hàng (VaiTro = 0)
        TaiKhoan kh = dao.checkKhachHangLogin(email, mk);

        if (kh != null) {
            // Đăng nhập thành công với tư cách Khách hàng
            session.setAttribute("user", kh); // Lưu đối tượng Khách hàng
            session.setAttribute("role", kh.getVaiTro()); // Lưu role = 0
            int cartCount = ghDAO.getSoLuongTrongGio(kh.getMaKH());
            session.setAttribute("cartCount", cartCount);

            // Chuyển về trang chủ
            response.sendRedirect(request.getContextPath() + "/TrangChu");
            
        } else {
            NhanVien nv = dao.checkNhanVienLogin(email, mk);

            if (nv != null) {
                session.setAttribute("user", nv); 
                session.setAttribute("role", nv.getVaiTro()); // Lưu role = 1 hoặc 2

                switch (nv.getVaiTro()) {
                    case 2: // Admin
                        response.sendRedirect(request.getContextPath() + "/admin.jsp"); // Trang quản trị
                        break;
                    case 1: // Nhân viên
                        response.sendRedirect(request.getContextPath() + "/nhanvien.jsp"); // Trang nhân viên
                        break;
                    default: // Các trường hợp khác
                        response.sendRedirect(request.getContextPath() + "/TrangChuServlet");
                }
            } else {
                // Bước 3: Đăng nhập thất bại (không tìm thấy ở cả 2 bảng)
                request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang login nếu cố gắng truy cập GET
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}