<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Cập nhật sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#productFile");
            const orgImage = "${newProduct.image}";
            if (orgImage) {
                const urlImage = "/images/product/" + orgImage;
                $("#productPreview").attr("src", urlImage).css("display", "block");
            }
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#productPreview").attr("src", imgURL).css("display", "block");
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
                    <li class="breadcrumb-item"><a href="/admin">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="/admin/product">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Cập nhật sản phẩm</h3>
                            <hr />
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <form:form method="post" action="/admin/product/update" class="row"
                                       enctype="multipart/form-data" modelAttribute="newProduct">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <form:input type="hidden" path="id" />

                                <div class="mb-3 col-md-6">
                                    <label class="form-label">Tên sản phẩm:</label>
                                    <form:input type="text" path="name" class="form-control"
                                                required="true" minlength="4" maxlength="255"
                                                oninvalid="this.setCustomValidity('Tên sản phẩm phải có ít nhất 4 ký tự')"
                                                oninput="this.setCustomValidity('')" />
                                    <form:errors path="name" cssClass="text-danger" />
                                </div>

                                <div class="mb-3 col-md-6">
                                    <label class="form-label">Giá (VND):</label>
                                    <form:input type="number" path="price" class="form-control"
                                                required="true" min="1001"
                                                oninvalid="this.setCustomValidity('Giá sản phẩm phải lớn hơn 1000 VNĐ')"
                                                oninput="this.setCustomValidity('')" />
                                    <form:errors path="price" cssClass="text-danger" />
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label">Mô tả chi tiết:</label>
                                    <form:textarea path="detailDesc" class="form-control" maxlength="255"
                                                   oninput="if(this.value.length > 255) this.value = this.value.slice(0,255);" />
                                </div>

                                <div class="mb-3 col-md-6">
                                    <label class="form-label">Mô tả ngắn:</label>
                                    <form:input path="shortDesc" class="form-control" maxlength="255"
                                                oninput="if(this.value.length > 255) this.value = this.value.slice(0,255);" />
                                </div>

                                <div class="mb-3 col-md-6">
                                    <label class="form-label">Số lượng:</label>
                                    <form:input type="number" path="quantity" class="form-control" min="0" />
                                </div>

                                <div class="mb-3 col-md-6">
                                    <label class="form-label">Phân loại:</label>
                                    <form:select path="category.name" class="form-select">
                                        <c:forEach var="category" items="${categories}">
                                            <form:option value="${category.name}">${category.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </div>

                                <div class="mb-3 col-md-6">
                                    <label for="productFile" class="form-label">Ảnh sản phẩm:</label>
                                    <input class="form-control" type="file" id="productFile"
                                           accept=".png, .jpg, .jpeg" name="productFile" />
                                </div>

                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" id="productPreview" alt="Xem trước ảnh sản phẩm" />
                                </div>

                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                                    <a href="/admin/product" class="btn btn-secondary ms-2">Quay lại</a>
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
