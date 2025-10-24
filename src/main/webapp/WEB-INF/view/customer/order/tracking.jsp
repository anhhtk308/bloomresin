<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Theo dõi đơn hàng</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
</head>
<body style="background-color: #FFF1D2;">
<jsp:include page="../layout/header.jsp" />

<div class="container-fluid py-5 mt-5">
    <div class="container py-5">
        <h2 class="mb-4 text-center">Theo dõi đơn hàng</h2>
        <p class="text-center text-muted mb-5">Kiểm tra trạng thái các đơn hàng bạn đã đặt</p>
        <c:if test="${not empty message}">
            <div class="alert alert-success text-center fw-semibold">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger text-center fw-semibold">${error}</div>
        </c:if>

        <c:if test="${not empty orders}">
            <div class="table-responsive mb-5">
                <table class="table table-bordered text-center align-middle shadow-sm rounded">
                    <thead style="background-color: #6B1700; color: #FFF1D2;">
                    <tr>
                        <th>Ảnh</th>
                        <th>Sản phẩm</th>
                        <th>Ngày đặt hàng</th>
                        <th>Tổng giá tiền</th>
                        <th>Trạng thái</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>
                                <div class="d-flex flex-column align-items-center">
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <div class="mb-2">
                                            <img src="/images/product/${orderDetail.product.image}"
                                                 class="img-fluid border rounded"
                                                 alt="${orderDetail.product.name}"
                                                 style="width: 100px; height: auto; object-fit: cover;">
                                        </div>
                                    </c:forEach>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex flex-column align-items-center">
                                    <c:forEach var="orderDetail" items="${order.orderDetails}">
                                        <div class="mb-2">
                                            <a href="/product/${orderDetail.product.id}" class="fw-semibold text-dark text-decoration-none" target="_blank">
                                                    ${orderDetail.product.name}
                                            </a>
                                        </div>
                                    </c:forEach>
                                </div>
                            </td>
                            <td>${order.convertedOrderDate}</td>
                            <td><fmt:formatNumber type="number" value="${order.totalPrice}" /> đ</td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}"><span class="text-warning">Chờ xác nhận</span></c:when>
                                    <c:when test="${order.status == 'CONFIRM'}"><span class="text-info">Đã xác nhận</span></c:when>
                                    <c:when test="${order.status == 'COMPLETE'}"><span class="text-success">Hoàn thành</span></c:when>
                                    <c:when test="${order.status == 'CANCEL'}"><span class="text-danger">Đã hủy</span></c:when>
                                    <c:otherwise><span class="text-muted">Không rõ</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${order.status == 'PENDING'}">
                                    <a href="/customer/order/cancel/${order.id}"
                                       class="btn btn-outline-danger btn-sm"
                                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                        Hủy đơn hàng
                                    </a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

<%--        <c:if test="${not empty customOrders}">--%>
<%--            <h4 class="mb-3">Đơn hàng theo yêu cầu</h4>--%>
<%--            <div class="table-responsive">--%>
<%--                <table class="table table-hover table-bordered text-center align-middle shadow-sm rounded">--%>
<%--                    <thead style="background-color: #6B1700; color: #fff;">--%>
<%--                    <tr>--%>
<%--                        <th>Ảnh</th>--%>
<%--                        <th>Tên sản phẩm</th>--%>
<%--                        <th>Trạng thái</th>--%>
<%--                        <th>Ngày đặt</th>--%>
<%--                        <th>Hành động</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tbody>--%>
<%--                    <c:forEach var="custom" items="${customOrders}">--%>
<%--                        <tr>--%>
<%--                            <td>--%>
<%--                                <img src="${pageContext.request.contextPath}/images/custom-order/${custom.image}"--%>
<%--                                     class="rounded border" style="width: 60px; height: 60px; object-fit: cover;" alt="${custom.name}">--%>
<%--                            </td>--%>
<%--                            <td><strong>${custom.name}</strong></td>--%>
<%--                            <td>--%>
<%--                                <c:choose>--%>
<%--                                    <c:when test="${custom.status == 'CONFIRM'}"><span class="text-warning">Chờ xác nhận</span></c:when>--%>
<%--                                    <c:when test="${custom.status == 'PROCESSING'}"><span class="text-primary">Đang xử lý</span></c:when>--%>
<%--                                    <c:when test="${custom.status == 'COMPLETED'}"><span class="text-success">Hoàn thành</span></c:when>--%>
<%--                                    <c:when test="${custom.status == 'CANCELLED'}"><span class="text-danger">Đã hủy</span></c:when>--%>
<%--                                    <c:otherwise><span class="text-muted">Không rõ</span></c:otherwise>--%>
<%--                                </c:choose>--%>
<%--                            </td>--%>
<%--                            <td><fmt:formatDate value="${convertedDates[custom.id]}" pattern="dd/MM/yyyy HH:mm" /></td>--%>
<%--                            <td>--%>
<%--                                <a href="${pageContext.request.contextPath}/custom-order/edit/${custom.id}" class="btn btn-outline-dark btn-sm">--%>
<%--                                    <i class="fas fa-search"></i> Xem chi tiết--%>
<%--                                </a>--%>
<%--                                <c:if test="${custom.status == 'CONFIRM'}">--%>
<%--                                    <a href="/customer/custom-order/cancel/${custom.id}"--%>
<%--                                       class="btn btn-outline-danger btn-sm"--%>
<%--                                       onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng theo yêu cầu này?');">--%>
<%--                                        Hủy đơn hàng--%>
<%--                                    </a>--%>
<%--                                </c:if>--%>
<%--                            </td>--%>
<%--                        </tr>--%>
<%--                    </c:forEach>--%>
<%--                    </tbody>--%>
<%--                </table>--%>
<%--            </div>--%>
<%--        </c:if>--%>

        <c:if test="${empty orders and empty customOrders}">
            <div class="text-center">
                <h4 class="text-muted">Bạn chưa có đơn hàng nào.</h4>
            </div>
        </c:if>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/js/main.js"></script>
</body>
</html>
