<%-- 
    Document   : home
    Created on : Jan 10, 2025, 11:15:54 PM
    Author     : DIEN MAY XANH
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Trang chủ</title>
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
        <jsp:include page="layout/header.jsp" /><!--end header-->
        <!-- Navbar End -->

        <!-- Banner Section -->
        <section class="banner-section">
            <div id="bannerCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <c:choose>
                        <c:when test="${empty banners}">
                            <div class="carousel-item active" style="width: 100vw; height: 100vh;">
                                <div class="banner-image w-100 h-100" 
                                     style="background: url('assets/images/bg/01.jpg') center center no-repeat;
                                     background-size: cover;
                                     transition: opacity 0.5s ease-in-out;">
                                    <div class="bg-overlay bg-overlay-dark"></div>
                                    <div class="container h-100">
                                        <div class="row h-100 align-items-center justify-content-center text-center">
                                            <div class="col-12">
                                                <div class="heading-title">
                                                    <h4 class="display-4 fw-bold text-white title-dark mb-4">
                                                        Chào mừng đến với trang web của chúng tôi!
                                                    </h4>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${banners}" var="banner" varStatus="status">
                                <div class="carousel-item ${status.first ? 'active' : ''}" 
                                     style="width: 100vw; height: 100vh;">
                                    <div class="banner-image w-100 h-100" 
                                         style="background: url('${banner.image}') center center no-repeat;
                                         background-size: cover;
                                         transition: opacity 0.5s ease-in-out;">
                                        <div class="bg-overlay bg-overlay-dark"></div>
                                        <div class="container h-100">
                                            <div class="row h-100 align-items-center justify-content-center text-center">
                                                <div class="col-12">
                                                    <div class="heading-title">
                                                        <h4 class="display-4 fw-bold text-white title-dark mb-4">
                                                            ${banner.blogName}
                                                        </h4>
                                                        <div class="mt-4">
                                                            <a href="blogDetail?blogId=${banner.blogId}" class="btn btn-primary">
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
                        </c:otherwise>
                    </c:choose>
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
                    <div class="card features feature-primary border-0 d-flex flex-column align-items-center text-center p-3">
                        <div class="icon rounded-md">
                            <i class="ri-hospital-fill h3 mb-2"></i> 
                        </div>
                        <div class="card-body p-0 mt-2">
                            <a href="departments.html" class="title text-dark h5 d-block">${dept.departmentName}</a>
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

                <div class="row d-flex flex-wrap justify-content-center">
                    <c:forEach items="${topDoctors}" var="doctor">
                        <div class="col-xl-3 col-lg-3 col-md-6 mt-4 pt-2 d-flex">
                            <div class="card team border-0 rounded shadow overflow-hidden w-100">
                                <div class="team-img position-relative">
                                    <img src="${doctor.avatar}" class="img-fluid w-100" alt="${doctor.name}" style="height: 250px; object-fit: cover;">
                                </div>
                                <div class="card-body content text-center">
                                    <a href="doctor-team-one.html" class="title text-dark h5 d-block mb-0">${doctor.name}</a>
                                    <small class="text-muted speciality">${doctor.department.departmentName}</small>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div><!--end row-->

                <div class="col-12 mt-4 pt-2 text-center">
                    <a href="doctor-team-one.html" class="btn btn-primary">Xem thêm</a>
                </div><!--end col-->

            </div><!--end row-->
    </div><!--end container-->
</section><!--end section-->
<!-- End -->


//<!-- Sua o doan nay -->
<div class="container mt-100 mt-60" style="margin-top: -5%;">
    <div class="row justify-content-center">
        <div class="col-12">
            <div class="section-title mb-4 pb-2 text-center">
                <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Blog nổi bật</span>
            </div>
        </div><!--end col-->
    </div><!--end row-->

    <div class="row">
        <c:forEach items="${blogs}" var="blog">
            <div class="col-lg-4 col-md-6 col-12 mt-4 pt-2 d-flex">
                <div class="card blog blog-primary border-0 shadow rounded overflow-hidden d-flex flex-column w-100">
                    <!-- Đảm bảo ảnh có kích thước đồng đều -->
                    <div style="width: 100%; height: 250px; overflow: hidden;">
                        <img src="${blog.image}" class="img-fluid w-100 h-100" alt="${blog.blogName}" style="object-fit: cover;">
                    </div>
                    <div class="card-body p-4 d-flex flex-column flex-grow-1">
                        <ul class="list-unstyled mb-2">
                            <li class="list-inline-item text-muted small me-3">
                                <i class="uil uil-calendar-alt text-dark h6 me-1"></i>
                                <fmt:formatDate value="${blog.date}" pattern="dd/MM/yyyy"/>
                            </li>
                        </ul>
                        <a href="blogDetail?blogId=${blog.blogId}" class="text-dark title h5">${blog.blogName}</a>
                        <div class="post-meta mt-auto d-flex justify-content-between mt-3">
                            <a href="blogDetail?blogId=${blog.blogId}" class="link">Chi tiết <i class="mdi mdi-chevron-right align-middle"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div><!--end row-->

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