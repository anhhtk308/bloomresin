<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử mua hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>

<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />

    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />
        <div class="p-4">
            <h1 class="mb-4 mt-4 text-center fw-bold">
                Lịch sử mua hàng của
                ${customer.present ? customer.get().fullName : 'Khách hàng'}
            </h1>

            <div class="p-4">
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                    <li class="breadcrumb-item"><a href="/admin/customer">Khách hàng</a></li>
                    <li class="breadcrumb-item active">Lịch sử mua hàng</li>
                </ol>

                <table class="table table-bordered table-hover align-middle text-center">
                    <thead class="table-light">
                    <tr>
                        <th>Mã đơn hàng</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Sản phẩm</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.convertedOrderDate}</td>
                            <td>
                                <fmt:formatNumber value="${order.totalPrice}" type="number" maxFractionDigits="2" />
                                đ
                            </td>
                            <td>${order.status}</td>
                            <td class="text-start">
                                <ul class="mb-0">
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <li>
                                                ${orderDetail.product.name} -
                                            <fmt:formatNumber value="${orderDetail.product.price}" type="number" maxFractionDigits="2" />
                                            đ - x${orderDetail.quantity}
                                        </li>
                                    </c:forEach>
                                </ul>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="d-flex justify-content-end mt-4">
                    <a href="/admin/customer" class="btn btn-secondary">Quay lại</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
