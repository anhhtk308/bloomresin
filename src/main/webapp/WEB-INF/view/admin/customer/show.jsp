<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khách hàng</title>
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
            <h1 class="mb-4 mt-4 text-center fw-bold">Quản lý khách hàng</h1>

            <div>
                <c:if test="${not empty message}">
                    <div class="alert alert-success">${message}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>
            </div>

            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                <li class="breadcrumb-item active">Khách hàng</li>
            </ol>

            <div class="d-flex justify-content-end mb-3">
                <a href="/admin/customer/create" class="btn btn-primary me-2">Thêm khách hàng</a>
            </div>

            <div class="mt-5">
                <div class="row">
                    <table class="table table-bordered table-hover text-center align-middle">
                        <thead class="table-light">
                        <tr>
                            <td>STT</td>
                            <th>Email</th>
                            <th>Họ và tên</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="customer" items="${customers}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${customer.email}</td>
                                <td>${customer.fullName}</td>
                                <td>
                                    <span class="${customer.status ? 'text-success' : 'text-danger'}">
                                            ${customer.status ? 'Hoạt động' : 'Đã khóa'}
                                    </span>
                                </td>
                                <td>
                                    <a href="/admin/customer/${customer.id}" class="btn btn-success btn-sm">Xem</a>
                                    <a href="/admin/customer/${customer.id}/feedback" class="btn btn-info btn-sm">Phản hồi</a>
                                    <a href="/admin/customer/${customer.id}/purchase-history"
                                       class="btn btn-secondary btn-sm mx-1">Đơn hàng</a>
                                    <form action="/admin/customer/ban/${customer.id}" method="post" class="d-inline">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                        <input type="hidden" name="status" value="${customer.status ? 'false' : 'true'}" />
                                        <button type="submit"
                                                class="btn btn-sm ${customer.status ? 'btn-danger' : 'btn-warning'}">
                                                ${customer.status ? 'Khóa' : 'Mở khóa'}
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
