<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thành công</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            font-family: 'Open Sans', sans-serif;
            color: #6B1700;
            padding-top: 100px;
        }
        .content-container {
            max-width: 650px;
            margin: auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            text-align: center;
        }
        .content-container h1 {
            color: #28a745;
            font-weight: bold;
        }
        .btn-custom {
            background-color: #CEAF95;
            color: white;
            border: none;
        }
        .btn-custom:hover {
            background-color: #6B1700;
            color: white;
        }
        .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container py-5">
    <div class="content-container">
        <h1><i class="bi bi-check-circle-fill me-2"></i>Thanh toán thành công</h1>
        <h4 class="my-3">Chi tiết đơn hàng</h4>
        <table class="table table-bordered text-start">
            <tbody>
            <tr>
                <td><strong>Thông tin đơn hàng:</strong></td>
                <td><c:out value="${orderInfo}" default="[Không có thông tin đơn hàng]"/></td>
            </tr>
            <tr>
                <td><strong>Tiền thanh toán:</strong></td>
                <td><fmt:formatNumber type="number" value="${amount}" groupingUsed="true"/> VND</td>
            </tr>
            <tr>
                <td><strong>Thời gian thanh toán:</strong></td>
                <td><c:out value="${paymentTime}" default="[Không có thời gian thanh toán]"/></td>
            </tr>
            <tr>
                <td><strong>Mã giao dịch:</strong></td>
                <td><c:out value="${transactionId}" default="[Không có mã giao dịch]"/></td>
            </tr>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/order-history" class="btn btn-custom mt-3">
            <i class="bi bi-clock-history me-1"></i> Quay lại lịch sử mua hàng
        </a>
    </div>
</div>
<jsp:include page="../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
