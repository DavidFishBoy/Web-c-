<%-- 
    Document   : edit_user
    Created on : Nov 13, 2025, 2:30:32 AM
    Author     : toite
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh Sửa Khách Hàng</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>">
</head>
<body>
    <div class="admin-layout">
        <jsp:include page="admin_sidebar.jsp" />
        
        <div class="admin-content-wrapper">
            <div class="admin-header">
                <h1>Chỉnh Sửa Thông Tin Khách Hàng</h1>
            </div>
            
            <div class="admin-container">
                <div class="card">
                    <div class="card-body">
                        
                        <form action="EditKhachHangServlet" method="POST">
                            
                            <input type="hidden" name="maKH" value="${kh.maKH}">

                            <div class="mb-3">
                                <label class="form-label">Mã KH</label>
                                <input type="text" class="form-control" 
                                       value="${kh.maKH}" disabled>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Họ Tên</label>
                                <input type="text" class="form-control" 
                                       name="hoTen" value="${kh.hoTen}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" 
                                       name="email" value="${kh.email}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" 
                                       name="dienThoai" value="${kh.dienThoai}">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Địa chỉ</label>
                                <textarea class="form-control" 
                                          name="diaChi" rows="3">${kh.diaChi}</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            <a href="QuanLyKhachHangServlet" class="btn btn-secondary">Hủy</a>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
