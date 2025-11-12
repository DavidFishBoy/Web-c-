package Controller;

// SỬA: Đổi từ 'jakarta' sang 'javax'
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import DAO.TaiKhoanDAO;
import jakarta.servlet.annotation.WebServlet; // SỬA: Đổi từ 'jakarta'
import model.TaiKhoan;

@WebServlet(name = "DangKyServlet", urlPatterns = {"/DangKyServlet"})
public class DangKyServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // SỬA: Lấy đúng tên các trường từ dangky.jsp
        String user = request.getParameter("username"); // Giả sử name="username"
        String pass = request.getParameter("password"); // Giả sử name="password"
        String re_pass = request.getParameter("repassword"); // Giả sử name="repassword"
        String email = request.getParameter("email");
        String ten = request.getParameter("hoTen");
        String sdt = request.getParameter("dienThoai");
        String diaChi = request.getParameter("diaChi");

        // Kiểm tra các trường bắt buộc
        if (user == null || pass == null || re_pass == null || email == null || ten == null ||
            user.isEmpty() || pass.isEmpty() || email.isEmpty() || ten.isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc.");
            request.getRequestDispatcher("dangky.jsp").forward(request, response);
            return;
        }

        if (!pass.equals(re_pass)) {
            request.setAttribute("error", "Mật khẩu không trùng khớp!");
            request.getRequestDispatcher("dangky.jsp").forward(request, response);
        } else {
            TaiKhoanDAO dao = new TaiKhoanDAO();
            
            // SỬA: Dùng hàm checkTaiKhoanTonTai(String username)
            TaiKhoan a = dao.checkTaiKhoanTonTai(user); 
            
            if (a == null) {
                // Được phép đăng ký
                // SỬA: Dùng hàm signup() khớp CSDL
                dao.signup(user, pass, email, ten, sdt, diaChi);
                response.sendRedirect("login.jsp"); // Chuyển về trang đăng nhập
            } else {
                // Tài khoản đã tồn tại
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("dangky.jsp").forward(request, response);
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
        processRequest(request, response);
    }
}