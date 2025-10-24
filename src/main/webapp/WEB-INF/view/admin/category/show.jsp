<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục</title>
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
            <h1 class="mb-4 mt-4 text-center fw-bold">Quản lý danh mục</h1>

            <c:if test="${not empty flash.successMessage}">
                <div class="alert alert-success" role="alert">${flash.successMessage}</div>
            </c:if>
            <c:if test="${not empty flash.errorMessage}">
                <div class="alert alert-danger" role="alert">${flash.errorMessage}</div>
            </c:if>
            <c:if test="${not empty param.successMessage}">
                <div class="alert alert-success" role="alert">${param.successMessage}</div>
            </c:if>
            <c:if test="${not empty param.errorMessage}">
                <div class="alert alert-danger" role="alert">${param.errorMessage}</div>
            </c:if>

            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                <li class="breadcrumb-item active">Danh mục</li>
            </ol>

            <div class="mt-5">
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between">
                            <h3>Danh sách danh mục</h3>
                            <a href="/admin/category/create" class="btn btn-primary">
                                <i class="bi bi-plus-circle"></i> Thêm danh mục
                            </a>
                        </div>
                        <hr />
                        <table class="table table-bordered table-hover text-center">
                            <thead class="table-light">
                            <tr>
                                <th>STT</th>
                                <th>Tên danh mục</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="category" items="${categories}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${category.name}</td>
                                    <td>
                                        <a href="/admin/category/${category.id}" class="btn btn-success btn-sm">
                                            <i class="bi bi-eye"></i> Xem
                                        </a>
                                        <a href="/admin/category/update/${category.id}" class="btn btn-warning btn-sm mx-1">
                                            <i class="bi bi-pencil"></i> Sửa
                                        </a>
                                        <a href="/admin/category/delete/${category.id}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                            <i class="bi bi-trash"></i> Xóa
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
