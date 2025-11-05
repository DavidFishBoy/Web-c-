<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%-- KIỂM TRA QUYỀN --%>
<c:if test="${sessionScope.role == null || sessionScope.role != 0}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>

    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <style>
        .shopping-cart { background-color: #f8f9fa; }
        .cart-item-card {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            padding: 20px;
        }
        .cart-item-pic {
            width: 100px; height: 100px;
            object-fit: cover; border-radius: 5px;
        }
        .cart-item-details { margin-left: 20px; flex-grow: 1; }
        .cart-item-details h6 { font-weight: 700; margin-bottom: 5px; }
        .cart-item-details .price { color: #ca1515; font-size: 16px; font-weight: 700; }
        
        /* CSS cho form số lượng MỚI */
        .quantity-form {
            display: flex;
            align-items: center;
        }
        .quantity-form .form-control {
            width: 60px; /* Ô input nhỏ hơn */
            height: 40px;
            text-align: center;
            border-radius: 5px 0 0 5px; /* Bo tròn góc trái */
            border-right: none;
        }
        .quantity-form .btn-update-cart {
            height: 40px;
            width: 40px;
            border: 1px solid #e1e1e1;
            background: #f5f5f5;
            color: #111;
            border-radius: 0 5px 5px 0; /* Bo tròn góc phải */
            padding: 0;
            font-size: 14px;
        }
        .quantity-form .btn-update-cart:hover {
            background: #ca1515;
            color: #ffffff;
            border-color: #ca1515;
        }
        
        .cart-item-actions { text-align: right; }
        .cart-item-actions .cart__price { font-size: 18px; font-weight: 700; color: #111; }
        .cart-item-actions .cart__close a { color: #ca1515; font-size: 18px; opacity: 0.7; transition: opacity 0.3s; }
        .cart-item-actions .cart__close a:hover { opacity: 1; }
        
        .cart-summary {
            background: #ffffff; border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 30px;
        }
        .cart-summary .primary-btn { width: 100%; }
    </style>
</head>
<body>
    <div id="preloder"><div class="loader"></div></div>

    <jsp:include page="header.jsp" />

    <section class="breadcrumb-option" style="background: #f3f2ee;">
        <div class="container"><div class="row"><div class="col-lg-12">
            <div class="breadcrumb__text">
                <h4>Giỏ hàng</h4>
                <div class="breadcrumb__links">
                    <a href="TrangChu">Trang chủ</a>
                    <span>Giỏ hàng</span>
                </div>
            </div>
        </div></div></div>
    </section>
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                
                <div class="col-lg-8">
                    
                    <c:if test="${empty requestScope.listGH}">
                        <div class="cart-item-card">
                            <h5>Giỏ hàng của bạn đang trống.</h5>
                            <a href="TrangChu" class="primary-btn mt-3">Tiếp tục mua sắm</a>
                        </div>
                    </c:if>

                    <c:forEach items="${requestScope.listGH}" var="o">
                        <div class="cart-item-card">
                            <div class="row align-items-center">
                                <div class="col-lg-5 col-md-6 d-flex align-items-center mb-3 mb-md-0">
                                    <img src="img/${o.hinhAnh}" alt="" class="cart-item-pic">
                                    <div class="cart-item-details">
                                        <h6>${o.tenSP}</h6>
                                        <div class="price">
                                            <fmt:formatNumber type="number" maxFractionDigits="0" value="${o.giaBan}" /> VNĐ
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-lg-3 col-md-3 col-6">
                                    <form action="CapNhatGioHangServlet" method="POST" class="quantity-form">
                                        <input type="hidden" name="maCTSP" value="${o.maCTSP}">
                                        
                                        <input type="number" class="form-control" name="soLuong" value="${o.soLuong}" min="0">
                                        
                                        <button type="submit" class="btn-update-cart" title="Cập nhật">
                                            <i class="fa fa-refresh"></i>
                                        </button>
                                    </form>
                                </div>
                                
                                <div class="col-lg-4 col-md-3 col-6 cart-item-actions">
                                    <div class="cart__price mb-2">
                                        <fmt:formatNumber type="number" maxFractionDigits="0" value="${o.giaBan * o.soLuong}" /> VNĐ
                                    </div>
                                    <div class="cart__close">
                                        <a href="XoaGioHangServlet?maCTSP=${o.maCTSP}" title="Xóa"><i class="fa fa-close"></i> Xóa</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${!empty requestScope.listGH}">
                        <div class="continue__btn">
                            <a href="TrangChu">Tiếp tục mua sắm</a>
                        </div>
                    </c:if>

                </div>
                
                <div class="col-lg-4">
                    <div class="cart-summary">
                        <div class="cart__total mt-4">
                            <h6>Tổng giỏ hàng</h6>
                            <ul>
                                <li>Tổng <span><fmt:formatNumber type="number" maxFractionDigits="0" value="${requestScope.tongTien}" /> VNĐ</span></li>
                            </ul>
                            <a href="CheckoutServlet" class="primary-btn">Tiến hành thanh toán</a>
                        </div>
                    </div>
                </div>
                
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
    
    </body>
</html>