<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Nhân Viên</title>
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
            <h1 class="mb-4 mt-4 text-center fw-bold">Quản lý nhân viên</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                <li class="breadcrumb-item active">Nhân viên</li>
            </ol>

            <div class="mt-4">
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4>Danh sách nhân viên</h4>
                            <a href="/admin/employee/create" class="btn btn-primary">Thêm nhân viên</a>
                        </div>

                        <c:if test="${not empty message}">
                            <div class="alert alert-success" role="alert">${message}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger" role="alert">${error}</div>
                        </c:if>

                        <table class="table table-bordered table-hover align-middle text-center">
                            <thead class="table-light">
                            <tr>
                                <td>STT</td>
                                <th>Email</th>
                                <th>Họ và tên</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th>Hành động</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="employee" items="${employees}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${employee.email}</td>
                                    <td>${employee.fullName}</td>
                                    <td>${employee.role.name}</td>
                                    <td>
                                        <span class="${employee.status ? 'text-success' : 'text-danger'}">
                                                ${employee.status ? 'Hoạt động' : 'Đã khóa'}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="/admin/employee/${employee.id}" class="btn btn-success btn-sm">Xem</a>
                                        <a href="/admin/employee/update/${employee.id}" class="btn btn-warning btn-sm mx-1">Cập nhật</a>

                                        <a href="/admin/employee/resend-email/${employee.id}" class="btn btn-info btn-sm" title="Gửi lại email tài khoản">
                                            <i class="bi bi-envelope"></i>
                                        </a>

                                        <form action="/admin/employee/ban/${employee.id}" method="post" class="d-inline">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                            <input type="hidden" name="status" value="${employee.status ? 'false' : 'true'}" />
                                            <button type="submit" class="btn ${employee.status ? 'btn-danger' : 'btn-secondary'} btn-sm mx-1">
                                                    ${employee.status ? 'Khóa' : 'Mở'}
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <c:if test="${empty employees}">
                            <div class="text-center text-muted mt-4">Không có nhân viên nào để hiển thị.</div>
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
