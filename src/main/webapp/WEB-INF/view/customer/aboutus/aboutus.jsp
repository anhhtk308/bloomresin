<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8" />
  <title>Giới thiệu</title>
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
    body {
      background-color: #FFF1D2 !important;
      color: #6B1700 !important;
      font-family: 'Open Sans', sans-serif;
    }
    .content-wrapper {
      display: flex;
      flex-wrap: wrap;
      align-items: flex-start;
      gap: 20px;
      margin-top: 100px;
    }
    .map-responsive {
      flex: 1;
      min-width: 300px;
      height: 450px;
    }
    .map-responsive iframe {
      width: 100%;
      height: 100%;
      border: 0;
    }
    .about-us {
      flex: 1;
      min-width: 300px;
      text-align: left;
    }
    .about-us h2 {
      text-align: center;
      font-size: 2rem;
      color: #6B1700;
      margin-bottom: 20px;
      font-family: 'Raleway', sans-serif;
      font-weight: 800;
    }
    .about-us p {
      font-size: 1rem;
      line-height: 1.5;
      color: #6B1700;
    }
    .btn-view-products {
      margin-top: 20px;
    }
    .btn-primary {
      background-color: #6B1700;
      border-color: #6B1700;
      color: #FFF1D2;
      font-weight: bold;
    }
    .btn-primary:hover {
      background-color: #CEAF95;
      color: #6B1700;
    }
    .featured-section {
      margin-top: 60px;
      text-align: center;
    }
    .featured-section h3 {
      margin-bottom: 30px;
      font-size: 2rem;
      font-weight: 600;
      color: #6B1700;
    }
    .member-card {
      background: #FFF1D2;
      border-radius: 10px;
      border: 1px solid #CEAF95;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
      overflow: hidden;
      margin-bottom: 30px;
      transition: transform 0.3s ease;
      padding-bottom: 10px;
    }
    .member-card:hover {
      transform: translateY(-5px);
    }
    .member-img {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 50%;
      border: 4px solid #6B1700;
      margin: 20px auto 10px auto;
      display: block;
    }
    .member-info {
      font-size: 13px;
      color: #6B1700;
      text-align: left;
      padding: 0 10px;
    }
    .member-name {
      font-weight: bold;
      color: #6B1700;
      text-align: center;
    }
  </style>
</head>

<body>
<jsp:include page="../layout/header.jsp" />

<div class="container">
  <div class="content-wrapper">
    <div class="map-responsive">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1043.0242097679557!2d105.73109210022393!3d10.012645611591076!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a089e2b10096f3%3A0x2e719911c0bc03b!2zVMOyYSBHYW1tYSDEkEggRlBUIEPhuqduIFRoxqE!5e1!3m2!1sen!2s!4v1745308879223!5m2!1sen!2s"
              allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
    </div>

    <div class="about-us">
      <h2>Giới thiệu</h2>
      <p>
        ✿ <strong>Hoa Hoè Hoa Hoẹt</strong> ✿ là một dự án thủ công nhỏ đang chớm nở, được tạo nên từ những hạt resin lấp lánh, những cánh hoa khô mong manh, và cả một bầu trời mộng mơ tụi mình rất muốn được chia sẻ cùng bạn.
        <br><br>
        Chúng mình đang ấp ủ cho ra mắt những món trang sức resin thủ công — mỗi món là một câu chuyện nhỏ, không chỉ để đeo cho đẹp mà còn để cất giữ cảm xúc, màu sắc và một phần cá tính riêng của người đeo.
        <br><br>
        <strong>Địa chỉ:</strong> Đại học FPT Cần Thơ, 600 Nguyễn Văn Cừ, P. An Bình, Q. Ninh Kiều, TP. Cần Thơ
      </p>
      <div class="text-center btn-view-products">
        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary px-4 py-2">
          <i class="fas fa-box-open me-2"></i> Khám phá sản phẩm
        </a>
      </div>
    </div>
  </div>

  <div class="container featured-section">
    <h3>Người phụ trách</h3>
    <div class="row justify-content-center">

      <!-- Thành viên 1 -->
      <div class="col-6 col-md-4 col-lg-2 d-flex">
        <div class="member-card w-100">
          <img src="${pageContext.request.contextPath}/client/img/contact/1.jpg" class="member-img" alt="Member 1">
          <div class="member-name">Nguyễn Tường Vi</div>
          <div class="text-muted small">
            CEO
          </div>
        </div>
      </div>

      <!-- Thành viên 2 -->
      <div class="col-6 col-md-4 col-lg-2 d-flex">
        <div class="member-card w-100">
          <img src="${pageContext.request.contextPath}/client/img/contact/2.jpg" class="member-img" alt="Member 2">
          <div class="member-name">Hứa Hoài Thơ</div>
          <div class="text-muted small">
            CMO
          </div>
        </div>
      </div>

      <!-- Thành viên 3 -->
      <div class="col-6 col-md-4 col-lg-2 d-flex">
        <div class="member-card w-100">
          <img src="${pageContext.request.contextPath}/client/img/contact/3.jpg" class="member-img" alt="Member 3">
          <div class="member-name">Trần Kim Hằng</div>
          <div class="text-muted small">
            COO
          </div>
        </div>
      </div>

      <!-- Thành viên 4 -->
      <div class="col-6 col-md-4 col-lg-2 d-flex">
        <div class="member-card w-100">
          <img src="${pageContext.request.contextPath}/client/img/contact/4.jpg" class="member-img" alt="Member 4">
          <div class="member-name">Cao Huỳnh Ngọc Như</div>
          <div class="text-muted small">
            CTO
          </div>
        </div>
      </div>

      <!-- Thành viên 5 -->
      <div class="col-6 col-md-4 col-lg-2 d-flex">
        <div class="member-card w-100">
          <img src="${pageContext.request.contextPath}/client/img/contact/5.jpg" class="member-img" alt="Member 5">
          <div class="member-name">Trần Lê Kim Đàm</div>
          <div class="text-muted small">
            CPO
          </div>
        </div>
      </div>

      <!-- Thành viên 6 -->
      <div class="col-6 col-md-4 col-lg-2 d-flex">
        <div class="member-card w-100">
          <img src="${pageContext.request.contextPath}/client/img/contact/6.jpg" class="member-img" alt="Member 6">
          <div class="member-name">Nguyễn Lê Hồng Ngọc</div>
          <div class="text-muted small">
            CBO
          </div>
        </div>
      </div>

    </div>
  </div>
</div>

<jsp:include page="../layout/footer.jsp" />

<!-- Scripts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/lib/easing/easing.min.js"></script>
<script src="/client/lib/waypoints/waypoints.min.js"></script>
<script src="/client/lib/lightbox/js/lightbox.min.js"></script>
<script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="/client/js/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
<script src="/client/js/main.js"></script>
</body>
</html>
