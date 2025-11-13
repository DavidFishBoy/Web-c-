package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import DAO.LienHeDAO;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ContactServlet", urlPatterns = {"/ContactServlet"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 2. Lấy dữ liệu động từ form
        String ten = request.getParameter("name");
        String email = request.getParameter("email");
        String noiDung = request.getParameter("noiDung");

       LienHeDAO dao = new LienHeDAO();
        boolean themThanhCong = dao.themLienHe(ten, email, noiDung);
        
        // 4. Gửi thông báo (thành công hoặc thất bại)
        if (themThanhCong) {
            request.setAttribute("message", "Tin nhắn của bạn đã được gửi thành công! Chúng tôi sẽ phản hồi sớm nhất có thể.");
        } else {
            request.setAttribute("message", "Có lỗi xảy ra, vui lòng thử lại.");
        }

        // 5. Chuyển hướng (forward) người dùng trở lại trang contact.jsp
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}