<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Quản lý đơn hàng</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
            <h1 class="mb-4 mt-4 text-center fw-bold">Quản lý đơn hàng</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Bảng điều khiển</a></li>
                <li class="breadcrumb-item active">Đơn hàng</li>
            </ol>
            <c:if test="${newOrderCount > 0}">
                <div class="alert alert-info">
                    📦 Có <strong>${newOrderCount}</strong> đơn hàng mới chờ xử lý.
                </div>
            </c:if>
            <div class="filter-bar mb-4">
                <form method="GET" action="/admin/order" class="d-inline">
                    <select name="status" style="margin-right: 10px;">
                        <option value="COMPLETE" <c:if test="${param.status == 'COMPLETE'}">selected</c:if>>Hoàn tất</option>
                        <option value="CONFIRM" <c:if test="${param.status == 'CONFIRM'}">selected</c:if>>Đã xác nhận</option>
                        <option value="PENDING" <c:if test="${param.status == 'PENDING'}">selected</c:if>>Chờ xử lý</option>
                        <option value="SHIPPING" <c:if test="${param.status == 'SHIPPING'}">selected</c:if>>Đang giao hàng</option>
                        <option value="CANCEL" <c:if test="${param.status == 'CANCEL'}">selected</c:if>>Đã hủy</option>
                        <option value="BANKING" <c:if test="${param.status == 'BANKING'}">selected</c:if>>Chuyển khoản</option>
                    </select>

                    <button type="submit" class="btn btn-primary">Lọc</button>
                </form>
                <a href="/admin/order" class="btn btn-secondary ms-2">Tất cả đơn hàng</a>
            </div>

            <div class="mt-5">
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex">
                            <h3>Danh sách đơn hàng</h3>
                        </div>

                        <hr />
                        <table class="table table-bordered table-hover text-center">
                            <thead class="table-light">
                            <tr>
                                <th>STT</th>
                                <th>Khách hàng</th>
                                <th>Ngày đặt</th>
                                <th>Tổng tiền</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" items="${orders}" varStatus="loop">
                                <c:if test="${empty param.status || order.status == param.status}">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${order.user.fullName}</td>
                                        <td>${order.convertedOrderDate}</td>
                                        <td><fmt:formatNumber type="number" value="${order.totalPrice}" /> đ</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'COMPLETE'}">Hoàn tất</c:when>
                                                <c:when test="${order.status == 'CONFIRM'}">Đã xác nhận</c:when>
                                                <c:when test="${order.status == 'PENDING'}">Chờ xử lý</c:when>
                                                <c:when test="${order.status == 'SHIPPING'}">Đang giao hàng</c:when>
                                                <c:when test="${order.status == 'CANCEL'}">Đã hủy</c:when>
                                                <c:when test="${order.status == 'BANKING'}">Chuyển khoản</c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'COMPLETE'}">
                                                    <a href="/admin/order/${order.id}" class="btn btn-success">Xem</a>
                                                </c:when>
                                                <c:when test="${order.status == 'CONFIRM'}">
                                                    <a href="/admin/order/${order.id}" class="btn btn-success">Xem</a>
                                                    <a href="/admin/order/update/${order.id}" class="btn btn-warning mx-2">Cập nhật</a>
                                                </c:when>
                                                <c:when test="${order.status == 'PENDING'}">
                                                    <a href="/admin/order/${order.id}" class="btn btn-success">Xem</a>
                                                    <a href="/admin/order/update/${order.id}" class="btn btn-warning mx-2">Cập nhật</a>
                                                </c:when>
                                                <c:when test="${order.status == 'SHIPPING' || order.status == 'PENDING'}">
                                                    <a href="/admin/order/${order.id}" class="btn btn-success">Xem</a>
                                                    <a href="/admin/order/update/${order.id}" class="btn btn-warning mx-2">Cập nhật</a>
                                                </c:when>
                                                <c:when test="${order.status == 'CANCEL'}">
                                                    <a href="/admin/order/${order.id}" class="btn btn-success">Xem</a>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
