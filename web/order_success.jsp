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

    <style>
        body { font-family:'Poppins', sans-serif; background:#f8f9fa; }
        .success-box {
            max-width:600px;
            margin:80px auto;
            background:#fff;
            padding:40px 30px;
            border-radius:12px;
            box-shadow:0 8px 25px rgba(0,0,0,0.1);
            text-align:center;
        }
        .success-box i {
            font-size:60px;
            color:#28a745;
            margin-bottom:20px;
            animation: pop 0.5s ease;
        }
        @keyframes pop {
            0% { transform: scale(0.5); opacity:0; }
            100% { transform: scale(1); opacity:1; }
        }
        .success-box h4 {
            font-size:26px;
            font-weight:700;
            margin-bottom:15px;
            color:#333;
        }
        .success-box p {
            font-size:16px;
            color:#555;
            margin-bottom:10px;
        }
        .order-id {
            font-weight:700;
            color:#e63946;
            font-size:18px;
        }
        .primary-btn {
            display:inline-block;
            background:linear-gradient(to right,#e63946,#f77f00);
            color:#fff;
            font-weight:600;
            padding:12px 25px;
            border-radius:8px;
            margin:10px 5px 0;
            text-decoration:none;
            transition:0.3s;
        }
        .primary-btn:hover { background:linear-gradient(to right,#d62828,#f77f00); color:#fff; }
        .second-btn {
            background:#e5e5e5;
            color:#1a1a1a;
        }
        .second-btn:hover { background:#ccc; color:#111; }

        @media(max-width:768px){
            .success-box { margin:40px 20px; padding:30px 20px; }
            .primary-btn, .second-btn { width:100%; margin:10px 0 0; }
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="container">
    <div class="success-box">
        <i class="fa fa-check-circle"></i>
        <h4>ĐẶT HÀNG THÀNH CÔNG!</h4>
        <p>Mã đơn hàng của bạn là: <span class="order-id">#${requestScope.maHD}</span></p>
        <p>Chúng tôi sẽ xử lý đơn hàng của bạn trong thời gian sớm nhất.</p>
        <a href="TrangChu" class="primary-btn">Tiếp tục mua sắm</a>
        <a href="OrderDetailServlet?maHD=${requestScope.maHD}" class="primary-btn second-btn">Xem chi tiết đơn hàng</a>
    </div>
</div>

<jsp:include page="footer.jsp" />
</body>
</html>
