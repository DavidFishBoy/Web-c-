<%-- 
    Document   : admin_stock
    Created on : Nov 13, 2025, 2:51:48 AM
    Author     : toite
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- (Bạn có thể copy phần kiểm tra Admin từ file admin.jsp vào đây) --%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Kho Hàng</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/adminstyle.css'/>">
</head>
<body>
    <div class="admin-layout">
        
        <jsp:include page="admin_sidebar.jsp" />
        
<div class="admin-container">
    
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="card">
        <div class="card-header">
            Danh Sách Tồn Kho Chi Tiết
        </div>
        <div class="card-body">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th>Mã CTSP</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Kích Cỡ</th>
                        <th style="width: 150px;">Số Lượng Tồn</th>
                        <th class="text-end" style="width: 120px;">Hành động</th>
                    </tr>
                </thead>
                <tbody>
    <c:forEach items="${listStock}" var="item">
        <tr>
            <form action="QuanLyKhoServlet" method="POST" style="display: contents;">
            
                <input type="hidden" name="maCTSP" value="${item.maCTSP}">
                <input type="hidden" name="currentPage" value="${currentPage}">
                
                <td>${item.maCTSP}</td>
                <td>${item.tenSP}</td>
                <td>${item.tenKichCo}</td>
                
                <td>
                    <input type="number" name="soLuongMoi" 
                           class="form-control form-control-sm" 
                           value="${item.soLuongTon}" 
                           min="0" required>
                </td>
                
                <td class="text-end">
                    <button type="submit" class="btn btn-sm btn-primary">
                        <i class="fa fa-check"></i> Cập nhật
                    </button>
                </td>
            </form>
        </tr>
    </c:forEach>
</tbody>
            </table>

            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="QuanLyKhoServlet?page=${currentPage - 1}">Lùi</a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="QuanLyKhoServlet?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="QuanLyKhoServlet?page=${currentPage + 1}">Tiếp</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
            </div>
    </div>

</div>
</body>
</html>
