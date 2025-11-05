<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zxx">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết | ${sp.tenSP}</title>

        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
        <link rel="stylesheet" href="css/nice-select.css" type="text/css">
        <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
        <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
        <link rel="stylesheet" href="css/style.css" type="text/css">

        <style>
            .product__details__option .size label {
                cursor: pointer;
                border: 1px solid #e5e5e5;
                padding: 5px 10px;
                margin-right: 5px;
            }
            .product__details__option .size input[type="radio"] {
                display: none;
            }
            .product__details__option .size input[type="radio"]:checked + label {
                border-color: #ca1515;
                background: #ca1515;
                color: #ffffff;
            }
            .product__details__text h3 span {
                font-size: 18px;
                color: #b7b7b7;
                text-decoration: line-through;
                margin-left: 10px;
            }
            .product__details__cart__option .primary-btn:disabled {
                background: #b7b7b7;
                cursor: not-allowed;
            }
            .product__details__breadcrumb {
                text-align: left;
            }
        </style>
    </head>

    <body>
        <div id="preloder"><div class="loader"></div></div>
            <jsp:include page="header.jsp" />

        <section class="shop-details">
            <div class="product__details__pic">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="product__details__breadcrumb">
                                <a href="TrangChu">Trang chủ</a>
                                <a href="ShopServlet">Shop</a>
                                <span>Chi tiết sản phẩm</span>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-3">
                            <%-- Ảnh nhỏ (Thumbnail) --%>
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item">
                                    <a class="nav-link active" data-toggle="tab" href="#tabs-0" role="tab">
                                        <div class="product__thumb__pic set-bg" data-setbg="${pageContext.request.contextPath}/img/${sp.hinhAnh}">                                    </div>
                                    </a>
                                </li>
                                <%-- Lặp qua các ảnh phụ trong listAnh --%>
                                <c:forEach items="${listAnh}" var="anh" varStatus="loop">
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#tabs-${loop.count}" role="tab">
                                            <div class="product__thumb__pic set-bg" data-setbg="${pageContext.request.contextPath}/img/${anh.URLHinhAnh}">                                            </div>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="col-lg-6 col-md-9">
                            <%-- Ảnh lớn (Main Image) --%>
                            <div class="tab-content">
                                <%-- Ảnh chính --%>
                                <div class="tab-pane active" id="tabs-0" role="tabpanel">
                                    <div class="product__details__pic__item">
                                        <img src="${pageContext.request.contextPath}/img/${sp.hinhAnh}" alt="${sp.tenSP}">
                                    </div>
                                </div>
                                <%-- Lặp qua các ảnh phụ --%>
                                <c:forEach items="${listAnh}" var="anh" varStatus="loop">
                                    <div class="tab-pane" id="tabs-${loop.count}" role="tabpanel">
                                        <div class="product__details__pic__item">
                                            <img src="${pageContext.request.contextPath}/img/${anh.URLHinhAnh}" alt="">
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- ============================================= --%>
            <%-- PHẦN 2: NỘI DUNG SẢN PHẨM (ĐỘNG)           --%>
            <%-- ============================================= --%>
            <div class="product__details__content">
                <div class="container">
                    <div class="row d-flex justify-content-center">
                        <div class="col-lg-8">
                            <div class="product__details__text">
                                <h4>${sp.tenSP}</h4>

                                <div class="rating">
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star"></i>
                                    <i class="fa fa-star-o"></i>
                                    <span> - 5 Đánh giá</span>
                                </div>

                                <%-- Giá bán động (lấy giá của size đầu tiên) --%>
                                <h3 id="product-price">
                                    <fmt:formatNumber type="number" value="${listSize[0].giaBan}" /> VNĐ
                                    <c:if test="${sp.giaCoBan > listSize[0].giaBan}">
                                        <span><fmt:formatNumber type="number" value="${sp.giaCoBan}" /> VNĐ</span>
                                    </c:if>
                                </h3>

                                <%-- Hiển thị tồn kho (sẽ được JS cập nhật) --%>
                                <p id="stock-level" style="font-weight: bold; color: #ca1515;"></p>

                                <%-- ============================================= --%>
                                <%-- PHẦN 3: FORM GIỎ HÀNG (ĐỘNG)               --%>
                                <%-- ============================================= --%>
                                <c:if test="${sessionScope.role == 0}">
                                    <form action="ThemGioHangServlet" method="POST">
                                        <div class="product__details__option">
                                            <div class="product__details__option__size">
                                                <span>Size:</span>
                                                <div class="size">
                                                    <c:forEach items="${listSize}" var="s" varStatus="loop">
                                                        <input type="radio" 
                                                               name="maCTSP" 
                                                               id="size-${s.maCTSP}" 
                                                               value="${s.maCTSP}"
                                                               data-price="${s.giaBan}"
                                                               data-soluongton="${s.soLuongTon}"
                                                               onchange="updateDetails(this)"
                                                               ${loop.first ? 'checked' : ''}>
                                                        <label for="size-${s.maCTSP}">${s.tenKichCo}</label>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="product__details__cart__option">
                                            <div class="quantity">
                                                <div class="pro-qty">
                                                    <input type="text" name="soLuong" value="1">
                                                </div>
                                            </div>
                                            <%-- Nút submit sẽ bị vô hiệu hóa nếu hết hàng --%>
                                            <button type="submit" class="primary-btn">Thêm vào giỏ</button>
                                        </div>
                                    </form>
                                </c:if>

                                <c:if test="${sessionScope.role != 0}">
                                    <h5 style="color: #ca1515;">Vui lòng <a href="login.jsp" style="text-decoration: underline;">đăng nhập</a> với tư cách khách hàng để mua sắm.</h5>
                                </c:if>

                                <div class="product__details__btns__option">
                                    <a href="#"><i class="fa fa-heart"></i> Thêm vào yêu thích</a>
                                </div>

                                <%-- Thông tin meta động --%>
                                <div class="product__details__last__option">SS
                                    <li><span>SKU:</span> ${sp.maSP}</li>
                                    <li><span>Danh mục:</span> ${sp.tenDanhMuc}</li>
                                    <li><span>Thương hiệu:</span> ${sp.tenNhaCungCap}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- ============================================= --%>
                    <%-- PHẦN 4: TAB MÔ TẢ (ĐỘNG)                  --%>
                    <%-- ============================================= --%>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="product__details__tab">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#tabs-5" role="tab">Mô tả</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">Đánh giá (5)</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tabs-5" role="tabpanel">
                                        <div class="product__details__tab__content">
                                            <p>${sp.moTa}</p>
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="tabs-6" role="tabpanel">
                                        <div class="product__details__tab__content">
                                            <p>(Nội dung đánh giá của khách hàng sẽ hiển thị ở đây)</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%-- ============================================= --%>
        <%-- PHẦN 5: SẢN PHẨM LIÊN QUAN (ĐỘNG)           --%>
        <%-- ============================================= --%>
        <section class="related spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h3 class="related-title">Sản phẩm liên quan</h3>
                    </div>
                </div>
                <div class="row">
                    <c:forEach items="${listSP_LienQuan}" var="spLienQuan">
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic set-bg" data-setbg="img/${spLienQuan.hinhAnh}">
                                </div>
                                <div class="product__item__text">
                                    <h6>${spLienQuan.tenSP}</h6>
                                    <a href="ShopDetailsServlet?maSP=${spLienQuan.maSP}" class="add-cart">+ Xem chi tiết</a>
                                    <div class="rating">
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                        <i class="fa fa-star-o"></i>
                                    </div>
                                    <h5><fmt:formatNumber type="number" value="${spLienQuan.giaCoBan}" /> VNĐ</h5>
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
        <script src="js/jquery.nice-select.min.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/jquery.countdown.min.js"></script>
        <script src="js/jquery.slicknav.js"></script>
        <script src="js/mixitup.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/main.js"></script>

        <%-- ============================================= --%>
        <%-- PHẦN 6: JAVASCRIPT (CẬP NHẬT GIÁ VÀ TỒN KHO) --%>
        <%-- ============================================= --%>
        <script type="text/javascript">
                                                                   // Lấy giá cơ bản từ ${sp.giaCoBan}
                                                                   const giaCoBan = ${sp.giaCoBan};

                                                                   // Hàm này được gọi khi nhấp vào radio button chọn size
                                                                   function updateDetails(radioElement) {
                                                                       // === 1. Cập nhật giá ===
                                                                       let newPrice = parseFloat(radioElement.getAttribute('data-price'));
                                                                       let formattedPrice = newPrice.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                                                       let priceElement = document.getElementById('product-price');
                                                                       let priceHTML = formattedPrice.replace('₫', 'VNĐ');

                                                                       if (giaCoBan > newPrice) {
                                                                           let formattedGiaCoBan = giaCoBan.toLocaleString('vi-VN', {style: 'currency', currency: 'VND'});
                                                                           priceHTML += ' <span>' + formattedGiaCoBan.replace('₫', 'VNĐ') + '</span>';
                                                                       }
                                                                       priceElement.innerHTML = priceHTML;

                                                                       // === 2. Cập nhật Tồn Kho và Nút bấm ===
                                                                       let soLuongTon = parseInt(radioElement.getAttribute('data-soluongton'));
                                                                       let stockElement = document.getElementById('stock-level');
                                                                       let submitButton = document.querySelector('button[type="submit"].primary-btn');

                                                                       if (soLuongTon > 0) {
                                                                           stockElement.innerHTML = "Chỉ còn " + soLuongTon + " sản phẩm";
                                                                           stockElement.style.color = "#ca1515"; // Màu đỏ
                                                                           if (submitButton) {
                                                                               submitButton.disabled = false; // Bật nút
                                                                               submitButton.innerHTML = "Thêm vào giỏ";
                                                                           }
                                                                       } else {
                                                                           stockElement.innerHTML = "Hết hàng";
                                                                           stockElement.style.color = "#888888"; // Màu xám
                                                                           if (submitButton) {
                                                                               submitButton.disabled = true; // Tắt nút
                                                                               submitButton.innerHTML = "Đã hết hàng";
                                                                           }
                                                                       }
                                                                   }

                                                                   // Tự động chạy hàm này khi tải trang (để cập nhật cho size đầu tiên)
                                                                   document.addEventListener("DOMContentLoaded", function () {
                                                                       let firstSize = document.querySelector('input[name="maCTSP"]:checked');
                                                                       if (firstSize) {
                                                                           updateDetails(firstSize);
                                                                       }
                                                                   });
        </script>

    </body>
</html>