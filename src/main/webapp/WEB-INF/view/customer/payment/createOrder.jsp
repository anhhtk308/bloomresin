<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo đơn hàng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #FFF1D2;
            font-family: 'Open Sans', sans-serif;
            color: #6B1700;
        }
        .card {
            border: none;
            border-radius: 12px;
        }
        .card-title {
            color: #6B1700;
            font-weight: 700;
        }
        label {
            font-weight: 600;
            color: #6B1700;
        }
        .form-control {
            border-radius: 6px;
        }
        .btn-primary {
            background-color: #CEAF95;
            border-color: #CEAF95;
            color: white;
        }
        .btn-primary:hover {
            background-color: #6B1700;
            border-color: #6B1700;
        }
        .alert-danger {
            background-color: #f8d7da;
            border: 1px solid #f5c2c7;
            color: #842029;
        }
    </style>
</head>

<body>
<div class="container py-5 mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card shadow-lg p-4">
                <div class="card-body text-center">
                    <h2 class="card-title mb-4">Tạo đơn hàng</h2>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/submitOrder" method="get">
                        <div class="container">
                            <div class="row mb-2">
                                <label for="ordertype" class="col-md-4 text-end">Loại đơn hàng</label>
                                <div class="col-md-8">
                                    <select name="ordertype" id="ordertype" class="form-control" required>
                                        <option value="billpayment">Thanh toán hóa đơn</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <label class="col-md-4 text-end">Tổng tiền (VND)</label>
                                <div class="col-md-8">
                                    <input type="text" class="form-control"
                                           value="<fmt:formatNumber value='${totalAmount}' type='number' groupingUsed='true' minFractionDigits='0' maxFractionDigits='0'/> VND"
                                           readonly>
                                    <input type="hidden" id="amount" name="amount" value="${totalAmount}">
                                </div>
                            </div>

                            <div class="row mb-2">
                                <label for="orderInfo" class="col-md-4 text-end">Thông tin đơn hàng</label>
                                <div class="col-md-8">
                                    <input type="text" id="orderInfo" name="orderInfo" value="${orderDetails}"
                                           readonly class="form-control" required>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <label for="address" class="col-md-4 text-end">Địa chỉ nhận hàng</label>
                                <div class="col-md-8">
                                    <input type="text" id="address" name="address"
                                           class="form-control" value="${sessionScope.receiverAddress}" required>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <label for="name" class="col-md-4 text-end">Tên người nhận</label>
                                <div class="col-md-8">
                                    <input type="text" id="name" name="name" class="form-control"
                                           value="${sessionScope.receiverName}" required>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <label for="phone" class="col-md-4 text-end">Số điện thoại</label>
                                <div class="col-md-8">
                                    <input type="text" id="phone" name="phone" class="form-control"
                                           value="${sessionScope.receiverPhone}" required>
                                </div>
                            </div>

                            <div class="row mb-2">
                                <label class="col-md-4 text-end">Phương thức thanh toán</label>
                                <div class="col-md-8">
                                    <select name="paymentMethod" class="form-control" required>
                                        <option value="">-- Chọn phương thức thanh toán --</option>
                                        <option value="online">Chuyển khoản (Online Banking)</option>
                                        <option value="cod">Thanh toán khi nhận hàng (COD)</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary btn-block mt-4">
                            <i class="bi bi-bag-check-fill"></i> Xác nhận mua hàng
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
