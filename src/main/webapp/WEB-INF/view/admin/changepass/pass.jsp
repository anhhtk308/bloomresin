<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>
<body class="sb-nav-fixed">
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Đổi mật khẩu</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin/user">Bảng điều khiển</a></li>
                        <li class="breadcrumb-item"><a href="/admin/profile/${id}">Hồ sơ người dùng</a></li>
                        <li class="breadcrumb-item active">Đổi mật khẩu</li>
                    </ol>

                    <div class="mt-5">
                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h3>Cập nhật mật khẩu</h3>
                                <hr />
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success" role="alert">${successMessage}</div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger" role="alert">${errorMessage}</div>
                                </c:if>

                                <form:form method="post" action="/admin/changepass"
                                           modelAttribute="passwordChangeForm" class="row">
                                    <div class="mb-3 col-12 position-relative">
                                        <label class="form-label">Mật khẩu hiện tại:</label>
                                        <form:input id="currentPassword" type="password" path="currentPassword"
                                                    class="form-control ${not empty errorCurrentPass ? 'is-invalid' : ''}" />
                                        <form:errors path="currentPassword" cssClass="invalid-feedback" />
                                        <i class="bi bi-eye-slash position-absolute top-50 me-2"
                                           id="toggleCurrentPassword" style="cursor: pointer; right: 1rem;"></i>
                                    </div>

                                    <div class="mb-3 col-12 position-relative">
                                        <label class="form-label">Mật khẩu mới:</label>
                                        <form:input id="newPassword" type="password" path="newPassword"
                                                    class="form-control ${not empty errorNewPass ? 'is-invalid' : ''}" />
                                        <form:errors path="newPassword" cssClass="invalid-feedback" />
                                        <i class="bi bi-eye-slash position-absolute top-50 me-2"
                                           id="toggleNewPassword" style="cursor: pointer; right: 1rem;"></i>
                                    </div>

                                    <div class="mb-3 col-12 position-relative">
                                        <label class="form-label">Xác nhận mật khẩu mới:</label>
                                        <form:input id="confirmPassword" type="password" path="confirmPassword"
                                                    class="form-control ${not empty errorConfirmPass ? 'is-invalid' : ''}" />
                                        <form:errors path="confirmPassword" cssClass="invalid-feedback" />
                                        <i class="bi bi-eye-slash position-absolute top-50 me-2"
                                           id="toggleConfirmPassword" style="cursor: pointer; right: 1rem;"></i>
                                    </div>

                                    <div class="col-12 mb-5">
                                        <button type="submit" class="btn btn-primary">Đổi mật khẩu</button>
                                        <a href="/admin/profile/${id}" class="btn btn-secondary">Quay lại</a>
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

<div class="modal fade" id="passwordChangeSuccessModal" tabindex="-1"
     aria-labelledby="passwordChangeSuccessModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Đổi mật khẩu thành công</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"
                        aria-label="Đóng"></button>
            </div>
            <div class="modal-body">
                Mật khẩu của bạn đã được thay đổi thành công. Vui lòng đăng nhập lại bằng mật khẩu mới.
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="redirectToLogin">OK</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePasswordVisibility(passwordFieldId, toggleButtonId) {
        document.getElementById(toggleButtonId).addEventListener('click', function () {
            const passwordField = document.getElementById(passwordFieldId);
            const type = passwordField.type === 'password' ? 'text' : 'password';
            passwordField.type = type;
            this.classList.toggle('bi-eye');
            this.classList.toggle('bi-eye-slash');
        });
    }

    togglePasswordVisibility('currentPassword', 'toggleCurrentPassword');
    togglePasswordVisibility('newPassword', 'toggleNewPassword');
    togglePasswordVisibility('confirmPassword', 'toggleConfirmPassword');

    window.addEventListener('load', function () {
        const successMessage = '${successMessage}';
        if (successMessage) {
            const myModal = new bootstrap.Modal(document.getElementById('passwordChangeSuccessModal'), {
                keyboard: false
            });
            myModal.show();
        }
    });

    document.getElementById("redirectToLogin").addEventListener('click', function () {
        window.location.href = '/admin/profile/${id}';
    });
</script>
</body>
</html>
