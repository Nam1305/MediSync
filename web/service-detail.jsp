<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>${service.name} - Chi tiết dịch vụ</title>
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
            .service-detail-card {
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 0 30px rgba(0,0,0,0.05);
            }
            
            .service-price {
                font-size: 2rem;
                font-weight: bold;
                color: #396cf0;
            }
            
            .service-content {
                font-size: 1.1rem;
                line-height: 1.8;
            }
            
            .related-service-card {
                height: 100%;
                transition: transform 0.3s, box-shadow 0.3s;
                border-radius: 10px;
            }

            .related-service-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            }
            
            /* Custom page header */
            .page-header {
                padding: 60px 0;
                background: linear-gradient(rgba(255, 255, 255, 0.85), rgba(255, 255, 255, 0.5)), url('assets/images/bg/pharm01.jpg');
                background-size: cover;
                background-position: center;
                margin-bottom: 30px;
            }
            
            .action-buttons .btn {
                padding: 12px 24px;
                font-size: 1.1rem;
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
                        <h2 class="title-dark text-primary mb-3">Chi tiết dịch vụ</h2>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb bg-transparent justify-content-center mb-0">
                                <li class="breadcrumb-item"><a href="home" class="text-dark">Trang chủ</a></li>
                                <li class="breadcrumb-item"><a href="services" class="text-dark">Dịch vụ</a></li>
                                <li class="breadcrumb-item active text-primary" aria-current="page">${service.name}</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
        </section>
        <!-- Page Header End -->

        <!-- Service Detail Section Start -->
        <section class="section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-md-7">
                        <div class="card service-detail-card border-0">
                            <div class="card-body p-4">
                                <h2 class="card-title text-primary mb-4">${service.name}</h2>
                                
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <div class="service-price">
                                        <fmt:formatNumber value="${service.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </div>
                                    <span class="badge bg-soft-primary text-primary rounded-pill px-3 py-2">
                                        <c:choose>
                                            <c:when test="${service.name.contains('Khám')}">Khám</c:when>
                                            <c:when test="${service.name.contains('Tư vấn')}">Tư vấn</c:when>
                                            <c:when test="${service.name.contains('Nội soi')}">Nội soi</c:when>
                                            <c:when test="${service.name.contains('xét nghiệm')}">Xét nghiệm</c:when>
                                            <c:otherwise>Khác</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <div class="service-content mt-4">
                                    <p>${service.content}</p>
                                </div>
                                
                                <!-- Service Features (Optional, could be expanded with more service data) -->
                                <div class="service-features mt-5">
                                    <h5 class="mb-3">Đặc điểm dịch vụ:</h5>
                                    <ul class="list-unstyled feature-list">
                                        <li class="mb-1">
                                            <span class="text-primary me-2"><i class="uil uil-check-circle"></i></span>
                                            Thực hiện bởi đội ngũ y bác sĩ giàu kinh nghiệm
                                        </li>
                                        <li class="mb-1">
                                            <span class="text-primary me-2"><i class="uil uil-check-circle"></i></span>
                                            Trang thiết bị hiện đại
                                        </li>
                                        <li class="mb-1">
                                            <span class="text-primary me-2"><i class="uil uil-check-circle"></i></span>
                                            Kết quả nhanh chóng và chính xác
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sidebar -->
                    <div class="col-lg-4 col-md-5 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <div class="card border-0 rounded shadow">
                            <div class="card-body">
                                <div class="widget">
                                    <h5 class="widget-title">Đặt lịch ngay</h5>
                                    
                                    <div class="mt-4 action-buttons">
                                        <c:choose>
                                            <c:when test="${customer != null}">
                                                <!-- Logged in as customer, show book button -->
                                                <a href="allDoctors" class="btn btn-primary w-100 mb-3">
                                                    <i class="uil uil-calendar-alt me-1"></i> Đặt lịch
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Not logged in or logged in as staff, show login reminder -->
                                                <a href="login" class="btn btn-primary w-100 mb-3">
                                                    <i class="uil uil-sign-in-alt me-1"></i> Đăng nhập để đặt lịch
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <a href="services" class="btn btn-soft-primary w-100">
                                            <i class="uil uil-arrow-left me-1"></i> Quay lại danh sách dịch vụ
                                        </a>
                                    </div>
                                </div>
                                
                                <!-- Contact Info -->
                                <div class="widget mt-4 pt-2">
                                    <h5 class="widget-title">Thông tin liên hệ</h5>
                                    <ul class="list-unstyled mt-4 mb-0">
                                        <li class="d-flex">
                                            <i class="uil uil-phone text-primary h5 mb-0 me-3"></i>
                                            <div class="flex-1">
                                                <a href="tel:+84123456789" class="text-muted">+84 123 456 789</a>
                                            </div>
                                        </li>
                                        <li class="d-flex mt-3">
                                            <i class="uil uil-envelope text-primary h5 mb-0 me-3"></i>
                                            <div class="flex-1">
                                                <a href="mailto:contact@example.com" class="text-muted">contact@example.com</a>
                                            </div>
                                        </li>
                                        <li class="d-flex mt-3">
                                            <i class="uil uil-map-marker text-primary h5 mb-0 me-3"></i>
                                            <div class="flex-1">
                                                <p class="text-muted mb-0">Hà Nội, Việt Nam</p>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Service Detail Section End -->
        
        <!-- Related Services Section Start -->
        <section class="section bg-light">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <h4 class="title mb-4">Dịch vụ liên quan</h4>
                            <p class="text-muted para-desc mx-auto mb-0">Khám phá thêm các dịch vụ khác của chúng tôi</p>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <!-- Check if we have related services -->
                    <c:choose>
                        <c:when test="${not empty relatedServices}">
                            <c:forEach var="relatedService" items="${relatedServices}">
                                <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                                    <div class="card related-service-card border-0 shadow rounded">
                                        <div class="card-body p-4">
                                            <h5 class="card-title">${relatedService.name}</h5>
                                            <p class="text-muted mt-3 mb-0">${relatedService.content.length() > 100 ? relatedService.content.substring(0, 100).concat('...') : relatedService.content}</p>
                                            <div class="mt-3 pt-2 d-flex justify-content-between align-items-center">
                                                <p class="price mb-0">
                                                    <fmt:formatNumber value="${relatedService.price}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </p>
                                                <a href="${pageContext.request.contextPath}/service-detail?id=${relatedService.serviceId}" class="btn btn-soft-primary">Chi tiết</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center">
                                <p>Không có dịch vụ liên quan.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>
        <!-- Related Services Section End -->

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