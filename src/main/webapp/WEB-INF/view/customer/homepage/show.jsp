<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Trang chủ</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
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

        .btn-primary {
            background-color: #6B1700 !important;
            border-color: #6B1700 !important;
            color: #FFF1D2 !important;
        }

        .btn-primary:hover {
            background-color: #CEAF95 !important;
            color: #6B1700 !important;
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

        button.btn {
            min-height: 40px;
            width: 100%;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            flex: 1;
        }

        button.btn {
            min-height: 40px;
            width: 100%;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            flex: 1;
        }
        @keyframes ticker {
            0% {
                transform: translateX(100%);
            }

            100% {
                transform: translateX(-100%);
            }
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
    </style>
</head>
<body>
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <jsp:include page="../layout/header.jsp" />
<%--    <jsp:include page="../layout/banner.jsp" />--%>
    <div class="container-fluid fruite pt-3 pb-5">
        <div class="container pt-3 pb-5">
            <div class="tab-class text-center">
                <div class="row g-4">
                    <div class="col-lg-4 text-start">
                        <h1>Sản phẩm hiện có</h1>
                    </div>
                    <div class="col-lg-8 text-end">
                        <ul class="nav nav-pills d-inline-flex text-center mb-5">
                            <li class="nav-item">
                                <a class="d-flex m-2 py-2 bg-light rounded-pill active" href="/products">
                                    <span class="text-dark" style="width: 130px;">SẢN PHẨM</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="row g-4">
                                    <c:set var="count" value="0" />
                                    <c:forEach var="category" items="${categories}">
                                        <div class="container py-3">
                                            <h2 class="text-start">${category.name}</h2>
                                            <div class="row g-4">
                                                <c:set var="count" value="0" />
                                                <c:forEach var="product" items="${category.products}">
                                                    <c:if test="${count < 4}">
                                                        <c:if test="${product.quantity > 0}">
                                                            <div class="col-md-6 col-lg-4 col-xl-3">
                                                                <div class="product-item position-relative">
                                                                <div>
                                                                        <img src="/images/product/${product.image}"
                                                                            class="img-fluid w-100 rounded-top"
                                                                            alt="">
                                                                    </div>
                                                                    <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                        style="top: 10px; left: 10px;">
                                                                        ${category.name}
                                                                    </div>
                                                                    <div
                                                                        class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                        <h4 style="font-size: 15px;">
                                                                            <a
                                                                                href="/product/${product.id}">${product.name}</a>
                                                                        </h4>
                                                                        <p class="product-desc">
                                                                            ${product.shortDesc}</p>
                                                                        <div
                                                                            class="d-flex flex-lg-wrap justify-content-center flex-column">
                                                                            <p style="font-size: 15px; text-align: center; width: 100%;"
                                                                                class="text-dark fw-bold mb-3">
                                                                                <fmt:formatNumber
                                                                                    type="number"
                                                                                    value="${product.price}" />
                                                                                đ
                                                                            </p>
                                                                            <form
                                                                                action="/add-product-to-cart/${product.id}"
                                                                                method="post">
                                                                                <input type="hidden"
                                                                                    name="${_csrf.parameterName}"
                                                                                    value="${_csrf.token}" />
                                                                                <button class="btn"><i class="fa fa-shopping-bag me-2"></i> Thêm vào giỏ hàng</button>
                                                                            </form>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <c:set var="count" value="${count + 1}" />
                                                        </c:if>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <a href="#" id="backToTop" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
        <i class="fa fa-arrow-up"></i>
    </a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/main.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
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
    <script>
        document.getElementById('backToTop').addEventListener('click', function (e) {
            e.preventDefault(); // Ngăn hành vi mặc định
            window.scrollTo({ top: 0, behavior: 'auto' }); // Cuộn lên ngay lập tức
        });
    </script>
</body>
</html>