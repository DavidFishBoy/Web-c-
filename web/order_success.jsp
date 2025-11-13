<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">
</head>
<body>
<jsp:include page="header.jsp" />

<section class="shopping-cart spad">
    <div class="container">
        <c:if test="${empty listHoaDon}">
            <div class="cart-empty text-center py-5">
                <h5>Bạn chưa có đơn hàng nào.</h5>
                <a href="ShopServlet" class="btn btn-primary mt-3">Bắt đầu mua sắm</a>
            </div>
        </c:if>

        <c:if test="${!empty listHoaDon}">
            <div class="orders-grid">
                <c:forEach items="${listHoaDon}" var="hd">
                    <div class="order-card">
                        <div class="order-header">
                            <span class="order-id">#${hd.maHD}</span>
                            <span class="order-date">
                                <fmt:formatDate value="${hd.ngayDatHang}" pattern="dd-MM-yyyy" />
                            </span>
                        </div>
                        <div class="order-body">
                            <p><strong>Người nhận:</strong> ${hd.hoTenNguoiNhan}</p>
                            <p><strong>Địa chỉ:</strong> ${hd.diaChiGiaoHang}</p>
                            <p><strong>Tổng tiền:</strong>
                                <span class="order-total">
                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${hd.tongTien}" /> VNĐ
                                </span>
                            </p>
                        </div>
                        <div class="order-footer">
                            <span class="order-status
    <c:choose>
        <c:when test="${hd.maTrangThai == 0}">status-new</c:when>
        <c:when test="${hd.maTrangThai == 1}">status-paid</c:when>
        <c:when test="${hd.maTrangThai == 2}">status-pending</c:when>
        <c:when test="${hd.maTrangThai == 3}">status-delivered</c:when>
        <c:when test="${hd.maTrangThai == -1}">status-canceled</c:when>
        <c:otherwise>status-unknown</c:otherwise>
    </c:choose>
">
    <c:choose>
        <c:when test="${hd.maTrangThai == 0}"><i class="fa fa-clock-o"></i> Mới đặt hàng</c:when>
        <c:when test="${hd.maTrangThai == 1}"><i class="fa fa-credit-card"></i> Đã thanh toán</c:when>
        <c:when test="${hd.maTrangThai == 2}"><i class="fa fa-truck"></i> Chờ giao hàng</c:when>
        <c:when test="${hd.maTrangThai == 3}"><i class="fa fa-check-circle"></i> Đã giao hàng</c:when>
        <c:when test="${hd.maTrangThai == -1}"><i class="fa fa-times-circle"></i> Khách hàng hủy</c:when>
        <c:otherwise>Không xác định</c:otherwise>
    </c:choose>
</span>a

                            <a href="OrderDetailServlet?maHD=${hd.maHD}" class="btn btn-detail">Xem chi tiết</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</section>



<jsp:include page="footer.jsp" />
</body>
</html>
