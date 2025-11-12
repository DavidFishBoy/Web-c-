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

    
  
</head>
<body>

    <%-- HEADER --%>
    <jsp:include page="header.jsp" />

    <%-- HERO SLIDER --%>
<%-- HERO SLIDER --%>
    <section class="hero-slider owl-carousel">
        
        <%-- 
          1. Xóa dòng <c:set var="i" value="0"/>
          2. Thêm varStatus="loop" vào thẻ c:forEach
        --%>
        <c:forEach var="hero" items="${requestScope.listHero}" varStatus="loop">
            
            <%-- 3. Xóa dòng <c:set var="i" value="${i + 1}"/> --%>

            <%-- 4. Dùng "loop.count" thay vì "i" --%>
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
