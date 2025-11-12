<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết đơn hàng | #${requestScope.maHD}</title>

    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
   <link rel="stylesheet" href="<c:url value='/css/custom.css'/>" type="text/css">
</head>

<body>
    <div id="preloder"><div class="loader"></div></div>
    
    <jsp:include page="header.jsp" />

    <section class="breadcrumb-option" style="background: #f3f2ee;">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>Chi tiết đơn hàng</h4>
                        <div class="breadcrumb__links">
                            <a href="TrangChu">Trang chủ</a>
                            <span>Chi tiết đơn hàng</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="order-detail spad">
        <div class="container">
            <div class="order-detail-card">
                <div class="row">
                    <div class="col-lg-12">
                        <h4>Đơn hàng #${requestScope.maHD}</h4>
                    </div>
                </div>
                
                <div class="row order-summary">
                    <div class="col-lg-8">
                        <h6>Danh sách sản phẩm</h6>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 50%;">Sản phẩm</th>
                                    <th>Đơn giá</th>
                                    <th>Số lượng</th>
                                    <th style="text-align: right;">Thành tiền</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.listChiTiet}" var="item">
                                    <tr>
                                        <td>${item.tenSP} (${item.tenKichCo})</td>
                                        <td><fmt:formatNumber type="number" value="${item.donGia}" /> VNĐ</td>
                                        <td>${item.soLuong}</td>
                                        <td><fmt:formatNumber type="number" value="${item.donGia * item.soLuong}" /> VNĐ</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <c:if test="${empty listChiTiet}">
                            <p class="text-danger">Không tìm thấy chi tiết sản phẩm cho đơn hàng này.</p>
                        </c:if>
                    </div>
                    
                    <div class="col-lg-4">
                        <h6>Tóm tắt</h6>
                        <ul class="checkout__total__all">
                            <li>Tổng giá trị hàng: <span><fmt:formatNumber type="number" value="${tongTien}" /> VNĐ</span></li>
                            <li>Trạng thái: <span style="font-weight: bold; color: #007bff;">Mới đặt hàng</span></li>
                            <li style="font-size: 20px; font-weight: bold;">Tổng cộng: <span><fmt:formatNumber type="number" value="${tongTien}" /> VNĐ</span></li>
                        </ul>
                        
                        <div class="mt-4">
                            <a href="TrangChu" class="primary-btn">Tiếp tục mua sắm</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="footer.jsp" />
    
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</body>

</html>