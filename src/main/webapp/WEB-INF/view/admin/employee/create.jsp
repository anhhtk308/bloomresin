<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Nhóm 4 - Dự án BloomResin" />
    <meta name="author" content="Nhóm 4" />
    <title>Thêm nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL).css("display", "block");
            });
        });
    </script>
</head>
<body class="sb-nav-fixed">
<div class="d-flex">
    <div class="sidebar bg-light" style="width: 250px;">
        <jsp:include page="../layout/navbar.jsp" />
    </div>
    <div id="layoutSidenav">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Thêm nhân viên</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                        <li class="breadcrumb-item"><a href="/admin/employee">Nhân viên</a></li>
                        <li class="breadcrumb-item active">Thêm</li>
                    </ol>

                    <div class="mt-5">
                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h3>Thông tin nhân viên</h3>
                                <hr />

                                <c:if test="${not empty message}">
                                    <div class="alert alert-danger" role="alert">${message}</div>
                                </c:if>

                                <form:form method="post" action="/admin/employee/create"
                                           modelAttribute="newEmployee" class="row" enctype="multipart/form-data">

                                    <div class="mb-3 col-12 col-md-6">
                                        <c:set var="errorEmail">
                                            <form:errors path="email" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label class="form-label">Email:</label>
                                        <form:input type="email" class="form-control ${not empty errorEmail ? 'is-invalid' : ''}" path="email" />
                                            ${errorEmail}
                                    </div>

                                    <div class="mb-3 col-12 col-md-6">
                                        <c:set var="errorPassword">
                                            <form:errors path="password" cssClass="invalid-feedback" />
                                        </c:set>
                                        <label class="form-label">Mật khẩu:</label>
                                        <form:input type="password" class="form-control ${not empty errorPassword ? 'is-invalid' : ''}" path="password" />
                                            ${errorPassword}
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
                                        <form:input type="text" class="form-control ${not empty errorFullName ? 'is-invalid' : ''}" path="fullName" />
                                            ${errorFullName}
                                    </div>

                                    <div class="mb-3 col-12">
                                        <label class="form-label">Địa chỉ:</label>
                                        <form:input type="text" class="form-control" path="address" />
                                    </div>

                                    <div class="mb-3 col-12 col-md-6" style="display: none;">
                                        <label class="form-label">Vai trò:</label>
                                        <form:select class="form-select" path="role.name">
                                            <form:option value="EMPLOYEE">EMPLOYEE</form:option>
                                        </form:select>
                                    </div>

                                    <div class="mb-3 col-12 col-md-6">
                                        <label for="avatarFile" class="form-label">Ảnh đại diện:</label>
                                        <input class="form-control" type="file" id="avatarFile" accept=".png, .jpg, .jpeg" name="imagesFile" />
                                    </div>

                                    <div class="col-12 mb-3">
                                        <img style="max-height: 250px; display: none;" alt="Xem trước ảnh" id="avatarPreview" class="img-thumbnail" />
                                    </div>

                                    <div class="col-12 mb-5">
                                        <button type="submit" class="btn btn-primary">Tạo nhân viên</button>
                                    </div>

                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
