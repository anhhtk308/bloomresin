<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <title>Tin tức</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <link href="/client/css/style.css" rel="stylesheet">

    <style>
        .news-container {
            max-width: 1200px;
            margin: 100px auto 40px;
            padding: 0 20px;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
        }

        .news-card {
            background: #fff;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            flex-direction: column;
        }

        .news-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .news-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .news-content {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .news-content h2 {
            font-size: 1.3rem;
            font-weight: 800;
            font-family: 'Raleway', sans-serif;
            margin: 0 0 10px;
            color: #6B1700;
        }

        .news-desc {
            font-size: 0.95rem;
            color: #444;
            margin-bottom: auto;
            line-height: 1.5;
        }

        .read-more {
            align-self: flex-start;
            margin-top: 15px;
            background-color: #6B1700;
            color: #fff;
            padding: 6px 14px;
            font-size: 0.9rem;
            border-radius: 8px;
            text-decoration: none;
        }

        .read-more:hover {
            background-color: #A6461D;
            color: #fff;
        }
    </style>
</head>
<body>
<!-- Header -->
<jsp:include page="../layout/header.jsp"/>

<!-- News Section -->
<div class="container-fluid py-5">
    <div class="container">
        <h1 class="mb-4 text-center">Tin tức mới nhất</h1>
        <div class="news-container">
            <c:forEach var="news" items="${newsList}">
                <div class="news-card">
                    <img src="${pageContext.request.contextPath}${news.imageUrl}" alt="Ảnh tin tức">
                    <div class="news-content">
                        <h2><a href="/news/${news.id}">${news.title}</a></h2>
                        <p class="news-desc">
                            <c:choose>
                                <c:when test="${fn:length(news.content) > 120}">
                                    ${fn:substring(news.content, 0, 120)}...
                                </c:when>
                                <c:otherwise>
                                    ${news.content}
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="/news/${news.id}" class="read-more">Đọc thêm</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" />

<script src="/client/js/jquery.min.js"></script>
<script src="/client/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/js/main.js"></script>
</body>
</html>
