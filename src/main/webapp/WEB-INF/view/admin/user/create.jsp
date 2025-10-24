<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <title>Thêm Khách Hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/styles.css">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL).show();
            });
        });
    </script>
    <style>
        .text-danger {
            font-size: 0.875em;
            color: #dc3545;
        }
        input:invalid:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
    </style>
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />
        <div class="p-4">
            <h1 class="mb-4 mt-2 text-center fw-bold">Thêm Khách Hàng Mới</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                <li class="breadcrumb-item"><a href="/admin/customer">Quản lý khách hàng</a></li>
                <li class="breadcrumb-item active">Thêm mới</li>
            </ol>

            <div class="row">
                <div class="col-md-6 col-12 mx-auto">
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>

                    <form:form method="post" action="/admin/customer/create"
                               modelAttribute="newCustomer"
                               enctype="multipart/form-data"
                               class="row g-3">
                        <form:input type="hidden" path="id"/>

                        <div class="col-md-6">
                            <label class="form-label">Email:</label>
                            <form:input type="email" class="form-control" path="email"
                                        required="true"
                                        pattern="[a-zA-Z0-9._%+-]+@gmail\.com"
                                        oninvalid="this.setCustomValidity('Email phải hợp lệ, ví dụ: example@gmail.com')"
                                        oninput="this.setCustomValidity('')" />
                            <form:errors path="email" cssClass="text-danger" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Mật khẩu:</label>
                            <form:input type="password" class="form-control" path="password"
                                        required="true" minlength="6"
                                        oninvalid="this.setCustomValidity('Mật khẩu tối thiểu 6 ký tự')"
                                        oninput="this.setCustomValidity('')" />
                            <form:errors path="password" cssClass="text-danger" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Số điện thoại:</label>
                            <form:input type="tel" class="form-control" path="phone"
                                        required="true" pattern="0[0-9]{9}"
                                        oninvalid="this.setCustomValidity('Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số')"
                                        oninput="this.setCustomValidity('')" />
                            <form:errors path="phone" cssClass="text-danger" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Họ và tên:</label>
                            <form:input type="text" class="form-control" path="fullName"
                                        required="true" minlength="3"
                                        oninvalid="this.setCustomValidity('Họ tên phải có ít nhất 3 ký tự')"
                                        oninput="this.setCustomValidity('')" />
                            <form:errors path="fullName" cssClass="text-danger" />
                        </div>

                        <div class="col-12">
                            <label class="form-label">Địa chỉ:</label>
                            <form:input type="text" class="form-control" path="address" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Ảnh đại diện:</label>
                            <input class="form-control" type="file" id="avatarFile"
                                   accept=".png, .jpg, .jpeg" name="imagesFile" />
                        </div>

                        <div class="col-12 text-center">
                            <img id="avatarPreview" alt="Xem trước ảnh" style="max-height: 250px; display: none;" />
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Nhập file Excel:</label>
                            <input class="form-control" type="file" id="excelFile"
                                   accept=".xls, .xlsx" name="excelFile" />
                        </div>

                        <div class="col-12 text-center mt-4">
                            <button type="submit" class="btn btn-primary">Tạo khách hàng</button>
                            <a href="/admin/customer" class="btn btn-secondary ms-2">Quay lại</a>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
