<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán</title>

    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
</head>

<body>
    <div id="preloder"><div class="loader"></div></div>
    
    <jsp:include page="header.jsp" />

    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>Thanh Toán</h4>
                        <div class="breadcrumb__links">
                            <a href="TrangChuServlet">Trang chủ</a>
                            <a href="GioHangServlet">Giỏ Hàng</a>
                            <span>Thanh Toán</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="checkout spad">
        <div class="container">
            <div class="checkout__form">
                
                <%-- 
                  Form này sẽ gửi dữ liệu đến 'PlaceOrderServlet'
                  (Bạn cần tạo Servlet này để xử lý logic lưu hóa đơn)
                --%>
                <form action="PlaceOrderServlet" method="POST">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h6 class="checkout__title">Thông tin giao hàng</h6>
                            
                            <%-- SỬ DỤNG sessionScope.user ĐỂ TỰ ĐIỀN THÔNG TIN --%>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="checkout__input">
                                        <p>Họ Tên người nhận<span>*</span></p>
                                        <input type="text" name="hoTenNguoiNhan" required
                                               value="${sessionScope.user.hoTen}">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="checkout__input">
                                <p>Địa chỉ giao hàng<span>*</span></p>
                                <input type="text" name="diaChiGiaoHang" required
                                       value="${sessionScope.user.diaChi}" class="checkout__input__add">
                            </div>
                            
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>Số điện thoại<span>*</span></p>
                                        <input type="text" name="sdtNguoiNhan" required
                                               value="${sessionScope.user.dienThoai}">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="checkout__input">
                                        <p>Email<span>*</span></p>
                                        <input type="text" name="emailNguoiNhan" required
                                               value="${sessionScope.user.email}">
                                    </div>
                                </div>
                            </div>
                            <div class="checkout__input">
                                <p>Ghi chú đơn hàng</p>
                                <input type="text" name="ghiChu"
                                placeholder="Ghi chú về đơn hàng, ví dụ: thời gian giao hàng...">
                            </div>
                        </div>
                        
                        <%-- PHẦN TÓM TẮT ĐƠN HÀNG (ĐỘNG) --%>
                        <div class="col-lg-4 col-md-6">
                            <div class="checkout__order">
                                <h4 class="order__title">Đơn hàng của bạn</h4>
                                <div class="checkout__order__products">Sản phẩm <span>Tổng</span></div>
                                <ul class="checkout__total__products">
                                    <%-- Lặp qua giỏ hàng (listGioHang) --%>
                                    <c:forEach items="${listGioHang}" var="item">
                                        <li>
                                            ${item.soLuong} x ${item.tenSP} (${item.tenKichCo})
                                            <span><fmt:formatNumber type="number" value="${item.giaBan * item.soLuong}" /> VNĐ</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <ul class="checkout__total__all">
                                    <li>Tổng phụ <span><fmt:formatNumber type="number" value="${tongTien}" /> VNĐ</span></li>
                                    <li>Phí vận chuyển <span>0 VNĐ</span></li>
                                    <li>Tổng cộng <span><fmt:formatNumber type="number" value="${tongTien}" /> VNĐ</span></li>
                                </ul>
                                
                                <%-- Tùy chọn Thanh toán (Giữ nguyên) --%>
                                <div class="checkout__input__checkbox">
                                    <label for="payment">
                                        Thanh toán khi nhận hàng (COD)
                                        <input type="radio" id="payment" name="paymentMethod" value="COD" checked>
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label for="transfer">
                                        Chuyển khoản Ngân hàng
                                        <input type="radio" id="transfer" name="paymentMethod" value="Transfer">
                                        <span class="checkmark"></span>
                                    </label>
                                </div>
                                
                                <button type="submit" class="site-btn">ĐẶT HÀNG</button>
                            </div>
                        </div>
                    </div>
                </form>
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
</body>
</html>