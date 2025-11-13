<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="currentPage" value="${pageContext.request.requestURI.substring(pageContext.request.contextPath.length() + 1)}" />

<div class="admin-sidebar">
    <h3 class="sidebar-title">Admin Menu</h3>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'admin/admin.jsp' ? 'active' : ''}" 
               href="<c:url value='/admin/admin.jsp'/>">
                <i class="fa fa-tachometer"></i> Tổng quan
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'QuanLySanPhamServlet' || currentPage == 'admin/admin_products.jsp' ? 'active' : ''}" 
               href="<c:url value='/QuanLySanPhamServlet'/>">
                <i class="fa fa-shopping-bag"></i> Quản lý Sản phẩm
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'QuanLyDonHangServlet' || currentPage == 'admin/admin_orders.jsp' ? 'active' : ''}" 
               href="<c:url value='/QuanLyDonHangServlet'/>">
                <i class="fa fa-file-text"></i> Quản lý Đơn hàng
            </a>
        </li>
        <li class="nav-item">
<a class="nav-link ${currentPage == 'admin/admin_users.jsp' || currentPage == 'QuanLyKhachHangServlet' ? 'active' : ''}" 
   href="<c:url value='/QuanLyKhachHangServlet'/>">
    <i class="fa fa-users"></i> Quản lý Khách hàng
</a>
        </li>
        <li class="nav-item">
<li class="nav-item">
            <a class="nav-link ${currentPage == 'admin/admin_staff.jsp' || currentPage == 'QuanLyNhanVienServlet' ? 'active' : ''}" 
               href="<c:url value='/QuanLyNhanVienServlet'/>">
                <i class="fa fa-id-badge"></i> Quản lý Nhân viên
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link ${currentPage == 'admin/admin_suppliers.jsp' || currentPage == 'QuanLyNhaCungCapServlet' ? 'active' : ''}" 
               href="<c:url value='/QuanLyNhaCungCapServlet'/>">
                <i class="fa fa-industry"></i> Quản lý NCC
            </a>
        </li>
<li class="nav-item">
    <a class="nav-link ${currentPage == 'QuanLyKhoServlet' || currentPage == 'admin/admin_stock.jsp' ? 'active' : ''}" 
       href="<c:url value='/QuanLyKhoServlet'/>">
        <i class="fa fa-dropbox"></i> Quản Lý Kho
    </a>
</li>

    </ul>
</div>