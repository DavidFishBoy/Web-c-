<%-- 
    Document   : admin_orders
    Created on : Nov 12, 2025, 11:05:08 PM
    Author     : toite
--%>

<%@page import="model.NhanVien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // --- Kiểm tra Admin (Bắt buộc) ---
    Object userObj = session.getAttribute("user");
    Integer role = (Integer) session.getAttribute("role");
    
    if (userObj == null || role == null || role != 2 || !(userObj instanceof NhanVien)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return; 
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Đơn hàng</title>
    
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>" type="text/css">
    
    <style>
        .table-responsive { max-height: 80vh; }
        .table th, .table td { vertical-align: middle; }
        .status-form select { min-width: 150px; }
        .status-form button { min-width: 90px; }
    </style>
</head>
<body>

    <div class="admin-layout">
        
        <jsp:include page="admin_sidebar.jsp" />
        
        <div class="admin-content-wrapper">
            
            <div class="admin-header">
                <h1>Quản lý Đơn hàng</h1>
                <div>
                    <span>Chào, <strong>${sessionScope.user.hoTen}</strong>!</span>
                    <a href="DangXuatServlet" class="btn btn-outline-danger" style="margin-left: 15px;">Đăng xuất</a>
                </div>
            </div>

            <div class="admin-container">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                Danh Sách Đơn Hàng
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>Mã HĐ</th>
                                                <th>Khách hàng</th>
                                                <th>Ngày đặt</th>
                                                <th>Người nhận</th>
                                                <th>Địa chỉ</th>
                                                <th>Tổng tiền</th>
                                                <th>Trạng thái</th>
                                                <th>Cập nhật</th>
                                                <th>Chi tiết</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listHoaDon}" var="hd">
                                            <tr>
                                                <td>${hd.maHD}</td>
                                                <td>${hd.maKH}</td>
                                                <td><fmt:formatDate value="${hd.ngayDatHang}" pattern="dd-MM-yyyy HH:mm"/></td>
                                                <td>${hd.hoTenNguoiNhan}</td>
                                                <td>${hd.diaChiGiaoHang}</td>
                                                <td><fmt:formatNumber value="${hd.tongTien}" type="number" /> VNĐ</td>
                                                
                                                <form action="QuanLyDonHangServlet" method="POST" class="status-form">
                                                    <input type="hidden" name="maHD" value="${hd.maHD}">
                                                    
                                                    <td>${hd.tenTrangThai}</td> 
                                                    
                                                    <td>
                                                        <select name="maTrangThaiMoi" class="form-control form-control-sm d-inline-block w-auto">
                                                            <c:forEach items="${listTrangThai}" var="tt">
                                                                <option value="${tt.maTrangThai}" ${tt.maTrangThai == hd.maTrangThai ? 'selected' : ''}>
                                                                    ${tt.tenTrangThai}
                                                                </option>
                                                            </c:forEach>
                                                        </select>
                                                        <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
                                                    </td>
                                                </form>
                                                
                                                <td>
                                                    <a href="OrderDetailServlet?maHD=${hd.maHD}&admin=true" class="btn btn-info btn-sm">Xem</a>
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
    </div>
    
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
    
</body>
</html>