<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Thêm sản phẩm</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            $("#productFile").change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#productPreview").attr("src", imgURL).show();
            });
        });
    </script>
</head>

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Trang quản trị</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Bảng điều khiển</a></li>
                    <li class="breadcrumb-item"><a href="/admin/product">Quản lý sản phẩm</a></li>
                    <li class="breadcrumb-item active">Thêm mới</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Thêm sản phẩm mới</h3>
                            <hr />
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>
                            <form:form method="post" action="/admin/product/create" modelAttribute="newProduct"
                                       enctype="multipart/form-data" class="row">

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Tên sản phẩm:</label>
                                    <form:input path="name" class="form-control" required="true" minlength="4"
                                                oninvalid="this.setCustomValidity('Tên sản phẩm phải ít nhất 4 ký tự')"
                                                oninput="this.setCustomValidity('')" />
                                    <form:errors path="name" cssClass="text-danger" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Giá bán (VNĐ):</label>
                                    <form:input path="price" class="form-control" type="number" min="1001"
                                                required="true"
                                                oninvalid="this.setCustomValidity('Giá phải lớn hơn 1000 VNĐ')"
                                                oninput="this.setCustomValidity('')" />
                                    <form:errors path="price" cssClass="text-danger" />
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label">Mô tả chi tiết:</label>
                                    <form:textarea path="detailDesc" class="form-control" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Mô tả ngắn:</label>
                                    <form:input path="shortDesc" class="form-control" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Số lượng:</label>
                                    <form:input path="quantity" class="form-control" type="number" min="0" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Phân loại:</label>
                                    <form:select path="category.id" class="form-select">
                                        <c:forEach var="category" items="${categories}">
                                            <form:option value="${category.id}">${category.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label for="productFile" class="form-label">Ảnh sản phẩm:</label>
                                    <input class="form-control" type="file" id="productFile"
                                           name="productFile" accept=".png,.jpg,.jpeg" />
                                </div>

                                <div class="col-12 mb-3">
                                    <img id="productPreview" alt="Xem trước ảnh" style="max-height: 250px; display: none;" />
                                </div>

                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                                </div>

                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
