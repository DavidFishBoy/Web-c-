<%-- 
    Document   : edit_product
    Created on : Nov 6, 2025, 12:27:08 AM
    Author     : sphuo
--%>

<%@page import="model.DanhMuc"%>
<%@page import="java.util.List"%>
<%@page import="model.SanPham"%>
<%@page import="model.NhanVien"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // ================== KIỂM TRA BẢO MẬT ==================
    // (Tương tự admin.jsp, đảm bảo chỉ Admin mới vào được)
    Object userObj = session.getAttribute("user");
    Integer role = (Integer) session.getAttribute("role");
    
    if (userObj == null || role == null || role != 2 || !(userObj instanceof NhanVien)) {
        response.sendRedirect("login.jsp");
        return; 
    }
    // ================== KẾT THÚC BẢO MẬT ==================

    // Lấy sản phẩm cần sửa và danh sách danh mục đã được gửi từ Servlet
    SanPham sp = (SanPham) request.getAttribute("sanPhamToEdit");
    List<DanhMuc> listDM = (List<DanhMuc>) request.getAttribute("listDM");

    // Nếu không tìm thấy sản phẩm, quay về trang admin
    if (sp == null || listDM == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Sản Phẩm - Admin</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    
    <style>
        /* CSS tương tự admin.jsp */
        body { background-color: #f8f9fa; }
        .admin-header { padding: 20px; background: #fff; border-bottom: 1px solid #dee2e6; margin-bottom: 30px; }
        .admin-header h1 { color: #111111; font-weight: 700; }
        .admin-container { max-width: 800px; margin: auto; }
        .card-header { font-weight: 600; background-color: #f1f1f1; }
        .form-control { margin-bottom: 15px; }
    </style>
</head>
<body>

    <div class="admin-header">
        <h1>Chỉnh Sửa Sản Phẩm (ID: <%= sp.getMaSP() %>)</h1>
    </div>

    <div class="admin-container">
        <div class="card">
            <div class="card-header">
                Cập nhật thông tin sản phẩm
            </div>
            <div class="card-body">
                <form action="QuanLySanPhamServlet" method="POST">
                    
                    <input type="hidden" name="action" value="update">
                    
                    <input type="hidden" name="maSP" value="<%= sp.getMaSP() %>">
                    
                    <label>Tên sản phẩm:</label>
                    <input type="text" name="tenSP" class="form-control" value="<%= sp.getTenSP() %>" required>
                    
                    <label>Danh mục:</label>
                    <select name="maDM" class="form-control">
                        <% for (DanhMuc dm : listDM) { 
                            // Tự động chọn đúng danh mục hiện tại của sản phẩm
                            String selected = (dm.getMaDM() == sp.getMaDM()) ? "selected" : "";
                        %>
                            <option value="<%= dm.getMaDM() %>" <%= selected %>>
                                <%= dm.getTenDM() %>
                            </option>
                        <% } %>
                    </select>
                    
                    <label>Giá cơ bản (VNĐ):</label>
                    <input type="number" name="giaCoBan" class="form-control" value="<%= sp.getGiaCoBan() %>" required>
                    
                    <label>Link hình ảnh (ví dụ: img/product-1.jpg):</label>
                    <input type="text" name="hinhAnh" class="form-control" value="<%= sp.getHinhAnh() %>" required>
                    
                    <label>Mã nhà cung cấp (AP, SM, NK):</label>
                    <input type="text" name="maNCC" class="form-control" value="<%= sp.getMaNCC() %>" required>
                    
                    <label>Mô tả sản phẩm:</label>
                    <textarea name="moTa" class="form-control" rows="4"><%= sp.getMoTa() %></textarea>
                    
                    <button type="submit" class="btn btn-success" style="margin-top: 15px;">Cập Nhật</button>
                    <a href="admin.jsp" class="btn btn-secondary" style="margin-top: 15px;">Hủy</a>
                </form>
            </div>
        </div>
    </div>

</body>
</html>