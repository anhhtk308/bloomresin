<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Thanh toán</title>
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

        h4, .fw-bold, .fw-semibold {
            color: #6B1700 !important;
        }

        .breadcrumb-item a,
        .breadcrumb-item.active {
            color: #6B1700 !important;
            font-weight: 600;
        }

        .table {
            background-color: #FFF1D2;
            color: #6B1700;
        }

        .table thead {
            background-color: #CEAF95;
            color: #6B1700;
        }

        .bg-white {
            background-color: #FFF1D2 !important;
        }

        .border-secondary {
            border-color: #CEAF95 !important;
        }

        .form-label {
            color: #6B1700;
            font-weight: 600;
        }

        .form-control {
            border: 1px solid #CEAF95;
            background-color: #fffef7;
            color: #6B1700;
        }

        .form-control:focus {
            border-color: #6B1700;
            box-shadow: 0 0 0 0.2rem rgba(107, 23, 0, 0.25);
        }

        .btn-primary {
            background-color: #6B1700;
            border-color: #6B1700;
            color: #FFF1D2;
        }

        .btn-primary:hover {
            background-color: #CEAF95;
            color: #6B1700;
        }

        .text-primary {
            color: #6B1700 !important;
        }

        .btn.border-secondary {
            border-color: #6B1700 !important;
            color: #6B1700 !important;
            font-weight: 600;
        }

        .btn.border-secondary:hover {
            background-color: #CEAF95;
            color: #6B1700;
        }

        .table-bordered td, .table-bordered th {
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
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <jsp:include page="../layout/header.jsp" />
    <div class="container-fluid py-5">
        <div class="container py-5">
            <div class="mb-3">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Thông tin thanh toán</li>
                    </ol>
                </nav>
            </div>

            <c:if test="${not empty cartDetails}">
                <form:form action="/place-order" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <input type="hidden" name="finalTotal" id="finalTotalHidden" value="${totalPrice + 30000}">

                    <div class="container d-flex justify-content-center align-items-center flex-column py-5" style="min-height: 100vh;">
                        <div class="col-lg-8 bg-white p-4 rounded-3 border border-1 border-secondary"
                             style="max-width: 850px;">
                            <h4 class="text-center mb-4 text-dark fw-bold">🛒 Đơn hàng của bạn</h4>

                            <table class="table table-bordered text-center">
                                <thead class="table-light">
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Số lượng</th>
                                    <th>Thành tiền</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="cartDetail" items="${cartDetails}">
                                    <tr>
                                        <td>${cartDetail.product.name}</td>
                                        <td>${cartDetail.quantity}</td>
                                        <td>
                                            <fmt:formatNumber type="number" value="${cartDetail.price * cartDetail.quantity}" /> đ
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <div class="row mt-4">
                                <div class="col-6 fw-semibold">💰 Thành tiền:</div>
                                <div class="col-6 text-end" id="originalTotal" data-cart-total-price="${totalPrice}">
                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                </div>
                                <div class="col-6 fw-semibold">🚚 Phí vận chuyển:</div>
                                <div class="col-6 text-end" id="shippingFee">30,000 đ</div>
                                <div class="col-6 fw-bold fs-5 mt-3">💰 Tổng thanh toán:</div>
                                <div class="col-6 text-end fw-bold fs-5 mt-3" id="finalTotal">
                                    <fmt:formatNumber type="number" value="${totalPrice + 30000}" /> đ
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-8 bg-white p-4 rounded-3 border border-1 border-secondary"
                             style="max-width: 850px; margin-top: 40px;">
                        <h4 class="text-center mb-4 text-dark fw-bold">📦 Thông tin người nhận</h4>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="receiverName" class="form-label">Họ tên:</label>
                                    <input type="text" id="receiverName" name="receiverName" class="form-control" required
                                           value="${user.fullName}">
                                </div>

                                <div class="col-md-4">
                                    <label for="receiverEmail" class="form-label">Email:</label>
                                    <input type="email" id="receiverEmail" name="receiverEmail" class="form-control" required
                                           value="${user.email}">
                                </div>

                                <div class="col-md-4">
                                    <label for="receiverPhone" class="form-label">Số điện thoại:</label>
                                    <input type="tel" id="receiverPhone" name="receiverPhone" class="form-control" required
                                           value="${user.phone}"
                                           pattern="0[0-9]{9}"
                                           oninvalid="this.setCustomValidity('Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số')"
                                           oninput="this.setCustomValidity('')">
                                </div>

                                <div class="col-12">
                                    <label for="receiverAddress" class="form-label">Địa chỉ (Hãy kiểm tra kỹ):</label>
                                    <input type="text" id="receiverAddress" name="receiverAddress" class="form-control" required
                                           value="${user.address}">
                                </div>

                                <div class="col-12">
                                    <label for="Note" class="form-label">Ghi chú(có thể ghi mong muốn như kích thước sản phẩm, chất liệu, hoa,...):</label>
                                    <textarea id="Note" name="Note" class="form-control" rows="3" required></textarea>
                                </div>
                            </div>

                            <div class="d-flex justify-content-center mt-3 gap-3">
                            <form action="/place-order" method="post" style="display: inline;">
                                <!-- Các trường ẩn -->
                                <input type="hidden" name="receiverName" th:value="${receiverName}" />
                                <input type="hidden" name="receiverAddress"
                                    th:value="${receiverAddress}" />
                                <input type="hidden" name="receiverPhone" th:value="${receiverPhone}" />
                                <input type="hidden" name="Note" th:value="${orderInfo}" />
                                <input type="hidden" name="finalTotal" th:value="${totalPrice}" />

                                <div class="d-flex justify-content-center mt-3 gap-3">
                                    <div class="d-flex justify-content-center mt-3 gap-3">
                                        <a href="/" class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-5">
                                            Quay về trang chủ
                                        </a>

                                        <button type="submit"
                                                class="btn btn-primary rounded-pill px-4 py-3 text-white text-uppercase mb-4 ms-5">
                                            Mua hàng
                                        </button>
                                    </div>
                                </div>
                            </form>
                            </div>
                        </div>
                    </div>
                </form:form>
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