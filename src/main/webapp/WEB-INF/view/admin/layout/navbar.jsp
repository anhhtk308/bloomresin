<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="p-3 d-flex flex-column align-items-center"
     style="width: 250px; min-height: 100vh; background-color: #020101;">
    <img src="/client/img/logo.jpg" alt="Logo" class="logo mb-4"
         style="width: 160px; height: 160px; object-fit: cover; border-radius: 50%; border: 3px solid white;">

    <ul class="list-unstyled w-100">
        <li><a href="/admin" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-house-fill"></i> Trang chủ</a></li>
        <li><a href="/admin/category" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-tags-fill"></i> Quản lý danh mục</a></li>
        <li><a href="/admin/product" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-box-fill"></i> Quản lý sản phẩm</a></li>
        <li><a href="/admin/customer" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-people-fill"></i> Quản lý khách hàng</a></li>
        <li><a href="/admin/employee" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-person-badge-fill"></i> Quản lý nhân viên</a></li>
        <li><a href="/admin/order" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-bag-check-fill"></i> Quản lý đơn hàng</a></li>
        <li><a href="/admin/profile/${sessionScope.id}" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-person-circle"></i> Quản lý hồ sơ</a></li>
        <li><a href="/admin/news" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-newspaper"></i> Quản lý tin tức</a></li>
<%--        <li><a href="/admin/custom-order" class="btn btn-light w-100 text-start mb-3"><i class="bi bi-newspaper"></i> Quản lý đơn hàng yêu cầu</a></li>--%>

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
