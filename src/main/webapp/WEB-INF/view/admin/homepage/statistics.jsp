<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thống kê doanh thu & traffic</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/css/ewstyle.css">
    <style>
        body { background-color: #f8f9fa; }
        .card { border-radius: 1rem; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .form-select { max-width: 120px; display: inline-block; margin-right: 10px; }
        .breadcrumb { background-color: transparent; }
        #revenue_chart, #pie_chart, #login_chart { width: 100%; height: 400px; }

        /* Stat cards */
        .stat-card {
            text-align: center;
            padding: 1.5rem 1rem;
            border-radius: 1rem;
            color: #fff;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .stat-card i { font-size: 2.5rem; margin-bottom: 0.5rem; }
        .stat-card h4 { margin: 0.5rem 0 0 0; font-weight: bold; font-size: 1.5rem; }
        .stat-card h6 { font-weight: 500; font-size: 0.95rem; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 8px 20px rgba(0,0,0,0.15); }

        /* Gradient colors */
        .bg-gradient-primary { background: linear-gradient(135deg, #007bff, #66b2ff); }
        .bg-gradient-success { background: linear-gradient(135deg, #28a745, #7ed957); }
        .bg-gradient-warning { background: linear-gradient(135deg, #ffc107, #ffe066); color: #000; }
        .bg-gradient-info { background: linear-gradient(135deg, #17a2b8, #66d1e0); }
        .bg-gradient-secondary { background: linear-gradient(135deg, #6c757d, #a0a5ab); }

        .table thead { background-color: #007bff; color: #fff; }
        .table tbody tr:hover { background-color: #f1f1f1; }
    </style>
</head>
<body>
<div class="container-fluid d-flex p-0">
    <jsp:include page="../layout/navbar.jsp" />
    <div class="main-content p-0">
        <jsp:include page="../layout/header.jsp" />

        <div class="p-4">
            <h1 class="mb-4 text-center fw-bold text-primary">📊 Thống kê doanh thu & traffic</h1>
            <ol class="breadcrumb mb-4">
                <li class="breadcrumb-item"><a href="/admin">Trang quản trị</a></li>
                <li class="breadcrumb-item active">Thống kê</li>
            </ol>

            <!-- Form lọc năm & tháng -->
            <form method="get" action="/admin/statistics" class="text-center mb-4">
                <label for="yearSelection" class="form-label fw-semibold">Chọn năm:</label>
                <select id="yearSelection" name="year" class="form-select" onchange="this.form.submit()">
                    <c:forEach var="y" items="${yearsWithData}">
                        <option value="${y}" <c:if test="${y == selectedYear}">selected</c:if>>${y}</option>
                    </c:forEach>
                </select>

                <label for="monthSelection" class="form-label fw-semibold ms-3">Chọn tháng:</label>
                <select id="monthSelection" name="month" class="form-select" onchange="this.form.submit()">
                    <c:forEach begin="1" end="12" var="m">
                        <option value="${m}" <c:if test="${m == selectedMonth}">selected</c:if>>Tháng ${m}</option>
                    </c:forEach>
                </select>
            </form>

            <!-- Tổng số liệu nhanh -->
            <div class="row mb-4 g-4 justify-content-center">
                <div class="col-md-2 col-sm-4">
                    <div class="stat-card bg-gradient-primary">
                        <i class="bi bi-currency-dollar"></i>
                        <h6>Tổng doanh thu</h6>
                        <h4><fmt:formatNumber value="${totalRevenue}" type="number" /></h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stat-card bg-gradient-success">
                        <i class="bi bi-cart-fill"></i>
                        <h6>Tổng đơn hàng</h6>
                        <h4><fmt:formatNumber value="${totalOrders}" type="number" /></h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stat-card bg-gradient-warning">
                        <i class="bi bi-people-fill"></i>
                        <h6>Tổng khách hàng</h6>
                        <h4><fmt:formatNumber value="${totalCustomers}" type="number" /></h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stat-card bg-gradient-info">
                        <i class="bi bi-person-badge-fill"></i>
                        <h6>Tổng nhân viên</h6>
                        <h4><fmt:formatNumber value="${totalEmployees}" type="number" /></h4>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stat-card bg-gradient-secondary">
                        <i class="bi bi-person-lines-fill"></i>
                        <h6>Lượt đăng nhập</h6>
                        <h4><fmt:formatNumber value="${totalLogins}" type="number" /></h4>
                    </div>
                </div>
            </div>

            <!-- Biểu đồ doanh thu theo ngày -->
            <div class="card p-4 mb-4">
                <h5 class="fw-bold text-primary text-center">💰 Doanh thu theo ngày</h5>
                <div id="revenue_chart"></div>
            </div>

            <!-- Bảng doanh thu theo ngày -->
            <div class="card p-4 mb-4">
                <h5 class="fw-bold text-primary text-center">📋 Bảng doanh thu theo ngày</h5>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle text-center">
                        <thead>
                        <tr>
                            <th>Ngày</th>
                            <th>Doanh thu (VNĐ)</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="entry" items="${revenueByDay}">
                            <tr>
                                <td>${entry.key}</td>
                                <td><fmt:formatNumber type="number" value="${entry.value}" /></td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty revenueByDay}">
                            <tr>
                                <td colspan="2" class="text-muted">Không có dữ liệu</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Biểu đồ tròn sản phẩm bán chạy -->
            <div class="card p-4 mb-4">
                <h5 class="fw-bold text-primary text-center">🍰 Top 5 sản phẩm bán chạy</h5>
                <div id="pie_chart"></div>
            </div>

            <!-- Biểu đồ login theo ngày -->
            <div class="card p-4 mb-4">
                <h5 class="fw-bold text-primary text-center">👥 Lượt đăng nhập trong tháng</h5>
                <div id="login_chart"></div>
            </div>

        </div>
    </div>
</div>

<!-- Google Charts -->
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', { packages: ['corechart'] });
    google.charts.setOnLoadCallback(drawAllCharts);

    function drawAllCharts() {
        drawRevenueChart();
        drawPieChart();
        drawLoginChart();
    }

    function drawRevenueChart() {
        var data = google.visualization.arrayToDataTable([
            ['Ngày', 'Doanh thu (VNĐ)'],
            <c:forEach var="entry" items="${revenueByDay}" varStatus="loop">
            ['${entry.key}', ${entry.value}]<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ]);

        var options = {
            title: 'Doanh thu theo ngày',
            hAxis: { title: 'Ngày', showTextEvery: 1, textStyle: { fontSize: 11 } },
            vAxis: { title: 'Doanh thu (VNĐ)', minValue: 0, textStyle: { fontSize: 12 } },
            legend: { position: 'none' },
            colors: ['#007bff'],
            chartArea: { width: '85%', height: '70%' },
            bar: { groupWidth: '70%' }
        };

        if (data.getNumberOfRows() === 0) {
            document.getElementById('revenue_chart').innerHTML = "<p class='text-center text-muted'>Không có dữ liệu</p>";
        } else {
            new google.visualization.ColumnChart(document.getElementById('revenue_chart')).draw(data, options);
        }
    }

    function drawPieChart() {
        var data = google.visualization.arrayToDataTable([
            ['Sản phẩm', 'Số lượng bán'],
            <c:forEach var="entry" items="${topProducts}" varStatus="loop">
            ['${entry.key}', ${entry.value}]<c:if test="${!loop.last}">,</c:if>
            </c:forEach>
        ]);

        var options = {
            title: 'Sản phẩm bán chạy trong tháng',
            pieHole: 0.4,
            colors: ['#007bff', '#28a745', '#ffc107', '#dc3545', '#6f42c1', '#fd7e14'],
            legend: { position: 'right', textStyle: { fontSize: 12 } },
            chartArea: { width: '80%', height: '70%' },
            backgroundColor: 'transparent',
            pieSliceText: 'percentage',
            pieSliceTextStyle: { fontSize: 12, color: 'black' }
        };

        if (data.getNumberOfRows() === 0) {
            document.getElementById('pie_chart').innerHTML = "<p class='text-center text-muted'>Không có dữ liệu</p>";
        } else {
            new google.visualization.PieChart(document.getElementById('pie_chart')).draw(data, options);
        }
    }

    function drawLoginChart() {
        var loginDataArray = [['Ngày', 'Lượt đăng nhập']];
        <c:forEach var="entry" items="${loginCountByDay}">
        loginDataArray.push(['${entry.key}', ${entry.value}]);
        </c:forEach>

        if (loginDataArray.length <= 1) {
            document.getElementById('login_chart').innerHTML = "<p class='text-center text-muted'>Không có dữ liệu</p>";
            return;
        }

        var data = google.visualization.arrayToDataTable(loginDataArray);

        var options = {
            title: 'Lượt đăng nhập trong tháng',
            hAxis: { title: 'Ngày', showTextEvery: 1, textStyle: { fontSize: 11 } },
            vAxis: { title: 'Lượt đăng nhập', minValue: 0, textStyle: { fontSize: 12 } },
            legend: { position: 'none' },
            colors: ['#28a745'],
            chartArea: { width: '85%', height: '70%' },
            lineWidth: 3,
            pointSize: 5
        };

        new google.visualization.LineChart(document.getElementById('login_chart')).draw(data, options);
    }

    window.addEventListener('resize', drawAllCharts);
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
