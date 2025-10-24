<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #FFF1D2;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #6B1700;
        }

        .panel {
            background: white;
            border-radius: 16px;
            padding: 40px;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 24px;
            color: #6B1700;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        .form-control {
            width: 100%;
            padding: 12px 40px 12px 16px;
            border: 1px solid #ccc;
            border-radius: 12px;
            font-size: 14px;
        }

        .form-group i {
            position: absolute;
            top: 50%;
            right: 12px;
            transform: translateY(-50%);
            cursor: pointer;
            color: #aaa;
        }

        .btn-primary {
            width: 100%;
            padding: 12px;
            background-color: #CEAF95;
            color: #6B1700;
            font-weight: bold;
            font-size: 16px;
            border: none;
            border-radius: 12px;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        .btn-primary:hover {
            background-color: #B5947D;
            color: white;
        }

        .text-danger {
            color: #d32f2f;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: center;
        }

        @media (max-width: 600px) {
            .panel {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
<div class="panel">
    <h2>Đặt lại mật khẩu</h2>

    <c:if test="${param.invalidpassword != null}">
        <div class="text-danger">Mật khẩu và xác nhận mật khẩu không khớp.</div>
    </c:if>

    <form:form method="post" action="/authentication/resetPassword" modelAttribute="resetPasswordForm">
        <div class="form-group">
            <form:input path="password" id="password" type="password" placeholder="Mật khẩu mới"
                        required="required" autocomplete="off" cssClass="form-control"/>
            <i class="fa fa-eye" onclick="togglePasswordVisibility('password')"></i>
        </div>

        <div class="form-group">
            <form:input path="confPassword" id="confPassword" type="password" placeholder="Xác nhận mật khẩu"
                        required="required" autocomplete="off" cssClass="form-control"/>
            <i class="fa fa-eye" onclick="togglePasswordVisibility('confPassword')"></i>
        </div>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <button type="submit" class="btn-primary">Xác nhận</button>
    </form:form>
</div>

<script>
    function togglePasswordVisibility(fieldId) {
        const input = document.getElementById(fieldId);
        const icon = input.nextElementSibling;
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }
</script>
</body>
</html>
