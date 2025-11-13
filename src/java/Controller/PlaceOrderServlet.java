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
        request.setCharacterEncoding("UTF-8"); 

        HttpSession session = request.getSession();
        TaiKhoan user = (TaiKhoan) session.getAttribute("user");

        if (user == null || user.getRole() != 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String hoTenNguoiNhan = request.getParameter("hoTenNguoiNhan");
            String diaChiGiaoHang = request.getParameter("diaChiGiaoHang");
            String ghiChu = request.getParameter("ghiChu");
            
            String maKH = user.getMaKH(); 
            GioHangDAO ghDAO = new GioHangDAO();
            List<GioHang> listGioHang = ghDAO.getGioHangByMaKH(maKH);

            if (listGioHang.isEmpty()) {
                response.sendRedirect("GioHangServlet");
                return;
            }


            HoaDon hd = new HoaDon();
            hd.setMaKH(maKH);
            hd.setHoTenNguoiNhan(hoTenNguoiNhan);
            hd.setDiaChiGiaoHang(diaChiGiaoHang);
            hd.setGhiChu(ghiChu);

            HoaDonDAO hoaDonDAO = new HoaDonDAO();
            
            int maHDMoi = hoaDonDAO.createHoaDon(hd, listGioHang);

            if (maHDMoi > 0) { 
                session.removeAttribute("listGioHang"); 
                session.removeAttribute("tongTien");
                session.setAttribute("cartCount", 0); 
                
            
response.sendRedirect("OrderDetailServlet?maHD=" + maHDMoi);
            } else {
                request.setAttribute("errorMessage", "Đã xảy ra lỗi khi đặt hàng. Vui lòng thử lại.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp");
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