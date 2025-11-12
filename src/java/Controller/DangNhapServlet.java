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
        String userOrEmail = request.getParameter("tendn"); // Nhận username hoặc email
        String mk = request.getParameter("matkhau");

        TaiKhoanDAO dao = new TaiKhoanDAO();
        GioHangDAO ghDAO = new GioHangDAO();
        HttpSession session = request.getSession();

        // Bước 1: Kiểm tra Khách hàng (role = 0)
        // Giả sử TaiKhoanDAO đã được sửa để dùng Email và MatKhau
        TaiKhoan kh = dao.checkKhachHangLogin(userOrEmail, mk); 

        if (kh != null) {
            // Đăng nhập thành công: Khách hàng
            session.setAttribute("user", kh);
            session.setAttribute("role", kh.getRole());
            session.setAttribute("tenHienThi", kh.getHoTen());
            
            // Giả sử model TaiKhoan đã được map đúng MaKH (là Int)
            int cartCount = ghDAO.getSoLuongTrongGio(kh.getMaKH()); 
            session.setAttribute("cartCount", cartCount);

            response.sendRedirect(request.getContextPath() + "/TrangChu");
            
        } else {
            // Bước 2: Kiểm tra Admin (role = 2)
            
            // SỬA LỖI: Tên phương thức là 'checkNhanVienLogin', không phải 'check'
            NhanVien nv = dao.checkNhanVienLogin(userOrEmail, mk); 

            // Giả sử TaiKhoanDAO và model NhanVien đã được sửa để dùng VaiTro (Role)
            if (nv != null && nv.getRole() == 2) { 
                // Đăng nhập thành công: Admin
                session.setAttribute("user", nv);
                session.setAttribute("role", nv.getRole()); 

                response.sendRedirect(request.getContextPath() + "/admin.jsp");

            } else {
                // Đăng nhập thất bại
                request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}