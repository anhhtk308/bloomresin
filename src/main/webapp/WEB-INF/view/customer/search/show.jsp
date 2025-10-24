<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Sản Phẩm</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2 !important;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        h1, h2, h3, h4, h5, h6, p, a, span, label {
            color: #6B1700 !important;
        }

        a:hover {
            color: #B5947D;
        }

        .breadcrumb-item a,
        .breadcrumb-item.active {
            color: #6B1700 !important;
            font-weight: 600;
        }

        .btn-primary {
            background-color: #6B1700 !important;
            border-color: #6B1700 !important;
            color: #FFF1D2 !important;
        }

        .btn-primary:hover,
        .btn-success:hover {
            background-color: #CEAF95 !important;
            color: #6B1700 !important;
        }

        .btn-success {
            background-color: #CEAF95 !important;
            border-color: #CEAF95 !important;
            color: #6B1700 !important;
        }

        .btn-secondary {
            background-color: #B5947D !important;
            border-color: #B5947D !important;
            color: #fff !important;
        }

        .product-item {
            background-color: #FFF1D2;
            border: 1px solid #CEAF95;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }

        .product-item:hover {
            transform: translateY(-5px);
        }

        .product-desc {
            font-size: 14px;
            color: #6B1700;
            margin-top: 8px;
            text-align: center;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .custom-product-blog {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
            padding: 20px;
        }

        .custom-product-blog .product-item {
            flex: 0 0 calc(33.333% - 20px);
            max-width: calc(33.333% - 20px);
            padding: 15px;
            background: #fff;
        }

        @media (max-width: 1024px) {
            .custom-product-blog .product-item {
                flex: 0 0 calc(50% - 20px);
                max-width: calc(50% - 20px);
            }
        }

        @media (max-width: 768px) {
            .custom-product-blog .product-item {
                flex: 0 0 calc(100% - 20px);
                max-width: calc(100% - 20px);
            }
        }

        .product-item img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 8px;
        }

        .product-item .btn {
            margin-top: 10px;
            width: 100%;
            text-align: center;
            padding: 10px;
            font-size: 14px;
            border-radius: 20px;
            font-weight: bold;
            transition: background 0.3s;
            background: #CEAF95;
            color: #6B1700;
        }

        .product-item .btn:hover {
            background: #B5947D;
            color: #fff;
        }

        #chat-icon {
            position: fixed;
            bottom: 100px;
            right: 30px;
            background-color: #6B1700;
            color: #FFF1D2;
            width: 50px;
            height: 50px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
            cursor: pointer;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            font-size: 24px;
            z-index: 999;
        }
        .pagination .page-link {
            color: #6B1700;
            background-color: #FFF1D2;
            border: 1px solid #CEAF95;
            font-weight: 600;
        }

        .pagination .page-item.active .page-link {
            background-color: #CEAF95;
            color: #fff;
            border-color: #CEAF95;
        }

        .pagination .page-link:hover {
            background-color: #B5947D;
            color: #fff;
        }

        /* Custom radio button màu CEAF95 */
        .form-check-input[type="radio"] {
            appearance: none;
            -webkit-appearance: none;
            width: 1.2em;
            height: 1.2em;
            border: 2px solid #6B1700;
            border-radius: 50%;
            outline: none;
            cursor: pointer;
            position: relative;
            background-color: transparent;
            transition: 0.2s all;
        }

        .form-check-input[type="radio"]::before {
            content: '';
            display: block;
            width: 0.6em;
            height: 0.6em;
            border-radius: 50%;
            background-color: #6B1700;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: scale(0) translate(-50%, -50%);
            transition: 0.2s ease-in-out;
        }

        .form-check-input[type="radio"]:checked::before {
            transform: scale(1) translate(-50%, -50%);
        }
        .filter-box {
            border: 1px solid #CEAF95;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            color: #6B1700;
        }
    </style>
