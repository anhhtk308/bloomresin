<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>

<style>
    .footer {
        background-color: #FFF1D2;
        color: #6B1700;
        font-family: 'Segoe UI', sans-serif;
        padding: 50px 30px;
        border-top: 2px solid #CEAF95;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        gap: 40px;
    }

    /* Cột 1: Logo */
    .footer-logo {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .footer-logo img {
        max-height: 160px;
        width: auto;
    }

    /* Cột 2: Thông tin liên hệ */
    .footer-contact {
        flex: 1;
        text-align: left;
    }

    .footer-contact p {
        font-size: 16px;
        margin: 6px 0;
    }

    .footer-contact i {
        margin-right: 8px;
        color: #CEAF95;
    }

    /* Cột 3: Follow + bản quyền */
    .footer-social {
        flex: 1;
        text-align: center;
    }

    .footer-social h5 {
        font-weight: bold;
        font-size: 16px;
        margin-bottom: 10px;
    }

    .footer-social a {
        color: #6B1700;
        font-size: 22px;
        margin-right: 16px;
        transition: color 0.3s;
    }

    .footer-social a:hover {
        color: #CEAF95;
    }

    .footer-bottom {
        margin-top: 20px;
        font-size: 14px;
        color: #6B1700;
    }

    /* Responsive mobile */
    @media (max-width: 768px) {
        .footer-container {
            flex-direction: column;
            align-items: center;
            text-align: center;
        }

        .footer-logo,
        .footer-contact,
        .footer-social {
            width: 100%;
        }

        .footer-contact,
        .footer-social {
            text-align: center;
        }
    }
</style>

<footer class="footer">
    <div class="footer-container">
        <!-- Cột 1: Logo -->
        <div class="footer-logo">
            <img src="${pageContext.request.contextPath}/client/img/logo.jpg" alt="Logo">
        </div>

        <!-- Cột 2: Thông tin liên hệ -->
        <div class="footer-contact">
            <p><i class="fas fa-map-marker-alt"></i>FPT University, 600 Nguyen Van Cu, An Binh, Ninh Kieu, Can Tho</p>
            <p><i class="fas fa-phone-alt"></i>0989780481</p>
            <p><i class="fas fa-envelope"></i>bloomresin.system@gmail.com</p>
        </div>

        <!-- Cột 3: Follow Us -->
        <div class="footer-social">
            <h5>FOLLOW US</h5>
            <a href="https://www.facebook.com/share/1J7Ztahajt/" target="_blank"><i class="fab fa-facebook-f"></i></a>
            <a href="https://www.instagram.com/bloomresin" target="_blank"><i class="fab fa-instagram"></i></a>
            <div class="footer-bottom">
                &copy; 2025 HOA HOE HOA HOET. All rights reserved.
            </div>
        </div>
    </div>
</footer>
