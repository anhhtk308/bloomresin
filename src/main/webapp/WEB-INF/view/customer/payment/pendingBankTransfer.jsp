<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chờ thanh toán</title>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #FFF1D2;
            font-family: 'Open Sans', sans-serif;
            color: #6B1700;
            padding-top: 100px;
        }
        .card {
            border: none;
            border-radius: 15px;
            background-color: #ffffff;
        }
        .btn-custom {
            background-color: #CEAF95;
            color: white;
        }
        .btn-custom:hover {
            background-color: #6B1700;
            color: white;
        }
        .text-highlight {
            color: #6B1700;
            font-weight: 600;
        }
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp" />

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-lg p-4">
                <div class="card-body text-center">
                    <h2 class="card-title mb-3"><i class="bi bi-hourglass-split me-2"></i>Chờ thanh toán</h2>
                    <p class="text-muted">Vui lòng chuyển khoản theo thông tin dưới đây để hoàn tất đơn hàng.</p>

                    <div class="text-start mt-4">
                        <p><strong>👤 Người nhận:</strong> Cao Huỳnh Ngọc Như</p>
                        <p><strong>💰 Số tiền:</strong>
                            <span class="text-highlight">
                                <fmt:formatNumber value="${amount}" type="number" groupingUsed="true" /> VND
                            </span>
                        </p>

                        <p class="mt-3"><strong>📝 Nội dung chuyển khoản:</strong></p>
                        <p class="font-italic text-primary fs-6">${sessionScope.orderInfo}</p>

                        <div class="alert alert-secondary mt-3 small">
                            <i class="bi bi-info-circle-fill me-1"></i>
                            Vui lòng ghi đúng <strong>nội dung chuyển khoản</strong> để đơn hàng được xử lý nhanh chóng.
                        </div>

                        <img src="${pageContext.request.contextPath}/images/bank-qr.png"
                             class="d-block mx-auto rounded mt-4 mb-4"
                             style="width: 80%; max-width: 800px; height: auto;"
                             alt="QR chuyển khoản">

                        <div class="alert alert-warning">
                            Sau khi chuyển khoản, đơn hàng của bạn sẽ được xác nhận và xử lý trong vòng <strong>24 giờ</strong>.<br>
                            <strong>📞 Ghi chú: 0989780481</strong> </br>Hãy liên hệ cửa hàng để xác nhận nếu cần thiết.
                        </div>

                        <a href="${pageContext.request.contextPath}/" class="btn btn-custom mt-2 px-4">
                            <i class="bi bi-arrow-left-circle me-1"></i> Quay lại trang chủ
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
