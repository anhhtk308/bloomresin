<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác minh OTP</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .otp-container {
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
        }

        .otp-container h1 {
            font-weight: 700;
            margin-bottom: 10px;
            color: #6B1700;
        }

        .otp-container p {
            color: #6B1700;
            margin-bottom: 25px;
        }

        .form-control {
            border-radius: 8px;
        }

        .btn-bloom {
            background-color: #CEAF95;
            color: #6B1700;
            font-weight: 600;
            border: none;
            border-radius: 8px;
            transition: background-color 0.3s ease;
        }

        .btn-bloom:hover {
            background-color: #B5947D;
            color: #fff;
        }

        .error-text {
            color: red;
            font-size: 14px;
            margin-top: -8px;
            margin-bottom: 12px;
        }
    </style>
</head>
<body>

<div class="otp-container">
    <h1 class="text-center">Xác minh OTP</h1>
    <p class="text-center">Hãy kiểm tra email của bạn để lấy mã xác thực</p>

    <form method="post" action="/authentication/enterOTP" modelAttribute="newOtpForm">
        <div class="mb-3">
            <label for="otp" class="form-label">Nhập mã OTP</label>
            <input type="text" id="otp" name="otp" class="form-control" required placeholder="Nhập mã OTP">
            <c:if test="${param.error != null}">
                <div class="error-text">Mã OTP không đúng. Vui lòng kiểm tra lại email và thử lại.</div>
            </c:if>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit" class="btn btn-bloom w-100">Xác nhận OTP</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
