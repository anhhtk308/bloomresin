<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Group 3 - Dự án BloomResin" />
    <meta name="author" content="Group 3" />
    <title>Thêm sản phẩm</title>

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script>
        $(document).ready(() => {
            const avatarFile = $("#productFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#productPreview").attr("src", imgURL).css({ "display": "block" });
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
                    <li class="breadcrumb-item"><a href="/employee/product">Trang quản trị</a></li>
                    <li class="breadcrumb-item"><a href="/employee/product">Sản phẩm</a></li>
                    <li class="breadcrumb-item active">Tạo sản phẩm</li>
                </ol>

                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Thêm sản phẩm mới</h3>
                            <hr />

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger">${error}</div>
                            </c:if>

                            <form:form method="post" action="/employee/product/create"
                                       enctype="multipart/form-data" modelAttribute="newProduct" class="row">
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Tên sản phẩm:</label>
                                    <form:input type="text" path="name" class="form-control" required="true"
                                                minlength="4"
                                                oninvalid="this.setCustomValidity('Tên phải ít nhất 4 ký tự')"
                                                oninput="this.setCustomValidity('')" />
                                    <form:errors path="name" cssClass="text-danger" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Giá (VND):</label>
                                    <form:input type="number" path="price" class="form-control" required="true" min="1001"
                                                oninvalid="this.setCustomValidity('Giá phải lớn hơn 1000 VND')"
                                                oninput="this.setCustomValidity('')" />
                                    <form:errors path="price" cssClass="text-danger" />
                                </div>

                                <div class="mb-3 col-12">
                                    <label class="form-label">Mô tả chi tiết:</label>
                                    <form:textarea class="form-control" path="detailDesc" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Mô tả ngắn:</label>
                                    <form:input type="text" class="form-control" path="shortDesc" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Số lượng:</label>
                                    <form:input type="number" class="form-control" path="quantity" />
                                </div>

<%--                                <div class="mb-3 col-12 col-md-6">--%>
<%--                                    <label class="form-label">Nhà sản xuất:</label>--%>
<%--                                    <form:select class="form-select" path="factory">--%>
<%--                                        <form:option value="BANDAINAMCO">Lego</form:option>--%>
<%--                                        <form:option value="MR-HOBBY">Lego X Adidas</form:option>--%>
<%--                                        <form:option value="None">IKEA</form:option>--%>
<%--                                    </form:select>--%>
<%--                                </div>--%>

                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Phân loại:</label>
                                    <form:select class="form-select" path="category.name">
                                        <c:forEach var="category" items="${categories}">
                                            <form:option value="${category.name}">${category.name}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </div>

<%--                                <div class="mb-3 col-12 col-md-6">--%>
<%--                                    <label class="form-label">Đối tượng sử dụng:</label>--%>
<%--                                    <form:select class="form-select" path="target">--%>
<%--                                        <form:option value="Lego">Lego</form:option>--%>
<%--                                        <form:option value="LEGO Accessories & Expansion Sets">Phụ kiện & Mở rộng</form:option>--%>
<%--                                        <form:option value="LEGO Tools & Utilities">Công cụ LEGO</form:option>--%>
<%--                                        <form:option value="Instructions & Ideas">Hướng dẫn & Ý tưởng</form:option>--%>
<%--                                        <form:option value="Tools">Dụng cụ</form:option>--%>
<%--                                    </form:select>--%>
<%--                                </div>--%>

                                <div class="mb-3 col-12 col-md-6">
                                    <label for="productFile" class="form-label">Hình ảnh:</label>
                                    <input class="form-control" type="file" id="productFile"
                                           accept=".png, .jpg, .jpeg" name="productFile" />
                                </div>

                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="Xem trước hình ảnh"
                                         id="productPreview" />
                                </div>

                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-primary">Tạo sản phẩm</button>
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
