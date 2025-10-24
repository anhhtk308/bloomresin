<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thất bại</title>
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
        }
        .alert-custom {
            background-color: #f8d7da;
            border: 1px solid #f5c2c7;
            color: #842029;
            font-size: 20px;
            padding: 25px;
            border-radius: 10px;
        }
        .btn-cart {
            margin-top: 20px;
            background-color: #CEAF95;
            border-color: #CEAF95;
            color: white;
        }
        .btn-cart:hover {
            background-color: #6B1700;
            border-color: #6B1700;
            color: white;
        }
    </style>
</head>

<body>
<jsp:include page="../layout/header.jsp" />

<div class="container" style="margin-top: 120px; min-height: 300px;">
    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <div class="alert alert-custom" role="alert">
                <i class="bi bi-x-circle-fill me-2"></i>
                Đơn hàng của bạn <strong>thanh toán không thành công</strong>. Vui lòng thử lại sau.
            </div>

            <a href="${pageContext.request.contextPath}/cart" class="btn btn-cart">
                <i class="bi bi-arrow-left-circle-fill"></i> Quay lại giỏ hàng
            </a>
        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
<script>
    setTimeout(function () {
        window.location.href = "${pageContext.request.contextPath}/cart";
    }, 5000);
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
