<%@ page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Đổi mật khẩu</title>
    <link rel="icon" type="image/png" href="../../images/icon-logo.png" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet"/>
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet"/>
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/client/css/style.css" rel="stylesheet" />
    <style>
      body {
        background-color: #FFF1D2;
        color: #6B1700;
        font-family: 'Open Sans', sans-serif;
      }

      h1, h3, label {
        color: #6B1700;
        font-family: 'Raleway', sans-serif;
        font-weight: 600;
      }

      .breadcrumb-item a {
        color: #6B1700;
        text-decoration: underline;
      }

      .breadcrumb-item.active {
        color: #6B1700;
        font-weight: bold;
      }

      .form-control {
        border: 1px solid #CEAF95;
      }

      .form-control:focus {
        border-color: #6B1700;
        box-shadow: 0 0 0 0.2rem rgba(107, 23, 0, 0.25);
      }

      .btn-primary {
        background-color: #6B1700;
        border-color: #6B1700;
        color: #FFF1D2;
      }

      .btn-primary:hover {
        background-color: #CEAF95;
        color: #6B1700;
        border-color: #CEAF95;
      }

      .btn-secondary {
        background-color: #CEAF95;
        color: #6B1700;
        border-color: #CEAF95;
      }

      .btn-secondary:hover {
        background-color: #6B1700;
        color: #FFF1D2;
        border-color: #6B1700;
      }

      .alert-success {
        background-color: #d4edda;
        border-color: #c3e6cb;
        color: #155724;
      }

      .alert-danger {
        background-color: #f8d7da;
        border-color: #f5c6cb;
        color: #721c24;
      }

      .invalid-feedback {
        display: block;
        color: red;
        font-size: 0.875em;
      }

      .modal-content {
        border: 2px solid #CEAF95;
      }

      .modal-header {
        background-color: #FFF1D2;
        color: #6B1700;
      }

      .modal-footer .btn-primary {
        background-color: #6B1700;
        border-color: #6B1700;
      }

      .modal-footer .btn-primary:hover {
        background-color: #CEAF95;
        color: #6B1700;
        border-color: #CEAF95;
      }
    </style>
  </head>
  <body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div class="container my-5 pt-5">
      <main>
        <div class="container-fluid px-4">
          <h1 class="mt-4">Đổi mật khẩu</h1>
          <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item">
              <a href="/customer/profile/${id}">Hồ sơ khách hàng</a>
            </li>
            <li class="breadcrumb-item active">Đổi mật khẩu</li>
          </ol>

          <div class="mt-5">
            <div class="row">
              <div class="col-md-6 col-12 mx-auto">
                <h3>Cập nhật mật khẩu của bạn</h3>
                <hr />
                <c:if test="${not empty successMessage}">
                  <div class="alert alert-success" role="alert">
                    ${successMessage}
                  </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                  <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                  </div>
                </c:if>

                <form:form
                  method="post"
                  action="/customer/changepass"
                  modelAttribute="passwordChangeForm"
                  class="row"
                >
                  <div class="mb-3 col-12 position-relative">
                    <label class="form-label">Mật khẩu hiện tại:</label>
                    <form:input
                      id="currentPassword"
                      type="password"
                      path="currentPassword"
                      class="form-control"
                    />
                    <form:errors
                      path="currentPassword"
                      cssClass="invalid-feedback"
                    />
                    <i
                      class="bi bi-eye-slash position-absolute top-50 me-2"
                      id="toggleCurrentPassword"
                      style="cursor: pointer; right: 1rem"
                    ></i>
                  </div>

                  <div class="mb-3 col-12 position-relative">
                    <label class="form-label">Mật khẩu mới:</label>
                    <form:input
                      id="newPassword"
                      type="password"
                      path="newPassword"
                      class="form-control"
                    />
                    <form:errors
                      path="newPassword"
                      cssClass="invalid-feedback"
                    />
                    <i
                      class="bi bi-eye-slash position-absolute top-50 me-2"
                      id="toggleNewPassword"
                      style="cursor: pointer; right: 1rem"
                    ></i>
                  </div>

                  <div class="mb-3 col-12 position-relative">
                    <label class="form-label">Xác nhận mật khẩu mới:</label>
                    <form:input
                      id="confirmPassword"
                      type="password"
                      path="confirmPassword"
                      class="form-control"
                    />
                    <form:errors
                      path="confirmPassword"
                      cssClass="invalid-feedback"
                    />
                    <i
                      class="bi bi-eye-slash position-absolute top-50 me-2"
                      id="toggleConfirmPassword"
                      style="cursor: pointer; right: 1rem"
                    ></i>
                  </div>

                  <div class="col-12 mb-5">
                    <button type="submit" class="btn btn-primary">
                      Thay đổi mật khẩu
                    </button>
                    <a href="/customer/profile/${id}" class="btn btn-secondary"
                      >Quay lại</a
                    >
                  </div>
                </form:form>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>

    <div class="modal fade" id="passwordChangeSuccessModal" tabindex="-1" aria-labelledby="passwordChangeSuccessModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="passwordChangeSuccessModalLabel">
              Mật khẩu đã thay đổi thành công
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            Mật khẩu của bạn đã được thay đổi thành công. Vui lòng đăng nhập lại bằng mật khẩu mới.
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-primary" id="redirectToLogin">
              OK
            </button>
          </div>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
      function togglePasswordVisibility(passwordFieldId, toggleButtonId) {
        document
          .getElementById(toggleButtonId)
          .addEventListener("click", function () {
            var passwordField = document.getElementById(passwordFieldId);
            var type = passwordField.type === "password" ? "text" : "password";
            passwordField.type = type;
            this.classList.toggle("bi-eye");
            this.classList.toggle("bi-eye-slash");
          });
      }
      togglePasswordVisibility("currentPassword", "toggleCurrentPassword");
      togglePasswordVisibility("newPassword", "toggleNewPassword");
      togglePasswordVisibility("confirmPassword", "toggleConfirmPassword");
      window.addEventListener("load", function () {
        var successMessage = "${successMessage}";
        if (
          successMessage &&
          successMessage !== "null" &&
          successMessage.trim() !== ""
        ) {
          var myModal = new bootstrap.Modal(
            document.getElementById("passwordChangeSuccessModal"),
            {
              keyboard: false,
            }
          );
          myModal.show();
        }
      });

      document
        .getElementById("redirectToLogin")
        .addEventListener("click", function () {
          window.location.href = "/customer/profile/${id}";
        });
    </script>
  </body>
</html>
