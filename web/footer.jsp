<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="footer__copyright__text">
                    <p>Copyright &copy;
                        <script>
                            document.write(new Date().getFullYear());
                        </script>
                        <b>:</b><br><br><b>Trần Văn Tiến</b><br><br>
                        <b>Nguyễn Thế Phương</b><br><br>
                        <b>Vũ Hoàng Nam</b>
                    </p>
                </div>
            </div>
        </div>
    </div>
</footer>

<div class="search-model">
    <div class="h-100 d-flex align-items-center justify-content-center">
        <div class="search-close-switch">+</div>
        <form class="search-model-form">
            <input type="text" id="search-input" placeholder="Tìm kiếm.....">
        </form>
    </div>
</div>

<%-- SỬ DỤNG ĐƯỜNG DẪN TUYỆT ĐỐI CÓ CONTEXT PATH CHO TẤT CẢ JS --%>
<script src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.nice-select.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.nicescroll.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.magnific-popup.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.countdown.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.slicknav.js"></script>
<script src="${pageContext.request.contextPath}/js/mixitup.min.js"></script>
<script src="${pageContext.request.contextPath}/js/owl.carousel.min.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>

<script type="text/javascript">
    function themVaoGio(maSP) {
        $.ajax({
            url: "${pageContext.request.contextPath}/ThemGioHang",
            type: "GET",
            data: {
                maSP: maSP
            },
            success: function(response) {
                // Kiểm tra xem response có lỗi không
                if(response.error) {
                    alert(response.error);
                    // Nếu lỗi là "Chưa đăng nhập", chuyển hướng đến trang đăng nhập
                    if(response.error === "Chưa đăng nhập") {
                        window.location.href = "${pageContext.request.contextPath}/dangnhap.jsp";
                    }
                } else {
                    // Nếu không lỗi, cập nhật số lượng
                    // Selector này cần phải chính xác trong template của bạn
                    $(".header__nav__option span").text(response.soLuong); 
                    $(".offcanvas__nav__option span").text(response.soLuong);
                    alert("Đã thêm sản phẩm vào giỏ hàng!");
                }
            },
            error: function() {
                alert("Đã xảy ra lỗi khi thêm vào giỏ hàng.");
            }
        });
    }
</script>

</body>
</html>