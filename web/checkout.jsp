<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Giả định rằng CheckoutServlet đã chuyển tiếp (forward) các thuộc tính:
     - listGioHang (List<GioHang> của người dùng)
     - tongTien (double)
--%>

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
        .checkout__input input { width:100%; padding:10px 12px; border:1px solid #ddd; border-radius:6px; font-size:15px; outline: none; }
        .checkout__input input:focus { border-color: #e63946; }
        .checkout__input p span { color: #e63946; } /* Dấu * màu đỏ */

        .checkout__order { background:#f8f9fa; padding:20px; border-radius:12px; box-shadow:0 8px 25px rgba(0,0,0,0.05); border: 1px solid #eee; }
        .checkout__order h4 { font-size:22px; font-weight:600; margin-bottom:20px; }
        .checkout__order__products { display:flex; justify-content:space-between; font-weight:600; border-bottom:1px solid #ddd; padding-bottom:10px; margin-bottom:10px; }
        
        /* Cải tiến danh sách sản phẩm */
        .checkout__total__products {
            max-height: 250px; /* Thêm thanh cuộn nếu nhiều sản phẩm */
            overflow-y: auto;
            padding-right: 10px;
        }
        .checkout__total__products li { 
            display:flex; 
            justify-content:space-between; 
            padding:10px 0; 
            border-bottom:1px dashed #eee; 
            font-size: 14px;
            line-height: 1.4;
        }
        .checkout__total__products li span {
            font-weight: 600;
            white-space: nowrap;
            margin-left: 10px;
        }
        
        /* Cải tiến phần tổng tiền */
        .checkout__order__details {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
        .checkout__order__details li {
            display: flex;
            justify-content: space-between;
            font-size: 16px;
            color: #555;
            margin-bottom: 12px;
        }
        .checkout__order__details li span:last-child {
            font-weight: 600;
            color: #111;
        }
        .checkout__order__details li.total-summary {
            font-size: 18px;
            font-weight: 700;
            color: #111;
            border-top: 1px solid #ddd;
            padding-top: 15px;
            margin-top: 15px;
        }
        .checkout__order__details li.total-summary span:last-child {
            font-size: 20px;
            color: #e63946;
        }

        .site-btn { display:inline-block; background:#e63946; color:#fff; font-weight:600; padding:12px 0; border-radius:8px; width:100%; text-align:center; transition:0.3s; border:none; cursor:pointer; }
        .site-btn:hover { background: #d62828; }
           /* CSS CHO NÚT TICK */
        .checkout__input__checkbox { margin:15px 0; }
        .checkout__input__checkbox label { font-weight:600; display:flex; align-items:center; cursor:pointer; }
        .checkout__input__checkbox input { margin-right:10px; }

      #bank-info p { margin-bottom: 8px; }
#bank-info strong { color: #111; }  
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
                <span>→</span>
                <span>Thanh Toán</span>
            </div>
        </div>
    </div>
</section>

<section class="checkout spad">
    <div class="container">
        <div class="checkout__form">
            <c:if test="${empty listGioHang}">
                <div class="text-center">
                    <h4>Giỏ hàng của bạn đang trống!</h4>
                    <p>Vui lòng thêm sản phẩm vào giỏ trước khi thanh toán.</p>
                    <a href="ShopServlet" class="primary-btn" style="width: auto; padding: 10px 20px; margin-top: 20px;">Quay lại cửa hàng</a>
                </div>
            </c:if>
            
            <c:if test="${!empty listGioHang}">
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
                                        <input type="email" name="emailNguoiNhan" required value="${sessionScope.user.email}">
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
                                            <span><fmt:formatNumber type="number" maxFractionDigits="0" value="${item.giaBan * item.soLuong}" /> VNĐ</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                                
                                <ul class="checkout__order__details">
                                    <li>
                                        <span>Tạm tính (sản phẩm):</span>
                                        <span><fmt:formatNumber type="number" maxFractionDigits="0" value="${tongTien}" /> VNĐ</span>
                                    </li>
                                    <li>
                                        <span>Phí vận chuyển:</span>
                                        <span>Miễn phí</span>
                                    </li>
                                    <li class="total-summary">
                                        <span>Tổng cộng:</span>
                                        <span><fmt:formatNumber type="number" maxFractionDigits="0" value="${tongTien}" /> VNĐ</span>
                                    </li>
                                </ul>

                                <div class="checkout__input__checkbox">
                                            <label>
                                        <input type="radio" name="paymentMethod" value="COD" checked>
                                        Thanh toán khi nhận hàng (COD)
                                    </label>
                                </div>
                                <div class="checkout__input__checkbox">
                                    <label>
                                        <input type="radio" name="paymentMethod" value="Transfer">
                                        Chuyển khoản Ngân hàng
                                    </label>
                                </div>

                                <div id="bank-info">
                                    <p>Vui lòng chuyển khoản với nội dung" [Mã Đơn Hàng][SĐT]"</p>
                                    
                                    <p><strong>Ngân hàng:</strong> Vietcombank</p>
                                    <p><strong>Số tài khoản:</strong> 1031789233</p>
                                    <p><strong>Chủ tài khoản:</strong> NGUYEN THE PHUONG</p>
                                </div>

                                <button type="submit" class="site-btn">ĐẶT HÀNG</button>
                            </div>
                        </div>
                    </div>
                </form>
            </c:if>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />

<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>

<script>
    $(document).ready(function(){
        // Lắng nghe sự kiện thay đổi của radio button
        $('input[name="paymentMethod"]').on('change', function(){
            if ($(this).val() === 'Transfer') {
                $('#bank-info').slideDown(); // Hiển thị
            } else {
                $('#bank-info').slideUp(); // Ẩn đi
            }
        });
    });
</script>
</body>
</html>