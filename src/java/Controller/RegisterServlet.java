package Controller; // Tên package của bạn

import java.io.IOException;

// 👇 THAY ĐỔI Ở ĐÂY: từ 'javax' thành 'jakarta'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        request.setCharacterEncoding("UTF-8");
        
        
        String hoten = request.getParameter("hoten");
        String email = request.getParameter("email");
        String matkhau = request.getParameter("matkhau");
        String gender = request.getParameter("gender");
        String ngaysinh = request.getParameter("ngaysinh");
        String sodienthoai = request.getParameter("sodienthoai");
        String diachi = request.getParameter("diachi");

      
        System.out.println("Đăng ký: " + hoten + " - Email: " + email);
        
      
        response.sendRedirect("login.jsp"); 
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