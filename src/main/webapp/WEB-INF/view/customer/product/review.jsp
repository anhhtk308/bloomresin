<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đánh giá sản phẩm</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        .fullscreen-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .rating-container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
            max-width: 600px;
            width: 100%;
            text-align: center;
        }

        .rating-container h2 {
            font-family: 'Raleway', sans-serif;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .rating-container p {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .star-rating {
            direction: rtl;
            display: inline-flex;
            gap: 0.5rem;
            margin-top: 10px;
            margin-bottom: 15px;
        }

        .star-rating input[type="radio"] {
            display: none;
        }

        .star-rating label {
            font-size: 2.2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.3s ease, transform 0.2s ease;
        }

        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #ffcc00;
            transform: scale(1.1);
        }

        .star-rating input[type="radio"]:checked ~ label {
            color: #ffcc00;
        }

        textarea {
            border-radius: 8px;
            border: 2px solid #CEAF95;
            padding: 10px;
            resize: none;
            transition: border-color 0.3s ease;
        }

        textarea:focus {
            border-color: #6B1700;
            box-shadow: 0 0 5px rgba(107, 23, 0, 0.5);
        }

        button,
        .btn-home {
            background-color: #CEAF95;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin-top: 15px;
        }

        button:hover,
        .btn-home:hover {
            background-color: #B5947D;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="fullscreen-container">
    <div class="rating-container">
        <h2>Sản phẩm: ${product.name}</h2>
        <p>Giá: <fmt:formatNumber value="${product.price}" type="number" /> đ</p>

        <c:if test="${isReviewed}">
            <p><strong>Đánh giá của bạn:</strong></p>
            <p>${existingReview.reviewContent}</p>
            <p><strong>Sao:</strong> ${existingReview.rating} &#9733;</p>
            <a href="/order-history" class="btn-home">Quay lại lịch sử mua hàng</a>
        </c:if>

        <c:if test="${!isReviewed}">
            <form action="${pageContext.request.contextPath}/customer/submit-review/${orderDetail.id}" method="POST">
                <input type="hidden" name="_csrf" value="${_csrf.token}" />

                <div class="form-group">
                    <label for="reviewContent">Nội dung đánh giá:</label>
                    <textarea id="reviewContent" name="reviewContent" rows="4" class="form-control" placeholder="Nhập nội dung đánh giá..."></textarea>
                </div>

                <div>
                    <label>Đánh giá:</label>
                    <div class="star-rating">
                        <input type="radio" id="star5" name="rating" value="5" /><label for="star5">&#9733;</label>
                        <input type="radio" id="star4" name="rating" value="4" /><label for="star4">&#9733;</label>
                        <input type="radio" id="star3" name="rating" value="3" /><label for="star3">&#9733;</label>
                        <input type="radio" id="star2" name="rating" value="2" /><label for="star2">&#9733;</label>
                        <input type="radio" id="star1" name="rating" value="1" /><label for="star1">&#9733;</label>
                    </div>
                </div>

                <button type="submit" onclick="return validateRating()">Gửi đánh giá</button>
            </form>
        </c:if>
    </div>
</div>
<jsp:include page="../layout/footer.jsp" />
<script>
    function validateRating() {
        const rating = document.querySelector('input[name="rating"]:checked');
        if (!rating) {
            alert("Vui lòng chọn số sao để đánh giá sản phẩm.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
