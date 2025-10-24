<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Giỏ hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
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

        .breadcrumb-item a,
        .breadcrumb-item.active {
            color: #6B1700 !important;
            font-weight: 600;
        }

        h1, h5, th {
            color: #6B1700 !important;
            font-family: 'Raleway', sans-serif;
        }

        .table {
            background-color: #fff;
            border-color: #CEAF95 !important;
            color: #6B1700;
        }

        .table thead {
            background-color: #CEAF95;
            color: #6B1700;
            border-bottom: 2px solid #CEAF95;
        }

        .table td, .table th {
            border-color: #CEAF95 !important;
            vertical-align: middle;
        }

        .text-danger, .text-successfully {
            font-weight: 600;
        }

        .text-danger {
            color: #dc3545 !important;
        }

        .text-successfully {
            color: #157347 !important;
        }

        .form-control {
            border: 1px solid #CEAF95;
            background-color: #fffef9;
            color: #6B1700;
        }

        .form-control:focus {
            border-color: #6B1700;
            box-shadow: 0 0 0 0.2rem rgba(107, 23, 0, 0.25);
        }

        .btn-primary,
        .btn.border-secondary.text-primary {
            background-color: #6B1700;
            border-color: #6B1700;
            color: #FFF1D2 !important;
            font-weight: bold;
        }

        .btn-primary:hover,
        .btn.border-secondary.text-primary:hover {
            background-color: #CEAF95;
            color: #6B1700 !important;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            color: #fff;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .bg-light.border {
            background-color: #fff6ea !important;
            border-color: #CEAF95 !important;
        }

        .back-to-top {
            background-color: #6B1700 !important;
            border-color: #6B1700 !important;
        }

        .back-to-top:hover {
            background-color: #CEAF95 !important;
            color: #6B1700 !important;
        }
    </style>
</head>
<body>
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <jsp:include page="../layout/header.jsp" />
    <div class="container-fluid py-5" style="margin-bottom: 80px;">
        <div class="container py-5">
            <div class="mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Chi tiết giỏ hàng</li>
                    </ol>
                </nav>
            </div>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Sản phẩm</th>
                            <th scope="col">Tên</th>
                            <th scope="col">Giá</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Tồn kho</th>
                            <th scope="col">Tổng số tiền</th>
                            <th scope="col">Xử lý</th>
                            <th scope="col">Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${ empty cartDetails}">
                            <tr>
                                <td colspan="8">Không có sản phẩm nào trong giỏ hàng</td>
                            </tr>
                        </c:if>
                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                            <tr>
                                <th scope="row">
                                    <div class="d-flex align-items-center">
                                        <img src="/images/product/${cartDetail.product.image}"
                                            class="img-fluid me-5 rounded-circle"
                                            style="width: 80px; height: 80px;" alt="">
                                    </div>
                                </th>
                                <td>
                                    <p class="mb-0 mt-4">
                                        <a href="/product/${cartDetail.product.id}" target="_blank">
                                            ${cartDetail.product.name}
                                        </a>
                                    </p>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4">
                                        <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                    </p>
                                </td>
                                <td>
                                    <div class="input-group quantity mt-4" style="width: 100px;">
                                        <div class="input-group-btn">
                                            <button
                                                class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                <i class="fa fa-minus"></i>
                                            </button>
                                        </div>
                                        <input type="text"
                                            class="form-control form-control-sm text-center border-0"
                                            value="${cartDetail.quantity}"
                                            data-cart-detail-id="${cartDetail.id}"
                                            data-cart-detail-price="${cartDetail.price}"
                                            data-cart-detail-index="${status.index}"
                                            data-available-quantity="${cartDetail.product.quantity}"
                                            readonly>
                                        <div class="input-group-btn">
                                            <button
                                                class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                <i class="fa fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4">
                                        ${cartDetail.product.quantity}
                                    </p>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                        <fmt:formatNumber type="number"
                                            value="${cartDetail.price * cartDetail.quantity}" /> đ
                                    </p>
                                </td>
                                <td>
                                    <form method="post" action="/delete-cart-product/${cartDetail.id}">
                                        <input type="hidden" name="${_csrf.parameterName}"
                                            value="${_csrf.token}" />
                                        <button
                                            class="btn btn-md rounded-circle bg-light border mt-4 mr-4">
                                            <i class="fa fa-times text-danger"></i>
                                        </button>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <c:choose>
                                        <c:when test="${cartDetail.product.quantity > 0}">
                                            <span class="text-successfully" style="color: green">In
                                                stock</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
            <c:if test="${param.errorInventory != null}">
                <div class="my-2" style="color: red;">Số lượng đặt vượt quá số lượng tồn kho.</div>
            </c:if>
            <c:if test="${not empty cartDetails}">
                <div class="mt-5 row g-4 justify-content-start">
                    <div class="col-12 col-md-8">
                        <div class="">
                            <div class="p-4">
                                <h1 class="display-6 mb-4"><span class="fw-normal">Thông tin đơn hàng</span></h1>
                                <div class="d-flex justify-content-between mb-4">
                                    <h5 class="mb-0 me-4">Tạm tính:</h5>
                                    <p class="mb-0" data-cart-total-price="${totalPrice}">
                                        <fmt:formatNumber type="number" value="${totalPrice}" />
                                    </p>
                                </div>
                            </div>
                            <div
                                class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                <h5 class="mb-0 ps-4 me-4">Tổng cộng</h5>
                                <p class="mb-0 pe-4" data-cart-total-price="${totalPrice}">
                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                </p>
                            </div>
                            <form:form action="/confirm-checkout" method="post" modelAttribute="cart">
                                <input type="hidden" name="${_csrf.parameterName}"
                                    value="${_csrf.token}" />
                                <div style="display: none;">
                                    <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                        varStatus="status">
                                        <div class="mb-3">
                                            <div class="form-group">
                                                <label>Id:</label>
                                                <form:input class="form-control" type="text"
                                                    value="${cartDetail.id}"
                                                    path="cartDetails[${status.index}].id" />
                                            </div>
                                            <div class="form-group">
                                                <label>Số lượng:</label>
                                                <form:input class="form-control" type="text"
                                                    value="${cartDetail.quantity}"
                                                    path="cartDetails[${status.index}].quantity" />
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button
                                    class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">
                                    Xác nhận thanh toán
                                </button>
                            </form:form>
                        </div>
                    </div>
                </div>
            </c:if>
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
</body>
</html>