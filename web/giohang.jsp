<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${sessionScope.role == null || sessionScope.role != 0}">
    <c:redirect url="${pageContext.request.contextPath}/login.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ hàng</title>

    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">

    <style>
        body { background:#f8f9fa; font-family:'Poppins', sans-serif; }

        /* Giỏ hàng */
        .shopping-cart-wrapper { padding:40px 0; }
        .shopping__cart__table { background:#fff; border-radius:12px; box-shadow:0 8px 25px rgba(0,0,0,0.05); overflow:hidden; }
        .shopping__cart__table table { width:100%; border-collapse:collapse; }
        .shopping__cart__table th, .shopping__cart__table td { text-align:center; padding:15px; vertical-align:middle; }
        .shopping__cart__table th { background:#f9f9f9; font-weight:600; color:#222; border-bottom:1px solid #eee; }
        .shopping__cart__table td { border-top:1px solid #eee; }
        .shopping__cart__table tr { transition:0.3s; }
        .shopping__cart__table tr:hover { box-shadow:0 4px 15px rgba(0,0,0,0.08); }

        .product__item__info { text-align:left; display:flex; align-items:center; }
        .cart-item-pic { width:100px; height:100px; object-fit:cover; border-radius:8px; border:1px solid #eee; }
        .item__details { margin-left:15px; }
        .item__details h6 { font-weight:600; font-size:18px; margin-bottom:4px; }
        .item__details .size { font-size:14px; color:#666; }

        .price__value, .subtotal__value { font-weight:700; font-size:16px; color:#e63946; display:block; }
        .subtotal__value { color:#111; margin-top:5px; }

        .quantity-form { display:flex; justify-content:center; align-items:center; max-width:120px; margin:auto; border-radius:6px; overflow:hidden; border:1px solid #ddd; }
        .quantity-form input { width:60px; border:none; text-align:center; font-weight:600; font-size:16px; outline:none; }

        .delete-btn { color:#777; font-size:16px; display:inline-flex; align-items:center; gap:5px; transition:0.3s; }
        .delete-btn:hover { color:#e63946; }

        /* Summary */
        .cart-summary { background:#fff; border-radius:12px; padding:30px; box-shadow:0 8px 25px rgba(0,0,0,0.05); position:sticky; top:80px; }
        .cart-summary h6 { font-size:22px; font-weight:600; margin-bottom:20px; }
        .cart-summary ul { list-style:none; padding:0; margin:0; }
        .cart-summary ul li { display:flex; justify-content:space-between; font-size:18px; font-weight:600; margin-bottom:15px; }
        .cart-summary ul li span { color:#e63946; font-size:18px; }
        @media(max-width:768px){
            .row { flex-direction:column; }
            .cart-summary { margin-top:20px; position:relative; top:0; }
            .shopping__cart__table table, .shopping__cart__table thead, .shopping__cart__table tbody, .shopping__cart__table th, .shopping__cart__table td, .shopping__cart__table tr { display:block; }
            .shopping__cart__table thead tr { position:absolute; top:-9999px; left:-9999px; }
            .shopping__cart__table tr { margin-bottom:1rem; border:1px solid #ddd; border-radius:8px; padding:10px; background:#fff; }
            .shopping__cart__table td { border:none; position:relative; padding-left:50%; text-align:left; }
            .shopping__cart__table td:before { position:absolute; top:15px; left:15px; width:45%; padding-right:10px; white-space:nowrap; font-weight:600; }
            .shopping__cart__table td:nth-of-type(1):before { content:"Sản phẩm"; }
            .shopping__cart__table td:nth-of-type(2):before { content:"Đơn giá"; }
            .shopping__cart__table td:nth-of-type(3):before { content:"Số lượng"; }
            .shopping__cart__table td:nth-of-type(4):before { content:"Thành tiền"; }
            .cart-item-pic { width:80px; height:80px; }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="shopping-cart-wrapper">
    <section class="breadcrumb-option">
        <div class="container">
            <div class="breadcrumb__text">
                <h4>Giỏ hàng của bạn</h4>
                <div class="breadcrumb__links">
                    <a href="TrangChu">Trang chủ</a>
                    <span>Giỏ hàng</span>
                </div>
            </div>
        </div>
    </section>

    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <c:if test="${empty requestScope.listGH}">
                        <div class="cart-summary text-center py-5">
                            <h5>Giỏ hàng của bạn đang trống.</h5>
<div class="row">
    <div class="col-lg-6 col-md-6 col-sm-6">
        <div class="continue__btn">
                            <a href="ShopServlet" class="primary-btn" style="width:auto;">Tiếp tục mua sắm</a>
        </div>
    </div>                        </div>
                    </c:if>

                    <c:if test="${!empty requestScope.listGH}">
                        <div class="shopping__cart__table mb-3">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Đơn giá</th>
                                        <th>Số lượng</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.listGH}" var="o">
                                        <tr data-price="${o.giaBan}" data-mactsp="${o.maCTSP}">
                                            <td class="product__item__info">
                                                <img src="${pageContext.request.contextPath}/img/product/${o.hinhAnh}" alt="${o.tenSP}" class="cart-item-pic">
                                                <div class="item__details">
                                                    <h6>${o.tenSP}</h6>
                                                    <div class="size">Kích cỡ: ${o.tenKichCo}</div>
                                                </div>
                                            </td>
                                            <td><span class="price__value"><fmt:formatNumber type="number" maxFractionDigits="0" value="${o.giaBan}" /> VNĐ</span></td>
                                            <td>
                                                <form class="quantity-form">
                                                    <input type="hidden" name="maCTSP" value="${o.maCTSP}">
                                                    <input type="number" class="item-qty" name="soLuong" value="${o.soLuong}" min="1" onchange="updateCartItem(this)">
                                                </form>
                                            </td>
                                            <td>
                                                <span class="subtotal__value"><fmt:formatNumber type="number" maxFractionDigits="0" value="${o.giaBan * o.soLuong}" /> VNĐ</span>
                                                <div class="cart__close mt-2">
                                                    <a href="XoaGioHangServlet?maCTSP=${o.maCTSP}" class="delete-btn"><i class="fa fa-trash-o"></i> Xóa</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="continue__btn text-left mb-3">
<a href="ShopServlet" class="primary-btn" style="width:auto;">Tiếp tục mua sắm</a>                        </div>
                    </c:if>
                </div>

                <div class="col-lg-4">
                    <div class="cart-summary">
                        <h6>Tổng giỏ hàng</h6>
                        <ul>
                            <li>Tổng tiền hàng <span id="grand-total"><fmt:formatNumber type="number" maxFractionDigits="0" value="${requestScope.tongTien}" /> VNĐ</span></li>
                        </ul>
                        <a href="CheckoutServlet" class="primary-btn">Tiến hành thanh toán</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<jsp:include page="footer.jsp" />

<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
<script>
function formatVND(amount){
    return new Intl.NumberFormat('vi-VN', {minimumFractionDigits:0, maximumFractionDigits:0}).format(amount) + ' VNĐ';
}
function updateGrandTotal(){
    let grandTotal = 0;
    $('.shopping-cart-wrapper .shopping__cart__table tbody tr').each(function(){
        let subtotalText = $(this).find('.subtotal__value').text().replace(/\./g,'').replace(' VNĐ','').trim();
        let subtotalAmount = parseFloat(subtotalText);
        if(!isNaN(subtotalAmount)) grandTotal += subtotalAmount;
    });
    $('#grand-total').text(formatVND(grandTotal));
}
function updateCartItem(inputElement){
    const $input = $(inputElement);
    const newQty = parseInt($input.val());
    const $row = $input.closest('tr');
    const maCTSP = $row.data('mactsp');
    const unitPrice = parseFloat($row.data('price'));
    if(newQty < 1 || isNaN(newQty)){
        if(confirm("Bạn có muốn xóa sản phẩm này?")) window.location.href=`XoaGioHangServlet?maCTSP=${maCTSP}`;
        else {$input.val(1); return;}
    }
    const newSubtotal = newQty * unitPrice;
    $row.find('.subtotal__value').text(formatVND(newSubtotal));
    updateGrandTotal();
    $.ajax({url:'CapNhatGioHangServlet', type:'POST', data:{maCTSP, soLuong:newQty}});
}
$(document).ready(function(){
    $('.item-qty').on('change blur input', function(){ updateCartItem(this); });
    updateGrandTotal();
});
</script>
</body>
</html>
