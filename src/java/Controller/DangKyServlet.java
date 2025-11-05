package Controller;

import DAO.TaiKhoanDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.TaiKhoan;
import java.util.UUID; // Để tạo MaKH ngẫu nhiên

@WebServlet(name = "DangKyServlet", urlPatterns = {"/DangKyServlet"})
public class DangKyServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String hoTen = request.getParameter("hoten");
        String pass = request.getParameter("pass");
        String repass = request.getParameter("repass");
        
 

        if (!pass.equals(repass)) {
            request.setAttribute("error", "Mật khẩu không trùng khớp!");
            request.getRequestDispatcher("dangky.jsp").forward(request, response);
        } else {
            TaiKhoanDAO dao = new TaiKhoanDAO();
            TaiKhoan tk = dao.checkTaiKhoan(email); 

            if (tk == null) {
                // Email hợp lệ, tiến hành đăng ký
                String maKH = "KH" + UUID.randomUUID().toString().substring(0, 5); // Tạo MaKH ngẫu nhiên
                
                int gioiTinh = 0; // Mặc định
                String ngaySinh = "2000-01-01"; // Mặc định
                String diaChi = ""; // Mặc định
                String dienThoai = ""; // Mặc định
                int hieuLuc = 1; // 1 = Hoạt động
                int vaiTro = 0;  // 0 = Khách hàng (QUAN TRỌNG)

                dao.insertTaiKhoan(maKH, pass, hoTen, gioiTinh, ngaySinh, diaChi, dienThoai, email, hieuLuc, vaiTro);
                
                response.sendRedirect("login.jsp");
            } else {
                // Email đã tồn tại
                request.setAttribute("error", "Email đã tồn tại!");
                request.getRequestDispatcher("dangky.jsp").forward(request, response);
            }
        }
    }
}