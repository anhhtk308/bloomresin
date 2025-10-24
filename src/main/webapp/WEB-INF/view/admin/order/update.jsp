<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Cập nhật đơn hàng</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-box {
            width: 60%;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />
        <div class="p-4">
            <h1 class="mt-4">Đơn hàng</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                <li class="breadcrumb-item"><a href="/admin/order">Quản lý đơn hàng</a></li>
                <li class="breadcrumb-item active">Cập nhật</li>
            </ol>

            <div class="mt-5">
                <div class="row">
                    <div class="col-md-6 col-12 mx-auto">
                        <h3>Cập nhật đơn hàng</h3>
                        <hr />
                        <form:form method="post" action="/admin/order/update" modelAttribute="newOrder" class="row">
                            <div class="form-box">
                                <form:input type="hidden" class="form-control" path="id" />

                                <div class="mb-3">
                                    <label>Mã đơn hàng: ${newOrder.id}</label><br>
                                    <label class="form-label">Tổng tiền:
                                        <fmt:formatNumber type="number" value="${newOrder.totalPrice}" /> đ
                                    </label>
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Khách hàng:</label>
                                    <form:input type="text" class="form-control" path="user.fullName" disabled="true" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Trạng thái đơn hàng:</label>
                                    <form:select class="form-select" path="status">
                                        <form:option value="PENDING">Chờ xử lý</form:option>
                                        <form:option value="CONFIRM">Đã xác nhận</form:option>
                                        <form:option value="SHIPPING">Đang giao hàng</form:option>
                                        <form:option value="COMPLETE">Hoàn tất</form:option>
                                        <form:option value="CANCEL">Đã hủy</form:option>
                                        <form:option value="BANKING">Chuyển khoản</form:option>
                                    </form:select>
                                </div>

                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-warning">Cập nhật</button>
                                    <a href="/admin/order" class="btn btn-secondary ms-2">Quay lại</a>
                                </div>
                            </div>
                        </form:form>
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
