<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Nhóm 7 - Dự án BloomResin" />
    <meta name="author" content="Nhóm 7" />
    <title>Cập nhật khách hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            const orgImage = "${newCustomer.avatar}";
            if (orgImage) {
                const urlImage = "/images/avatar/" + orgImage;
                $("#avatarPreview").attr("src", urlImage).show();
            }
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL).show();
            });
        });
    </script>
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />
        <div class="p-4">
            <h1 class="mt-4">Cập nhật khách hàng</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                <li class="breadcrumb-item"><a href="/admin/user">Khách hàng</a></li>
                <li class="breadcrumb-item active">Cập nhật</li>
            </ol>

            <div class="mt-5">
                <div class="row">
                    <div class="col-md-6 col-12 mx-auto">
                        <h3>Thông tin khách hàng</h3>
                        <hr />
                        <form:form method="post" action="/admin/customer/update"
                                   modelAttribute="newCustomer" class="row" enctype="multipart/form-data">

                            <form:input type="hidden" path="id" />

                            <div class="mb-3 col-12 col-md-6">
                                <c:set var="errorEmail">
                                    <form:errors path="email" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label">Email:</label>
                                <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid' : ''}"
                                            path="email" disabled="true" />
                                    ${errorEmail}
                            </div>

                            <div class="mb-3 col-12 col-md-6">
                                <label class="form-label">Số điện thoại:</label>
                                <form:input type="text" class="form-control" path="phone" />
                            </div>

                            <div class="mb-3 col-12 col-md-6">
                                <c:set var="errorFullName">
                                    <form:errors path="fullName" cssClass="invalid-feedback" />
                                </c:set>
                                <label class="form-label">Họ và tên:</label>
                                <form:input type="text" class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                            path="fullName" />
                                    ${errorFullName}
                            </div>

                            <div class="mb-3 col-12">
                                <label class="form-label">Địa chỉ:</label>
                                <form:input type="text" class="form-control" path="address" />
                            </div>

                            <div class="mb-3 col-12 col-md-6">
                                <label for="avatarFile" class="form-label">Ảnh đại diện:</label>
                                <input class="form-control" type="file" id="avatarFile"
                                       accept=".png, .jpg, .jpeg" name="imagesFile" />
                            </div>

                            <div class="col-12 mb-3">
                                <img style="max-height: 250px; display: none;" alt="Xem trước ảnh"
                                     id="avatarPreview" class="img-thumbnail" />
                            </div>

                            <div class="col-12 mb-5">
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            </div>

                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
</body>
</html>
