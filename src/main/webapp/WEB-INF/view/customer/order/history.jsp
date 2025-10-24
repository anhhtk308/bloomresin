<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Lịch sử mua hàng</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        h4 {
            color: #6B1700;
            font-weight: bold;
        }

        .breadcrumb a {
            color: #6B1700;
            text-decoration: none;
        }

        .breadcrumb .active {
            font-weight: 600;
        }

        table th, table td {
            vertical-align: middle !important;
        }

        .btn-outline-success, .btn-outline-info {
            border-color: #6B1700;
            color: #6B1700;
        }

        .btn-outline-success:hover, .btn-outline-info:hover {
            background-color: #CEAF95;
            border-color: #CEAF95;
            color: white;
        }

        .table thead.custom-header th {
            background-color: #6B1700; /* màu nâu đậm của giao diện */
            color: #FFF1D2;
        }

        .table-danger {
            background-color: #CEAF95;
        }

        .btn:focus {
            box-shadow: none !important;
        }
    </style>
</head>

<body>
<jsp:include page="../layout/header.jsp" />

<div class="container-fluid py-5 mt-5">
    <div class="container py-5">
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
            </ol>
        </nav>

        <!-- Đơn hàng thường -->
<%--        <h4 class="mb-3">Đơn hàng thông thường</h4>--%>
        <div class="table-responsive mb-5">
            <table class="table table-hover table-bordered text-center align-middle">
                <thead class="custom-header">
                <tr>
                    <th>Sản phẩm</th>
                    <th>Tên</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th>Phương thức</th>
                    <th>Trạng thái</th>
                    <th>Ngày đặt</th>
                    <th>Hành động</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orders}">
                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/images/product/${orderDetail.product.image}"
                                     class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="${orderDetail.product.name}">
                            </td>
                            <td>
                                <a href="/product/${orderDetail.product.id}" class="fw-semibold text-dark text-decoration-none" target="_blank">
                                        ${orderDetail.product.name}
                                </a>
                            </td>
                            <td><fmt:formatNumber value="${orderDetail.price}" type="number" groupingUsed="true" /> đ</td>
                            <td>${orderDetail.quantity}</td>
                            <td><fmt:formatNumber value="${orderDetail.price * orderDetail.quantity}" type="number" groupingUsed="true" /> đ</td>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:toLowerCase(order.paymentMethod) == 'cod'}">COD</c:when>
                                    <c:when test="${fn:toLowerCase(order.paymentMethod) == 'banking'}">Chuyển khoản</c:when>
                                    <c:otherwise>Không rõ</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}"><span class="text-warning">Chờ xác nhận</span></c:when>
                                    <c:when test="${order.status == 'CONFIRM'}"><span class="text-info">Đã xác nhận</span></c:when>
                                    <c:when test="${order.status == 'COMPLETE'}"><span class="text-success">Hoàn thành</span></c:when>
                                    <c:when test="${order.status == 'CANCEL'}"><span class="text-danger">Đã hủy</span></c:when>
                                    <c:otherwise><span class="text-muted">Không rõ</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${order.convertedOrderDate}</td>
                            <td>
                                <a href="/order-success?orderId=${order.id}" class="btn btn-outline-success btn-sm">
                                    <i class="fas fa-file-invoice"></i> Hóa đơn
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:forEach>
                <c:if test="${empty orders}">
                    <tr><td colspan="9" class="text-muted text-center">Không có đơn hàng nào.</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>

<%--        <!-- Đơn hàng theo yêu cầu -->--%>
<%--        <h4 class="mb-3">Đơn hàng theo yêu cầu</h4>--%>
<%--        <div class="table-responsive">--%>
<%--            <table class="table table-hover table-bordered text-center align-middle">--%>
<%--                <thead class="table-danger text-dark">--%>
<%--                <tr>--%>
<%--                    <th>Ảnh</th>--%>
<%--                    <th>Tên sản phẩm</th>--%>
<%--                    <th>SĐT</th>--%>
<%--                    <th>Địa chỉ</th>--%>
<%--                    <th>Mô tả</th>--%>
<%--                    <th>Trạng thái</th>--%>
<%--                    <th>Ngày đặt</th>--%>
<%--                    <th>Hành động</th>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>
<%--                <c:forEach var="custom" items="${customOrders}">--%>
<%--                    <tr>--%>
<%--                        <td>--%>
<%--                            <img src="${pageContext.request.contextPath}/images/custom-order/${custom.image}"--%>
<%--                                 class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="${custom.name}">--%>
<%--                        </td>--%>
<%--                        <td><strong>${custom.name}</strong></td>--%>
<%--                        <td>${custom.phone}</td>--%>
<%--                        <td>${custom.address}</td>--%>
<%--                        <td style="max-width: 200px; white-space: pre-line">${custom.description}</td>--%>
<%--                        <td>--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${custom.status == 'CONFIRM'}"><span class="text-warning">Chờ xác nhận</span></c:when>--%>
<%--                                <c:when test="${custom.status == 'PROCESSING'}"><span class="text-primary">Đang xử lý</span></c:when>--%>
<%--                                <c:when test="${custom.status == 'COMPLETED'}"><span class="text-success">Hoàn thành</span></c:when>--%>
<%--                                <c:when test="${custom.status == 'CANCELLED'}"><span class="text-danger">Đã hủy</span></c:when>--%>
<%--                                <c:otherwise><span class="text-muted">Không rõ</span></c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </td>--%>
<%--                        <td><fmt:formatDate value="${convertedDates[custom.id]}" pattern="dd/MM/yyyy HH:mm" /></td>--%>
<%--                        <td>--%>
<%--                            <a href="${pageContext.request.contextPath}/custom-order/edit/${custom.id}" class="btn btn-outline-info btn-sm">--%>
<%--                                <i class="fas fa-search"></i> Xem chi tiết--%>
<%--                            </a>--%>
<%--                        </td>--%>
<%--                    </tr>--%>
<%--                </c:forEach>--%>
<%--                <c:if test="${empty customOrders}">--%>
<%--                    <tr><td colspan="8" class="text-muted text-center">Không có đơn hàng theo yêu cầu.</td></tr>--%>
<%--                </c:if>--%>
<%--                </tbody>--%>
<%--            </table>--%>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top">
    <i class="fa fa-arrow-up"></i>
</a>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/js/main.js"></script>
</body>
</html>
