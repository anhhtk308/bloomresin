<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Cập nhật nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            const orgImage = "${newEmployee.avatar}";
            if (orgImage) {
                $("#avatarPreview").attr("src", "/images/avatar/" + orgImage).show();
            }

            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL).show();
            });
        });
    </script>
</head>

<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div class="d-flex">
        <div class="sidebar bg-light" style="min-height:100vh;">
            <jsp:include page="../layout/navbar.jsp" />
        </div>

        <div class="main-content p-0">
            <jsp:include page="../layout/header.jsp" />
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Cập nhật nhân viên</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                            <li class="breadcrumb-item"><a href="/admin/employee">Nhân viên</a></li>
                            <li class="breadcrumb-item active">Cập nhật</li>
                        </ol>

                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h3>Thông tin nhân viên</h3>
                                <hr />
                                <form:form method="post" action="/admin/employee/update"
                                           modelAttribute="newEmployee" class="row" enctype="multipart/form-data">
                                    <form:input path="id" type="hidden" />

                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Email:</label>
                                        <form:input path="email" class="form-control" disabled="true" />
                                        <form:errors path="email" cssClass="invalid-feedback" />
                                    </div>

                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Số điện thoại:</label>
                                        <form:input path="phone" class="form-control" pattern="^0\\d{9}$"
                                                    title="Số điện thoại phải bắt đầu bằng số 0 và gồm 10 chữ số" required="true" />
                                    </div>

                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Họ và tên:</label>
                                        <form:input path="fullName"
                                                    class="form-control ${not empty errorFullName ? 'is-invalid' : ''}"
                                                    minlength="4" title="Họ tên phải có ít nhất 4 ký tự" required="true" />
                                        <form:errors path="fullName" cssClass="invalid-feedback" />
                                    </div>

                                    <div class="mb-3 col-12">
                                        <label class="form-label">Địa chỉ:</label>
                                        <form:input path="address" class="form-control" />
                                    </div>

                                    <div class="mb-3 col-12 col-md-6">
                                        <label class="form-label">Ảnh đại diện:</label>
                                        <input type="file" class="form-control" id="avatarFile"
                                               accept=".png,.jpg,.jpeg" name="imagesFile" />
                                    </div>

                                    <div class="col-12 mb-3">
                                        <img id="avatarPreview" style="max-height: 250px; display: none;" alt="Xem trước ảnh đại diện"
                                             class="img-thumbnail" />
                                    </div>

                                    <div class="col-12 mb-4">
                                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                        <a href="/admin/employee" class="btn btn-secondary">Hủy</a>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
