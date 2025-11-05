<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    
    <style>
        .success-box {
            text-align: center;
            padding: 80px 0;
        }
        .success-box h4 {
            color: #1a1a1a;
            margin-top: 20px;
        }
        .success-box .fa-check-circle {
            color: #4CAF50; /* Màu xanh lá cây */
            font-size: 80px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <div class="success-box">
            <i class="fa fa-check-circle"></i>
            <h4>ĐẶT HÀNG THÀNH CÔNG!</h4>
            <p>Mã đơn hàng của bạn là: **#${requestScope.maHD}**</p>
            <p>Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>
            <a href="TrangChu" class="primary-btn mt-3">Tiếp tục mua sắm</a>
            <a href="OrderDetailServlet?maHD=${requestScope.maHD}" class="primary-btn second-btn mt-3" style="background: #e5e5e5; color: #1a1a1a;">Xem chi tiết đơn hàng</a>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>