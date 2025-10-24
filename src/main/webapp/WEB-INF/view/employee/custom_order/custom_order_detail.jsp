<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng theo yêu cầu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="/css/ewstyle.css"/>
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp"/>
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp"/>

        <div class="p-4">
            <h1 class="mt-4">Chi tiết đơn hàng theo yêu cầu</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/employee">Trang quản trị</a></li>
                <li class="breadcrumb-item"><a href="/employee/custom-order/list">Đơn hàng</a></li>
                <li class="breadcrumb-item active">Xem chi tiết</li>
            </ol>

            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="card mb-4">
                        <div class="card-header fw-bold">
                            Thông tin đơn hàng
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Tên sản phẩm: ${customOrder.name}</li>
                            <li class="list-group-item">Người đặt: ${customOrder.user.fullName}</li>
                            <li class="list-group-item">Email: ${customOrder.user.email}</li>
                            <li class="list-group-item">Số điện thoại: ${customOrder.phone}</li>
                            <li class="list-group-item">Địa chỉ: ${customOrder.address}</li>
                            <li class="list-group-item">Mô tả: ${customOrder.description}</li>
                            <li class="list-group-item">Trạng thái:
                                <span class="badge bg-secondary">${customOrder.displayStatus}</span>
                            </li>
                        </ul>
                    </div>

                    <form action="/employee/custom-order/update-status/${customOrder.id}" method="post" class="mb-3">
                        <label class="form-label">Cập nhật trạng thái</label>
                        <select name="status" class="form-select mb-2">
                            <option value="PENDING" ${customOrder.status == 'PENDING' ? 'selected' : ''}>Đang xử lý</option>
                            <option value="CONFIRM" ${customOrder.status == 'CONFIRM' ? 'selected' : ''}>Chờ xác nhận</option>
                            <option value="COMPLETED" ${customOrder.status == 'COMPLETED' ? 'selected' : ''}>Hoàn thành</option>
                            <option value="CANCELLED" ${customOrder.status == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
                        </select>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-save"></i> Lưu thay đổi
                        </button>
                        <a href="/employee/custom-order/list" class="btn btn-secondary ms-2">← Quay lại</a>
                    </form>
                </div>

                <div class="col-md-4">
                    <div class="card p-3">
                        <h5 class="text-center">Ảnh minh hoạ</h5>
                        <img class="img-fluid border rounded"
                             src="${pageContext.request.contextPath}/images/custom-order/${customOrder.image}"
                             alt="Ảnh sản phẩm" />
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>
</body>
</html>
