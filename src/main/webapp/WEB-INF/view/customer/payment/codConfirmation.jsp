<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận đơn hàng COD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            font-family: 'Segoe UI', sans-serif;
            color: #6B1700;
        }
        .confirmation-box {
            max-width: 600px;
            margin: 60px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .success-badge {
            background-color: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .cod-info {
            background-color: #cff4fc;
            color: #055160;
            border: 1px solid #b6effb;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .table-custom {
            margin-top: 20px;
            border-color: #CEAF95;
        }
        .table th, .table td {
            color: #6B1700;
        }
        .btn-home .btn {
            background-color: #CEAF95;
            border-color: #CEAF95;
            color: #fff;
        }
        .btn-home .btn:hover {
            background-color: #6B1700;
            border-color: #6B1700;
            color: #fff;
        }
        h3 {
            color: #6B1700;
        }
    </style>
</head>
<body>

<div class="confirmation-box">
    <div class="text-center">
        <h3 class="mb-4"><i class="bi bi-check-circle-fill"></i> Đặt hàng thành công</h3>
    </div>

    <div class="success-badge">
        <strong>Đơn hàng của bạn đã được tạo thành công!</strong>
    </div>

    <table class="table table-bordered table-custom">
        <tr>
            <th>Thông tin đơn hàng:</th>
            <td>${orderInfo}</td>
        </tr>
        <tr>
            <th>Tổng tiền:</th>
            <td><fmt:formatNumber value="${amount}" type="number" groupingUsed="true" /> VND</td>
        </tr>
    </table>

    <div class="cod-info">
        Bạn đã chọn <strong>thanh toán khi nhận hàng</strong>. Vui lòng chuẩn bị tiền mặt khi nhận sản phẩm.
    </div>

    <div class="text-center btn-home">
        <a href="${pageContext.request.contextPath}/" class="btn">
            <i class="bi bi-house-door-fill"></i> Quay về trang chủ
        </a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
