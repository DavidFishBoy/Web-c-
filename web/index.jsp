<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Male-Fashion | Trang Chủ</title>
    
    <!-- Fonts & Icons -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/owl.carousel.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/owl.theme.default.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">

    <style>
        /* Thêm CSS nâng cao từ nhánh master + chỉnh sửa bố cục */
        .header .container { background: transparent; margin-top: 0; }
        .hero { padding-top: 175px; }

        .category-slider-section { padding-top: 100px; padding-bottom: 50px; }
        .category-slider-section .section-title { text-align: left; margin-bottom: 40px; position: relative; }
        .category-slider__item { aspect-ratio: 3/4; position: relative; overflow: hidden; border-radius: 5px; }
        .category-slider__item img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s ease; }
        .category-slider__item:hover img { transform: scale(1.05); }
        .category-slider__item .category-slider__text { position: absolute; bottom: 15px; left: 15px; right: 15px; padding: 15px; background: rgba(0,0,0,0.5); border-radius:5px; text-align:center; }
        .category-slider__item .category-slider__text h4 { color:#fff; font-weight:700; margin-bottom:5px; }
        .category-slider__item .category-slider__text a.primary-btn-link { color:#fff; font-size:13px; font-weight:700; text-transform:uppercase; text-decoration:none; transition:color 0.3s; }
        .category-slider__item:hover .category-slider__text a.primary-btn-link { color:#e53637; }
        .category-slider-section .owl-nav { position:absolute; top:-10px; right:0; }
        .category-slider-section .owl-nav button { margin:0 5px; background:#f3f2ee !important; width:30px; height:30px; border-radius:50%; font-size:0 !important; transition: all 0.3s; }
        .category-slider-section .owl-nav button span.fa { font-size:20px !important; color:#b7b7b7 !important; line-height:30px !important; }
        .category-slider-section .owl-nav button:hover { background:#111 !important; }
        .category-slider-section .owl-nav button:hover span.fa { color:#fff !important; }

        .product_slider_section .section-title-wrapper { margin-bottom:30px; display:flex; justify-content:space-between; align-items:center; }
        .product_slider_section .owl-nav { position:absolute; top:-65px; right:0; }
        .product_slider_section .owl-nav button { margin:0 5px; background:#f3f2ee !important; width:30px; height:30px; border-radius:50%; font-size:0 !important; }
        .product_slider_section .owl-nav button span.fa { font-size:20px !important; color:#b7b7b7 !important; line-height:30px !important; }
        .product_slider_section .owl-nav button:hover { background:#111 !important; }
        .product_slider_section .owl-nav button:hover span.fa { color:#fff !important; }
    </style>
</head>
<body>
    <div id="preloder"><div class="loader"></div></div>

    <%-- HEADER --%>
    <jsp:include page="header.jsp" />

    <%-- HERO SLIDER --%>
    <section class="hero-slider owl-carousel">
        <c:forEach var="hero" items="${requestScope.listHero}" varStatus="loop">
            <div class="hero-item" style="background-image: url('${pageContext.request.contextPath}/img/hero/hero-${loop.count}.jpg');">
                <div class="overlay"></div>
                <div class="container">
                    <div class="hero-content">
                        <h1>${hero.tenSP}</h1>
                        <a href="ShopDetailsServlet?maSP=${hero.maSP}">Xem ngay</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </section>

    <%-- CATEGORY SLIDER --%>
    <section class="category-slider-section py-5">
        <div class="container">
            <h2 class="mb-4">Danh Mục Nổi Bật</h2>
            <div class="owl-carousel category-slider">
                <c:forEach var="dm" items="${requestScope.listDanhMucs}">
                    <div class="category-card">
                        <img src="<c:url value='img/${dm.hinhAnh}'/>" alt="${dm.tenDM}">
                        <div class="category-info">
                            <h4>${dm.tenDM}</h4>
                            <a href="<c:url value='/ShopServlet?maDM=${dm.maDM}'/>">Xem sản phẩm</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <%-- PRODUCT SLIDER --%>
    <section class="product-slider-section py-5 bg-light">
        <div class="container">
            <h2 class="mb-4">Sản Phẩm Mới</h2>
            <div class="owl-carousel product__slider">
                <c:forEach var="sp" items="${requestScope.listNewSP}">
                    <div class="card product-card">
                        <img src="<c:url value='img/product/${sp.hinhAnh}'/>" class="card-img-top" alt="${sp.tenSP}">
                        <div class="product-info">
                            <h5>${sp.tenSP}</h5>
                            <p><fmt:formatNumber type="number" value="${sp.giaCoBan}" /> VNĐ</p>
                            <a href="ShopDetailsServlet?maSP=${sp.maSP}">Xem chi tiết</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    <%-- FOOTER --%>
    <jsp:include page="footer.jsp" />

    <%-- JS --%>
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
    <script src="<c:url value='/js/owl.carousel.min.js'/>"></script>
    <script>
        $(document).ready(function(){
            $(".hero-slider").owlCarousel({
                items:1,
                loop:true,
                autoplay:true,
                autoplayTimeout:4000,
                nav:true,
                navText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
                dots:true,
            });
            $(".category-slider").owlCarousel({
                loop:true,
                margin:20,
                nav:true,
                navText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
                dots:false,
                responsive:{
                    0:{items:1},
                    600:{items:2},
                    1000:{items:3}
                }
            });
            $(".product__slider").owlCarousel({
                loop:true,
                margin:20,
                nav:true,
                navText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
                dots:false,
                responsive:{
                    0:{items:1},
                    600:{items:2},
                    1000:{items:4}
                }
            });
        });
    </script>
</body>
</html>
