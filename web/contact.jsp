<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Male-Fashion | Liên hệ</title>

    <!-- Fonts & CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/elegant-icons.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/magnific-popup.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/nice-select.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/owl.carousel.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/slicknav.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">
    <style>
        .contact-section {
    padding-top: 100px;
    padding-bottom: 100px;
}
.contact-title {
    font-size: 28px;
    font-weight: 700;
    color: #111;
    margin-bottom: 30px;
}

/* Contact Info */
.contact-info-wrapper {
    background: #f8f8f8;
    padding: 40px;
    border-radius: 5px;
    height: 100%;
}
.contact-info-item {
    display: flex;
    align-items: flex-start;
    margin-bottom: 25px;
    transition: transform 0.3s;
}
.contact-info-item i.fa {
    font-size: 20px;
    color: #e53637;
    margin-right: 20px;
    margin-top: 5px;
    transition: color 0.3s;
}
.contact-info-item:hover i.fa {
    color: #ff4d4d;
    transform: scale(1.2);
}
.contact-info-item .info-text h5 {
    font-size: 18px;
    font-weight: 700;
    margin-bottom: 5px;
}
.contact-info-item .info-text p {
    font-size: 16px;
    color: #555;
    margin: 0;
}

/* Contact Form */
.contact-form-wrapper {
    background: #f8f8f8;
    padding: 40px;
    border-radius: 5px;
    height: 100%;
}
.contact-form-wrapper .form-group input,
.contact-form-wrapper .form-group textarea {
    width: 100%;
    border: 1px solid #e1e1e1;
    background: #fff;
    padding: 10px 20px;
    font-size: 15px;
    border-radius: 5px;
}
.contact-form-wrapper .form-group textarea {
    height: 150px;
    resize: none;
}
.contact-form-wrapper .site-btn {
    width: 100%;
    letter-spacing: 2px;
}

    </style>
</head>

<body>
    <!-- Preloader -->
    <div id="preloder"><div class="loader"></div></div>

    <!-- Header -->
    <jsp:include page="header.jsp" />

    <!-- Breadcrumb -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="breadcrumb__text">
                        <h4>Liên hệ</h4>
                        <div class="breadcrumb__links">
                            <a href="<c:url value='/TrangChu'/>">Trang chủ</a>
                            <span>Liên hệ</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact-section">
        <div class="container">
            <div class="row gx-4 gy-4">
                <!-- Contact Info -->
                <div class="col-lg-5 col-md-6 d-flex flex-column">
                    <div class="contact-info-wrapper flex-grow-1">
                        <h3 class="contact-title">Thông tin liên hệ</h3>
                        <div class="contact-info-item">
                            <i class="fa fa-map-marker"></i>
                            <div class="info-text">
                                <h5>Địa chỉ</h5>
                                <p>123 Đường ABC, Phường XYZ, Quận 1, TP. Hồ Chí Minh</p>
                            </div>
                        </div>
                        <div class="contact-info-item">
                            <i class="fa fa-envelope"></i>
                            <div class="info-text">
                                <h5>Email</h5>
                                <p>support@malefashion.com</p>
                            </div>
                        </div>
                        <div class="contact-info-item">
                            <i class="fa fa-phone"></i>
                            <div class="info-text">
                                <h5>Số điện thoại</h5>
                                <p>+84 123 456 789</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Contact Form -->
                <div class="col-lg-7 col-md-6 d-flex flex-column">
                    <div class="contact-form-wrapper flex-grow-1">
                        <h3 class="contact-title">Gửi tin nhắn</h3>

                        <!-- Alert thông báo -->
                        <c:if test="${not empty requestScope.mess}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${requestScope.mess}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Form -->
                        <form action="ContactServlet" method="post">
                            <div class="form-group mb-3">
                                <input type="text" name="name" class="form-control" placeholder="Họ và tên" required minlength="3">
                            </div>
                            <div class="form-group mb-3">
                                <input type="email" name="email" class="form-control" placeholder="Email" required>
                            </div>
                            <div class="form-group mb-3">
                                <textarea name="noiDung" class="form-control" placeholder="Nội dung tin nhắn" required minlength="10"></textarea>
                            </div>
                            <button type="submit" class="site-btn btn btn-primary">Gửi</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />

    <!-- JS -->
    <script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.nice-select.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.nicescroll.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.magnific-popup.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.countdown.min.js'/>"></script>
    <script src="<c:url value='/js/jquery.slicknav.js'/>"></script>
    <script src="<c:url value='/js/owl.carousel.min.js'/>"></script>
    <script src="<c:url value='/js/main.js'/>"></script>
</body>
</html>
