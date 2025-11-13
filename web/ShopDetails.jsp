<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${sp.tenSP} | Chi tiết sản phẩm</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/custom.css">

</head>

<body>
    <jsp:include page="header.jsp" />

    <section class="breadcrumb-option py-3">
        <div class="container">
            <div class="breadcrumb__text">
                <h4>Chi tiết sản phẩm</h4>
                <div class="breadcrumb__links">
                    <a href="TrangChu">Trang chủ</a>
                    <a href="ShopServlet">Shop</a>
                    <span>${sp.tenSP}</span>
                </div>
            </div>
        </div>
    </section>

          
    <section class="shop-details spad">
        <div class="container">
            <c:set var="firstImage" value="${!empty listAnh ? listAnh[0].urlHinhAnh : 'placeholder.jpg'}"/>

            <div class="row align-items-start g-5 mt-4">
                <div class="col-lg-6">
                    <div class="product-gallery shadow-sm rounded-4 bg-white p-4">
                        <div class="main-image text-center mb-3">
                            <img id="mainImage" src="${pageContext.request.contextPath}/img/product/${firstImage}" 
                                 alt="${sp.tenSP}">
                            <button type="button" class="gallery-nav-btn prev" id="prevImage">‹</button>
                            <button type="button" class="gallery-nav-btn next" id="nextImage">›</button>
                        </div>
                        
                        <div class="owl-carousel owl-theme">
                            <c:forEach items="${listAnh}" var="anh">
                                <div class="item-thumb">
                                    <img src="${pageContext.request.contextPath}/img/product/${anh.urlHinhAnh}" 
                                         data-img="${pageContext.request.contextPath}/img/product/${anh.urlHinhAnh}" 
                                         alt="Thumb">
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="product-info shadow-sm rounded-4 bg-white p-4">
                        <h2>${sp.tenSP}</h2>
                        
                        <div class="mb-3">
                            <span class="text-secondary small d-block">Mã SP: ${sp.maSP}</span>
                            <span class="text-secondary small d-block">Thương hiệu: ${sp.tenNhaCungCap}</span>
                        </div>

                        <c:if test="${not empty listSize}">
                            <h3 class="mb-4"><fmt:formatNumber value="${listSize[0].giaBan}" type="number" /> VNĐ</h3>
                        </c:if>

                        <form action="ThemGioHangServlet" method="POST">
                            <div class="mb-4">
                                <span class="fw-semibold">Kích cỡ:</span>
                                <div class="mt-2 d-flex flex-wrap gap-2">
                                    <c:forEach items="${listSize}" var="s" varStatus="loop">
                                        <input type="radio" class="btn-check" name="maCTSP" id="size-${s.maCTSP}" value="${s.maCTSP}" ${loop.first ? 'checked' : ''}>
                                        <label class="btn btn-outline-dark rounded-pill px-3 py-2" for="size-${s.maCTSP}">
                                            ${s.tenKichCo}
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>

                            <div class="mb-4 d-flex align-items-center">
                                <span class="fw-semibold me-3">Số lượng:</span>
                                <div class="input-group" style="width:120px;">
                                    <button type="button" class="btn btn-outline-secondary" onclick="decreaseValue(this)">−</button>
                                    <input type="number" class="form-control text-center" name="soLuong" value="1" min="1" max="99">
                                    <button type="button" class="btn btn-outline-secondary" onclick="increaseValue(this)">+</button>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-outline-dark rounded-pill px-4 py-2 fw-semibold add-to-cart-btn">
                                <i class="fa fa-cart-plus me-2"></i> Thêm vào giỏ hàng
                            </button>
                        </form>
                        
                        <div class="product__details__tab mt-4">
                            <ul class="nav nav-tabs">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#mota">Mô tả sản phẩm</a>
                                </li>
                            </ul>
                            <div class="tab-content p-3 bg-white rounded-bottom">
                                <div id="mota" class="tab-pane fade show active">
                                    <p>${sp.moTa}</p>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
            
        </div>
    </section>

    <section class="related spad">
        <div class="container">
            <h3 class="text-center fw-bold mb-4">Sản phẩm liên quan</h3>
            <div class="row">
                <c:forEach items="${listSP_LienQuan}" var="spLienQuan">
                    <div class="col-lg-3 col-md-6 col-sm-6 mb-4">
                        <div class="product__item">
                            <div class="product__item__pic">
                                <img src="img/product/${spLienQuan.hinhAnh}" alt="${spLienQuan.tenSP}">
                            </div>
                            <div class="product__item__text text-center p-3">
                                <h6>${spLienQuan.tenSP}</h6>
                                <h5><fmt:formatNumber value="${spLienQuan.giaCoBan}" type="number" /> VNĐ</h5>
                                <a href="ShopDetailsServlet?maSP=${spLienQuan.maSP}">Xem chi tiết</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>

    
    <jsp:include page="footer.jsp" />

    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script>
     // --- LOGIC TĂNG/GIẢM SỐ LƯỢNG ---
     function decreaseValue(btn){ 
         const input = btn.parentElement.querySelector("input[type='number']");
         if (parseInt(input.value) > 1) {
             input.value = parseInt(input.value) - 1;
         }
     }
     function increaseValue(btn){ 
         const input = btn.parentElement.querySelector("input[type='number']");
         if (parseInt(input.value) < 99) { 
             input.value = parseInt(input.value) + 1;
         }
     }

     // --- LOGIC KHI TRANG TẢI XONG ---
     $(document).ready(function(){
         
         // 1. Khởi tạo Owl Carousel (như cũ)
         var owl = $(".owl-carousel");
         owl.owlCarousel({ loop:false, margin:10, items:4, nav:false });
 
         // --- LOGIC MỚI CHO GALLERY ---
         var allThumbnails = $(".item-thumb img");
         var totalImages = allThumbnails.length;
         var currentIndex = 0; 

         function updateCurrentIndexBySrc(src) {
             allThumbnails.each(function(index) {
                 if ($(this).data("img") === src) {
                     currentIndex = index;
                     return false; 
                 }
             });
         }

         allThumbnails.click(function(){
             var newImgSrc = $(this).data("img");
             $("#mainImage").attr("src", newImgSrc);
             updateCurrentIndexBySrc(newImgSrc); 
         });
 
         $("#nextImage").click(function() {
             currentIndex++; 
             if (currentIndex >= totalImages) {
                 currentIndex = 0; 
             }
             var nextImgSrc = $(allThumbnails[currentIndex]).data("img");
             $("#mainImage").attr("src", nextImgSrc);
         });
         
         $("#prevImage").click(function() {
             currentIndex--; 
             if (currentIndex < 0) {
                 currentIndex = totalImages - 1; 
             }
             var prevImgSrc = $(allThumbnails[currentIndex]).data("img");
             $("#mainImage").attr("src", prevImgSrc);
         });
         
        // SỬA: Code JS để active tab (Bootstrap 5)
        var triggerTabList = [].slice.call(document.querySelectorAll('.product__details__tab a'))
        triggerTabList.forEach(function (triggerEl) {
            var tabTrigger = new bootstrap.Tab(triggerEl)

            triggerEl.addEventListener('click', function (event) {
                event.preventDefault()
                tabTrigger.show()
            })
        });
     });
    </script>
    
</body>
</html>