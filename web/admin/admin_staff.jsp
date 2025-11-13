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
    
    NhanVien admin = (NhanVien) userObj;
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhân viên</title>
    
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>" type="text/css">
</head>
<body>

    <div class="admin-layout">
        
        <jsp:include page="admin_sidebar.jsp" />
        
        <div class="admin-content-wrapper">
            
            <div class="admin-header">
                <h1>Quản lý Nhân viên</h1>
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
                                <c:if test="${empty nvToEdit}">Thêm Nhân viên Mới</c:if>
                                <c:if test="${not empty nvToEdit}">Sửa Nhân viên</c:if>
                            </div>
                            <div class="card-body">
                                
                                <form action="QuanLyNhanVienServlet" method="POST">
                                    <c:if test="${not empty nvToEdit}">
                                        <input type="hidden" name="action" value="update">
                                    </c:if>
                                    <c:if test="${empty nvToEdit}">
                                        <input type="hidden" name="action" value="add">
                                    </c:if>
                                    
                                    <div class="form-group">
                                        <label>Mã Nhân viên (VD: nv03, nv04):</label>
                                        <input type="text" name="maNV" class="form-control" value="${nvToEdit.maNV}" ${not empty nvToEdit ? 'readonly' : 'required'}>
                                    </div>
                                    <div class="form-group">
                                        <label>Họ Tên:</label>
                                        <input type="text" name="hoTen" class="form-control" value="${nvToEdit.hoTen}" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Email:</label>
                                        <input type="email" name="email" class="form-control" value="${nvToEdit.email}" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Mật khẩu:</label>
                                        <input type="password" name="matKhau" class="form-control" 
                                               placeholder="${not empty nvToEdit ? '(Để trống nếu không đổi)' : 'Nhập mật khẩu'}"
                                               ${empty nvToEdit ? 'required' : ''}>
                                    </div>
                                    <div class="form-group">
                                        <label>Vai trò:</label>
                                        <select name="role" class="form-control">
                                            <option value="1" ${nvToEdit.role == 1 ? 'selected' : ''}>Nhân viên</option>
                                            <option value="2" ${nvToEdit.role == 2 ? 'selected' : ''}>Admin</option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-block" style="margin-top: 15px;">
                                        <c:if test="${not empty nvToEdit}">Cập nhật</c:if>
                                        <c:if test="${empty nvToEdit}">Thêm mới</c:if>
                                    </button>
                                    
                                    <c:if test="${not empty nvToEdit}">
                                        <a href="QuanLyNhanVienServlet" class="btn btn-secondary btn-block" style="margin-top: 10px;">Hủy</a>
                                    </c:if>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                Danh Sách Nhân Viên
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-striped">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th>Mã NV</th>
                                                <th>Họ Tên</th>
                                                <th>Email</th>
                                                <th>Vai trò</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listNV}" var="nv">
                                            <tr>
                                                <td>${nv.maNV}</td>
                                                <td>${nv.hoTen}</td>
                                                <td>${nv.email}</td>
                                                <td>
                                                    <c:if test="${nv.role == 2}"><span class="badge bg-primary">Admin</span></c:if>
                                                    <c:if test="${nv.role == 1}"><span class="badge bg-secondary">Nhân viên</span></c:if>
                                                </td>
                                                <td>
                                                    <a href="QuanLyNhanVienServlet?action=edit&maNV=${nv.maNV}" 
                                                       class="btn btn-warning btn-sm btn-action">Sửa</a>
                                                    
                                                    <a href="QuanLyNhanVienServlet?action=delete&maNV=${nv.maNV}" 
                                                       class="btn btn-danger btn-sm btn-action ${admin.maNV == nv.maNV ? 'disabled' : ''}"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa nhân viên này?');">Xóa</a>
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