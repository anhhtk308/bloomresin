<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý phản hồi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/css/ewstyle.css">
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />
        <div class="p-4">
            <h1 class="mb-4 mt-4 text-center fw-bold">
                Quản lý phản hồi của khách hàng ID: ${userId}
            </h1>

            <div class="p-4">
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                    <li class="breadcrumb-item"><a href="/admin/customer">Khách hàng</a></li>
                    <li class="breadcrumb-item active">Phản hồi</li>
                </ol>

                <table class="table table-bordered align-middle text-center">
                    <thead class="table-light">
                    <tr>
                        <th>ID sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Đánh giá</th>
                        <th>Nội dung phản hồi</th>
                        <th>Hiển thị</th>
                        <th>Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="feedback" items="${feedbackList}">
                        <tr>
                            <td>${feedback.product.id}</td>
                            <td>${feedback.product.name}</td>
                            <td>${feedback.rating}</td>
                            <td>${feedback.reviewContent}</td>
                            <td>${feedback.visible}</td>
                            <td>
                                <form:form action="/admin/customer/feedback/${feedback.id}" method="post">
                                    <input type="hidden" name="visible"
                                           value="${feedback.visible == 'Hiện' ? 'Ẩn' : 'Hiện'}" />
                                    <button type="submit"
                                            class="btn ${feedback.visible == 'Yes' ? 'btn-danger' : 'btn-success'}">
                                            ${feedback.visible == 'Hiện' ? 'Ẩn' : 'Hiện'}
                                    </button>
                                </form:form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>

                <div class="d-flex justify-content-end mb-3">
                    <a href="/admin/customer" class="btn btn-secondary">Quay lại</a>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-info">${message}</div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
