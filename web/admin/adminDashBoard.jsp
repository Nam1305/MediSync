
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link href="assets/css/tiny-slider.css" rel="stylesheet" />
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            /* Cải thiện giao diện tổng thể */
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f4f7fe;
                color: #333;
            }

            h5, h6 {
                font-weight: 600;
                color: #2c3e50;
            }

            .card {
                border-radius: 12px;
                transition: all 0.3s ease;
                border: none;
            }

            .card:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            }

            .icon {
                width: 50px;
                height: 50px;
                background: #f0f4ff;
                color: #5b73e8;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                font-size: 24px;
            }

            /* Cải thiện layout các thẻ thống kê */
            .features-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 15px;
            }

            .features {
                background: #fff;
                padding: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .features h5 {
                font-size: 22px;
                color: #1e3050;
            }

            .features p {
                font-size: 14px;
                color: #6c757d;
            }

            /* Form chọn ngày tháng năm */
            form {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                align-items: center;
                background: #fff;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }



            /* Biểu đồ */
            canvas {
                background: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
                padding: 15px;
            }

        </style>
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../layout/navbar.jsp" />


            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../layout/header.jsp" />


                <div class="container-fluid">
                    <div class="layout-specing">
                        <h2 class="mb-0">Dashboard</h2>

                        <div class="row">
                            <div class="col-12">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">

                                        <div class="d-flex align-items-center bg-light rounded p-3 flex-fill">
                                            <div class="icon text-center rounded-md me-2">
                                                <i class="uil uil-bed h3 mb-0"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-0">${customerCount}</h5>
                                                <p class="text-muted mb-0">Khách Hàng</p>
                                            </div>
                                        </div>

                                        <div class="d-flex align-items-center bg-light rounded p-3 flex-fill">
                                            <div class="icon text-center rounded-md me-2">
                                                <i class="uil uil-file-medical-alt h3 mb-0"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-0">
                                                    <c:choose>
                                                        <c:when test="${totalRevenue >= 1000000000}">
                                                            <fmt:formatNumber value="${totalRevenue / 1000000000}" type="number" groupingUsed="true"/> tỷ
                                                        </c:when>
                                                        <c:when test="${totalRevenue >= 1000000}">
                                                            <fmt:formatNumber value="${totalRevenue / 1000000}" type="number" groupingUsed="true"/> triệu
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </h5>
                                                <p class="text-muted mb-0">Tổng Doanh Thu</p>
                                            </div>
                                        </div>

                                        <div class="d-flex align-items-center bg-light rounded p-3 flex-fill">
                                            <div class="icon text-center rounded-md me-2">
                                                <i class="uil uil-social-distancing h3 mb-0"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-0">${totalAppointments}</h5>
                                                <p class="text-muted mb-0">Appointment</p>
                                            </div>
                                        </div>

                                        <div class="d-flex align-items-center bg-light rounded p-3 flex-fill">
                                            <div class="icon text-center rounded-md me-2">
                                                <i class="uil uil-ambulance h3 mb-0"></i>
                                            </div>
                                            <div>
                                                <h5 class="mb-0">${totalService}</h5>
                                                <p class="text-muted mb-0">Service</p>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>





                        <!-- Nhân viên theo từng vai trò -->

                        <div class="row">
                            <div class="col-12"> <!-- Card lớn chiếm toàn bộ dòng -->
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center flex-wrap gap-3">
                                        <c:forEach var="entry" items="${staffByRole}">
                                            <div class="d-flex align-items-center bg-light rounded p-2">
                                                <div class="icon text-center rounded-md me-2">
                                                    <i class="uil uil-user h3 mb-0"></i>
                                                </div>
                                                <div>
                                                    <h5 class="mb-0">${entry.value}</h5> <!-- Số nhân viên -->
                                                    <p class="text-muted mb-0">${entry.key}</p> <!-- Tên vai trò -->
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- end row -->


                        <div class="row">
                            <h3>Thống kê khách hàng và doanh thu</h3>
                            <form action="AdminDashBoard" method="post">
                                <div class="form-group">
                                    <label>Chọn năm:</label>
                                    <input type="number" name="year" class="form-control" placeholder="Nhập năm">
                                </div>

                                <div class="form-group">
                                    <label>Chọn tháng:</label>
                                    <input type="number" name="month" class="form-control"  placeholder="Nhập tháng (1-12)">
                                </div>

                                <div class="form-group">
                                    <label>Chọn ngày:</label>
                                    <input type="number" name="day" class="form-control"  placeholder="Nhập ngày (1-31)">
                                </div>

                                <hr>

                                <div class="form-group">
                                    <label>Từ ngày:</label>
                                    <input type="date" class="form-control" name="startDate">
                                </div>

                                <div class="form-group">
                                    <label>Đến ngày:</label>
                                    <input type="date" class="form-control" name="endDate">
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="form-control" >Thống kê</button>
                                </div>
                                
                            </form>
                            <div>
                                <c:if test="${not empty error}">
                                <ul style="color: red">
                                    <c:forEach var="err" items="${errors}">
                                        <li>${err}</li>
                                        </c:forEach>
                                </ul>
                            </c:if>
                            </div>
                            
                            <canvas id="statsChart"></canvas>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <h3 class="mb-3">Top 4 Dịch Vụ Được Sử Dụng Nhiều Nhất</h3>
                                    <c:forEach var="service" items="${topServices}">
                                        <div class="d-flex align-items-center bg-light rounded p-2 mb-2">
                                            <div class="icon text-center rounded-md me-2">
                                                <i class="uil uil-medical-square h3 mb-0"></i>
                                            </div>
                                            <h6 class="mb-0">${service}</h6>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <div>
                            <h3>Top 3 nhân viên được feedback cao nhất</h3>
                        </div>
                        <div class="row">
                            <c:forEach var="entry" items="${topStaffList}">
                                <div class="col-md-4 col-sm-6 col-12 mt-4 pt-2"> <!-- Đảm bảo 3 cột trên màn lớn -->
                                    <div class="card border-0 shadow rounded p-4">
                                        <div class="d-flex justify-content-between">
                                            <img src="${entry.key.avatar}" class="avatar avatar-md-md rounded-pill shadow" alt="">
                                        </div>

                                        <div class="card-body p-0 pt-3">
                                            <a href="#" class="text-dark h6">${entry.key.name}</a>
                                            <p class="text-muted">ID: ${entry.key.staffId}</p>

                                            <ul class="mb-0 list-unstyled mt-2">
                                                <li class="mt-1">
                                                    <span class="text-muted me-2">
                                                        <c:choose>
                                                            <c:when test="${entry.key.gender.trim() == 'M'}">Nam</c:when>
                                                            <c:when test="${entry.key.gender.trim() == 'F'}">Nữ</c:when>
                                                            <c:otherwise>Khác</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </li>
                                                <li class="mt-1">
                                                    <span class="text-muted me-2">Tuổi:</span> 
                                                    <fmt:formatDate value="${entry.key.dateOfBirth}" pattern="yyyy" var="birthYear"/>
                                                    <c:set var="currentYear" value="<%= java.time.Year.now().getValue() %>" />
                                                    ${currentYear - birthYear} tuổi
                                                </li>
                                                <li class="mt-1">
                                                    <span class="text-muted me-2">Số sao trung bình:</span> 
                                                    <fmt:formatNumber value="${entry.value}" pattern="#.##"/>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>


                    </div>
                </div><!--end container-->


            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->



        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Chart -->
        <script src="assets/js/apexcharts.min.js"></script>
        <script src="assets/js/columnchart.init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
        <script>
            var labels = [];
            var customerCounts = [];
            var revenueCounts = [];

            <c:forEach var="label" items="${labels}">
            labels.push("${label}");
            </c:forEach>

            <c:forEach var="count" items="${customerCounts}">
            customerCounts.push(${count});
            </c:forEach>

            <c:forEach var="revenue" items="${revenueCounts}">
            revenueCounts.push(${revenue});
            </c:forEach>

            var ctx = document.getElementById('statsChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [
                        {
                            label: 'Số lượng khách',
                            data: customerCounts,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)'
                        },
                        {
                            label: 'Doanh thu (VND)',
                            data: revenueCounts,
                            backgroundColor: 'rgba(255, 99, 132, 0.6)'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {beginAtZero: true}
                    }
                }
            });
        </script>
        <script>
            document.querySelector("form").addEventListener("submit", function (event) {
                let year = document.querySelector("[name='year']").value.trim();
                let month = document.querySelector("[name='month']").value.trim();
                let day = document.querySelector("[name='day']").value.trim();
                let startDate = document.querySelector("[name='startDate']").value;
                let endDate = document.querySelector("[name='endDate']").value;

                let errors = [];

                // Ép kiểu về số nguyên (nếu có giá trị)
                year = year ? parseInt(year) : null;
                month = month ? parseInt(month) : null;
                day = day ? parseInt(day) : null;

                // Kiểm tra năm hợp lệ
                if (year !== null && (isNaN(year) || year <= 0)) {
                    errors.push("❌ Năm phải là số nguyên dương.");
                }

                // Kiểm tra tháng hợp lệ
                if (month !== null && (isNaN(month) || month < 1 || month > 12)) {
                    errors.push("❌ Tháng phải từ 1 đến 12.");
                }

                // Kiểm tra ngày hợp lệ (thủ công theo từng tháng)
                if (year !== null && month !== null && day !== null) {
                    let maxDays = 31; // Mặc định tháng có 31 ngày

                    // Xác định số ngày tối đa theo từng tháng
                    if ([4, 6, 9, 11].includes(month)) {
                        maxDays = 30; // Tháng 4, 6, 9, 11 có 30 ngày
                    } else if (month === 2) {
                        // Kiểm tra năm nhuận
                        let isLeapYear = (year % 4 === 0 && year % 100 !== 0) || (year % 400 === 0);
                        maxDays = isLeapYear ? 29 : 28;
                    }

                    // Kiểm tra ngày có hợp lệ không
                    if (isNaN(day) || day < 1 || day > maxDays) {
                        errors.push(`ngày không hợp lệ`);
                    }
                }

                // Kiểm tra startDate <= endDate
                if (startDate && endDate && startDate > endDate) {
                    errors.push("❌ Ngày bắt đầu không được lớn hơn ngày kết thúc.");
                }

                // Nếu có lỗi, hiển thị thông báo và ngăn form submit
                if (errors.length > 0) {
                    alert(errors.join("\n"));
                    event.preventDefault();
                }
            });
        </script>
    </body>

</html>