<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký tài khoản</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
  <style>
    body {
      background-color: #FFF1D2;
      font-family: 'Poppins', sans-serif;
      color: #6B1700;
    }

    .register-wrapper {
      max-width: 850px;
      margin: 0px auto;
      background-color: #fff;
      border-radius: 16px;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      overflow: hidden;
    }

    .register-header {
      background-color: #CEAF95;
      padding: 20px;
      text-align: center;
    }

    .register-header h2 {
      color: #6B1700;
      font-weight: 600;
    }

    .register-body {
      padding: 30px;
    }

    .form-control {
      border-radius: 10px;
      padding: 10px 14px;
    }

    .form-label {
      font-weight: 500;
      margin-bottom: 6px;
    }

    .btn-custom {
      background-color: #CEAF95;
      color: #fff;
      border: none;
      padding: 10px 20px;
      border-radius: 10px;
      transition: background-color 0.3s;
    }

    .btn-custom:hover {
      background-color: #B5947D;
    }

    .error-message, .form:errors {
      color: red;
      font-size: 14px;
    }

    .form-footer {
      text-align: center;
      margin-top: 20px;
    }

    .form-footer a {
      color: #6B1700;
      text-decoration: underline;
    }

    @media (max-width: 768px) {
      .register-body {
        padding: 20px;
      }
    }
  </style>
</head>
<body>

<div class="container">
  <div class="register-wrapper">
    <div class="register-header">
      <h2>Đăng ký tài khoản</h2>
    </div>

    <div class="register-body">
      <c:if test="${param.exist != null}">
        <div class="alert alert-danger">Email đã được đăng ký. Vui lòng đăng nhập.</div>
      </c:if>
      <c:if test="${param.password != null}">
        <div class="alert alert-danger">Mật khẩu và xác nhận mật khẩu không trùng khớp.</div>
      </c:if>

      <form:form method="post" action="/register" modelAttribute="registerUser">
        <div class="row g-3">
          <div class="col-md-6">
            <label class="form-label">Họ</label>
            <form:input path="firstName" cssClass="form-control" />
            <form:errors path="firstName" cssClass="error-message" />
          </div>

          <div class="col-md-6">
            <label class="form-label">Tên</label>
            <form:input path="lastName" cssClass="form-control" />
            <form:errors path="lastName" cssClass="error-message" />
          </div>

          <div class="col-12">
            <label class="form-label">Email</label>
            <form:input path="email" type="email" cssClass="form-control" />
            <form:errors path="email" cssClass="error-message" />
          </div>

          <div class="col-md-6">
            <label class="form-label">Mật khẩu</label>
            <form:input path="password" type="password" cssClass="form-control" />
            <form:errors path="password" cssClass="error-message" />
          </div>

          <div class="col-md-6">
            <label class="form-label">Xác nhận mật khẩu</label>
            <form:input path="confirmPassword" type="password" cssClass="form-control" />
            <form:errors path="confirmPassword" cssClass="error-message" />
          </div>

          <div class="col-md-6">
            <label class="form-label">Số điện thoại</label>
            <form:input path="phone" cssClass="form-control" />
            <form:errors path="phone" cssClass="error-message" />
          </div>

          <div class="col-md-6">
            <label class="form-label">Địa chỉ</label>
            <form:input path="address" cssClass="form-control" />
            <form:errors path="address" cssClass="error-message" />
          </div>
        </div>

        <div class="mt-4 d-grid">
          <button type="submit" class="btn btn-custom">Tạo tài khoản</button>
        </div>
      </form:form>

      <div class="form-footer mt-4">
        <span>Đã có tài khoản? </span><a href="/login">Đăng nhập ngay</a>
      </div>
    </div>
  </div>
</div>

</body>
</html>
