
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
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../layout/navbar.jsp" />


            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../layout/header.jsp" />


                <div class="container-fluid">
                    <div class="layout-specing">
                        <h5 class="mb-0">Dashboard</h5>

                        <!-- Khách Hàng -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-bed h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">${customerCount}</h5>
                                            <p class="text-muted mb-0">Khách Hàng</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--end row-->

                        <!-- Tổng Doanh Thu -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-file-medical-alt h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
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
                                </div>
                            </div>
                        </div><!--end row-->

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
                            <div class="col-12">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-medkit h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">${totalAppintment}</h5>
                                            <p class="text-muted mb-0">Appointment</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end row-->
                        </div><!--end col-->

                        <div class="row">
                            <div class="col-12">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-medical-drip h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">${totalService}</h5>
                                            <p class="text-muted mb-0">Service</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--end row--> 
                        <div class="row">
                            <div class="col-12">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <h5 class="mb-3">Top 4 Dịch Vụ Được Sử Dụng Nhiều Nhất</h5>
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

                        <div class="row">
                            <h2>Thống kê khách hàng và doanh thu</h2>
                            <form action="AdminDashBoard" method="get">
                                <label>Chọn năm:</label>
                                <input type="number" name="year">

                                <label>Chọn tháng:</label>
                                <input type="number" name="month">

                                <label>Chọn ngày:</label>
                                <input type="number" name="day">

                                <button type="submit">Thống kê</button>
                            </form>

                            <canvas id="statsChart"></canvas>
                        </div>
                    </div>
                </div><!--end container-->


            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- Offcanvas Start -->
        <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
            <div class="offcanvas-header p-4 border-bottom">
                <h5 id="offcanvasRightLabel" class="mb-0">
                    <img src="assets/images/logo-dark.png" height="24" class="light-version" alt="">
                    <img src="assets/images/logo-light.png" height="24" class="dark-version" alt="">
                </h5>
                <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
            </div>
            <div class="offcanvas-body p-4 px-md-5">
                <div class="row">
                    <div class="col-12">
                        <!-- Style switcher -->
                        <div id="style-switcher">
                            <div>
                                <ul class="text-center list-unstyled mb-0">
                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                    <li class="d-grid"><a href="landing/index.html" target="_blank" class="mt-4"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- end Style switcher -->
                    </div><!--end col-->
                </div><!--end row-->
            </div>

            <div class="offcanvas-footer p-4 border-top text-center">
                <ul class="list-unstyled social-icon mb-0">
                    <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                    <li class="list-inline-item mb-0"><a href="index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                </ul><!--end icon-->
            </div>
        </div>
        <!-- Offcanvas End -->

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
                    y: { beginAtZero: true }
                }
            }
        });
    </script>
    </body>

</html>