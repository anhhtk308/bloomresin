<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8" />
  <title>Cảm ơn bạn đã đánh giá!</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@600;800&display=swap" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
  <link href="/client/css/style.css" rel="stylesheet" />
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #FFF1D2;
      font-family: 'Open Sans', sans-serif;
    }

    .thank-you-page {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 90vh;
      padding: 20px;
    }

    .thank-you-container {
      background: #fff;
      border-radius: 15px;
      padding: 40px 30px;
      text-align: center;
      box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
      max-width: 500px;
      width: 100%;
      animation: fadeIn 0.8s ease;
    }

    .thank-you-icon {
      font-size: 3.5rem;
      color: #6B1700;
      margin-bottom: 20px;
    }

    .thank-you-title {
      font-size: 2rem;
      color: #6B1700;
      font-weight: bold;
      margin-bottom: 15px;
    }

    .thank-you-message {
      font-size: 1.1rem;
      color: #6B1700;
      margin-bottom: 30px;
    }

    .btn-back-home {
      padding: 12px 30px;
      border-radius: 30px;
      font-size: 1.1rem;
      background-color: #CEAF95;
      color: #fff;
      text-decoration: none;
      border: none;
      transition: all 0.3s ease;
    }

    .btn-back-home:hover {
      background-color: #B5947D;
      color: #fff;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
      transform: scale(1.03);
    }

    @keyframes fadeIn {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  </style>
  <jsp:include page="../layout/header.jsp" />
</head>
<body>
<div class="thank-you-page">
  <div class="thank-you-container">
    <i class="bi bi-check-circle thank-you-icon"></i>
    <h2 class="thank-you-title">Cảm ơn bạn đã đánh giá!</h2>
    <p class="thank-you-message">
      Chúng tôi trân trọng đánh giá của bạn về sản phẩm này.
    </p>
    <a href="/order-history" class="btn-back-home">Quay lại lịch sử mua hàng</a>
  </div>
</div>
<jsp:include page="../layout/footer.jsp" />
</body>
</html>
