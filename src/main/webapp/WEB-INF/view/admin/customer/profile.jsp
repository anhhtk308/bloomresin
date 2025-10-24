<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật thông tin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            const orgImage = "${newUser.avatar}";
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
<body class="sb-nav-fixed">
<div id="layoutSidenav">
    <div id="layoutSidenav_content">
        <jsp:include page="../layout/header.jsp" />
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Cập nhật thông tin cá nhân</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/customer">Trang khách hàng</a></li>
                    <li class="breadcrumb-item"><a href="/customer/user">Tài khoản</a></li>
                    <li class="breadcrumb-item active">Cập nhật</li>
                </ol>

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h3>Thông tin cá nhân</h3>
                    <a href="/customer/changepass" class="btn btn-primary">Đổi mật khẩu</a>
                </div>
                <hr />

                <div class="row">
                    <div class="col-md-6 mx-auto">
                        <form:form method="post" action="/customer/update" modelAttribute="newUser"
                                   enctype="multipart/form-data" class="row g-3">

                            <div class="text-center mb-3">
                                <img id="avatarPreview" alt="Ảnh đại diện"
                                     class="img-fluid rounded-circle"
                                     style="max-height: 250px; display: none;" />
                            </div>

                            <form:input type="hidden" path="id" />

                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <form:input path="email" class="form-control" disabled="true" />
                                <form:errors path="email" cssClass="invalid-feedback" />
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <form:input path="phone" class="form-control" />
                                <form:errors path="phone" cssClass="invalid-feedback" />
                            </div>

                            <div class="mb-3">
                                <label for="fullName" class="form-label">Họ và tên</label>
                                <form:input path="fullName" class="form-control" />
                                <form:errors path="fullName" cssClass="invalid-feedback" />
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">Địa chỉ</label>
                                <form:input path="address" class="form-control" />
                                <form:errors path="address" cssClass="invalid-feedback" />
                            </div>

                            <div class="mb-3">
                                <label for="avatarFile" class="form-label">Chọn ảnh đại diện</label>
                                <input type="file" id="avatarFile" class="form-control"
                                       name="imagesFile" accept=".png, .jpg, .jpeg" />
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-success">Lưu thay đổi</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
</html>
