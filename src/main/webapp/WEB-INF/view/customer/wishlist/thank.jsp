<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách yêu thích</title>
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
            color: #6B1700;
        }

        .alert-info {
            background-color: #CEAF95;
            color: #6B1700;
            border: none;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #CEAF95;
            color: #6B1700;
            border: none;
        }

        .btn-primary:hover {
            background-color: #B5947D;
            color: #fff;
        }

        .back-to-top {
            background-color: #CEAF95;
            border-color: #B5947D;
            color: #6B1700;
        }

        .back-to-top:hover {
            background-color: #B5947D;
            color: white;
        }
    </style>
</head>
<body>
<div id="spinner"
     class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-grow text-primary" role="status"></div>
</div>
<jsp:include page="../layout/header.jsp" />
<div class="container" style="margin-top: 100px;">
    <div class="row">
        <div class="col-12 mt-5">
            <div class="alert alert-info text-center" role="alert">
                <h4 class="fw-bold">Đã thêm vào danh sách yêu thích 💖</h4>
                <p>Bạn có thể truy cập <a href="/wishlist" class="text-decoration-underline fw-bold">Danh sách yêu thích</a> để xem lại các sản phẩm đã lưu.</p>
                <a href="/products" class="btn btn-primary mt-3">
                    <i class="fa fa-arrow-left me-2"></i> Tiếp tục mua sắm
                </a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
<a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/js/main.js"></script>
</body>
</html>
