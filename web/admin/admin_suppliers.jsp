<%-- 
    Document   : admin_suppliers
    Created on : Nov 13, 2025, 12:06:40 AM
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhà Cung Cấp</title>
    
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>" type="text/css">
</head>
<body>

    <div class="admin-layout">
        
        <jsp:include page="admin_sidebar.jsp" />
        
        <div class="admin-content-wrapper">
            
            <div class="admin-header">
                <h1>Quản lý Nhà Cung Cấp</h1>
                <div>
                    <span>Chào, <strong>${sessionScope.user.hoTen}</strong>!</span>
                    <a href="DangXuatServlet" class="btn btn-outline-danger" style="margin-left: 15px;">Đăng xuất</a>
                </div>
            </div>

            <div class="admin-container">
                <div class="row">
                    
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                <c:if test="${empty nccToEdit}">Thêm NCC Mới</c:if>
                                <c:if test="${not empty nccToEdit}">Sửa NCC</c:if>
                            </div>
                            <div class="card-body">
                                
                                <form action="QuanLyNhaCungCapServlet" method="POST">
                                    <c:if test="${not empty nccToEdit}">
                                        <input type="hidden" name="action" value="update">
                                    </c:if>
                                    <c:if test="${empty nccToEdit}">
                                        <input type="hidden" name="action" value="add">
                                    </c:if>
                                    
                                    <div class="form-group">
                                        <label>Mã NCC (VD: AP, SM, NK):</label>
                                        <input type="text" name="maNCC" class="form-control" value="${nccToEdit.maNCC}" ${not empty nccToEdit ? 'readonly' : 'required'}>
                                    </div>
                                    <div class="form-group">
                                        <label>Tên Công ty:</label>
                                        <input type="text" name="tenCty" class="form-control" value="${nccToEdit.tenCty}" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Tên Liên hệ:</label>
                                        <input type="text" name="tenLH" class="form-control" value="${nccToEdit.tenLH}">
                                    </div>
                                    <div class="form-group">
                                        <label>Email:</label>
                                        <input type="email" name="email" class="form-control" value="${nccToEdit.email}">
                                    </div>
                                    <div class="form-group">
                                        <label>Điện thoại:</label>
                                        <input type="text" name="phone" class="form-control" value="${nccToEdit.phone}">
                                    </div>
                                    <div class="form-group">
                                        <label>Địa chỉ:</label>
                                        <input type="text" name="diaChi" class="form-control" value="${nccToEdit.diaChi}">
                                    </div>
                                    <div class="form-group">
                                        <label>Mô tả:</label>
                                        <textarea name="moTa" class="form-control" rows="3">${nccToEdit.moTa}</textarea>
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-block" style="margin-top: 15px;">
                                        <c:if test="${not empty nccToEdit}">Cập nhật</c:if>
                                        <c:if test="${empty nccToEdit}">Thêm mới</c:if>
                                    </button>
                                    
                                    <c:if test="${not empty nccToEdit}">
                                        <a href="QuanLyNhaCungCapServlet" class="btn btn-secondary btn-block" style="margin-top: 10px;">Hủy</a>
                                    </c:if>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                Danh Sách Nhà Cung Cấp
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>Mã NCC</th>
                                                <th>Tên Công ty</th>
                                                <th>Email</th>
                                                <th>Điện thoại</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listNCC}" var="ncc">
                                            <tr>
                                                <td>${ncc.maNCC}</td>
                                                <td>${ncc.tenCty}</td>
                                                <td>${ncc.email}</td>
                                                <td>${ncc.phone}</td>
                                                <td>
                                                    <a href="QuanLyNhaCungCapServlet?action=edit&maNCC=${ncc.maNCC}" 
                                                       class="btn btn-warning btn-sm btn-action">Sửa</a>
                                                    
                                                    <a href="QuanLyNhaCungCapServlet?action=delete&maNCC=${ncc.maNCC}" 
                                                       class="btn btn-danger btn-sm btn-action"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa NCC này? (Sản phẩm thuộc NCC này có thể bị lỗi)');">Xóa</a>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                Services
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