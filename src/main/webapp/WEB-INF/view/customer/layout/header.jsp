<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Navbar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
            font-family: 'Open Sans', sans-serif;
        }

        .navbar {
            background-color: #FFF1D2;
            border-bottom: 2px solid #CEAF95;
            width: 100%;
            padding-left: 24px;
            padding-right: 24px;
            z-index: 1030;
        }

        .nav-logo {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
        }

        .nav-link {
            font-family: 'Raleway', sans-serif;
            font-weight: 800;
            text-transform: uppercase;
            color: #6B1700 !important;
            white-space: nowrap;
            font-size: 13px;
            padding: 0.5rem 0.6rem;
        }

        .nav-link:hover {
            color: #CEAF95 !important;
        }

        .nav-item {
            padding: 0 2px;
        }

        .nav-search {
            width: 150px;
            height: 36px;
            padding: 6px 12px;
            border: 2px solid #ccc;
            border-radius: 20px;
            outline: none;
            font-size: 14px;
            transition: width 0.4s ease-in-out;
        }

        .nav-search:focus {
            width: 280px;
            border-color: #CEAF95;
        }

        .nav-search::placeholder {
            color: #999;
            font-style: italic;
        }

        .search-wrapper {
            margin-top: 5px;
        }

        /* Icon */
        .icon-colored {
            color: #6B1700 !important;
            transition: color 0.3s ease;
        }

        .icon-colored:hover {
            color: #CEAF95 !important;
        }

        /* Dropdown */
        .navbar .dropdown-menu {
            background-color: #FFF1D2;
            border: 1px solid #CEAF95;
            border-radius: 10px;
            padding: 0;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        }

        .navbar .dropdown-item {
            padding: 10px 20px;
            color: #6B1700;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .navbar .dropdown-item:hover {
            background-color: #CEAF95;
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .nav-search {
                width: 120px;
            }

            .nav-search:focus {
                width: 150px;
            }

            .nav-link {
                font-size: 11px;
                padding: 0.3rem 0.4rem;
            }

            .nav-item {
                padding: 0 1px;
            }

            .search-wrapper {
                margin-top: 10px;
            }

            .dropdown-menu {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
<div class="container-fluid fixed-top px-0">
    <nav class="navbar navbar-expand-xl px-4">
        <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarCollapse">
            <span class="fa fa-bars text-primary"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-between align-items-center" id="navbarCollapse">
            <div class="navbar-nav d-flex align-items-center">
                <a href="/" class="nav-item d-flex align-items-center me-3">
                    <img class="nav-logo" src="/client/img/logo.jpg" alt="logo">
                </a>

                <a href="/" class="nav-item nav-link active fw-bold">Trang chủ</a>

                <div class="nav-item d-flex align-items-center ms-2 search-wrapper">
                    <form action="/search" method="get" class="d-flex align-items-center">
                        <input class="nav-search" type="text" name="query" placeholder="Bạn cần tìm gì..." required>
                        <button type="submit" class="btn p-0 ms-2" style="background: none; border: none;">
                            <i class="fas fa-search fa-lg icon-colored"></i>
                        </button>
                    </form>
                </div>

                <div class="nav-item dropdown d-flex align-items-center">
                    <a href="/products" class="nav-link fw-bold">Sản phẩm</a>
                    <a href="#" class="nav-link dropdown-toggle px-2" data-bs-toggle="dropdown"></a>
                    <ul class="dropdown-menu">
                        <c:forEach var="category" items="${categories}">
                            <li>
                                <a class="dropdown-item" href="/products?categoryId=${category.id}">
                                        ${category.name}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <a href="/careservice" class="nav-item nav-link fw-bold">Dịch vụ hỏi đáp</a>
                <a href="/news" class="nav-item nav-link fw-bold">Tin tức</a>
<%--                <a href="/contact" class="nav-item nav-link fw-bold">Liên hệ</a>--%>
                <a href="/aboutus" class="nav-item nav-link fw-bold">Giới thiệu</a>
            </div>

            <div class="d-flex m-3 me-0 align-items-center gap-3">
                <c:if test="${not empty pageContext.request.userPrincipal}">
                    <!-- Cart -->
                    <a href="/cart" class="position-relative">
                        <i class="fa fa-shopping-bag fa-2x icon-colored"></i>
                        <span class="position-absolute bg-secondary rounded-circle text-dark px-1 d-flex align-items-center justify-content-center"
                              style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumCart">
                                ${sessionScope.sum}
                        </span>
                    </a>

                    <!-- Wishlist -->
                    <a href="/wishlist" class="position-relative">
                        <i class="fas fa-heart fa-2x icon-colored"></i>
                        <span class="position-absolute bg-secondary rounded-circle text-dark px-1 d-flex align-items-center justify-content-center"
                              style="top: -5px; left: 15px; height: 20px; min-width: 20px;" id="sumWishlist">
                            <c:out value="${sessionScope.wishlistSize != null ? sessionScope.wishlistSize : 0}"/>
                        </span>
                    </a>

                    <!-- User Dropdown -->
                    <div class="dropdown">
                        <a href="#" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user fa-2x icon-colored"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end p-4" aria-labelledby="dropdownMenuLink">
                            <li class="d-flex align-items-center flex-column" style="min-width: 300px;">
                                <img src="/images/avatar/${sessionScope.avatar}" alt="Avatar người dùng"
                                     style="width: 150px; height: 150px; border-radius: 50%;" />
                                <div class="text-center my-3">
                                    <c:out value="${sessionScope.username}" />
                                </div>
                            </li>
                            <li><a class="dropdown-item" href="/customer/profile/${sessionScope.id}">Quản lý tài khoản</a></li>
                            <li><a class="dropdown-item" href="/order-tracking">Theo dõi đơn hàng</a></li>
                            <li><a class="dropdown-item" href="/order-history">Lịch sử mua hàng</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <form method="post" action="/logout">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button class="dropdown-item">Đăng xuất</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </c:if>

                <c:if test="${empty pageContext.request.userPrincipal}">
                    <a href="/login" class="a-login position-relative fw-bold text-uppercase text-decoration-none" style="color: #6B1700;">Đăng nhập</a>
                    <a href="/register" class="a-login position-relative fw-bold text-uppercase text-decoration-none" style="color: #6B1700;">Đăng ký</a>
                </c:if>
            </div>
        </div>
    </nav>
</div>
</body>
</html>
