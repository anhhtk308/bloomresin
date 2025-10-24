<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sản phẩm không khả dụng</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        .custom-main-content {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            min-height: 80vh;
            padding: 20px;
        }

        .custom-main-content h1 {
            font-family: 'Raleway', sans-serif;
            font-weight: 800;
            color: #6B1700;
            margin: 20px auto;
        }

        .custom-main-content p {
            font-size: 16px;
            color: #6B1700;
            margin-bottom: 20px;
        }

        .custom-main-content a.btn-back {
            display: inline-block;
            padding: 12px 25px;
            font-weight: 600;
            color: #fff;
            background-color: #CEAF95;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .custom-main-content a.btn-back:hover {
            background-color: #B5947D;
            color: #fff;
        }

        .custom-back-to-top {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            background-color: #CEAF95;
            border: 2px solid #B5947D;
            color: white;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .custom-back-to-top:hover {
            background-color: #B5947D;
            transform: scale(1.1);
        }
    </style>
</head>

<body>
<jsp:include page="../layout/header.jsp" />
<div class="custom-main-content">
    <h1>Sản phẩm không còn khả dụng</h1>
    <p>Sản phẩm bạn đang tìm kiếm đã bị ẩn hoặc không còn được bán.</p>
    <a href="/products" class="btn-back">Quay lại danh sách sản phẩm</a>
</div>
<jsp:include page="../layout/footer.jsp" />
<a href="#" class="custom-back-to-top"><i class="fas fa-arrow-up"></i></a>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/js/main.js"></script>
</body>
</html>
