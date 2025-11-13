<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cửa Hàng | Danh Sách Sản Phẩm</title>

    <!-- CSS -->
        <link rel="stylesheet" href="<c:url value='/css/custom.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/font-awesome.min.css'/>" />
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>" />

  
</head>

<body>
<jsp:include page="header.jsp" />

<!-- Breadcrumb -->
<section class="breadcrumb-option py-4">
    <div class="container">
        <div class="breadcrumb__text">
            <h4 style="color:#e53637;">Cửa hàng</h4>
            <div class="breadcrumb__links">
                <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                <span>Cửa hàng</span>
            </div>
        </div>
    </div>
</section>

<!-- Shop -->
<section class="shop spad py-5">
    <div class="container">
        <div class="row">
            <!-- SIDEBAR -->
            <div class="col-lg-3 col-md-4 mb-4">
                <div class="shop__sidebar">
                    <!-- Danh mục -->
                    <h5>Danh mục</h5>
                    <ul class="category-list">
                        <li>
                            <a class="category-btn ${empty maDM_active ? 'active' : ''}" href="<c:url value='/ShopServlet'/>">Tất cả</a>
                        </li>
                        <c:forEach items="${listDM}" var="dm">
                            <li>
                                <c:url var="dmUrl" value="/ShopServlet">
                                    <c:param name="maDM" value="${dm.maDM}" />
                                </c:url>
                                <a class="category-btn ${maDM_active == dm.maDM ? 'active' : ''}" href="${dmUrl}">
                                    ${dm.tenDM}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>

                    <!-- Kích cỡ -->
                    <h5>Kích cỡ</h5>
                    <ul class="size-list size-radio">
                        <li>
                            <label>
                                <input type="radio" name="size-filter" value="" ${empty maKC_active ? 'checked' : ''}/> Tất cả
                            </label>
                        </li>
                        <c:forEach items="${listKC}" var="kc">
                            <li>
                                <label>
                                    <input type="radio" name="size-filter" value="${kc.maKC}" ${maKC_active == kc.maKC ? 'checked' : ''}/> ${kc.tenKichCo}
                                </label>
                            </li>
                        </c:forEach>
                    </ul>

                    <!-- Khoảng giá -->
                    <h5>Khoảng giá</h5>
                    <div>
                        <input id="priceMin" type="number" placeholder="Giá từ" style="width:48%; display:inline-block; padding:6px; border-radius:6px; border:1px solid #ddd;" value="${param.priceMin}"/>
                        <input id="priceMax" type="number" placeholder="Giá đến" style="width:48%; display:inline-block; padding:6px; border-radius:6px; border:1px solid #ddd; margin-left:4%;" value="${param.priceMax}"/>
                        <button id="priceApply" class="btn btn-sm btn-danger mt-2">Áp dụng</button>
                    </div>
                </div>
            </div>

            <!-- PRODUCTS -->
            <div class="col-lg-9 col-md-8">
                <div class="shop__product__option d-flex justify-content-between align-items-center">
                    <div>
                        <p class="mb-0">Hiển thị <strong><c:out value="${fn:length(listSP)}"/></strong> / <strong>${totalProducts}</strong> sản phẩm</p>
                    </div>

                    <div>
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle sort-dropdown" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa fa-sort"></i> Sắp xếp: <span id="sortLabel">${empty sort_active ? 'Mới nhất' : (sort_active == 'price_asc' ? 'Giá: Thấp → Cao' : 'Giá: Cao → Thấp')}</span>
                            </button>
                            <ul class="dropdown-menu" aria-labelledby="sortDropdown">
                                <li><a class="dropdown-item sort-option" data-val="" href="javascript:void(0)">Mới nhất</a></li>
                                <li><a class="dropdown-item sort-option" data-val="price_asc" href="javascript:void(0)">Giá: Thấp → Cao</a></li>
                                <li><a class="dropdown-item sort-option" data-val="price_desc" href="javascript:void(0)">Giá: Cao → Thấp</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- product grid -->
                <div class="row g-4 mt-3">
                    <c:forEach items="${listSP}" var="sp">
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item">
                                <div class="product__item__pic">
                                    <img src="${pageContext.request.contextPath}/img/product/${sp.hinhAnh}" alt="${sp.tenSP}" />
                                    <a href="<c:url value='/ShopDetailsServlet'><c:param name='maSP' value='${sp.maSP}'/></c:url>" 
                                       class="btn btn-danger view-detail-btn">
                                        <i class="fa fa-eye"></i> Xem chi tiết
                                    </a>
                                </div>
                                <div class="product__item__text mt-2 text-center">
                                    <h6>${sp.tenSP}</h6>
                                    <p class="text-danger fw-bold">
                                        <fmt:formatNumber value="${sp.giaCoBan}" type="number" /> VNĐ
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty listSP}">
                        <div class="col-12 text-center py-5">
                            <p class="text-muted">Không tìm thấy sản phẩm phù hợp.</p>
                        </div>
                    </c:if>
                </div>

                <!-- Pagination -->
                <div class="row mt-4">
                    <div class="col-12">
                        <nav aria-label="page navigation">
                            <ul class="pagination justify-content-center">
                                <c:if test="${currentPage > 1}">
                                    <c:set var="prev" value="${currentPage - 1}" />
                                    <c:url var="prevUrl" value="/ShopServlet">
                                        <c:param name="page" value="${prev}" />
                                        <c:if test="${not empty maDM_active}"><c:param name="maDM" value="${maDM_active}" /></c:if>
                                        <c:if test="${not empty maKC_active}"><c:param name="maKC" value="${maKC_active}" /></c:if>
                                        <c:if test="${not empty sort_active}"><c:param name="sort" value="${sort_active}" /></c:if>
                                        <c:if test="${not empty param.priceMin}"><c:param name="priceMin" value="${param.priceMin}" /></c:if>
                                        <c:if test="${not empty param.priceMax}"><c:param name="priceMax" value="${param.priceMax}" /></c:if>
                                    </c:url>
                                    <li class="page-item"><a class="page-link" href="${prevUrl}">« Trước</a></li>
                                </c:if>

                                <c:forEach var="p" begin="1" end="${totalPages}">
                                    <c:url var="linkP" value="/ShopServlet">
                                        <c:param name="page" value="${p}" />
                                        <c:if test="${not empty maDM_active}"><c:param name="maDM" value="${maDM_active}" /></c:if>
                                        <c:if test="${not empty maKC_active}"><c:param name="maKC" value="${maKC_active}" /></c:if>
                                        <c:if test="${not empty sort_active}"><c:param name="sort" value="${sort_active}" /></c:if>
                                        <c:if test="${not empty param.priceMin}"><c:param name="priceMin" value="${param.priceMin}" /></c:if>
                                        <c:if test="${not empty param.priceMax}"><c:param name="priceMax" value="${param.priceMax}" /></c:if>
                                    </c:url>
                                    <li class="page-item ${currentPage == p ? 'active' : ''}">
                                        <a class="page-link" href="${linkP}">${p}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <c:set var="next" value="${currentPage + 1}" />
                                    <c:url var="nextUrl" value="/ShopServlet">
                                        <c:param name="page" value="${next}" />
                                        <c:if test="${not empty maDM_active}"><c:param name="maDM" value="${maDM_active}" /></c:if>
                                        <c:if test="${not empty maKC_active}"><c:param name="maKC" value="${maKC_active}" /></c:if>
                                        <c:if test="${not empty sort_active}"><c:param name="sort" value="${sort_active}" /></c:if>
                                        <c:if test="${not empty param.priceMin}"><c:param name="priceMin" value="${param.priceMin}" /></c:if>
                                        <c:if test="${not empty param.priceMax}"><c:param name="priceMax" value="${param.priceMax}" /></c:if>
                                    </c:url>
                                    <li class="page-item"><a class="page-link" href="${nextUrl}">Tiếp »</a></li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div> <!-- end products col -->
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />

