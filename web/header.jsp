<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="offcanvas-menu-overlay"></div>
<div class="offcanvas-menu-wrapper">
    <div class="offcanvas__option">

        <div class="offcanvas__links">
            <c:choose>
                <%-- 1. Nếu CHƯA đăng nhập --%>
                <c:when test="${sessionScope.user == null}">
                    <a href="login.jsp">Đăng nhập</a>
                    <a href="dangky.jsp">Đăng ký</a>
                </c:when>
                <%-- 2. Nếu ĐÃ đăng nhập --%>
                <c:otherwise>
                    <a href="DangXuatServlet">Đăng xuất</a>
                    <%-- Link Admin/Staff (nếu có) --%>
                    <c:if test="${sessionScope.role == 2}">
                        <a href="admin.jsp" style="color: red;">(Admin)</a>
                    </c:if>
                    <c:if test="${sessionScope.role == 1}">
                        <a href="nhanvien.jsp" style="color: blue;">(Staff)</a>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
    <div class="offcanvas__nav__option">
        <c:if test="${sessionScope.role == 0}">
            <a href="GioHangServlet"><img src="img/icon/cart.png" alt=""> <span>0</span></a>
            </c:if>
    </div>
    <div id="mobile-menu-wrap"></div>
    <div class="offcanvas__text">
        <p>Chào mừng bạn đến với shop thời trang nam.</p>
    </div>
</div>
<header class="header">
    <div class="header__top">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-7">
                    <div class="header__top__left">
                        <p>Chào mừng bạn đến với shop thời trang nam.</p>
                    </div>
                </div>
                <div class="col-lg-6 col-md-5">
                    <div class="header__top__right">

                        <div class="header__top__links">
                            <c:choose>
                                <%-- 1. Nếu CHƯA đăng nhập --%>
                                <c:when test="${sessionScope.user == null}">
                                    <a href="login.jsp">Đăng nhập</a>
                                    <a href="dangky.jsp">Đăng ký</a>
                                </c:when>
                                <%-- 2. Nếu ĐÃ đăng nhập --%>
                                <c:otherwise>
                                    <a href="DangXuatServlet">Đăng xuất</a>
                                    <%-- Link Admin/Staff (nếu có) --%>
                                    <c:if test="${sessionScope.role == 2}">
                                        <a href="admin.jsp" style="color: red;">(Admin)</a>
                                    </c:if>
                                    <c:if test="${sessionScope.role == 1}">
                                        <a href="nhanvien.jsp" style="color: blue;">(Staff)</a>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-3">
                <div class="header__logo">
                    <a href="TrangChu"><img src="img/logo.png" alt=""></a>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <nav class="header__menu mobile-menu">
                    <ul>
                        <li class="active"><a href="TrangChu">Trang chủ</a></li>
                        <li><li><a href="ShopServlet">Cửa hàng</a></li></li>
                        <li><a href="#">Giới thiệu</a></li>
                        <li><a href="#">Liên hệ</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-lg-3 col-md-3">
                <div class="header__nav__option">

                    <c:if test="${sessionScope.user != null}">
                        <span style="font-weight: bold; color: #ca1515; margin-right: 15px;">
                            Chào, ${sessionScope.user.hoTen}
                        </span>
                    </c:if>

                    <c:if test="${sessionScope.role == 0}">
                        <a href="GioHangServlet"><img src="img/icon/cart.png" alt=""> 
                            <span>${sessionScope.cartCount == null ? 0 : sessionScope.cartCount}</span>
                        </a>                        </c:if>

                </div>
            </div>
        </div>
        <div class="canvas__open"><i class="fa fa-bars"></i></div>
    </div>
</header>