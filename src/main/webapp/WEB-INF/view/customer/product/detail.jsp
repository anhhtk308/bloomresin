<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Chi Tiết Sản Phẩm</title>
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
        body { background-color: #FFF1D2; color: #6B1700; font-family: 'Open Sans', sans-serif; }
        .btn-primary { background-color: #CEAF95; border-color: #CEAF95; color: #6B1700; }
        .btn-primary:hover { background-color: #B5947D; color: white; }
        .btn-dark { background-color: #6B1700; border-color: #6B1700; }
        .btn-dark:hover { background-color: #4a0e00; }
        .review-item { background: #fff; border: 1px solid #CEAF95; border-radius: 10px; padding: 15px; }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp"/>

<div class="container py-5 mt-5">
    <div class="row g-4">
        <!-- BREADCRUMB -->
        <div>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                    <li class="breadcrumb-item active" aria-current="page">${product.name}</li>
                </ol>
            </nav>
        </div>

        <!-- IMAGE -->
        <div class="col-lg-6">
            <img src="<c:out value='/images/product/${product.image}'/>"
                 class="img-fluid rounded border"
                 alt="${product.name}"
                 onerror="this.src='/images/no-image.png'">
        </div>

        <!-- INFO -->
        <div class="col-lg-6">
            <h3 class="fw-bold">${product.name}</h3>
            <h5 class="fw-bold text-danger mb-3">
                <fmt:formatNumber type="number" value="${product.price}"/> đ
            </h5>
            <p>${product.shortDesc}</p>

            <c:choose>
                <c:when test="${product.quantity > 0}">
                    <form action="/cart/add" method="post" class="mb-3">
                        <input type="hidden" name="id" value="${product.id}"/>
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-shopping-cart me-2"></i> Thêm vào giỏ hàng
                        </button>
                    </form>
                    <form action="/wishlist/add/${product.id}" method="post">
                        <button type="submit" class="btn btn-dark">
                            <i class="fa fa-heart me-2"></i> Wishlist
                        </button>
                    </form>
                </c:when>
                <c:otherwise>
                    <button class="btn btn-secondary" disabled>Hết hàng</button>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- DETAIL -->
        <div class="col-12 mt-5">
            <h4 class="fw-bold">Mô tả chi tiết</h4>
            <p>${product.detailDesc}</p>
        </div>

        <!-- REVIEW -->
        <div class="col-12 mt-4">
            <h4 class="fw-bold mb-3">Đánh giá khách hàng</h4>
            <c:forEach var="review" items="${reviews}">
                <div class="review-item mb-3">
                    <p><strong>${review.user.fullName}</strong>
                        <c:forEach begin="1" end="${review.rating}">
                            <i class="fa fa-star text-warning"></i>
                        </c:forEach>
                    </p>
                    <c:choose>
                        <c:when test="${review.visible == 'Yes'}">
                            <p>${review.reviewContent}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted">Bình luận đã bị ẩn.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
