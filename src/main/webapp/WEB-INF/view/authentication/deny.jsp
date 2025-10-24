<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>403 - Không có quyền truy cập</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        .error-container {
            margin-top: 10vh;
            padding: 40px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .error-code {
            font-size: 6rem;
            font-weight: 800;
            color: #6B1700;
        }

        .btn-bloom {
            background-color: #CEAF95;
            color: #6B1700;
            border: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-bloom:hover {
            background-color: #B5947D;
            color: #fff;
        }

        .icon {
            font-size: 4rem;
            color: #CEAF95;
        }
    </style>
</head>
<body>
<div class="container error-container text-center">
    <div class="icon mb-3"><i class="fas fa-ban"></i></div>
    <div class="error-code">403</div>
    <h3 class="mb-3">Bạn không có quyền truy cập vào tài nguyên này.</h3>
    <p class="mb-4">Vui lòng kiểm tra lại tài khoản của bạn hoặc quay về trang chủ.</p>
    <a href="${pageContext.request.contextPath}/" class="btn btn-bloom px-4 py-2"><i class="fas fa-home me-1"></i>Trang chủ</a>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
