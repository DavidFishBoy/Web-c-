<%-- 
    Document   : admin_users
    Created on : Nov 12, 2025, 11:34:14 PM
    Author     : toite
--%>

<%@page import="model.NhanVien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <title>Quản Lý Khách Hàng</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>">
</head>
<body>
    <div class="admin-layout">
        
        <jsp:include page="admin_sidebar.jsp" />
        
        <div class="admin-content-wrapper">
            <div class="admin-header">
                <h1>Quản Lý Khách Hàng</h1>
                <div>
                    <span>Chào, <strong>${sessionScope.user.hoTen}</strong>!</span>
                    <a href="DangXuatServlet" class="btn btn-outline-danger" style="margin-left: 15px;">Đăng xuất</a>
                </div>
            </div>
            
            <div class="admin-container">
              

                <div class="card">
                    <div class="card-header">
                        Danh Sách Khách Hàng
                    </div>
                    <div class="card-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Mã KH</th>
                                    <th>Họ Tên</th>
                                    <th>Email</th>
                                    <th>Điện thoại</th>
                                    <th class="text-end">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${listKH}" var="kh">
                                    <tr>
                                        <td>${kh.maKH}</td>
                                        <td>${kh.hoTen}</td>
                                        <td>${kh.email}</td>
                                        <td>${kh.dienThoai}</td>
                                        
                                        <td class="text-end">
                                            <a href="EditKhachHangServlet?maKH=${kh.maKH}" 
                                               class="btn btn-sm btn-warning">
                                               Sửa
                                            </a>


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
</body>
</html>