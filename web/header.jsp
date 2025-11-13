<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="<c:url value='/css/custom.css'/>">

<header class="header bg-white shadow-sm sticky-top">
    <div class="container py-3 d-flex align-items-center justify-content-between flex-wrap">
        <!-- Logo -->
        <a href="<c:url value='/TrangChu'/>" class="d-flex align-items-center text-decoration-none">
            <img src="<c:url value='/img/logo.png'/>" alt="Logo" style="height:40px;" class="me-2">
        </a>

        <!-- Search -->
        <form action="<c:url value='/ShopServlet'/>" method="get" class="d-flex align-items-center" style="flex:1; max-width:500px;">
            <input type="text" name="keyword" class="form-control rounded-start-pill" placeholder="Tìm kiếm sản phẩm...">
            <button class="btn btn-dark rounded-end-pill px-3"><i class="fa fa-search"></i></button>
        </form>

        <!-- User & Cart -->
        <div class="d-flex align-items-center gap-3">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="dropdown">
                        <button class="btn btn-outline-dark rounded-pill dropdown-toggle" type="button"
                                id="dropdownUserButton" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-user me-1"></i>
                            <c:out value="${sessionScope.user.hoTen}" default="Tài khoản"/>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="dropdownUserButton">
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="<c:url value='/DangXuatServlet'/>">Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/login.jsp'/>" class="btn btn-outline-dark rounded-pill">
                        <i class="fa fa-user"></i> Đăng nhập
                    </a>
                </c:otherwise>
            </c:choose>

            <a href="<c:url value='/GioHangServlet'/>" class="btn btn-outline-dark rounded-pill position-relative">
                <i class="fa fa-shopping-cart"></i>
                <c:if test="${not empty sessionScope.cartCount && sessionScope.cartCount > 0}">
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        ${sessionScope.cartCount}
                    </span>
                </c:if>
            </a>
        </div>
    </div>

    <!-- Navbar -->
    <nav class="bg-dark">
        <div class="container d-flex justify-content-center flex-wrap py-2">
            <a href="<c:url value='/TrangChu'/>" class="nav-link text-white px-3 fw-semibold">Trang chủ</a>
            <a href="<c:url value='/ShopServlet'/>" class="nav-link text-white px-3 fw-semibold">Cửa hàng</a>
            <a href="<c:url value='/LichSuHoaDonServlet'/>" class="nav-link text-white px-3 fw-semibold">Lịch sử hóa đơn</a>
            <a href="<c:url value='/contact.jsp'/>" class="nav-link text-white px-3 fw-semibold">Liên hệ</a>
        </div>
    </nav>
</header>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
