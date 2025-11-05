<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <%-- Phần head giữ nguyên, đã bao gồm c:url và CSS --%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Male-Fashion | Trang Chủ</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/elegant-icons.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/magnific-popup.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/nice-select.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/owl.carousel.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/slicknav.min.css'/>" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" type="text/css">
    <style>
        /* CSS giữ nguyên */
        .header { position: absolute; width: 100%; left: 0; top: 0; z-index: 99; background: transparent; }
        .header .container { background: transparent; margin-top: 0; }
        .hero { padding-top: 175px; }
        
        /* CSS cho filter (Giờ đây là nút data-filter, không phải link) */
        .filter__controls li {
            padding: 5px 15px;
            cursor: pointer;
            border-radius: 2px;
            color: #b7b7b7;
        }
        .filter__controls li.active {
            background: #111111;
            color: #ffffff;
        }
    </style>
</head>

<body>
    <div id="preloder"><div class="loader"></div></div>

    <jsp:include page="header.jsp" />

    <%-- ======================== HERO SLIDER ======================== --%>
    <section class="hero">
        <div class="hero__slider owl-carousel">
            <c:set var="heroIndex" value="${0}" /> 
            <c:forEach items="${requestScope.listHero}" var="heroSP">
                <c:set var="heroIndex" value="${heroIndex + 1}" />
                <div class="hero__items set-bg" 
                     data-setbg="<c:url value='/img/hero/hero-${heroIndex}.jpg'/>">
                     <div class="container">
                        <div class="row">
                            <div class="col-xl-5 col-lg-7 col-md-8">
                                <div class="hero__text">
                                    <h6>Sản Phẩm Nổi Bật</h6>
                                    <h2>${heroSP.tenSP}</h2>
                                    <a href="ShopDetailsServlet?maSP=${heroSP.maSP}" class="primary-btn">
                                        Xem ngay <span class="arrow_right"></span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
    
    <%-- ======================== PRODUCT SECTION (Dùng Mixitup) ======================== --%>
    <section class="product spad">
        <div class="container">
            
            <%-- Dòng 1: Tiêu đề và Filter (Quay lại dùng data-filter) --%>
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>SẢN PHẨM CỦA CHÚNG TÔI</h2>
                    </div>
                    <ul class="filter__controls">
                        <li class="active" data-filter="*">Tất cả (${requestScope.totalSP})</li>
                        <li data-filter=".new-arrivals">Sản phẩm mới (${requestScope.totalNewSP})</li>
                        <li data-filter=".other-products">Sản phẩm khác (${requestScope.totalOtherSP})</li>
                    </ul>
                </div>
            </div>
            
            <%-- Dòng 2: HIỂN THỊ SẢN PHẨM (Thêm class 'product__filter') --%>
            <%-- Lặp qua 'allProducts' (danh sách đầy đủ) --%>
            <div class="row product__filter"> 
            
                <c:forEach items="${requestScope.allProducts}" var="sp"> 
                    <%-- Thêm class 'mix' và class filter động --%>
                    <div class="col-lg-3 col-md-6 col-sm-6 mix 
                        <c:choose>
                            <c:when test="${sp.laSPMoi == true}">new-arrivals</c:when>
                            <c:otherwise>other-products</c:otherwise>
                        </c:choose>
                    ">
                        
                        <%-- CẤU TRÚC HTML GIỐNG HỆT index.html --%>
                        <div class="product__item">
                            <div class="product__item__pic set-bg" 
                                 data-setbg="<c:url value='img/${sp.hinhAnh}'/>">
                                
                                <c:if test="${sp.laSPMoi == true}">
                                    <span class="label">New</span>
                                </c:if>

                                <ul class="product__hover">
                                    <li><a href="#"><img src="<c:url value='/img/icon/heart.png'/>" alt=""></a></li>
                                    <li><a href="ShopDetailsServlet?maSP=${sp.maSP}"><img src="<c:url value='/img/icon/search.png'/>" alt=""> <span>Chi tiết</span></a></li>
                                </ul>
                            </div>
                            <div class="product__item__text">
                                <h6>${sp.tenSP}</h6>
                                <a href="ShopDetailsServlet?maSP=${sp.maSP}" class="add-cart">+ Xem chi tiết</a>
                                <div class="rating">
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                    <i class="fa fa-star-o"></i>
                                </div>
                                <h5><fmt:formatNumber type="number" value="${sp.giaCoBan}" /> VNĐ</h5>
                                <div class="product__color__select">
                                    <label class="active black" for="pc-1-${sp.maSP}">
                                        <input type="radio" id="pc-1-${sp.maSP}">
                                    </label>
                                    <label class="grey" for="pc-2-${sp.maSP}">
                                        <input type="radio" id="pc-2-${sp.maSP}">
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            
            
        </div>
    </section>
 
    
    <jsp:include page="footer.jsp" />
    
    <%-- JS scripts (Giữ nguyên) --%>
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.nice-select.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.nicescroll.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.magnific-popup.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.countdown.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.slicknav.js'/>"></script>
    
    <%-- THÊM LẠI MIXITUP --%>
    <script src="<c:url value='/js/mixitup.min.js'/>"></script>
    
    <script src="<c:url value='/js/owl.carousel.min.js'/>"></script> 
    <script src="<c:url value='/js/main.js'/>"></script>

    
</body>
</html>