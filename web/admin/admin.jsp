<%@page import="model.ThongKeSanPham"%>
<%@page import="DAO.SanPhamDAO"%>
<%@page import="DAO.TaiKhoanDAO"%>
<%@page import="model.NhanVien"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ThongKeDoanhThu"%>
<%@page import="DAO.HoaDonDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // --- 1. Kiểm tra Admin (Giữ nguyên) ---
    Object userObj = session.getAttribute("user");
    Integer role = (Integer) session.getAttribute("role");
    NhanVien admin = null;
    
    if (userObj == null || role == null || role != 2 || !(userObj instanceof NhanVien)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return; 
    } else {
        admin = (NhanVien) userObj;
    }
 
    // --- 2. SỬA: Lấy TẤT CẢ dữ liệu cho Dashboard ---
    HoaDonDAO hdDAO = new HoaDonDAO();
    TaiKhoanDAO tkDAO = new TaiKhoanDAO();
    SanPhamDAO spDAO = new SanPhamDAO();
    
    // Biểu đồ 7 ngày (cũ)
    List<ThongKeDoanhThu> dataDoanhThu = hdDAO.getThongKeDoanhThu7NgayQua();
    
    // Thẻ Thống kê (mới)
    double tongDoanhThu = hdDAO.getTongDoanhThu();
    int tongSoDonHang = hdDAO.getTongSoDonHang();
    int tongSoKhachHang = tkDAO.getTongSoKhachHang();
    
    // Bảng Bán chạy (mới)
    List<ThongKeSanPham> topSanPham = spDAO.getTopSanPhamBanChay(5);
    
    // Đặt vào request để JSTL/EL dùng (an toàn hơn scriptlet)
    request.setAttribute("dataDoanhThu", dataDoanhThu);
    request.setAttribute("tongDoanhThu", tongDoanhThu);
    request.setAttribute("tongSoDonHang", tongSoDonHang);
    request.setAttribute("tongSoKhachHang", tongSoKhachHang);
    request.setAttribute("topSanPham", topSanPham);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị - Tổng quan</title>
    
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>" type="text/css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

    <div class="admin-layout">
        
        <jsp:include page="admin_sidebar.jsp" />
        
        <div class="admin-content-wrapper">
            
            <div class="admin-header">
                <h1>Tổng quan</h1>
                <div>
                    <span>Chào, <strong>${sessionScope.user.hoTen}</strong>!</span>
                    <a href="<c:url value='/DangXuatServlet'/>" class="btn btn-outline-danger" style="margin-left: 15px;">Đăng xuất</a>
                </div>
            </div>

            <div class="admin-container">
                
                <div class="row">
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="stat-card card-revenue">
                            <div class="icon"><i class="fa fa-usd"></i></div>
                            <div class="info">
                                <h5>Tổng Doanh Thu</h5>
                                <h3><fmt:formatNumber value="${tongDoanhThu}" type="number" /> VNĐ</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="stat-card card-orders">
                            <div class="icon"><i class="fa fa-shopping-cart"></i></div>
                            <div class="info">
                                <h5>Tổng Đơn Hàng</h5>
                                <h3>${tongSoDonHang}</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="stat-card card-users">
                            <div class="icon"><i class="fa fa-users"></i></div>
                            <div class="info">
                                <h5>Tổng Khách Hàng</h5>
                                <h3>${tongSoKhachHang}</h3>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header">
                                Thống Kê Doanh Thu (7 Ngày Gần Nhất)
                            </div>
                            <div class="card-body">
                                <canvas id="myRevenueChart"></canvas>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header">
                                Top 5 Sản Phẩm Bán Chạy
                            </div>
                            <div class="card-body">
                                <table class="table table-hover table-top-products">
                                    <tbody>
                                        <c:forEach items="${topSanPham}" var="topSP" varStatus="loop">
                                        <tr>
                                            <td>${topSP.tenSP}</td>
                                            <td class="text-end">
                                                <span class="badge bg-danger">${topSP.soLuongBan}</span>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
            
        </div>
    </div>

    
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>

    <script>
        // Truyền dữ liệu từ JSTL/EL (an toàn hơn) sang JS
        var chartLabels = [
            <c:forEach items="${dataDoanhThu}" var="tk">
                "${tk.ngay}",
            </c:forEach>
        ];
        var chartData = [
            <c:forEach items="${dataDoanhThu}" var="tk">
                ${tk.tongDoanhThu},
            </c:forEach>
        ];
    </script>
    
    <script src="<c:url value='/js/admin.js'/>"></script>
    
</body>
</html>