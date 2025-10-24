<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Chi tiết đơn hàng</title>
    <link href="/css/styles.css" rel="stylesheet" />
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
            <h1 class="mt-4">Chi tiết đơn hàng</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                <li class="breadcrumb-item"><a href="/admin/order">Quản lý đơn hàng</a></li>
                <li class="breadcrumb-item active">Chi tiết</li>
            </ol>

            <div class="mb-5">
                <h4>Thông tin khách hàng</h4>
                <table class="table table-bordered">
                    <tr>
                        <th>Họ tên</th>
                        <td>${order.user.fullName}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${order.user.email}</td>
                    </tr>
                    <tr>
                        <th>Số điện thoại</th>
                        <td>${order.receiverPhone}</td>
                    </tr>
                    <tr>
                        <th>Địa chỉ</th>
                        <td>${order.receiverAddress}</td>
                    </tr>
                    <tr>
                        <th>Ghi chú</th>
                        <td>${order.note}</td>
                    </tr>
                    <tr>
                        <th>Trạng thái</th>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 'COMPLETE'}">Hoàn tất</c:when>
                                <c:when test="${order.status == 'CONFIRM'}">Đã xác nhận</c:when>
                                <c:when test="${order.status == 'PENDING'}">Chờ xử lý</c:when>
                                <c:when test="${order.status == 'CANCEL'}">Đã hủy</c:when>
                                <c:when test="${order.status == 'SHIPPING'}">Đang giao hàng</c:when>
                                <c:when test="${order.status == 'REFUND'}">Đã hoàn tiền</c:when>
                                <c:when test="${order.status == 'PROCESSING'}">Đang xử lý</c:when>
                                <c:when test="${order.status == 'FAIL'}">Thất bại</c:when>
                                <c:otherwise>Không xác định</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>Phương thức thanh toán</th>
                        <td>${order.paymentMethod}</td>
                    </tr>
                    <tr>
                        <th>Ngày đặt hàng</th>
                        <td>${formattedOrderDate}</td>
                    </tr>
                </table>
            </div>

            <div class="table-responsive">
                <h4>Sản phẩm trong đơn hàng</h4>
                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng cộng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${empty order.orderDetails}">
                        <tr>
                            <td colspan="5">Đơn hàng này không có sản phẩm.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="od" items="${order.orderDetails}">
                        <tr>
                            <td>
                                <img src="/images/product/${od.product.image}" class="img-fluid rounded-circle"
                                     style="width: 80px; height: 80px;" alt="">
                            </td>
                            <td>
                                <a href="/product/${od.product.id}" target="_blank">${od.product.name}</a>
                            </td>
                            <td>
                                <fmt:formatNumber value="${od.price}" type="number" /> đ
                            </td>
                            <td>${od.quantity}</td>
                            <td>
                                <fmt:formatNumber value="${od.price * od.quantity}" type="number" /> đ
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-end">
                <a href="/admin/order" class="btn btn-success mt-3">Quay lại</a>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
