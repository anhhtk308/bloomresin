<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật Tin Tức</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        #preview {
            max-width: 300px;
            max-height: 200px;
            margin-top: 10px;
            display: none;
            border-radius: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4 text-center text-primary">📝 Cập Nhật Tin Tức</h1>
    <form action="/admin/news/update/${news.id}" method="post" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

        <div class="mb-3">
            <label for="title" class="form-label">Tiêu đề</label>
            <input type="text" class="form-control" id="title" name="title" value="${news.title}" required>
            <c:if test="${not empty titleError}">
                <div class="text-danger">${titleError}</div>
            </c:if>
        </div>

        <div class="mb-3">
            <label for="content" class="form-label">Nội dung</label>
            <textarea class="form-control" id="content" name="content" rows="5" required>${news.content}</textarea>
            <c:if test="${not empty contentError}">
                <div class="text-danger">${contentError}</div>
            </c:if>
        </div>

        <div class="mb-3">
            <label class="form-label">Hình ảnh hiện tại:</label>
            <c:if test="${not empty news.imageUrl}">
                <div class="mb-2">
                    <img src="${news.imageUrl}" alt="Ảnh tin tức" style="max-width: 200px;">
                </div>
            </c:if>

            <label for="image" class="form-label">Tải ảnh mới (tùy chọn)</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*">
            <!-- ảnh preview khi chọn file -->
            <img id="preview" alt="Ảnh mới sẽ hiển thị tại đây">
        </div>

        <div class="d-flex justify-content-start gap-2 mt-4">
            <button type="submit" class="btn btn-warning">Cập nhật</button>
            <a href="/admin/news" class="btn btn-secondary">Hủy</a>
        </div>
    </form>
</div>

<script>
    document.getElementById("image").addEventListener("change", function (event) {
        const file = event.target.files[0];
        const preview = document.getElementById("preview");
        if (file) {
            preview.src = URL.createObjectURL(file);
            preview.style.display = "block";
        } else {
            preview.style.display = "none";
            preview.src = "";
        }
    });
</script>
</body>
</html>
