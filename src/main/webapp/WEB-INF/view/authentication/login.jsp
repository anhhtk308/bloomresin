<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8" />
    <title>Đăng nhập</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            font-family: "Poppins", sans-serif;
        }
        body {
            margin: 0;
            padding: 0;
            background: #FFF1D2;
            color: #6B1700;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .container {
            display: flex;
            width: 100%;
            max-width: 900px;
            height: 520px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .left-side {
            flex: 1;
            background: linear-gradient(135deg, #CEAF95, #CEAF95);
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            padding: 50px 30px;
            color: #6B1700;
            border-top-left-radius: 16px;
            border-bottom-left-radius: 16px;
            text-align: center;
            box-shadow: inset 0 0 20px rgba(107, 23, 0, 0.05);
        }
        .logo-container {
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .curved-text {
            width: 300px;
            height: 80px;
            margin-bottom: -30px;
        }
        .logo-wrapper {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            padding: 10px;
            background-color: #FFF1D2;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: -20px;
            animation: float 4s ease-in-out infinite;
        }
        .logo-circle {
            width: 160px;
            height: 160px;
            border-radius: 50%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .logo-circle:hover {
            transform: scale(1.05);
        }
        .left-side h1.brand-name {
            font-family: 'Pacifico', cursive;
            font-size: 28px;
            margin: 10px 0;
        }
        .left-side p {
            font-size: 16px;
            max-width: 260px;
            color: #6B1700;
        }
        @keyframes float {
            0% { transform: translateY(0); }
            50% { transform: translateY(-6px); }
            100% { transform: translateY(0); }
        }

        .right-side {
            flex: 1;
            background: white;
            padding: 40px 30px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .right-side h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
        }

        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        .input-group i.fa-solid {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            color: #aaa;
            z-index: 2;
        }
        .input-group .toggle-password {
            position: absolute;
            top: 50%;
            left: 12px;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 2;
            color: #aaa;
        }
        .input-group input {
            width: 100%;
            padding: 12px 12px 12px 38px; /* padding-left để tránh đè icon trái */
            border-radius: 25px;
            border: 1px solid #ccc;
            font-size: 14px;
            background-color: white;
        }
        .input-group input:focus {
            border-color: #CEAF95;
            outline: none;
        }
        .login-btn {
            width: 100%;
            padding: 12px;
            border-radius: 25px;
            background-color: #CEAF95;
            color: #6B1700;
            font-weight: 600;
            border: none;
            transition: background 0.3s ease;
            cursor: pointer;
        }
        .login-btn:hover {
            background-color: #B5947D;
            color: white;
        }

        .links, .register-link {
            margin-top: 15px;
            font-size: 14px;
            text-align: center;
        }
        .links a, .register-link a {
            color: #6B1700;
            text-decoration: underline;
            transition: color 0.3s ease;
        }
        .links a:hover, .register-link a:hover {
            color: #B5947D;
        }

        .msg {
            font-size: 14px;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }
        .msg.error { background: #ffe6e6; color: #d63031; }
        .msg.success { background: #e6ffed; color: #2ecc71; }
        .msg.warning { background: #fff3e0; color: #e67e22; }

        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                height: auto;
            }
            .left-side {
                display: none;
            }
            .right-side {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="left-side">
        <div class="logo-container">
            <svg viewBox="0 0 500 120" class="curved-text">
                <defs>
                    <path id="curve" d="M50,100 A200,200 0 0,1 450,100" />
                </defs>
                <text width="500">
                    <textPath xlink:href="#curve" startOffset="50%" text-anchor="middle" fill="#6B1700"
                              style="font-size: 22px; font-weight: bold; font-family: 'Poppins', sans-serif;">
                        ✿ Hoa hòe hoa hoẹt ✿
                    </textPath>
                </text>
            </svg>

            <div class="logo-wrapper">
                <img src="${pageContext.request.contextPath}/client/img/logo.jpg" alt="Logo BloomResin"
                     class="logo-circle">
            </div>

            <h1 class="brand-name">✿ Hoa Hòe Hoa Hoẹt ✿</h1>
            <p>Trang sức hoa resin độc đáo dành riêng cho bạn</p>
        </div>
    </div>

    <div class="right-side">
        <h2>Đăng nhập</h2>
        <form method="post" action="/login">
            <c:if test="${param.error != null}">
                <div class="msg error">Email hoặc mật khẩu không đúng</div>
            </c:if>
            <c:if test="${param.logout != null}">
                <div class="msg success">Bạn đã đăng xuất thành công</div>
            </c:if>
            <c:if test="${param.resetsuccess != null}">
                <div class="msg success">Đổi mật khẩu thành công</div>
            </c:if>
            <c:if test="${param.locked != null}">
                <div class="msg warning">Tài khoản của bạn đã bị khóa</div>
            </c:if>
            <c:if test="${param.registersuccess != null}">
                <div class="msg success">Đăng ký thành công. Vui lòng đăng nhập</div>
            </c:if>

            <div class="input-group">
                <i class="fa-solid fa-envelope"></i>
                <input type="email" name="username" placeholder="Email đăng nhập" required />
            </div>

            <div class="input-group">
                <i class="fa-solid fa-eye toggle-password" onclick="togglePassword(this)"></i>
                <input type="password" name="password" id="password" placeholder="Mật khẩu" required />
            </div>

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

            <button type="submit" class="login-btn">Đăng nhập</button>

            <div class="links mt-3">
                <a href="/forgotpassword" style="margin-right: 20px;">Quên mật khẩu?</a>
                <a href="/register">Đăng ký tài khoản</a>
            </div>
            <div class="register-link mt-2">
                <a href="/">← Quay lại trang chủ</a>
            </div>
        </form>
    </div>
</div>

<script>
    function togglePassword(icon) {
        const input = icon.closest('.input-group').querySelector('input');
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("fa-eye");
            icon.classList.add("fa-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("fa-eye-slash");
            icon.classList.add("fa-eye");
        }
    }
</script>
</body>
</html>
