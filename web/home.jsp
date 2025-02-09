<%-- 
    Document   : home
    Created on : Jan 10, 2025, 11:15:54 PM
    Author     : DIEN MAY XANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Home Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        

        <style>
            .banner-section {
                position: relative;
                overflow: hidden;
            }

            .carousel-item {
                position: relative;
            }

            .banner-image {
                opacity: 0;
                transition: opacity 0.5s ease-in-out;
            }

            .carousel-item.active .banner-image {
                opacity: 1;
            }

            .carousel-control-prev,
            .carousel-control-next {
                width: 5%;
                opacity: 0.8;
                transition: opacity 0.3s ease;
            }

            .carousel-control-prev:hover,
            .carousel-control-next:hover {
                opacity: 1;
            }

            .carousel-indicators {
                bottom: 20px;
            }

            .carousel-indicators button {
                width: 12px;
                height: 12px;
                border-radius: 50%;
                margin: 0 4px;
                background-color: rgba(255, 255, 255, 0.5);
            }

            .carousel-indicators button.active {
                background-color: #fff;
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

        <!-- Navbar STart -->
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
                    <li class="list-inline-item mb-0">
                        <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                            <div class="btn btn-icon btn-pills btn-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                        </a>
                    </li>

                    <li class="list-inline-item mb-0 ms-1">
                        <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                            <i class="uil uil-search"></i>
                        </a>
                    </li>

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
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="profile">
                                            <img src="${staff != null ? staff.avatar : customer.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
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
                                        <c:if test="${staff != null}">
                                            <a class="dropdown-item text-dark" href="doctorprofile">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Profile
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
                            <a href="home.jsp">Trang chủ</a><span class="menu-arrow"></span>
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="javascript:void(0)">Bác Sĩ</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
                                    <a href="javascript:void(0)" class="menu-item"> Dashboard </a><span class="submenu-arrow"></span>
                                    <ul class="submenu">
                                        <li><a href="doctor-dashboard.html" class="sub-menu-item">Dashboard</a></li>
                                        <li><a href="doctor-appointment.html" class="sub-menu-item">Appointment</a></li>
                                        <li><a href="patient-list.html" class="sub-menu-item">Patients</a></li>
                                        <li><a href="doctor-schedule.html" class="sub-menu-item">Schedule Timing</a></li>
                                        <li><a href="invoices.html" class="sub-menu-item">Invoices</a></li>
                                        <li><a href="patient-review.html" class="sub-menu-item">Reviews</a></li>
                                        <li><a href="doctor-messages.html" class="sub-menu-item">Messages</a></li>
                                        <li><a href="doctor-profile.html" class="sub-menu-item">Profile</a></li>
                                        <li><a href="doctor-profile-setting.html" class="sub-menu-item">Profile Settings</a></li>
                                        <li><a href="doctor-chat.html" class="sub-menu-item">Chat</a></li>
                                        <li><a href="login.html" class="sub-menu-item">Login</a></li>
                                        <li><a href="signup.html" class="sub-menu-item">Sign Up</a></li>
                                        <li><a href="forgot-password.html" class="sub-menu-item">Forgot Password</a></li>
                                    </ul>
                                </li>
                                <li><a href="doctor-team-one.html" class="sub-menu-item">Doctors One</a></li>
                                <li><a href="doctor-team-two.html" class="sub-menu-item">Doctors Two</a></li>
                                <li><a href="doctor-team-three.html" class="sub-menu-item">Doctors Three</a></li>
                            </ul>
                        </li>

                        <li class="has-submenu parent-menu-item">
                            <a href="javascript:void(0)">Khách hàng</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="patient-dashboard.html" class="sub-menu-item">Dashboard</a></li>
                                <li><a href="patient-profile.html" class="sub-menu-item">Profile</a></li>
                                <li><a href="booking-appointment.html" class="sub-menu-item">Book Appointment</a></li>
                                <li><a href="patient-invoice.html" class="sub-menu-item">Invoice</a></li>
                            </ul>
                        </li>


                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Khác</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li><a href="aboutus.html" class="sub-menu-item"> About Us</a></li>
                                <li><a href="departments.html" class="sub-menu-item">Departments</a></li>
                                <li><a href="faqs.html" class="sub-menu-item">FAQs</a></li>
                                <li class="has-submenu parent-menu-item">
                                    <a href="javascript:void(0)" class="menu-item"> Blogs </a><span class="submenu-arrow"></span>
                                    <ul class="submenu">
                                        <li><a href="blogs.html" class="sub-menu-item">Blogs</a></li>
                                        <li><a href="blog-detail.html" class="sub-menu-item">Blog Details</a></li>
                                    </ul>
                                </li>
                                <li><a href="terms.html" class="sub-menu-item">Terms & Policy</a></li>
                                <li><a href="privacy.html" class="sub-menu-item">Privacy Policy</a></li>
                                <li><a href="error.html" class="sub-menu-item">404 !</a></li>
                                <li><a href="contact.html" class="sub-menu-item">Contact</a></li>
                            </ul>
                        </li>
                        <li><a href="../admin/index.html" class="sub-menu-item" target="_blank">Admin</a></li>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->

        <!-- Banner Section -->
        <section class="banner-section">
            <div id="bannerCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:forEach items="${banners}" var="banner" varStatus="status">
                        <div class="carousel-item ${status.first ? 'active' : ''}"
                             style="height: 500px; /* Adjust height as needed */">
                            <div class="banner-image w-100 h-100" 
                                 style="background: url('${banner.image}') center center no-repeat;
                                 background-size: cover;
                                 transition: opacity 0.5s ease-in-out;">
                                <div class="bg-overlay bg-overlay-dark"></div>
                                <div class="container h-100">
                                    <div class="row h-100 align-items-center">
                                        <div class="col-12">
                                            <div class="heading-title">
                                                <h4 class="display-4 fw-bold text-white title-dark mb-4">
                                                    ${banner.blogName}
                                                </h4>
                                                <div class="mt-4">
                                                    <a href="blog-detail?blogId=${banner.blogId}" class="btn btn-primary">
                                                        Xem chi tiết
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <c:if test="${banners.size() > 1}">
                    <button class="carousel-control-prev" type="button" 
                            data-bs-target="#bannerCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" 
                            data-bs-target="#bannerCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                        <span class="visually-hidden">Next</span>
                    </button>

                    <div class="carousel-indicators">
                        <c:forEach items="${banners}" var="banner" varStatus="status">
                            <button type="button" 
                                    data-bs-target="#bannerCarousel" 
                                    data-bs-slide-to="${status.index}" 
                                    class="${status.first ? 'active' : ''}"
                                    aria-current="${status.first ? 'true' : 'false'}" 
                                    aria-label="Slide ${status.index + 1}">
                            </button>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </section>
        <!-- End Hero -->





    </div><!--end container-->

    <div class="container mt-100 mt-60">
        <div class="row justify-content-center">
            <div class="col-12">
                <div class="section-title mb-4 pb-2 text-center">
                    <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Các chuyên khoa</span>
                </div>
            </div><!--end col-->
        </div><!--end row-->

        <div class="row">
            <c:forEach items="${departments}" var="dept">
                <div class="col-xl-3 col-md-4 col-12 mt-5">
                    <div class="card features feature-primary border-0">
                        <div class="icon text-center rounded-md">
                            <i class="ri-stethoscope-fill h3 mb-0"></i>
                        </div>
                        <div class="card-body p-0 mt-3">
                            <a href="departments.html" class="title text-dark h5">${dept.departmentName}</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Start -->
        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                        <div class="section-title mb-4 pb-2 text-center">
                            <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Các bác sĩ tiêu biểu</span>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row align-items-center">
                    <c:forEach items="${topDoctors}" var="doctor">
                        <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2">
                            <div class="card team border-0 rounded shadow overflow-hidden">
                                <div class="team-img position-relative">
                                    <img src="${doctor.avatar}" class="img-fluid" alt="${doctor.name}">
                                </div>
                                <div class="card-body content text-center">
                                    <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">${doctor.name}</a>
                                    <small class="text-muted speciality">${doctor.department.departmentName}</small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div><!--end col-->

                <div class="col-12 mt-4 pt-2 text-center">
                    <a href="doctor-team-one.html" class="btn btn-primary">Xem thêm</a>
                </div><!--end col-->
            </div><!--end row-->
    </div><!--end container-->
</section><!--end section-->
<!-- End -->


//<!-- Sua o doan nay -->
<div class="container mt-100 mt-60">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="section-title mb-4 pb-2 text-center">
                <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Blog mới nhất</span>
            </div>
        </div><!--end col-->
    </div><!--end row-->


    <div class="row">
        <c:forEach items="${blogs}" var="blog">
            <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2">
                <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                    <img src="${blog.image}" class="img-fluid" alt="${blog.blogName}">
                    <div class="card-body p-4">
                        <ul class="list-unstyled mb-2">
                            <li class="list-inline-item text-muted small me-3">
                                <i class="uil uil-calendar-alt text-dark h6 me-1"></i>
                                <fmt:formatDate value="${blog.date}" pattern="dd/MM/yyyy"/>
                            </li>
                        </ul>
                        <a href="blog-detail?blogId=${blog.blogId}" class="text-dark title h5">${blog.blogName}</a>
                        <div class="post-meta d-flex justify-content-between mt-3">
                            <a href="blog-detail?blogId=${blog.blogId}" class="link">Chi tiết <i class="mdi mdi-chevron-right align-middle"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div><!--end col-->
    <div class="col-12 mt-4 pt-2 text-center">
        <a href="listBlog" class="btn btn-primary">Xem thêm</a>
    </div><!--end col-->
</div><!--end row-->
</div><!--end container-->
</section><!--end section-->
<!-- End -->



<!-- Start -->
<footer class="bg-footer" style="margin-top: 5%;">
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
<!-- End -->







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

<script>
                            document.addEventListener('DOMContentLoaded', function () {
                                // Initialize the carousel with specific options
                                const bannerCarousel = new bootstrap.Carousel(document.getElementById('bannerCarousel'), {
                                    interval: 5000, // Time between slides in milliseconds
                                    pause: 'hover', // Pause on mouse hover
                                    ride: 'carousel', // Start cycling automatically
                                    wrap: true // Continuous loop
                                });

                                // Preload all banner images
                                const preloadImages = () => {
                                    const bannerItems = document.querySelectorAll('.banner-image');
                                    bannerItems.forEach(item => {
                                        const bgUrl = item.style.background.match(/url\(['"]?([^'")]+)['"]?\)/)[1];
                                        const img = new Image();
                                        img.src = bgUrl;
                                    });
                                };

                                // Call preload function
                                preloadImages();

                                // Add smooth transition when changing slides
                                const carousel = document.getElementById('bannerCarousel');
                                carousel.addEventListener('slide.bs.carousel', function (e) {
                                    const activeItem = e.relatedTarget;
                                    const bannerImage = activeItem.querySelector('.banner-image');

                                    // Ensure opacity transition works smoothly
                                    setTimeout(() => {
                                        bannerImage.style.opacity = '1';
                                    }, 50);
                                });
                            });
</script>
</body>
</html>