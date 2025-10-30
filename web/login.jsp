<%-- Đảm bảo dòng này ở trên cùng --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập / Đăng ký - MEN'S SHOP</title>
    
    <%-- Đường dẫn đến file CSS --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login-style.css">
</head>
<body>

    <div class="form-container">
        
        <div class="login-header-branding">
            <img src="${pageContext.request.contextPath}/img/menshop.jpg" alt="MEN'S Shop Logo" class="login-logo">
            <h2 class="login-shop-name">MEN'S SHOP</h2>
        </div>
        
        <div class="tab-header">
            <button class="tab-link active" onclick="switchTab(event, 'register-form')">Đăng ký</button>
            <button class="tab-link" onclick="switchTab(event, 'login-form')">Đăng nhập</button>
        </div>

        <div id="register-form" class="form-content active">
            
            <form action="RegisterServlet" method="post">
                
                <div class="form-group">
                    <input type="text" class="input-field" name="hoten" placeholder="Họ và tên" required>
                </div>
                
                <div class="form-group gender-group">
                    <label>
                        <input type="radio" name="gender" value="nu"> Nữ
                    </label>
                    <label>
                        <input type="radio" name="gender" value="nam" checked> Nam
                    </label>
                </div>
                
                <div class="form-group">
                    <input type="text" class="input-field" name="ngaysinh" placeholder="mm/dd/yyyy" onfocus="(this.type='date')" onblur="if(!this.value) {this.type='text';}" required>
                </div>
                
                <div class="form-group">
                    <input type="email" class="input-field" name="email" placeholder="Email" required>
                </div>
                
                <div class="form-group">
                    <input type="text" class="input-field" name="sodienthoai" placeholder="Số điện thoại" required>
                </div>
                <div class="form-group">
                    <input type="text" class="input-field" name="diachi" placeholder="Địa chỉ" required>
                </div>
                
                <div class="form-group">
                    <input type="password" class="input-field" name="matkhau" placeholder="Mật khẩu" required>
                </div>
                
                
                <div class="form-group" style="margin-top: 20px;">
                    <button type="submit" class="submit-btn">Đăng ký</button>
                </div>
                
                <div class="form-footer">
                    Bạn đã có tài khoản? 
                    <a onclick="switchTab(event, 'login-form', true)">Đăng nhập ngay</a>
                </div>
            </form>
        </div>

        <div id="login-form" class="form-content">
            
            <form action="LoginServlet" method="post">
                
                <div id="login-error-message" class="form-error"></div>

                <div class="form-group">
                    <input type="email" class="input-field" name="email_login" placeholder="Email" required>
                </div>
                
                <div class="form-group">
                    <input type="password" class="input-field" name="matkhau_login" placeholder="Mật khẩu" required>
                </div>
                
                <div class="form-group">
                    <button type="submit" class="submit-btn">Đăng nhập</button>
                </div>
                
                <div class="form-footer">
                    Bạn chưa có tài khoản? 
                    <a onclick="switchTab(event, 'register-form', true)">Đăng ký ngay</a>
                </div>
            </form>
        </div>

    </div>

    <script src="${pageContext.request.contextPath}/js/login-script.js"></script>

</body>
</html>