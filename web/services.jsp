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
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->
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
        <jsp:include page="layout/header.jsp" /><!--end header-->
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
        <jsp:include page="layout/customer-side-footer.jsp" />
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