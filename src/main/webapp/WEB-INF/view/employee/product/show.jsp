<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>

<body>
    <div class="container-fluid d-flex p-0">
        <jsp:include page="../layout/navbar.jsp" />

        <!-- Main Content -->
        <div class="main-content p-0">
            <jsp:include page="../layout/header.jsp" />

            <div class="p-4">
                <h1 class="mb-4 mt-4 text-center" style="font-weight: bold;">Quản lý sản phẩm</h1>

                <!-- Search Bar -->
                <div class="search-bar mb-4">
                    <form method="GET" action="/employee/product/search" class="d-flex align-items-stretch" style="max-width: 600px;">
                        <input type="text" name="keyword"
                               placeholder="Tìm theo tên hoặc phân loại"
                               class="form-control me-2"
                               style="flex: 1 1 auto; max-width: 400px; height: 45px;">
                        <button type="submit" class="btn btn-primary" style="height: 45px;">Tìm kiếm</button>
                    </form>
                </div>

                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">Sản phẩm</li>
                </ol>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-12 mx-auto">
                            <div class="d-flex justify-content-between">
                                <h3>Bảng sản phẩm</h3>
                                <a href="/employee/product/create" class="btn btn-primary">Tạo sản phẩm mới</a>
                            </div>

                            <hr />
                            <table class="table table-bordered table-hover align-middle text-center">
                                <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Tên</th>
                                    <th>Giá</th>
                                    <th>Danh mục</th>
                                    <th>Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="product" items="${products}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${product.name}</td>
                                        <td>
                                            <fmt:formatNumber type="number" value="${product.price}" /> đ
                                        </td>
                                        <td>${product.category.name}</td>
                                        <td>
                                            <a href="/employee/product/${product.id}" class="btn btn-success">Xem</a>
                                            <a href="/employee/product/update/${product.id}" class="btn btn-warning mx-2">Sửa</a>
                                            <a href="/employee/product/delete/${product.id}"
                                               class="btn btn-danger btn-sm"
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')">
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

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>