package Controller; // Tên package của bạn

import java.io.IOException;

// 👇 THAY ĐỔI Ở ĐÂY: từ 'javax' thành 'jakarta'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// 👇 Thêm import này để quản lý Session
import jakarta.servlet.http.HttpSession;

// (Giả sử bạn có 1 class User trong package 'model')
// import model.User;
// import util.UserDAO;


@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Nhận dữ liệu từ form (khớp với thuộc tính 'name' trong JSP)
        String email = request.getParameter("email_login");
        String matkhau = request.getParameter("matkhau_login");

        // --- XỬ LÝ LOGIC TẠI ĐÂY ---
        // 1. Gọi DAO để kiểm tra email và mật khẩu trong database
        // UserDAO dao = new UserDAO();
        // User user = dao.checkLogin(email, matkhau); // (Giả sử hàm này trả về User nếu đúng)

        // 2. Xử lý kết quả
        // if (user != null) {
        if (true) { // <-- Đây là code giả định, bạn phải thay bằng logic thật
            // Đăng nhập thành công
            
            // Tạo hoặc lấy session hiện tại
            HttpSession session = request.getSession();
            
            // Lưu thông tin người dùng vào session
            // session.setAttribute("account", user); 
            session.setAttribute("email", email); // Lưu tạm email vào session
            
            // Chuyển hướng đến trang chủ
            response.sendRedirect("index.html"); // hoặc "index.jsp"
            
        } else {
            // Đăng nhập thất bại
            
            // Đặt một thông báo lỗi
            request.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng!");
            
            // Chuyển tiếp (forward) về lại trang login.jsp để hiển thị lỗi
            // (Lưu ý: dùng forward để giữ lại request và hiển thị lỗi)
            request.getRequestDispatcher("login.jsp").forward(request, response);
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