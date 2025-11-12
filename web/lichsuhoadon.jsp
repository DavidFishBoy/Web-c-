<%-- 
    Document   : líchuhoadon
    Created on : Nov 12, 2025, 2:31:06 PM
    Author     : toite
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử hóa đơn</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">
</head>
<body>
    <jsp:include page="header.jsp" />

    <section class="breadcrumb-option py-3">
        <div class="container">
            <div class="breadcrumb__text">
                <h4>Lịch sử hóa đơn</h4>
                <div class="breadcrumb__links">
                    <a href="TrangChu">Trang chủ</a>
                    <span>Lịch sử hóa đơn</span>
                </div>
            </div>
        </div>
    </section>

    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <c:if test="${empty listHoaDon}">
                        <div class="cart-summary text-center py-5">
                            <h5>Bạn chưa có đơn hàng nào.</h5>
                            <a href="ShopServlet" class="primary-btn mt-3" style="width:auto;">Bắt đầu mua sắm</a>
                        </div>
                    </c:if>

                    <c:if test="${!empty listHoaDon}">
                        <div class="shopping__cart__table">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Mã HĐ</th>
                                        <th>Ngày đặt</th>
                                        <th>Người nhận</th>
                                        <th>Địa chỉ</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listHoaDon}" var="hd">
                                        <tr>
                                            <td>#${hd.maHD}</td>
                                            <td>
                                                <fmt:formatDate value="${hd.ngayDatHang}" pattern="dd-MM-yyyy" />
                                            </td>
                                            <td>${hd.hoTenNguoiNhan}</td>
                                            <td>${hd.diaChiGiaoHang}</td>
                                            <td>
                                                <span class="subtotal__value" style="color: var(--primary-color);">
                                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${hd.tongTien}" /> VNĐ
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${hd.maTrangThai == 1}">
                                                        <span style="color: #f77f00;">Chờ xác nhận</span>
                                                    </c:when>
                                                    <c:when test="${hd.maTrangThai == 2}">
                                                        <span style="color: #007bff;">Đang giao hàng</span>
                                                    </c:when>
                                                    <c:when test="${hd.maTrangThai == 3}">
                                                        <span style="color: #28a745;">Đã hoàn thành</span>
                                                    </c:when>
                                                    <c:when test="${hd.maTrangThai == 4}">
                                                        <span style="color: #dc3545;">Đã hủy</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span>Không xác định</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="OrderDetailServlet?maHD=${hd.maHD}" class="primary-btn" style="padding: 10px 15px; width:auto; font-size: 13px;">
                                                    Xem chi tiết
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />

    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.min.js'/>"></script>
    <script src="<c:url value='/js/main.js'/>"></script>
</body>
</html>