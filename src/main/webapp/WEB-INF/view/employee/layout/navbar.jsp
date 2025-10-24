<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-3 d-flex flex-column align-items-center"
     style="width: 250px; min-height: 100vh; background-color: #020101;">

    <img src="/client/img/logo.jpg" alt="Logo" class="logo mb-4"
         style="width: 160px; height: 160px; object-fit: cover; border-radius: 50%; border: 3px solid white;">

    <ul class="list-unstyled w-100">
        <li>
            <a href="/employee/product" class="btn btn-light w-100 text-start mb-3">
                <i class="bi bi-clipboard-fill"></i> Quản lý sản phẩm
            </a>
        </li>
        <li>
            <a href="/employee/order" class="btn btn-light w-100 text-start mb-3">
                <i class="bi bi-basket-fill"></i> Quản lý đơn hàng
            </a>
        </li>
        <li>
            <a href="/employee/custom-order" class="btn btn-light w-100 text-start mb-3">
                <i class="bi bi-basket-fill"></i> Quản lý đơn hàng yêu cầu
            </a>
        </li>
        <li>
            <a href="/employee/profile/${sessionScope.id}" class="btn btn-light w-100 text-start mb-3">
                <i class="bi bi-person-badge-fill"></i> Hồ sơ nhân viên
            </a>
        </li>
        <li>
            <form method="post" action="/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <button type="submit" class="btn btn-danger w-100 text-start">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </button>
            </form>
        </li>
    </ul>
</div>
