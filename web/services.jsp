<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Danh sách dịch vụ</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            .service-card {
                height: 100%;
                transition: transform 0.3s, box-shadow 0.3s;
                border-radius: 10px;
            }

            .service-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }

            .price {
                font-weight: bold;
                color: #396cf0;
                font-size: 1.2rem;
            }

            .pagination {
                justify-content: center;
                margin-top: 2rem;
            }

            .filter-form {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 10px;
                margin-bottom: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }

            .section-title .badge {
                font-size: 2rem !important;
                padding: 10px 20px !important;
            }

            /* Custom page header */
            .page-header {
                padding: 80px 0;
                background: linear-gradient(rgba(255, 255, 255, 0.85), rgba(255, 255, 255, 0.5)), url('assets/images/bg/pharm01.jpg');
                background-size: cover;
                background-position: center;
                margin-bottom: 30px;
            }
        </style>
    </head>

    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <!-- Navbar Start -->
        <header id="topnav" class="navigation sticky">
            <div class="container">
                <!-- Start Mobile Toggle -->
                <div class="menu-extras">
                    <div class="menu-item">
                        <!-- Mobile menu toggle-->
                        <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </a>
                        <!-- End mobile menu toggle-->
                    </div>
                </div>
                <!-- End Mobile Toggle -->

                <!-- Start Dropdown -->
                <ul class="dropdowns list-inline mb-0">

                    <!-- Replace the profile dropdown section in home.jsp -->
                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <c:choose>
                                <c:when test="${staff != null || customer != null}">
                                    <!-- Logged in user -->
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <img src="${staff != null ? staff.avatar : customer.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                    </button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" 
                                           href="${staff != null ? 'staffProfile' : (customer != null ? 'customer-profile' : '#')}">
                                            <img src="${staff != null ? staff.avatar : customer.avatar}" 
                                                 class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">${staff != null ? staff.name : customer.name}</span>
                                                <small class="text-muted">
                                                    <c:choose>
                                                        <c:when test="${staff != null}">
                                                            ${staff.department.departmentName}
                                                        </c:when>
                                                        <c:otherwise>
                                                            Customer
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </div>
                                        </a>

                                        <a class="dropdown-item text-dark" href="change-password">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-key-skeleton align-middle h6"></i></span> Đổi mật khẩu
                                        </a>
                                        <c:if test="${customer != null}">
                                            <a class="dropdown-item text-dark" href="listAppointments">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-calendar-alt align-middle h6"></i></span> Thông tin chi tiết
                                            </a>
                                        </c:if>
                                        <c:if test="${staff != null}">
                                            <a class="dropdown-item text-dark" href="doctorprofile">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Profile
                                            </a>
                                        </c:if>
                                        <c:if test="${staff != null}">
                                            <a class="dropdown-item text-dark" href="doctorappointment">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> DashBoard
                                            </a>
                                        </c:if>

                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="logout">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Not logged in -->
                                    <a href="login" class="btn btn-soft-primary">
                                        <i class="uil uil-user align-middle"></i> Đăng nhập
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left nav-light">
                        <li class="parent-menu-item">
                            <a href="home">Trang chủ</a><span class="menu-arrow"></span>
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="listDoctor.jsp">Bác Sĩ</a><span class="menu-arrow"></span>
                        </li>

                        <li><a href="listBlog" class="sub-menu-item">Blogs</a></li>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->

        <!-- Page Header Start -->
        <section class="page-header">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12 text-center">
                        <h2 class="title-dark text-white mb-3">Danh sách dịch vụ</h2>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb bg-transparent justify-content-center mb-0">
                                <li class="breadcrumb-item"><a href="home" class="text-white">Trang chủ</a></li>
                                <li class="breadcrumb-item active text-white" aria-current="page">Dịch vụ</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- Page Header End -->

        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <span class="badge badge-pill badge-soft-primary mb-3">Dịch vụ y tế</span>
                            <h4 class="title mb-4">Tìm kiếm dịch vụ phù hợp với nhu cầu của bạn</h4>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <!-- Search and Filter Form -->
                <div class="filter-form">
                    <form action="${pageContext.request.contextPath}/services" method="GET" class="row g-3">
                        <!-- Service Type Filter -->
                        <div class="col-md-3">
                            <label for="serviceType" class="form-label">Loại dịch vụ</label>
                            <select name="serviceType" id="serviceType" class="form-select">
                                <option value="" ${empty serviceType ? 'selected' : ''}>Tất cả</option>
                                <option value="Khám" ${serviceType eq 'Khám' ? 'selected' : ''}>Khám</option>
                                <option value="Tư vấn" ${serviceType eq 'Tư vấn' ? 'selected' : ''}>Tư vấn</option>
                                <option value="Nội soi" ${serviceType eq 'Nội soi' ? 'selected' : ''}>Nội soi</option>
                                <option value="xét nghiệm" ${serviceType eq 'xét nghiệm' ? 'selected' : ''}>Xét nghiệm</option>
                                <option value="other" ${serviceType eq 'other' ? 'selected' : ''}>Khác</option>
                            </select>
                        </div>

                        <!-- Search by Name -->
                        <div class="col-md-3">
                            <label for="search" class="form-label">Tìm theo tên</label>
                            <input type="text" name="search" id="search" class="form-control" value="${search}" placeholder="Nhập tên dịch vụ...">
                        </div>

                        <!-- Price Range -->
                        <div class="col-md-4">
                            <label class="form-label">Khoảng giá</label>
                            <div class="input-group">
                                <input type="number" name="minPrice" id="minPrice" class="form-control" value="${minPrice}" placeholder="Tối thiểu" min="0">
                                <span class="input-group-text">-</span>
                                <input type="number" name="maxPrice" id="maxPrice" class="form-control" value="${maxPrice}" placeholder="Tối đa" min="0">
                            </div>
                        </div>

                        <!-- Sort By Price -->
                        <div class="col-md-2">
                            <label for="sortPrice" class="form-label">Sắp xếp theo giá</label>
                            <select name="sortPrice" id="sortPrice" class="form-select">
                                <option value="" ${empty sortPrice ? 'selected' : ''}>Mặc định</option>
                                <option value="asc" ${sortPrice eq 'asc' ? 'selected' : ''}>Thấp đến cao</option>
                                <option value="desc" ${sortPrice eq 'desc' ? 'selected' : ''}>Cao đến thấp</option>
                            </select>
                        </div>

                        <!-- Apply Filters Button -->
                        <div class="col-12 text-center mt-4">
                            <button type="submit" class="btn btn-primary">Áp dụng</button>
                            <a href="${pageContext.request.contextPath}/services" class="btn btn-outline-primary ms-2">Đặt lại</a>
                        </div>

                        <!-- Hidden inputs to preserve pagination info -->
                        <input type="hidden" name="page" value="1">
                        <input type="hidden" name="pageSize" value="${pageSize}">
                    </form>
                </div>

                <!-- Services Listing -->
                <div class="row">
                    <c:forEach var="service" items="${services}">
                        <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                            <div class="card service-card border-0 shadow rounded">
                                <div class="card-body p-4">
                                    <h5 class="card-title">${service.name}</h5>
                                    <p class="text-muted mt-3 mb-0">${service.content}</p>
                                    <div class="mt-3 pt-2 d-flex justify-content-between align-items-center">
                                        <p class="price mb-0">
                                            <fmt:formatNumber value="${service.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                        </p>
                                        <a href="${pageContext.request.contextPath}/service-detail?id=${service.serviceId}" class="btn btn-soft-primary">Chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty services}">
                        <div class="col-12 text-center py-5">
                            <div class="card shadow rounded border-0 p-4">
                                <div class="card-body">
                                    <i class="uil uil-search-alt text-primary h1"></i>
                                    <h4 class="mt-3">Không tìm thấy dịch vụ phù hợp</h4>
                                    <p class="text-muted">Vui lòng điều chỉnh bộ lọc hoặc từ khóa tìm kiếm của bạn</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="row mt-4">
                        <div class="col-12">
                            <nav aria-label="Services pagination">
                                <ul class="pagination justify-content-center">
                                    <!-- Previous Page Button -->
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/services?page=${currentPage - 1}&pageSize=${pageSize}&serviceType=${serviceType}&search=${search}&sortPrice=${sortPrice}&minPrice=${minPrice}&maxPrice=${maxPrice}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>

                                    <!-- Page Numbers -->
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <c:choose>
                                            <c:when test="${i <= 3 || i >= totalPages - 2 || (i >= currentPage - 1 && i <= currentPage + 1)}">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="${pageContext.request.contextPath}/services?page=${i}&pageSize=${pageSize}&serviceType=${serviceType}&search=${search}&sortPrice=${sortPrice}&minPrice=${minPrice}&maxPrice=${maxPrice}">${i}</a>
                                                </li>
                                            </c:when>
                                            <c:when test="${(i == 4 && currentPage > 4) || (i == totalPages - 3 && currentPage < totalPages - 3)}">
                                                <li class="page-item disabled">
                                                    <a class="page-link" href="#">...</a>
                                                </li>
                                            </c:when>
                                        </c:choose>
                                    </c:forEach>

                                    <!-- Next Page Button -->
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/services?page=${currentPage + 1}&pageSize=${pageSize}&serviceType=${serviceType}&search=${search}&sortPrice=${sortPrice}&minPrice=${minPrice}&maxPrice=${maxPrice}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </c:if>

                <!-- Page Size Selector -->
                <div class="text-center mt-4">
                    <form action="${pageContext.request.contextPath}/services" method="GET" class="d-inline-flex align-items-center">
                        <input type="hidden" name="serviceType" value="${serviceType}">
                        <input type="hidden" name="search" value="${search}">
                        <input type="hidden" name="sortPrice" value="${sortPrice}">
                        <input type="hidden" name="minPrice" value="${minPrice}">
                        <input type="hidden" name="maxPrice" value="${maxPrice}">
                        <input type="hidden" name="page" value="1">

                        <label for="pageSizeSelect" class="me-2">Hiển thị:</label>
                        <select name="pageSize" id="pageSizeSelect" class="form-select form-select-sm" style="width: auto;" onchange="this.form.submit()">
                            <option value="6" ${pageSize == 6 ? 'selected' : ''}>6</option>
                            <option value="12" ${pageSize == 12 ? 'selected' : ''}>12</option>
                            <option value="24" ${pageSize == 24 ? 'selected' : ''}>24</option>
                        </select>
                    </form>
                </div>
            </div>
        </section>

        <!-- Start Footer -->
        <footer class="bg-footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <p>Đội ngũ bác sĩ xuất sắc sẵn sàng cung cấp sự hỗ trợ kịp thời, điều trị khẩn cấp và tư vấn chuyên sâu cho gia đình bạn.</p>

                        <div class="mt-4">
                            <h5 class="text-light title-dark footer-head">Địa chỉ</h5>
                            <div id="google-map" style="height: 200px; width: 100%; overflow: hidden;">
                                <!-- Nhúng Google Map tại đây -->
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d33006.67071116369!2d105.51462100371513!3d21.005883448895787!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e1!3m2!1svi!2s!4v1737175663000!5m2!1svi!2s" 
                                        width="100%" height="200" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                        <h5 class="text-light title-dark footer-head">Liên hệ với chúng tôi</h5>
                        <ul class="list-unstyled footer-list mt-4">
                            <li class="d-flex align-items-center">
                                <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                <a href="mailto:contact@fpt.edu.vn" class="text-foot ms-2">contact@fpt.edu.vn</a>
                            </li>
                            <li class="d-flex align-items-center">
                                <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                <a href="tel:+152534468854" class="text-foot ms-2">+114</a>
                            </li>
                        </ul>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-5">
                <div class="pt-4 footer-bar">
                    <div class="text-center">
                        <p class="mb-0">2025 © MediSync. Code backend by Group 3 - SE1885</p>
                    </div>
                </div>
            </div><!--end container-->
        </footer><!--end footer-->
        <!-- End Footer -->

        <!-- Back to top -->
        <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
        <!-- Back to top -->

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <!-- Counter -->
        <script src="assets/js/counter.init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
    </body>
</html>