<!-- JS -->
<script src="<c:url value='/js/jquery-3.3.1.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
<script>
(function(){
    function buildUrl(params) {
        const url = new URL(window.location.href);
        Object.keys(params).forEach(k=>{
            if(!params[k] && params[k] !== 0) url.searchParams.delete(k);
            else url.searchParams.set(k, params[k]);
        });
        return url.toString();
    }

    // sort click
    document.querySelectorAll('.sort-option').forEach(el=>{
        el.addEventListener('click', function(){
            const val = this.dataset.val;
            const params = {
                page:1,
                sort:val,
                maDM:new URL(window.location.href).searchParams.get('maDM'),
                maKC:new URL(window.location.href).searchParams.get('maKC'),
                priceMin:new URL(window.location.href).searchParams.get('priceMin'),
                priceMax:new URL(window.location.href).searchParams.get('priceMax')
            };
            window.location.href = buildUrl(params);
        });
    });

    // size radio
    document.querySelectorAll('input[name="size-filter"]').forEach(r=>{
        r.addEventListener('change', function(){
            const params = {
                page:1,
                maKC:this.value,
                maDM:new URL(window.location.href).searchParams.get('maDM'),
                sort:new URL(window.location.href).searchParams.get('sort'),
                priceMin:new URL(window.location.href).searchParams.get('priceMin'),
                priceMax:new URL(window.location.href).searchParams.get('priceMax')
            };
            window.location.href = buildUrl(params);
        });
    });

    // price apply
    document.getElementById('priceApply').addEventListener('click', function(){
        const params = {
            page:1,
            priceMin:document.getElementById('priceMin').value,
            priceMax:document.getElementById('priceMax').value,
            maDM:new URL(window.location.href).searchParams.get('maDM'),
            maKC:new URL(window.location.href).searchParams.get('maKC'),
            sort:new URL(window.location.href).searchParams.get('sort')
        };
        window.location.href = buildUrl(params);
    });
})();
</script>
</body>
</html>
