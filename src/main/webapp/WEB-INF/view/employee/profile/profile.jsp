<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/ewstyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body>
<div class="container-fluid d-flex p-0">
    <!-- Sidebar -->
    <jsp:include page="../layout/navbar.jsp" />

    <!-- Main Content -->
    <div class="main-content p-0">
        <!-- Header -->
        <jsp:include page="../layout/header.jsp" />

        <!-- Page Content -->
        <div class="p-4">
            <h2 class="mb-4 text-center">Hồ sơ nhân viên</h2>
            <div class="d-flex justify-content-end align-items-center">
                <a href="/employee/changepass" class="btn btn-primary">Thay đổi mật khẩu</a>
            </div>

            <form:form method="post" action="/employee/profile/update" modelAttribute="newUser" enctype="multipart/form-data" class="w-100 d-flex flex-column align-items-center">
                <form:input path="id" type="hidden" />

                <div class="mb-3 text-center">
                    <c:choose>
                        <c:when test="${not empty newUser.avatar}">
                            <img id="avatarPreview" src="/images/avatar/${newUser.avatar}" class="img-thumbnail" style="max-height: 250px; border-radius: 10px;" />
                        </c:when>
                        <c:otherwise>
                            <img id="avatarPreview" src="/client/img/default-avatar.png" class="img-thumbnail" style="max-height: 250px; border-radius: 10px;" />
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="mb-3 w-50">
                    <label>Email:</label>
                    <form:input path="email" class="form-control" disabled="true" />
                </div>

                <div class="mb-3 w-50">
                    <label>Số điện thoại:</label>
                    <form:input path="phone" class="form-control" pattern="^0\\d{9}$" required="true" />
                </div>

                <div class="mb-3 w-50">
                    <label>Họ và tên:</label>
                    <form:input path="fullName" class="form-control" pattern=".{3,}" required="true" />
                </div>

                <div class="mb-3 w-50">
                    <label>Địa chỉ:</label>
                    <form:input path="address" class="form-control" />
                </div>

                <div class="mb-3 w-50">
                    <label>Ảnh đại diện:</label>
                    <input type="file" id="avatarFile" name="imagesFile" class="form-control" accept=".jpg,.jpeg,.png" />
                </div>

                <div class="mb-3 w-50 d-grid">
                    <button type="submit" class="btn btn-primary">Lưu thông tin</button>
                </div>
            </form:form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $("#avatarFile").change(function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    $('#avatarPreview').attr('src', e.target.result);
                }
                reader.readAsDataURL(file);
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
