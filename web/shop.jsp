<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="zxx">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng | Danh Sách Sản Phẩm</title>

    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    
    <style>
        .shop__sidebar__categories ul li.active a {
            color: #ca1515;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <div id="preloder"><div class="loader"></div></div>
    
    <jsp:include page="header.jsp" />

    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>Cửa Hàng</h4>
                        <div class="breadcrumb__links">
                            <a href="TrangChu">Trang chủ</a>
                            <span>Cửa Hàng</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="shop spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="shop__sidebar">
                        <div class="shop__sidebar__search">
                            <form action="#">
                                <input type="text" placeholder="Search...">
                                <button type="submit"><span class="icon_search"></span></button>
                            </form>
                        </div>
                        <div class="shop__sidebar__accordion">
                            <div class="accordion" id="accordionExample">
                                
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseOne">Danh mục</a>
                                    </div>
                                    <div id="collapseOne" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__categories">
                                                <ul class="nice-scroll">
                                                    <li class="${maDM_active == null ? 'active' : ''}">
                                                        <a href="ShopServlet">Tất cả</a>
                                                    </li>
                                                    <c:forEach items="${listDM}" var="dm">
                                                        <li class="${maDM_active == dm.maDM ? 'active' : ''}">
                                                            <a href="ShopServlet?maDM=${dm.maDM}">${dm.tenDM}</a>
                                                        </li>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                

                                <%-- BỘ LỌC SIZE (ĐÃ SỬA) --%>
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseFour">Size</a>
                                    </div>
                                    <div id="collapseFour" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__size">
                                                <%-- Thêm nút "Tất cả" --%>
                                                <label for="size-all">Tất cả
                                                    <input type="radio" id="size-all" name="size-filter" value=""
                                                           ${maKC_active == null ? 'checked' : ''}>
                                                </label>
                                                <%-- Lặp qua danh sách Kích Cỡ --%>
                                                <c:forEach items="${listKC}" var="kc">
                                                    <label for="size-${kc.maKC}">${kc.tenKichCo}
                                                        <input type="radio" id="size-${kc.maKC}" name="size-filter" value="${kc.maKC}"
                                                               ${maKC_active == kc.maKC ? 'checked' : ''}>
                                                    </label>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-9">
                    <div class="shop__product__option">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__left">
                                    <p>Hiển thị 1–12 trong ${totalProducts} kết quả</p>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <%-- BỘ LỌC SẮP XẾP (ĐÃ SỬA) --%>
                                <div class="shop__product__option__right">
                                    <p>Sắp xếp theo:</p>
                                    <select name="sort-order" id="sort-order">
                                        <option value="" ${sort_active == null ? 'selected' : ''}>Mới nhất</option>
                                        <option value="price_asc" ${sort_active == 'price_asc' ? 'selected' : ''}>Giá: Thấp đến cao</option>
                                        <option value="price_desc" ${sort_active == 'price_desc' ? 'selected' : ''}>Giá: Cao đến thấp</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row">
                        <%-- HIỂN THỊ ĐỘNG SẢN PHẨM ĐÃ LỌC --%>
                        <c:forEach items="${listSP}" var="sp">
                            <div class="col-lg-4 col-md-6 col-sm-6">
                                <div class="product__item">
                                    <div class="product__item__pic set-bg" data-setbg="img/${sp.hinhAnh}">
                                        <ul class="product__hover">
                                            <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
                                            <li><a href="ShopDetailsServlet?maSP=${sp.maSP}"><img src="img/icon/search.png" alt=""></a></li>
                                        </ul>
                                    </div>
                                    <div class="product__item__text">
                                        <h6>${sp.tenSP}</h6>
                                        <a href="ShopDetailsServlet?maSP=${sp.maSP}" class="add-cart">+ Xem chi tiết</a>
                                        <h5><fmt:formatNumber type="number" value="${sp.giaCoBan}" /> VNĐ</h5>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${empty listSP}">
                            <div class="col-lg-12">
                                <p>Không tìm thấy sản phẩm nào phù hợp.</p>
                            </div>
                        </c:if>
                    </div>
                    
                    <%-- (Phần phân trang giữ nguyên HTML) --%>
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
    
    <%-- =================================== --%>
    <%-- SCRIPT (MỚI) ĐỂ KÍCH HOẠT BỘ LỌC   --%>
    <%-- =================================== --%>
    <script>
        $(document).ready(function() {
            
            // Hàm này sẽ được gọi khi bấm size hoặc sắp xếp
            function applyFilters() {
                // 1. Lấy URL hiện tại
                var url = new URL(window.location.href);
                
                // 2. Lấy giá trị MỚI từ các bộ lọc
                var size = $('input[name="size-filter"]:checked').val();
                var sort = $('#sort-order').val();

                // 3. Cập nhật tham số 'maKC' (size)
                if (size && size !== "") {
                    url.searchParams.set('maKC', size);
                } else {
                    url.searchParams.delete('maKC'); // Xóa nếu chọn "Tất cả"
                }
                
                // 4. Cập nhật tham số 'sort'
                if (sort && sort !== "") {
                    url.searchParams.set('sort', sort);
                } else {
                    url.searchParams.delete('sort'); // Xóa nếu chọn "Mới nhất" (mặc định)
                }

                // 5. Tải lại trang với URL mới
                window.location.href = url.href;
            }

            // Gán sự kiện "change" cho các bộ lọc
            $('input[name="size-filter"]').on('change', applyFilters);
            $('#sort-order').on('change', applyFilters);
        });
    </script>
</body>

</html>