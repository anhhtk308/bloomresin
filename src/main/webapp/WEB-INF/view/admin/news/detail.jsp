<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Chi Tiết Tin Tức</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="/css/ewstyle.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border: none;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .card-img-top {
            max-height: 400px;
            object-fit: cover;
            border-radius: 8px;
        }

        .card-header {
            background-color: #007bff;
            color: white;
            font-weight: bold;
        }
    </style>
</head>

<body class="sb-nav-fixed">
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0 w-100">
        <jsp:include page="../layout/header.jsp" />
        <div class="p-4">
            <h1 class="mt-4">Chi Tiết Tin Tức</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang Quản Trị</a></li>
                <li class="breadcrumb-item"><a href="/admin/news">Quản Lý Tin Tức</a></li>
                <li class="breadcrumb-item active">Xem Chi Tiết</li>
            </ol>

            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card mb-4 p-3">
                        <h4 class="text-primary mb-3">${news.title}</h4>

                        <img src="${news.imageUrl}" class="card-img-top mb-4" alt="${news.title}" />

                        <div class="card-header">Thông Tin Bài Viết</div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>Tiêu đề:</strong> ${news.title}</li>
                            <li class="list-group-item"><strong>Nội dung:</strong> ${news.content}</li>
                        </ul>

                        <div class="text-end mt-4">
                            <a href="/admin/news" class="btn btn-success"><i class="bi bi-arrow-left"></i> Quay lại danh sách</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
