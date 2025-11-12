<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán</title>

    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">

    <style>
        body { font-family:'Poppins', sans-serif; background:#f8f9fa; }

        .checkout__form { background:#fff; padding:30px; border-radius:12px; box-shadow:0 8px 25px rgba(0,0,0,0.05); }
        .checkout__title { font-size:22px; font-weight:600; margin-bottom:20px; }

        .checkout__input { margin-bottom:15px; }
        .checkout__input p { font-weight:600; margin-bottom:5px; }
        .checkout__input input { width:100%; padding:10px 12px; border:1px solid #ddd; border-radius:6px; font-size:15px; }

        .checkout__order { background:#fff; padding:20px; border-radius:12px; box-shadow:0 8px 25px rgba(0,0,0,0.05); }
        .checkout__order h4 { font-size:22px; font-weight:600; margin-bottom:20px; }
        .checkout__order__products { display:flex; justify-content:space-between; font-weight:600; border-bottom:1px solid #ddd; padding-bottom:10px; margin-bottom:10px; }
        .checkout__total__products li { display:flex; justify-content:space-between; padding:8px 0; border-bottom:1px dashed #eee; }
        .checkout__total__all li { display:flex; justify-content:space-between; padding:10px 0; font-weight:600; font-size:16px; }

        .site-btn { display:inline-block; background:linear-gradient(to right,#e63946,#f77f00); color:#fff; font-weight:600; padding:12px 0; border-radius:8px; width:100%; text-align:center; transition:0.3s; border:none; cursor:pointer; }
        .site-btn:hover { background:linear-gradient(to right,#d62828,#f77f00); }

        .checkout__input__checkbox { margin:15px 0; }
        .checkout__input__checkbox label { font-weight:600; display:flex; align-items:center; cursor:pointer; }
        .checkout__input__checkbox input { margin-right:10px; }

        @media(max-width:768px){
            .row { flex-direction:column; }
            .checkout__order { margin-top:20px; position:relative; }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<section class="breadcrumb-option">
    <div class="container">
        <div class="breadcrumb__text">
            <h4>Thanh Toán</h4>
            <div class="breadcrumb__links">
                <a href="TrangChu">Trang chủ</a>
                <span>→</span>
                <a href="GioHangServlet">Giỏ Hàng</a>
                <span>Thanh Toán</span>
            </div>
        </div>
    </div>
</section>

<section class="checkout spad">
    <div class="container">
        <div class="checkout__form">
            <form action="PlaceOrderServlet" method="POST">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <h6 class="checkout__title">Thông tin giao hàng</h6>

                        <div class="checkout__input">
                            <p>Họ Tên người nhận<span>*</span></p>
                            <input type="text" name="hoTenNguoiNhan" required value="${sessionScope.user.hoTen}">
                        </div>

                        <div class="checkout__input">
                            <p>Địa chỉ giao hàng<span>*</span></p>
                            <input type="text" name="diaChiGiaoHang" required value="${sessionScope.user.diaChi}" placeholder="Số nhà, đường, phường/xã, quận/huyện">
                        </div>

                        <div class="row">
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>Số điện thoại<span>*</span></p>
                                    <input type="text" name="sdtNguoiNhan" required value="${sessionScope.user.dienThoai}">
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="checkout__input">
                                    <p>Email<span>*</span></p>
                                    <input type="text" name="emailNguoiNhan" required value="${sessionScope.user.email}">
                                </div>
                            </div>
                        </div>

                        <div class="checkout__input">
                            <p>Ghi chú đơn hàng</p>
                            <input type="text" name="ghiChu" placeholder="Ví dụ: thời gian giao hàng, lưu ý khác...">
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-6">
                        <div class="checkout__order">
                            <h4 class="order__title">Đơn hàng của bạn</h4>
                            <div class="checkout__order__products">Sản phẩm <span>Tổng</span></div>
                            <ul class="checkout__total__products">
                                <c:forEach items="${listGioHang}" var="item">
                                    <li>
                                        ${item.soLuong} x ${item.tenSP} (${item.tenKichCo})
                                        <span><fmt:formatNumber type="number" value="${item.giaBan * item.soLuong}" /> VNĐ</span>
                                    </li>
                                </c:forEach>
                            </ul>
                            <ul class="checkout__total__all">
                                <li>Tổng cộng <span><fmt:formatNumber type="number" value="${tongTien}" /> VNĐ</span></li>
                            </ul>

                            <div class="checkout__input__checkbox">
                                <label>
                                    <input type="radio" name="paymentMethod" value="COD" checked> Thanh toán khi nhận hàng (COD)
                                </label>
                            </div>
                            <div class="checkout__input__checkbox">
                                <label>
                                    <input type="radio" name="paymentMethod" value="Transfer"> Chuyển khoản Ngân hàng
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

<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>
