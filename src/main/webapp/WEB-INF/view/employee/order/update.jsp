<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Hỏi Dân IT - Dự án Bloomresin" />
                    <meta name="author" content="Hỏi Dân IT" />
                    <title>Update Order </title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                    <link rel="stylesheet" href="/css/ewstyle.css">
                </head>
                <body>
                    <div class="container-fluid d-flex p-0">
                        <jsp:include page="../layout/navbar.jsp" />
                        <div class="main-content p-0">
                            <jsp:include page="../layout/header.jsp" />
                            <div class="p-4">
                                <h1 class="mt-4">Đơn hàng</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/employee/product">Trang quản trị</a></li>
                                    <li class="breadcrumb-item"><a href="/employee/order">Đơn hàng</a></li>
                                    <li class="breadcrumb-item active">Cập nhật đơn hàng</li>
                                </ol>
                                <div class=" mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Cập nhật đơn hàng</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/order/update" class="row"
                                                modelAttribute="newOrder">
                                                <div class="mb-3" style="display: none;">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="text" class="form-control" path="id" />
                                                </div>
                                                <div class="mb-3">
                                                    <label>Mã đơn hàng = ${newOrder.id} </label>
                                                           
                                                    <label class="form-label">Giá:
                                                        <!-- Nhãn cho trường Price. -->
                                                        <fmt:formatNumber type="number"
                                                            value="${newOrder.totalPrice}" /> đ
                                                    </label>
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Khách hàng:</label>
                                                    <form:input type="text" class="form-control" disabled="true"
                                                        path="user.fullName" />
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Trạng thái:</label>
                                                    <form:select class="form-select" path="status">
                                                        <form:option value="PENDING">Chờ xử lý</form:option>
                                                        <form:option value="CONFIRM">Đã xác nhận</form:option>
                                                        <form:option value="SHIPPING">Đang giao hàng</form:option>
                                                        <form:option value="COMPLETE">Hoàn tất</form:option>
                                                        <form:option value="CANCEL">Đã hủy</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-warning">Cập nhật</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </main>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>
                </body>
                </html>