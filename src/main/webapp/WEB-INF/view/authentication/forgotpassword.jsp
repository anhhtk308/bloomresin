<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
            padding-top: 60px;
        }

        .card {
            background-color: #fff;
            border: none;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }

        .card h2 {
            font-weight: 700;
            color: #6B1700;
        }

        .card ol {
            padding-left: 20px;
            margin-top: 15px;
        }

        .form-control {
            border-radius: 8px;
        }

        .form-control:focus {
            border-color: #CEAF95;
            box-shadow: 0 0 0 0.2rem rgba(206, 175, 149, 0.25);
        }

        .form-text, .text-muted {
            color: #6B1700 !important;
        }

        .btn-bloom {
            background-color: #CEAF95;
            color: #6B1700;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }

        .btn-bloom:hover {
            background-color: #B5947D;
            color: white;
        }

        .btn-back {
            background-color: #6B1700;
            color: #fff;
            border-radius: 8px;
        }

        .invalid-feedback {
            display: block;
            font-size: 14px;
            margin-top: 4px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card">
                <h2>Quên mật khẩu?</h2>
                <p>Thực hiện 3 bước sau để lấy lại quyền truy cập vào tài khoản của bạn:</p>
                <ol>
                    <li>Nhập địa chỉ email đã đăng ký.</li>
                    <li>Kiểm tra email để nhận mã OTP.</li>
                    <li>Nhập mã OTP ở bước tiếp theo.</li>
                </ol>

                <form:form method="post" action="/authentication/forgotpassword" modelAttribute="newUser">
                    <div class="mb-3">
                        <label for="email-for-pass" class="form-label">Địa chỉ Email</label>
                        <form:input type="email" path="email" id="email-for-pass" class="form-control" required="true"/>
                        <form:errors path="email" cssClass="invalid-feedback"/>
                        <c:if test="${param.invalidemail != null}">
                            <div class="invalid-feedback">Email không tồn tại hoặc không hợp lệ.</div>
                        </c:if>
                        <div class="form-text">Email phải trùng với email đã dùng để đăng ký tài khoản.</div>
                    </div>

                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="d-flex justify-content-between mt-4">
                        <button type="submit" class="btn btn-bloom">Gửi mã OTP</button>
                        <a href="/login" class="btn btn-back">Quay lại đăng nhập</a>
                    </div>
                </form:form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
