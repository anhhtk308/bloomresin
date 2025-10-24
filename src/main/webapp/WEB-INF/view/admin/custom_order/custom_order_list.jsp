<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng theo yêu cầu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="/css/ewstyle.css"/>
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        .page-wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container-fluid {
            flex: 1;
            display: flex;
            flex-direction: row;
        }

        .main-content {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .content-area {
            flex-grow: 1;
            padding: 2rem;
        }

        footer {
            margin-top: auto;
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <div class="container-fluid p-0">
        <jsp:include page="../layout/navbar.jsp"/>

        <div class="main-content">
            <jsp:include page="../layout/header.jsp"/>

            <div class="content-area">
                <h1 class="mb-4 mt-4 text-center fw-bold">Quản lý đơn hàng theo yêu cầu</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                    <li class="breadcrumb-item active">Đơn hàng theo yêu cầu</li>
                </ol>

                <div class="table-responsive">
                    <table class="table table-bordered table-hover text-center align-middle">
                        <thead class="table-light">
                        <tr>
                            <th>STT</th>
                            <th>Khách hàng</th>
                            <th>Email</th>
                            <th>Tên sản phẩm</th>
                            <th>Ngày tạo</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="customOrder" items="${customOrders}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${customOrder.user.fullName}</td>
                                <td>${customOrder.user.email}</td>
                                <td>${customOrder.name}</td>
                                <td>${customOrder.createdAt}</td>
                                <td>
                                    <span class="badge bg-secondary">${customOrder.displayStatus}</span>
                                </td>
                                <td>
                                    <a href="/admin/custom-order/detail/${customOrder.id}" class="btn btn-sm btn-success">
                                        <i class="bi bi-eye"></i> Xem
                                    </a>
                                    <a href="/admin/custom-order/delete/${customOrder.id}" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa đơn hàng này không?');">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty customOrders}">
                            <tr>
                                <td colspan="7" class="text-center text-muted">Không có đơn hàng nào.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <footer>
                <jsp:include page="../layout/footer.jsp"/>
            </footer>
        </div>
    </div>
</div>
</body>
</html>
