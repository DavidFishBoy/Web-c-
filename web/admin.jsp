
<%@page import="model.NhanVien"%>
<%@page import="model.DanhMuc"%>
<%@page import="model.SanPham"%>
<%@page import="java.util.List"%>
<%@page import="DAO.SanPhamDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.ThongKeDoanhThu"%>
<%@page import="DAO.HoaDonDAO"%>

<%
    Object userObj = session.getAttribute("user");
    Integer role = (Integer) session.getAttribute("role");
    NhanVien admin = null;
    
    if (userObj == null || role == null || role != 2 || !(userObj instanceof NhanVien)) {
        response.sendRedirect(request.getContextPath() + "/login.jsp"); 
        return; 
    } else {
        admin = (NhanVien) userObj;
    }
 
    SanPhamDAO dao = new SanPhamDAO();
    List<SanPham> listSP = dao.getAllSanPhamSortedByDate();
    List<DanhMuc> listDM = dao.getAllDanhMuc();
    
    HoaDonDAO hdDAO = new HoaDonDAO();
    List<ThongKeDoanhThu> dataDoanhThu = hdDAO.getThongKeDoanhThu7NgayQua();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Quản Trị - Admin</title>
    
    <%-- ĐÃ SỬA ĐƯỜNG DẪN CSS BẰNG CONTEXT PATH --%>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css" type="text/css">
    
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/adminstyle.css" type="text/css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
</head>
<body>

    <div class="admin-header">
        <h1>Bảng điều khiển Admin</h1>
        <div>
            <span>Chào, <strong><%= admin.getHoTen() %></strong>!</span>
            <a href="DangXuatServlet" class="btn btn-outline-danger" style="margin-left: 15px;">Đăng xuất</a>
        </div>
    </div>

    <div class="admin-container">
        
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        Thống Kê Doanh Thu (7 Ngày Gần Nhất)
                    </div>
                    <div class="card-body">
                        <canvas id="myRevenueChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
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
                                    <% for (DanhMuc dm : listDM) { %>
                                        <option value="<%= dm.getMaDM() %>"><%= dm.getTenDM() %></option>
                                    <% } %>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label>Giá cơ bản (VNĐ):</label>
                                <input type="number" name="giaCoBan" class="form-control" required>
                            </div>

                                        <div class="form-group">
                                   <label>Tên file hình ảnh (VD: jeans_black.jpg):</label>
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
                                <% for (SanPham sp : listSP) { %>
                                <tr>
                                    <td><%= sp.getMaSP() %></td>
                                    <%-- ĐÃ SỬA ĐƯỜNG DẪN ẢNH SẢN PHẨM --%>
                                    <td><img src="<%= request.getContextPath() %>/img/<%= sp.getHinhAnh() %>" alt="Ảnh SP" style="width: 50px; height: auto;"></td>
                                    <td><%= sp.getTenSP() %></td>
                                    <td><%= sp.getMaDM() %></td>
                                    <td><%= String.format("%,.0f", sp.getGiaCoBan()) %></td>
                                    <td><%= sp.getLuotXem() %></td>
                                    <td>
                                        <a href="QuanLySanPhamServlet?action=edit&id=<%= sp.getMaSP() %>" 
                                            class="btn btn-warning btn-sm btn-action">Sửa</a>
                                        
                                        <a href="QuanLySanPhamServlet?action=delete&id=<%= sp.getMaSP() %>" 
                                            class="btn btn-danger btn-sm btn-action"
                                            onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này?');">Xóa</a>
                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    
    <%-- ĐÃ SỬA ĐƯỜNG DẪN JS BẰNG CONTEXT PATH --%>
    <script src="<%= request.getContextPath() %>/js/jquery-3.3.1.min.js"></script>
    <script src="<%= request.getContextPath() %>/js/bootstrap.min.js"></script>

    <script>
        // Định nghĩa biến toàn cục để tệp js/admin.js có thể đọc được
        var chartLabels = [];
        var chartData = [];
        
        <% for (ThongKeDoanhThu tk : dataDoanhThu) { %>
            chartLabels.push("<%= tk.getNgay() %>");
            chartData.push(<%= tk.getTongDoanhThu() %>);
        <% } %>
        
        // Đoạn JavaScript để xem trước ảnh
        const contextPath = "<%= request.getContextPath() %>";
        
        $('#hinhAnhInput').on('input', function() {
            const fileName = $(this).val();
            const $preview = $('#imagePreview');
            
            if (fileName) {
                const imageUrl = contextPath + '/img/' + fileName;
                $preview.attr('src', imageUrl).show();
            } else {
                $preview.hide().attr('src', '');
            }
        });
        
    </script>
    
    <script src="<%= request.getContextPath() %>/js/admin.js"></script>
    
</body>
</html>