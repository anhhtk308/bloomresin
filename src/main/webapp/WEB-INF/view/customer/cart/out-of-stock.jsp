<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hết hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #FFF1D2;
            font-family: 'Open Sans', sans-serif;
            color: #6B1700;
        }

        .out-of-stock-container {
            max-width: 600px;
            margin: 100px auto;
            background-color: #fff;
            border-radius: 12px;
            border: 2px solid #CEAF95;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            text-align: center;
        }

        .out-of-stock-container h1 {
            color: #6B1700;
            font-weight: bold;
            font-family: 'Raleway', sans-serif;
        }

        .out-of-stock-container p {
            color: #6B1700;
            font-size: 1rem;
            margin-top: 10px;
        }

        .btn-custom {
            margin-top: 20px;
            background-color: #6B1700;
            color: #FFF1D2;
            border-color: #6B1700;
        }

        .btn-custom:hover {
            background-color: #CEAF95;
            color: #6B1700;
            border-color: #CEAF95;
        }
    </style>
</head>
<body>
<div class="out-of-stock-container">
    <h1>Sản phẩm đã hết hàng</h1>
    <p>Xin lỗi, một số sản phẩm trong giỏ hàng của bạn đã hết hàng. Vui lòng xóa chúng hoặc chọn sản phẩm khác.</p>
    <a href="/cart" class="btn btn-custom">Quay lại giỏ hàng</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
