<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tạo Tin Tức</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        img#preview {
            max-height: 200px;
            display: none;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h1 class="mb-4">Tạo tin tức mới</h1>
    <form action="/admin/news/create" method="post" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

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
            <label for="image" class="form-label">Ảnh minh họa</label>
            <input type="file" class="form-control" id="image" name="image" accept="image/*">
            <img id="preview" src="#" alt="Preview Image">
        </div>

        <div class="mt-4">
            <button type="submit" class="btn btn-primary">Tạo</button>
            <a href="/admin/news" class="btn btn-secondary ms-2">Hủy</a>
        </div>
    </form>
</div>
<script>
    document.getElementById('image').addEventListener('change', function (event) {
        const imgPreview = document.getElementById('preview');
        const file = event.target.files[0];
        if (file) {
            imgPreview.src = URL.createObjectURL(file);
            imgPreview.style.display = 'block';
        } else {
            imgPreview.style.display = 'none';
        }
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
