package Controller;

import DAO.GioHangDAO;
import DAO.HoaDonDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GioHang;
import model.HoaDon;
import model.TaiKhoan;

@WebServlet(name = "PlaceOrderServlet", urlPatterns = {"/PlaceOrderServlet"})
public class PlaceOrderServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận tiếng Việt

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        // 1. Kiểm tra đăng nhập
        if (user == null || user.getRole() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 2. Lấy thông tin từ form (trang checkout.jsp)
            String hoTenNguoiNhan = request.getParameter("hoTenNguoiNhan");
            String diaChiGiaoHang = request.getParameter("diaChiGiaoHang");
            String sdtNguoiNhan = request.getParameter("sdtNguoiNhan");
            String emailNguoiNhan = request.getParameter("emailNguoiNhan");
            String ghiChu = request.getParameter("ghiChu");
            // String paymentMethod = request.getParameter("paymentMethod"); 

            // 3. Lấy thông tin giỏ hàng từ DAO
            int maKH = user.getMaKH(); 
            GioHangDAO ghDAO = new GioHangDAO();
            List<GioHang> listGioHang = ghDAO.getGioHangByMaKH(maKH);

            if (listGioHang.isEmpty()) {
                // Không có gì trong giỏ, quay về trang giỏ hàng
                response.sendRedirect("GioHangServlet");
                return;
            }

            // 4. Tính tổng tiền (RẤT QUAN TRỌNG, vì CSDL cần)
            double tongTien = 0;
            for (GioHang item : listGioHang) {
                tongTien += item.getGiaBan() * item.getSoLuong();
            }

            // 5. Tạo đối tượng HoaDon (đã khớp với CSDL)
            HoaDon hd = new HoaDon();
            hd.setMaKH(maKH);
            hd.setTongTien(tongTien);
            hd.setHoTenNguoiNhan(hoTenNguoiNhan);
            hd.setDiaChiGiaoHang(diaChiGiaoHang);
            hd.setSdtNguoiNhan(sdtNguoiNhan);
            hd.setEmailNguoiNhan(emailNguoiNhan);
            hd.setGhiChu(ghiChu);
            // NgayDatHang và MaTrangThai sẽ được set tự động trong DAO

            // 6. Gọi HoaDonDAO để tạo đơn
            HoaDonDAO hoaDonDAO = new HoaDonDAO();
            boolean datHangThanhCong = hoaDonDAO.createHoaDon(hd, listGioHang);

            // 7. Chuyển hướng
            if (datHangThanhCong) {
                // Xóa giỏ hàng trong session (nếu bạn có lưu)
                session.removeAttribute("listGioHang"); 
                session.removeAttribute("tongTien");
                
                // Chuyển đến trang thông báo thành công
                response.sendRedirect("order_success.jsp");
            } else {
                // Báo lỗi (ví dụ: quay lại giỏ hàng với thông báo lỗi)
                request.setAttribute("errorMessage", "Đã xảy ra lỗi khi đặt hàng. Vui lòng thử lại.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp"); // Gửi về trang checkout nếu có lỗi
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