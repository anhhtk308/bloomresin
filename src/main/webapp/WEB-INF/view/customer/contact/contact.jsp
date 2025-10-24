<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Liên hệ</title>
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
            font-family: 'Open Sans', sans-serif;
            color: #6B1700;
        }

        h2.contact-title {
            font-family: 'Raleway', sans-serif;
            font-size: 3rem;
            font-weight: 800;
            text-align: center;
            margin-top: 40px;
            margin-bottom: 30px;
        }

        .member-card {
            background-color: #FFF1D2;
            border: 2px solid #CEAF95;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 30px;
            text-align: center;
            height: 100%;
        }

        .member-img {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 20px;
            background-color: #D9D9D9;
            margin-bottom: 15px;
        }

        .member-name {
            font-weight: 700;
            font-family: 'Raleway', sans-serif;
            font-size: 1rem;
        }

        .member-info {
            font-size: 0.9rem;
        }

        .footer-logo h3 {
            font-family: 'Raleway', sans-serif;
            font-weight: 800;
            color: #6B1700;
        }

        .footer-contact,
        .footer-social,
        .footer-copyright {
            color: #6B1700;
            text-align: center;
            font-size: 14px;
        }

        .footer-social a {
            margin: 0 10px;
            color: #6B1700;
        }

        .footer-copyright {
            font-size: 12px;
            margin-top: 10px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="container">
    <h2 class="contact-title">LIÊN HỆ</h2>
    <div class="row justify-content-center">
        <div class="col-6 col-md-4 col-lg-2 d-flex">
            <div class="member-card w-100">
                <img src="${pageContext.request.contextPath}/client/img/contact/1.jpg" class="member-img" alt="Member 1">
                <div class="member-name">Nguyễn Văn A</div>
                <div class="member-info mt-2">
                    MSSV: CE000001<br>
                    Ngành: CNTT<br>
                    SĐT: 0901000001
                </div>
            </div>
        </div>

        <div class="col-6 col-md-4 col-lg-2 d-flex">
            <div class="member-card w-100">
                <img src="${pageContext.request.contextPath}/client/img/contact/2.jpg" class="member-img" alt="Member 2">
                <div class="member-name">Trần Thị B</div>
                <div class="member-info mt-2">
                    MSSV: CE000002<br>
                    Ngành: CNTT<br>
                    SĐT: 0901000002
                </div>
            </div>
        </div>

        <div class="col-6 col-md-4 col-lg-2 d-flex">
            <div class="member-card w-100">
                <img src="${pageContext.request.contextPath}/client/img/contact/3.jpg" class="member-img" alt="Member 3">
                <div class="member-name">Lê Văn C</div>
                <div class="member-info mt-2">
                    MSSV: CE000003<br>
                    Ngành: CNTT<br>
                    SĐT: 0901000003
                </div>
            </div>
        </div>

        <div class="col-6 col-md-4 col-lg-2 d-flex">
            <div class="member-card w-100">
                <img src="${pageContext.request.contextPath}/client/img/contact/4.jpg" class="member-img" alt="Member 4">
                <div class="member-name">Phạm Thị D</div>
                <div class="member-info mt-2">
                    MSSV: CE000004<br>
                    Ngành: CNTT<br>
                    SĐT: 0901000004
                </div>
            </div>
        </div>

        <div class="col-6 col-md-4 col-lg-2 d-flex">
            <div class="member-card w-100">
                <img src="${pageContext.request.contextPath}/client/img/contact/5.jpg" class="member-img" alt="Member 5">
                <div class="member-name">Hoàng Văn E</div>
                <div class="member-info mt-2">
                    MSSV: CE000005<br>
                    Ngành: CNTT<br>
                    SĐT: 0901000005
                </div>
            </div>
        </div>

        <div class="col-6 col-md-4 col-lg-2 d-flex">
            <div class="member-card w-100">
                <img src="${pageContext.request.contextPath}/client/img/contact/6.jpg" class="member-img" alt="Member 6">
                <div class="member-name">Ngô Thị F</div>
                <div class="member-info mt-2">
                    MSSV: CE000006<br>
                    Ngành: CNTT<br>
                    SĐT: 0901000006
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/js/main.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
    <script src="/client/js/main.js"></script>
</body>
</html>
