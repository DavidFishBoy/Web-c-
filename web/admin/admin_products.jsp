<%-- 
    Document   : admin_products
    Created on : Nov 12, 2025, 10:53:05 PM
    Author     : toite
--%>

<%@page import="model.NhanVien"%>
<%@page import="model.DanhMuc"%>
<%@page import="model.SanPham"%>
<%@page import="java.util.List"%>
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
    
    // --- Lấy dữ liệu đã được Servlet gửi sang ---
    List<SanPham> listSP = (List<SanPham>) request.getAttribute("listSP");
    List<DanhMuc> listDM = (List<DanhMuc>) request.getAttribute("listDM");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Sản phẩm</title>
    
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>" type="text/css">
</head>
<body>

    <div class="admin-layout">
        
        <jsp:include page="admin_sidebar.jsp" />
        
        <div class="admin-content-wrapper">
            
            <div class="admin-header">
                <h1>Quản lý Sản phẩm</h1>
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
                                Thêm Sản Phẩm Mới
                            </div>
                            <div class="card-body">
                                <form action="QuanLySanPhamServlet" method="POST">
                                    <input type="hidden" name="action" value="add">
                                    
                                    <div class="form-group">
                                        <label>Tên sản phẩm:</label>
                                        <input type="text" name="tenSP" class="form-control" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label>Danh mục:</label>
                                        <select name="maDM" class="form-control">
                                            <c:forEach items="${listDM}" var="dm">
                                                <option value="${dm.maDM}">${dm.tenDM}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label>Giá cơ bản (VNĐ):</label>
                                        <input type="number" name="giaCoBan" class="form-control" step="1000" min="0" required>
                                    </div>

                                    <div class="form-group">
                                       <label>Tên file hình ảnh (VD: product-1.webp):</label>
                                       <input type="text" name="hinhAnh" id="hinhAnhInput" class="form-control" required>
                                    </div>

                                    <div class="form-group">
                                        <img id="imagePreview" src="" alt="Ảnh xem trước" 
                                             style="width: 100%; max-width: 300px; height: auto; display: none; border: 1px solid #ddd; padding: 5px; border-radius: 5px;">
                                    </div>

                                    <div class="form-group">
                                        <label>Mã nhà cung cấp (AP, SM, NK):</label>
                                        <input type="text" name="maNCC" class="form-control" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label>Mô tả sản phẩm:</label>
                                        <textarea name="moTa" class="form-control" rows="4"></textarea>
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-block" style="margin-top: 15px;">Thêm Sản Phẩm</button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                Danh Sách Sản Phẩm
                            </div>
                            <div class="card-body">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>Mã SP</th>
                                            <th>Hình ảnh</th>
                                            <th>Tên Sản Phẩm</th>
                                            <th>Mã DM</th>
                                            <th>Giá (VNĐ)</th>
                                            <th>Lượt xem</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listSP}" var="sp">
                                        <tr>
                                            <td>${sp.maSP}</td>
                                            <td><img src="<c:url value='/img/product/${sp.hinhAnh}'/>" alt="Ảnh SP"></td>
                                            <td>${sp.tenSP}</td>
                                            <td>${sp.maDM}</td>
                                            <td><fmt:formatNumber value="${sp.giaCoBan}" type="number" /></td>
                                            <td>${sp.luotXem}</td>
                                            <td>
                                                <a href="<c:url value='/QuanLySanPhamServlet?action=edit&id=${sp.maSP}'/>" 
                                                   class="btn btn-warning btn-sm btn-action">Sửa</a>
                                                
                                                <a href="<c:url value='/QuanLySanPhamServlet?action=delete&id=${sp.maSP}'/>" 
                                                   class="btn btn-danger btn-sm btn-action"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
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
        // Đoạn JavaScript để xem trước ảnh
        const contextPath = "${pageContext.request.contextPath}";
        $('#hinhAnhInput').on('input', function() {
            const fileName = $(this).val();
            const $preview = $('#imagePreview');
            
            if (fileName) {
                // SỬA: Đường dẫn ảnh sản phẩm là /img/product/
                const imageUrl = contextPath + '/img/product/' + fileName;
                $preview.attr('src', imageUrl).show();
            } else {
                $preview.hide().attr('src', '');
            }
        });
    </script>
    
</body>
</html>
