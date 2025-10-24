<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Hồ Sơ khách hàng</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        h2 {
            font-weight: bold;
            color: #6B1700;
        }

        label {
            font-weight: 600;
            color: #6B1700;
        }

        .form-control:disabled {
            background-color: #f8f9fa;
            color: #6B1700;
        }

        .btn-primary {
            background-color: #6B1700;
            border-color: #6B1700;
            color: #FFF1D2;
        }

        .btn-primary:hover {
            background-color: #B5947D;
            border-color: #B5947D;
            color: #fff;
        }

        .btn-secondary {
            background-color: #CEAF95;
            border-color: #CEAF95;
            color: #fff;
        }

        .btn-secondary:hover {
            background-color: #B5947D;
            border-color: #B5947D;
            color: #fff;
        }

        .img-thumbnail {
            border: 2px solid #CEAF95;
        }

        .profile-wrapper {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 40px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="container-fluid py-4 mt-5">
    <div class="container profile-wrapper">
        <h2 class="mb-4 text-center">Hồ sơ khách hàng</h2>

        <div class="d-flex justify-content-end mb-3">
            <a href="/customer/changepass" class="btn btn-primary">Thay đổi mật khẩu</a>
        </div>

        <form:form method="post" action="/customer/profile/update" modelAttribute="newUser"
                   enctype="multipart/form-data"
                   class="w-100 d-flex flex-column align-items-center">
            <form:input path="id" type="hidden"/>

            <div class="mb-4 text-center">
                <c:choose>
                    <c:when test="${not empty newUser.avatar}">
                        <img id="avatarPreview" src="/images/avatar/${newUser.avatar}" class="img-thumbnail"
                             style="max-height: 250px; border-radius: 10px;"/>
                    </c:when>
                    <c:otherwise>
                        <img id="avatarPreview" src="/client/img/default-avatar.png" class="img-thumbnail"
                             style="max-height: 250px; border-radius: 10px;"/>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="mb-3 w-50">
                <label>Email:</label>
                <form:input path="email" class="form-control" disabled="true"/>
            </div>

            <div class="mb-3 w-50">
                <label>Số điện thoại:</label>
                <form:input path="phone" class="form-control" pattern="^0\\d{9}$" required="true"/>
            </div>

            <div class="mb-3 w-50">
                <label>Họ và tên:</label>
                <form:input path="fullName" class="form-control" pattern=".{3,}" required="true"/>
            </div>

            <div class="mb-3 w-50">
                <label>Địa chỉ:</label>
                <form:input path="address" class="form-control"/>
            </div>

            <div class="mb-4 w-50">
                <label>Ảnh đại diện:</label>
                <input type="file" id="avatarFile" name="imagesFile" class="form-control"
                       accept=".jpg,.jpeg,.png"/>
            </div>

            <div class="mb-3 w-50 d-flex justify-content-between">
                <button type="submit" class="btn btn-primary mb-2">Lưu thông tin</button>
                <a href="/" class="btn btn-secondary">Quay về trang chủ</a>
            </div>
        </form:form>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
    $(document).ready(function () {
        $("#avatarFile").change(function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    $('#avatarPreview').attr('src', e.target.result);
                };
                reader.readAsDataURL(file);
            }
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
