<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chỉnh sửa đơn theo yêu cầu</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <style>
        body {
            background-color: #FFF1D2;
            color: #6B1700;
        }

        .breadcrumb-item a {
            color: #6B1700;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #6B1700;
        }

        .form-label {
            font-weight: 600;
        }

        .form-control {
            border: 1px solid #CEAF95;
        }

        .btn-custom {
            background-color: #6B1700;
            color: white;
        }

        .btn-custom:hover {
            background-color: #4e1000;
            color: white;
        }

        .border-custom {
            border-color: #CEAF95 !important;
        }

        .alert {
            color: #6B1700;
            background-color: #f8d7da;
            border-color: #CEAF95;
        }

        .fw-bold {
            color: #6B1700;
        }
    </style>
</head>
<body>

<jsp:include page="../layout/header.jsp"/>

<div class="container py-5 mt-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="/order-history">Lịch sử mua hàng</a></li>
            <li class="breadcrumb-item active">Chỉnh sửa đơn hàng</li>
        </ol>
    </nav>

    <div class="row justify-content-center">
        <div class="col-lg-9 bg-white p-4 rounded-3 border border-custom">
            <h4 class="text-center mb-4 fw-bold">✏️ Chỉnh sửa đơn đặt theo yêu cầu</h4>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger text-center">${errorMessage}</div>
            </c:if>

            <form:form method="post" modelAttribute="customOrder" action="/custom-order/update" enctype="multipart/form-data">
                <form:hidden path="id"/>
                <div class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">Tên sản phẩm:</label>
                        <form:input path="name" cssClass="form-control"/>
                        <form:errors path="name" cssClass="text-danger"/>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Số điện thoại:</label>
                        <form:input path="phone" cssClass="form-control"/>
                        <form:errors path="phone" cssClass="text-danger"/>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Địa chỉ:</label>
                        <form:input path="address" cssClass="form-control"/>
                        <form:errors path="address" cssClass="text-danger"/>
                    </div>

                    <div class="col-12">
                        <label class="form-label">Mô tả chi tiết:</label>
                        <form:textarea path="description" cssClass="form-control" rows="3"/>
                        <form:errors path="description" cssClass="text-danger"/>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Ảnh minh họa:</label>
                        <input type="file" name="imageFile" class="form-control" onchange="previewImage(event)">
                        <img id="preview"
                             src="${pageContext.request.contextPath}/images/custom-order/${customOrder.image != null ? customOrder.image : 'default_custom.png'}"
                             class="img-thumbnail mt-2" style="max-height: 150px; max-width: 100%; object-fit: contain;" alt="preview">
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-custom px-4">
                        <i class="fas fa-save"></i> Lưu thay đổi
                    </button>
                </div>
            </form:form>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>

<script>
    function previewImage(event) {
        const preview = document.getElementById("preview");
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    }
</script>
</body>
</html>
