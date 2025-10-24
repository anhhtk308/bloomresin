<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="BloomResin - Trang quản lý sản phẩm" />
    <meta name="author" content="Group 44" />
    <title>Chi tiết sản phẩm</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border: none;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            border-radius: 8px;
            max-height: 300px;
            object-fit: cover;
        }
    </style>
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />
        <div class="p-4">
            <h1 class="mt-4">Chi tiết sản phẩm</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                <li class="breadcrumb-item"><a href="/admin/product">Quản lý sản phẩm</a></li>
                <li class="breadcrumb-item active">Xem chi tiết</li>
            </ol>

            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="card mb-4">
                        <div class="card-header">
                            Thông tin sản phẩm
                        </div>
                        <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>Tên sản phẩm:</strong> ${newProduct.name}</li>
<%--                        <li class="list-group-item"><strong>Phân loại:</strong> ${newProduct.category.name}</li>--%>
                        </ul>
                    </div>
                    <a href="/admin/product" class="btn btn-success mt-3">Quay lại</a>
                </div>

                <div class="col-md-4">
                    <div class="card p-4">
                        <h4 class="text-center">Ảnh sản phẩm</h4>
                        <img class="product-image w-100" src="/images/product/${newProduct.image}" alt="Ảnh ${newProduct.name}" />
                    </div>
                </div>
            </div>
        </div>

        <footer>
            <div class="footer-content">
                <jsp:include page="../layout/footer.jsp" />
            </div>
        </footer>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