</head>
<body>
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<jsp:include page="../layout/header.jsp" />
<div class="container-fluid py-4 mt-3">
    <div class="container py-4">
        <div class="row g-4 mb-5">
            <div>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Danh sách sản phẩm</li>
                    </ol>
                </nav>
            </div>
            <div class="row g-4 fruite">
                <div class="col-12 col-md-4">
                    <div class="filter-box p-4 rounded">
                        <div class="row g-4">
                            <div class="col-12" id="priceFilter">
                                <div class="mb-2"><b>Giá</b></div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="price-2" name="price" value="duoi-100.000"
                                           <c:if test="${param.price == 'duoi-100.000'}">checked</c:if>>
                                    <label class="form-check-label" for="price-2">Dưới 100.000</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="price-3" name="price" value="100000-500000"
                                           <c:if test="${param.price == '100000-500000'}">checked</c:if>>
                                    <label class="form-check-label" for="price-3">Từ 100.000 - 500.000</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" id="price-5" name="price" value="tren-500.000"
                                           <c:if test="${param.price == 'tren-500.000'}">checked</c:if>>
                                    <label class="form-check-label" for="price-5">Trên 500.000</label>
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="col-12">
                                    <div class="mb-2"><b>Sorting</b></div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="sort-1"
                                               value="gia-tang-dan" name="radio-sort">
                                        <label class="form-check-label" for="sort-1">Giá tăng dần</label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="sort-2"
                                               value="gia-giam-dan" name="radio-sort">
                                        <label class="form-check-label" for="sort-2">Giá giảm dần</label>
                                    </div>

                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" id="sort-3"
                                               value="gia-nothing" name="radio-sort" checked>
                                        <label class="form-check-label" for="sort-3">Không sắp xếp theo giá</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12">
                                <button
                                        class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4"
                                        id="btnFilter">
                                    SẮP XẾP SẢN PHẨM
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-md-8 text-center">
<%--                    <div class="text-end mb-3">--%>
<%--                        <a href="/custom-order/form" class="btn btn-success px-4 py-2 rounded-pill shadow-sm" style="font-weight: 600; font-size: 16px;">--%>
<%--                            <i class="fas fa-magic me-1"></i> Làm sản phẩm theo yêu cầu--%>
<%--                        </a>--%>
<%--                    </div>--%>
                    <div class="row g-4">
                        <c:if test="${totalPages ==  0}">
                            <div>Không tìm thấy sản phẩm !!! </div>
                        </c:if>
                        <div class="custom-product-blog">
                            <c:forEach var="product" items="${products}">
                                <c:if test="${product.status == true}">
                                    <div class="product-item">
                                        <div class="rounded position-relative">
                                            <div class="fruite-img">
                                                <img src="/images/product/${product.image}"
                                                     class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                 style="top: 10px; left: 10px;">
                                                    ${product.category.name}
                                            </div>
                                            <div
                                                    class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                <h4 style="font-size: 15px;">
                                                    <a
                                                            href="/product/${product.id}">${product.name}</a>
                                                </h4>
                                                <p class="product-desc">${product.shortDesc}</p>
                                                <p style="font-size: 15px; text-align: center; width: 100%;"
                                                   class="text-dark fw-bold mb-3">
                                                    <fmt:formatNumber type="number"
                                                                      value="${product.price}" /> đ
                                                </p>
                                                <c:choose>
                                                    <c:when test="${product.quantity > 0}">
                                                        <form
                                                                action="/add-products-to-cart/${product.id}"
                                                                method="post">
                                                            <input type="hidden"
                                                                   name="${_csrf.parameterName}"
                                                                   value="${_csrf.token}" />
                                                            <button class="btn btn-primary"><i
                                                                    class="fa fa-shopping-bag me-2"></i>Thêm vào giỏ hàng</button>
                                                        </form>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-secondary"
                                                                disabled>Đã bán hết</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <c:if test="${totalPages > 0}">
                            <div class="d-flex justify-content-center mt-5">
                                <ul class="pagination">
                                    <li class="page-item ${1 eq currentPage ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="/products?page=${currentPage - 1}${queryString}"
                                           aria-label="Trước">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>

                                    <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                        <li class="page-item ${(loop.index + 1) eq currentPage ? 'active' : ''}">
                                            <a class="page-link"
                                               href="/products?page=${loop.index + 1}${queryString}">
                                                    ${loop.index + 1}
                                            </a>
                                        </li>
                                    </c:forEach>

                                    <li class="page-item ${totalPages eq currentPage ? 'disabled' : ''}">
                                        <a class="page-link"
                                           href="/products?page=${currentPage + 1}${queryString}"
                                           aria-label="Sau">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/js/main.js"></script>
<script>
    document.querySelectorAll('.product-desc').forEach(function (desc) {
        const words = desc.textContent.trim().split(/\s+/);
        if (words.length > 4) {
            desc.textContent = words.slice(0, 4).join(' ') + '...';
        }
    });
</script>
<div id="chat-icon" onclick="redirectToCareService()">
    <i class="fas fa-comment-alt"></i>
</div>
<script>
    function redirectToCareService() {
        window.location.href = "/careservice";
    }
</script>
</body>
</html>