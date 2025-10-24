<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt hàng thành công</title>
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

        .alert-success {
            background-color: #CEAF95;
            border-color: #CEAF95;
            color: #6B1700;
            font-weight: bold;
        }

        .alert-info {
            background-color: #fff;
            border: 2px dashed #CEAF95;
            color: #6B1700;
        }

        h1, h2, h3, h4, h5 {
            color: #6B1700;
            font-family: 'Raleway', sans-serif;
            font-weight: 800;
        }

        .breadcrumb-item a,
        .breadcrumb-item.active {
            color: #6B1700 !important;
        }

        .btn-primary {
            background-color: #6B1700;
            border-color: #6B1700;
            color: #FFF1D2;
        }

        .btn-primary:hover {
            background-color: #CEAF95;
            color: #6B1700;
        }

        .back-to-top {
            background-color: #6B1700 !important;
            border-color: #6B1700 !important;
        }

        .back-to-top:hover {
            background-color: #CEAF95 !important;
            color: #6B1700 !important;
        }
    </style>
</head>
<body>
    <div id="spinner"
        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <jsp:include page="../layout/header.jsp" />
    <div class="container" style="margin-top: 100px;">
        <div class="row">
            <div class="col-12 mt-5">
                <div class="alert alert-success text-center fs-5" role="alert">
                    ${message}
                </div>
                <c:if test="${paymentType == 'COD'}">
                    <div class="alert alert-info text-center fs-6 mt-3">
                        Bạn đã chọn thanh toán khi nhận hàng. Vui lòng chuẩn bị tiền mặt khi giao hàng.
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/client/js/main.js"></script>
</body>
</html>