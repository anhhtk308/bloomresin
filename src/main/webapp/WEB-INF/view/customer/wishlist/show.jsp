<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sách yêu thích</title>
    <link rel="stylesheet" href="/client/css/bootstrap.min.css">
    <link rel="stylesheet" href="/client/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
        }

        h2, h3 {
            color: #6B1700;
            font-weight: bold;
        }

        .wishlist-empty-container {
            padding: 40px 20px;
            text-align: center;
            background-color: #fff;
            border: 2px dashed #CEAF95;
            border-radius: 10px;
            margin: 20px 0;
        }

        .wishlist-empty-icon {
            font-size: 60px;
            color: #CEAF95;
            margin-bottom: 20px;
        }

        .wishlist-empty-title {
            font-size: 24px;
            margin-bottom: 10px;
            color: #6B1700;
            font-weight: 600;
        }

        .wishlist-empty-text {
            font-size: 16px;
            color: #6B1700;
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #CEAF95;
            color: #6B1700;
            border: none;
        }

        .btn-primary:hover {
            background-color: #B5947D;
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            border: none;
        }

        .btn-danger:hover {
            background-color: #a71d2a;
        }

        .table thead {
            background-color: #CEAF95;
            color: #6B1700;
        }

        .table tbody td {
            vertical-align: middle;
            color: #6B1700;
        }

        .table-bordered th, .table-bordered td {
            border-color: #CEAF95;
        }

        .btn-sm {
            font-size: 14px;
        }

        .text-success {
            color: #1e6b00 !important;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="container py-5">
    <h2 class="mb-4">Danh sách yêu thích của bạn</h2>
    <div id="wishlist-container">
        <c:choose>
            <c:when test="${empty wishlist}">
                <div class="wishlist-empty-container">
                    <div class="wishlist-empty-icon">
                        <i class="fa fa-heart-o"></i>
                    </div>
                    <h3 class="wishlist-empty-title">Danh sách yêu thích đang trống</h3>
                    <p class="wishlist-empty-text">Khám phá và lưu lại những món trang sức hoa resin bạn yêu thích để mua sau</p>
                    <a href="/products" class="btn btn-primary">
                        <i class="fa fa-shopping-cart me-2"></i>Xem sản phẩm
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <p class="text-success">Danh sách yêu thích có ${wishlist.size()} sản phẩm</p>
                    <table class="table table-bordered">
                        <thead class="thead-dark">
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Tên</th>
                                <th>Giá</th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${wishlist}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty product.image}">
                                                <img src="/images/product/${product.image}"
                                                    class="img-fluid rounded"
                                                    style="width: 80px; height: 80px;"
                                                    alt="${product.name}">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="/images/product/default.jpg"
                                                    class="img-fluid rounded"
                                                    style="width: 80px; height: 80px;"
                                                    alt="No Image">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${product.name}</td>
                                    <td>
                                        <fmt:formatNumber type="currency" currencyCode="VND"
                                            value="${product.price}" />
                                    </td>
                                    <td>
                                        <form action="/wishlist/remove/${product.id}" method="post"
                                            class="wishlist-ajax-form" style="display:inline;">
                                            <input type="hidden" name="${_csrf.parameterName}"
                                                value="${_csrf.token}" />
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="fa fa-trash me-1"></i> Xóa
                                            </button>
                                        </form>

                                        <button
                                            onclick="addToCartAndRemoveFromWishlist('${product.id}')"
                                            class="btn btn-primary btn-sm"
                                            style="margin-left: 5px;">
                                            <i class="fa fa-shopping-cart me-1"></i> Thêm vào giỏ hàng
                                        </button>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<jsp:include page="../layout/footer.jsp" />
<script src="/client/js/main.js"></script>
<script>
    var csrfToken = $("meta[name='_csrf']").attr("content");
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
    $(document).on('submit', '.wishlist-ajax-form', function (e) {
        e.preventDefault();
        var form = $(this);

        $.ajax({
            url: form.attr('action'),
            type: 'POST',
            data: form.serialize(),
            beforeSend: function (xhr) {
                if (csrfToken && csrfHeader) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            },
            success: function (response) {
                $("#wishlist-container").html(response);
            },
            error: function (xhr, status, error) {
                console.error("Lỗi AJAX:", status, error);

            }
        });
    });

    function addToCartAndRemoveFromWishlist(productId) {
        $.ajax({
            url: '/wishlist/remove/' + productId,
            type: 'POST',
            data: {
                "${_csrf.parameterName}": "${_csrf.token}"
            },
            beforeSend: function (xhr) {
                if (csrfToken && csrfHeader) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                }
            },
            success: function () {
                $.ajax({
                    url: '/add-products-to-cart/' + productId,
                    type: 'POST',
                    data: {
                        "${_csrf.parameterName}": "${_csrf.token}"
                    },
                    beforeSend: function (xhr) {
                        if (csrfToken && csrfHeader) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        }
                    },
                    success: function () {
                        window.location.href = '/wishlist';
                    },
                    error: function (xhr, status, error) {
                        console.error("Lỗi khi thêm vào giỏ hàng:", status, error);
                        alert("Sản phẩm đã được thêm vào giỏ hàng, nhưng có lỗi khi chuyển trang.");
                        // Nếu có lỗi vẫn cố gắng chuyển trang
                        window.location.href = '/wishlist';
                    }
                });
            },
            error: function (xhr, status, error) {
                console.error("Lỗi khi xóa khỏi danh sách yêu thích:", status, error);
                $.ajax({
                    url: '/add-products-to-cart/' + productId,
                    type: 'POST',
                    data: {
                        "${_csrf.parameterName}": "${_csrf.token}"
                    },
                    beforeSend: function (xhr) {
                        if (csrfToken && csrfHeader) {
                            xhr.setRequestHeader(csrfHeader, csrfToken);
                        }
                    },
                    success: function () {
                        window.location.href = '/wishlist';
                    },
                    error: function (xhr, status, error) {
                        console.error("Lỗi khi thêm vào giỏ hàng:", status, error);
                        alert("Có lỗi xảy ra khi thêm sản phẩm vào giỏ hàng.");
                    }
                });
            }
        });
    }

</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var dropdownElementList = [].slice.call(document.querySelectorAll('[data-bs-toggle="dropdown"]'));
        dropdownElementList.map(function (dropdownToggleEl) {
            return new bootstrap.Dropdown(dropdownToggleEl);
        });
        var userIcon = document.querySelector('.dropdown a[role="button"]');
        if (userIcon) {
            userIcon.addEventListener('click', function (e) {
                e.preventDefault();
                var dropdown = bootstrap.Dropdown.getInstance(this);
                if (!dropdown) {
                    dropdown = new bootstrap.Dropdown(this);
                }
                dropdown.toggle();
            });
        }
    });
</script>
</body>
</html>