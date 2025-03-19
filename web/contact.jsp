<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Liên hệ - Hệ thống đặt lịch hẹn bác sĩ</title>
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

        <!-- Start Hero -->
        <section class="bg-half-170 d-table w-100" style="background: url('assets/images/bg/03.jpg');">
            <div class="bg-overlay bg-overlay-dark"></div>
            <div class="container">
                <div class="row mt-5 justify-content-center">
                    <div class="col-12">
                        <div class="section-title text-center">
                            <h3 class="sub-title mb-4 text-white title-dark">Liên hệ với chúng tôi</h3>
                            <p class="para-desc mx-auto text-white-50">Bác sĩ xuất sắc, sẵn sàng hỗ trợ ngay lập tức, điều trị khẩn cấp hoặc tư vấn sức khỏe cho người thân của bạn.</p>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->
        <!-- End Hero -->

        <div class="container mt-100 mt-60">
            <div class="row align-items-center">
                <div class="col-lg-5 col-md-6">
                    <div class="me-lg-5">
                        <img src="assets/images/about/about-2.png" class="img-fluid" alt="">
                    </div>
                </div>

                <div class="col-lg-7 col-md-6 mt-4 pt-2 mt-sm-0 pt-sm-0">
                    <div class="custom-form rounded shadow p-4">
                        <h5 class="mb-4">Liên hệ</h5>
                        <form method="post" action="contact" id="contactForm">
                            <c:if test="${not empty message}">
                                <div class="alert alert-${status}" role="alert">
                                    ${message}
                                </div>
                            </c:if>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Tên của bạn <span class="text-danger">*</span></label>
                                        <input name="name" id="name" type="text" class="form-control border rounded" placeholder="Tên :" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Email <span class="text-danger">*</span></label>
                                        <input name="email" id="email" type="email" class="form-control border rounded" placeholder="Email :" required>
                                    </div> 
                                </div><!--end col-->

                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label class="form-label">Tiêu đề</label>
                                        <input name="subject" id="subject" class="form-control border rounded" placeholder="Tiêu đề :">
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label class="form-label">Nội dung <span class="text-danger">*</span></label>
                                        <textarea name="message" id="message" rows="4" class="form-control border rounded" placeholder="Nội dung :" required></textarea>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <button type="submit" id="submit" name="send" class="btn btn-success">Gửi</button>
                                </div><!--end col-->
                            </div><!--end row-->
                        </form>
                    </div><!--end custom-form-->
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

    <!-- End -->

    <!-- Start Footer -->
    <jsp:include page="layout/customer-side-footer.jsp" /><!--end footer-->
    <!-- End Footer -->

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-success back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
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