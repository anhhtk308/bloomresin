<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sản phẩm</title>
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
            <h1 class="mb-4 mt-4 text-center fw-bold">Quản lý sản phẩm</h1>

            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang chủ quản trị</a></li>
                <li class="breadcrumb-item active">Sản phẩm</li>
            </ol>

            <!-- Search Bar -->
            <div class="search-bar mb-4">
                <form method="GET" action="/admin/product/search" class="d-flex align-items-stretch" style="max-width: 600px;">
                    <input type="text" name="keyword"
                           placeholder="Tìm theo tên hoặc phân loại"
                           class="form-control me-2"
                           style="flex: 1 1 auto; max-width: 400px; height: 45px;">
                    <button type="submit" class="btn btn-primary" style="height: 45px;">Tìm kiếm</button>
                </form>
            </div>

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Đóng"></button>
                </div>
            </c:if>

            <div class="mt-5">
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between">
                            <h3>Danh sách sản phẩm</h3>
                            <a href="/admin/product/create" class="btn btn-primary">Thêm sản phẩm mới</a>
                        </div>
                        <hr />
                        <c:choose>
                            <c:when test="${productPage.totalElements == 0}">
                                <div class="alert alert-warning text-center" role="alert">
                                    Không tìm thấy sản phẩm nào.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <table class="table table-bordered table-hover align-middle text-center">
                                    <thead class="table-light">
                                    <tr>
                                        <td>STT</td>
                                        <th>Tên</th>
                                        <th>Giá</th>
                                        <th>Thao tác</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="product" items="${productPage.content}" varStatus="loop">
                                        <tr>
                                            <td>${loop.index + 1}</td>
                                            <td>${product.name}</td>
                                            <td><fmt:formatNumber type="number" value="${product.price}" /> đ</td>
                                            <td>
                                                <div class="btn-group" role="group">
                                                    <a href="/admin/product/${product.id}" class="btn btn-success btn-sm">Xem</a>
                                                    <a href="/admin/product/update/${product.id}" class="btn btn-warning btn-sm mx-1">Sửa</a>
                                                    <a href="/admin/product/delete/${product.id}"
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa sản phẩm này không?')">
                                                        Xóa
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </c:otherwise>
                        </c:choose>

                        <c:if test="${productPage.totalElements > 0}">
                            <nav aria-label="Phân trang sản phẩm">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${currentPage > 0}">
                                        <li class="page-item">
                                            <a class="page-link" href="?keyword=${keyword}&page=${currentPage - 1}" aria-label="Trước">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                    </c:if>
                                    <c:forEach var="i" begin="0" end="${totalPages - 1}">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?keyword=${keyword}&page=${i}">${i + 1}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages - 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?keyword=${keyword}&page=${currentPage + 1}" aria-label="Tiếp">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </c:if>
                                </ul>
                            </nav>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
