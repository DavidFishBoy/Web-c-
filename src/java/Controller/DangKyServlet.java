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

   // BÊN TRONG processRequest của DangKyServlet.java

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ JSP (sử dụng tên đúng)
        String ten = request.getParameter("hoten");      
        String email = request.getParameter("email");
        String sdt = request.getParameter("dienThoai");  
        String diaChi = request.getParameter("diaChi");  
        String pass = request.getParameter("pass");     
        String re_pass = request.getParameter("repass"); 
        
        // Gán username là email (vì DAO check tồn tại bằng email)
        String user = email; 

        // Kiểm tra các trường bắt buộc (HoTen, Email, MatKhau)
        if (ten == null || pass == null || re_pass == null || email == null || 
            ten.isEmpty() || pass.isEmpty() || email.isEmpty() || re_pass.isEmpty()) {
            
            request.setAttribute("error", "Vui lòng điền đầy đủ các trường bắt buộc (Họ tên, Email, Mật khẩu).");
            request.getRequestDispatcher("dangky.jsp").forward(request, response);
            return;
        }
        
        // Chuẩn hóa sdt và địa chỉ (nếu người dùng bỏ trống)
        if (sdt == null) sdt = "";
        if (diaChi == null) diaChi = "";

        if (!pass.equals(re_pass)) {
            request.setAttribute("error", "Mật khẩu không trùng khớp!");
            request.getRequestDispatcher("dangky.jsp").forward(request, response);
        } else {
            TaiKhoanDAO dao = new TaiKhoanDAO();
            
            // SỬA: DAO check tồn tại bằng email (đúng logic của TaiKhoanDAO)
            TaiKhoan a = dao.checkTaiKhoanTonTai(email); 
            
            if (a == null) {
                // Được phép đăng ký
                // SỬA: Thay đổi DAO.signup để kiểm tra kết quả trả về (boolean)
                if (dao.signup(user, pass, email, ten, sdt, diaChi)) {
                    // Đăng ký thành công
                    response.sendRedirect("login.jsp"); // Chuyển về trang đăng nhập
                } else {
                    // Lỗi xảy ra trong quá trình thêm vào CSDL (Do CSDL hoặc lỗi hệ thống)
                    request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại hoặc liên hệ hỗ trợ.");
                    request.getRequestDispatcher("dangky.jsp").forward(request, response);
                }
            } else {
                // Tài khoản đã tồn tại
                request.setAttribute("error", "Email này đã được đăng ký!");
                request.getRequestDispatcher("dangky.jsp").forward(request, response);
            }
        }}
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