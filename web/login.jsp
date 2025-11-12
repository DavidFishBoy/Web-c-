<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Nếu người dùng đã đăng nhập, chuyển về trang chủ --%>
<c:if test="${sessionScope.user != null}">
    <c:redirect url="TrangChu" />
</c:if>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Đăng nhập</title>

    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@300;400;600;700;800;900&display=swap"
    rel="stylesheet">

    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link rel="stylesheet" href="<c:url value='/css/custom.css'/>" type="text/css">

    <style>
        .login-section {
            min-height: 80vh;
            display: flex;
            align-items: center;
        }
        .login-form-container {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            padding: 40px;
        }
        .login-form-container h2 {
            font-weight: 700;
            color: #111111;
            margin-bottom: 30px;
            text-align: center; /* Căn giữa tiêu đề */
        }
        .input-group-icon {
            position: relative;
        }
        .input-group-icon .form-control {
            padding-left: 45px;
            height: 50px;
            border-radius: 5px;
        }
        .input-group-icon .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
            color: #b2b2b2;
        }
        .login-btn {
            width: 100%;
            height: 50px;
            font-weight: 700;
        }
    </style>
</head>

<body>
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <jsp:include page="header.jsp" />

    <section class="login-section spad">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 col-md-8">
                    <div class="login-form-container"> 
                        <h2>Đăng nhập</h2>
                        
                        <form action="DangNhapServlet" method="post">
                            <div class="form-group input-group-icon mb-3">
                                <span class="input-icon"><i class="fa fa-envelope"></i></span>
                                <input type="text" class="form-control" placeholder="Email (Tên đăng nhập)" id="tendn" name="tendn" required>
                            </div>
                            <div class="form-group input-group-icon mb-3">
                                <span class="input-icon"><i class="fa fa-lock"></i></span>
                                <input type="password" class="form-control" placeholder="Mật khẩu" id="matkhau" name="matkhau" required>
                            </div>
                            
                            <c:if test="${requestScope.error != null}">
                                <p style="color: red; margin-top: 10px;">${requestScope.error}</p>
                            </c:if>

                            <button type="submit" class="site-btn login-btn mt-3">Đăng nhập</button>
                        </form>
                        
                        <div class="switch-login text-center mt-4">
                            <a href="dangky.jsp" class="or-login">Hoặc Tạo tài khoản mới</a>
                        </div>
                    </div>
                </div>
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