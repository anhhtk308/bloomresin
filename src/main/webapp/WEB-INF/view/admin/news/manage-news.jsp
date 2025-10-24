<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Tin Tức</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
    <style>
        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }
    </style>
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />

        <div class="p-4">
            <h1 class="mb-4 mt-4 text-center fw-bold text-primary">📢 Quản Lý Tin Tức</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang Quản Trị</a></li>
                <li class="breadcrumb-item active">Tin Tức</li>
            </ol>
            <div class="mt-5">
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between">
                            <h3>Danh sách tin tức</h3>
                            <a href="/admin/news/create" class="btn btn-primary">+ Thêm Tin Mới</a>
                        </div>
                        <hr />
                        <c:if test="${not empty message}">
                            <div class="alert alert-success" role="alert">
                                    ${message}
                            </div>
                        </c:if>
                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead>
                            <tr>
                                <th>Tiêu đề</th>
                                <th>Hình ảnh</th>
                                <th>Hiển thị</th>
                                <th>Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="news" items="${newsList}">
                                <tr>
                                    <td>${news.title}</td>
                                    <td>
                                        <img src="${news.imageUrl}" alt="Ảnh tin tức" style="max-width: 100px; max-height: 60px;">
                                    </td>
                                    <td>
                                        <form action="/admin/news/toggle-status/${news.id}" method="get">
                                            <label class="switch">
                                                <input type="checkbox" name="status" onchange="this.form.submit()"
                                                       <c:if test="${news.status}">checked</c:if> />
                                                <span class="slider"></span>
                                            </label>
                                        </form>
                                    </td>
                                    <td>
                                        <a href="/admin/news/detail/${news.id}" class="btn btn-success btn-sm">Xem</a>
                                        <a href="/admin/news/update/${news.id}" class="btn btn-warning btn-sm mx-1">Sửa</a>
                                        <a href="/admin/news/delete/${news.id}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa tin tức này không?');">
                                            Xóa
                                        </a>
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
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
