<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa đánh giá</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap + Custom Style -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
        }

        h2, label {
            color: #6B1700;
        }

        .btn-primary {
            background-color: #CEAF95;
            border-color: #CEAF95;
            color: #6B1700;
        }

        .btn-primary:hover {
            background-color: #B5947D;
            border-color: #B5947D;
            color: white;
        }

        textarea.form-control {
            min-height: 150px;
        }
    </style>
</head>
<body>
<div class="container mt-5 mb-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="/order-history">Lịch sử đơn hàng</a></li>
            <li class="breadcrumb-item active" aria-current="page">Chỉnh sửa đánh giá</li>
        </ol>
    </nav>

    <div class="card shadow-sm p-4">
        <h2 class="mb-3">Chỉnh sửa đánh giá sản phẩm</h2>
        <p><strong>Sản phẩm:</strong> ${product.name}</p>
        <p><strong>Giá:</strong> <fmt:formatNumber value="${product.price}" type="number"/> đ</p>

        <form action="${pageContext.request.contextPath}/customer/update-review/${review.id}" method="post">
            <div class="mb-3">
                <label for="reviewContent" class="form-label">Nội dung đánh giá</label>
                <textarea id="reviewContent" name="reviewContent" class="form-control" required>${review.reviewContent}</textarea>
            </div>

            <div class="mb-3">
                <label for="rating" class="form-label">Đánh giá (1-5 sao)</label>
                <input type="number" id="rating" name="rating" value="${review.rating}" class="form-control" min="1" max="5" required>
            </div>

            <button type="submit" class="btn btn-primary">Cập nhật đánh giá</button>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
