<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán sản phẩm yêu thích</title>
    <link rel="stylesheet" href="/client/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/client/css/style.css">
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
        }

        h2, h4, h5 {
            color: #6B1700;
            font-weight: bold;
        }

        .table th, .table td {
            vertical-align: middle;
            font-size: 15px;
        }

        .table img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
        }

        .bg-light {
            background-color: #fff3e6 !important;
        }

        .btn-primary {
            background-color: #CEAF95;
            border: none;
        }

        .btn-primary:hover {
            background-color: #B5947D;
        }

        .table thead {
            background-color: #fbeacc;
        }

        .table th {
            color: #6B1700;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="container py-5">
    <h2 class="mb-4 text-center">Thanh toán sản phẩm yêu thích</h2>
    <div class="table-responsive mb-4">
        <table class="table table-bordered text-center align-middle">
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Tên</th>
                <th>Giá</th>
                <th>Số lượng</th>
                <th>Tổng tiền</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
                <c:when test="${empty wishlist}">
                    <tr>
                        <td colspan="5">Danh sách yêu thích của bạn đang trống</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:set var="totalPrice" value="0" />
                    <c:forEach var="product" items="${wishlist}">
                        <c:set var="itemTotal" value="${product.price * 1}" />
                        <c:set var="totalPrice" value="${totalPrice + itemTotal}" />
                        <tr>
                            <td>
                                <img src="/images/product/${product.image}" alt="${product.name}">
                            </td>
                            <td>${product.name}</td>
                            <td><fmt:formatNumber value="${product.price}" type="number" /> đ</td>
                            <td>1</td>
                            <td><fmt:formatNumber value="${itemTotal}" type="number" /> đ</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <c:if test="${not empty wishlist}">
        <div class="bg-light rounded p-4 shadow-sm">
            <h4 class="mb-4">Tóm tắt đơn hàng</h4>
            <div class="d-flex justify-content-between mb-3">
                <h5>Tạm tính:</h5>
                <p><fmt:formatNumber value="${totalPrice}" type="number" /> đ</p>
            </div>
            <div class="border-top py-3 d-flex justify-content-between">
                <h5>Tổng tiền:</h5>
                <p><fmt:formatNumber value="${totalPrice}" type="number" /> đ</p>
            </div>

            <form action="/wishlist/checkout" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <c:forEach var="product" items="${wishlist}">
                    <input type="hidden" name="productIds" value="${product.id}" />
                    <input type="hidden" name="quantities" value="1" />
                </c:forEach>
                <button type="submit" class="btn btn-primary w-100 py-2">Tiến hành thanh toán</button>
            </form>
        </div>
    </c:if>
</div>
<jsp:include page="../layout/footer.jsp" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/js/main.js"></script>
</body>
</html>
