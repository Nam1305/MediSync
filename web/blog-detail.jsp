<%-- 
    Document   : blog-detail
    Created on : Feb 2, 2025, 10:11:23 PM
    Author     : Admin
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
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-key-skeleton align-middle h6"></i></span> Change password
                                        </a>
                                        <c:if test="${staff != null}">
                                            <a class="dropdown-item text-dark" href="doctor-dashboard">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard
                                            </a>
                                        </c:if>
                                        <a class="dropdown-item text-dark" href="profile">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings
                                        </a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="logout">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <!-- Not logged in -->
                                    <a href="login" class="btn btn-soft-primary">
                                        <i class="uil uil-user align-middle"></i> Login
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left">
                        <li class="parent-menu-item">
                            <a href="home">Trang chủ</a><span class="menu-arrow"></span>
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
                                <li><a href="listBlog" class="sub-menu-item">Blogs</a></li>
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

        <div class="container-fluid">
            <div class="blog-detail-container">
                <div class="d-md-flex justify-content-between">
                    <div>
                        <h4 class="mb-0">${blog.blogName}</h4>

                        <ul class="list-unstyled mt-2 mb-0">
                            <li class="list-inline-item user text-muted me-2"><i class="mdi mdi-account"></i> ${blog.author}</li>
                            <li class="list-inline-item date text-muted"><i class="mdi mdi-calendar-check"></i> ${blog.date}</li>
                        </ul>
                    </div>
                </div>       

                <div class="row">
                    <div class="col-lg-8 col-lg-7 mt-4">
                        <div class="card rounded shadow border-0 overflow-hidden">
                            <img src="${blog.image}" class="img-fluid" alt="">

                            <div class="p-4">
                                <!-- <ul class="list-unstyled">
                                    <li class="list-inline-item user text-muted me-2"><i class="mdi mdi-account"></i> Calvin Carlo</li>
                                    <li class="list-inline-item date text-muted"><i class="mdi mdi-calendar-check"></i> 1st January, 2021</li>
                                </ul> -->
                                <p class="text-muted mb-0">${blog.content}</p>

                                <h5 class="card-title mt-4 mb-0">Comments :</h5>

                                <ul class="media-list list-unstyled mb-0">
                                    <li class="mt-4">
                                        <ul>
                                            <c:forEach var="comment" items="${comments}">
                                                <li class="mt-4">
                                                    <div class="d-flex justify-content-between">
                                                        <div class="d-flex align-items-center">
                                                            <a class="pe-3" href="#">
                                                                <img src="${comment.avatar}" class="img-fluid avatar avatar-md-sm rounded-circle shadow" alt="img">
                                                            </a>
                                                            <div class="commentor-detail">
                                                                <h6 class="mb-0">
                                                                    <a href="javascript:void(0)" class="text-dark media-heading">${comment.name}</a>
                                                                </h6>
                                                                <small class="text-muted">
                                                                    <fmt:formatDate value="${comment.date}" pattern="dd/MM/yyyy"/>
                                                                </small>
                                                            </div>
                                                        </div>
                                                        <a href="#" class="text-muted"><i class="mdi mdi-reply"></i> Reply</a>
                                                    </div>
                                                    <div class="mt-3">
                                                        <p class="text-muted font-italic p-3 bg-light rounded">"${comment.content}"</p>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>


                                        <ul class="list-unstyled ps-4 ps-md-5 sub-comment">
                                            <li class="mt-4">
                                                <div class="d-flex justify-content-between">
                                                    <div class="d-flex align-items-center">
                                                        <a class="pe-3" href="#">
                                                            <img src="../assets/images/client/01.jpg" class="img-fluid avatar avatar-md-sm rounded-circle shadow" alt="img">
                                                        </a>
                                                        <div class="commentor-detail">
                                                            <h6 class="mb-0"><a href="javascript:void(0)" class="text-dark media-heading">Random Guy</a></h6>
                                                            <small class="text-muted">17th August, 2024</small>
                                                        </div>
                                                    </div>
                                                    <a href="#" class="text-muted"><i class="mdi mdi-reply"></i> Reply</a>
                                                </div>
                                                <div class="mt-3">
                                                    <p class="text-muted font-italic p-3 bg-light rounded">"<3"</p>
                                                </div>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>

                                <h5 class="card-title mt-4 mb-0">Leave A Comment :</h5>

                                <form class="mt-3">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Your Comment</label>
                                                <textarea id="message" placeholder="Your Comment" rows="5" name="message" class="form-control" required=""></textarea>
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Name <span class="text-danger">*</span></label>
                                                <input id="name" name="name" type="text" placeholder="Name" class="form-control" required="">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                                <input id="email" type="email" placeholder="Email" name="email" class="form-control" required="">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-md-12">
                                            <div class="send d-grid">
                                                <button type="submit" class="btn btn-primary">Send Message</button>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form><!--end form-->
                            </div>
                        </div>
                    </div><!--end col-->

                    <div class="col-lg-4 col-md-5 mt-4">
                        <div class="card border-0 sidebar sticky-bar rounded shadow">
                            <div class="card-body">
                                <!-- RECENT POST -->
                                <div class="widget mb-4 pb-2">
                                    <h5 class="widget-title">Recent Post</h5>
                                    <div class="mt-4">
                                        <div class="clearfix post-recent">
                                            <div class="post-recent-thumb float-start"> <a href="jvascript:void(0)"> <img alt="img" src="../assets/images/blog/07.jpg" class="img-fluid rounded"></a></div>
                                            <div class="post-recent-content float-start"><a href="jvascript:void(0)">Consultant Business</a><span class="text-muted mt-2">15th June, 2019</span></div>
                                        </div>
                                        <div class="clearfix post-recent">
                                            <div class="post-recent-thumb float-start"> <a href="jvascript:void(0)"> <img alt="img" src="../assets/images/blog/08.jpg" class="img-fluid rounded"></a></div>
                                            <div class="post-recent-content float-start"><a href="jvascript:void(0)">Look On The Glorious Balance</a> <span class="text-muted mt-2">15th June, 2019</span></div>
                                        </div>
                                        <div class="clearfix post-recent">
                                            <div class="post-recent-thumb float-start"> <a href="jvascript:void(0)"> <img alt="img" src="../assets/images/blog/01.jpg" class="img-fluid rounded"></a></div>
                                            <div class="post-recent-content float-start"><a href="jvascript:void(0)">Research Financial.</a> <span class="text-muted mt-2">15th June, 2019</span></div>
                                        </div>
                                    </div>
                                </div>
                                <!-- RECENT POST -->

                                <!-- TAG CLOUDS -->
                                <div class="widget mb-4 pb-2">
                                    <h5 class="widget-title">Tags Cloud</h5>
                                    <div class="tagcloud mt-4">
                                        <a href="jvascript:void(0)" class="rounded">Business</a>
                                        <a href="jvascript:void(0)" class="rounded">Finance</a>
                                        <a href="jvascript:void(0)" class="rounded">Marketing</a>
                                        <a href="jvascript:void(0)" class="rounded">Fashion</a>
                                        <a href="jvascript:void(0)" class="rounded">Bride</a>
                                        <a href="jvascript:void(0)" class="rounded">Lifestyle</a>
                                        <a href="jvascript:void(0)" class="rounded">Travel</a>
                                        <a href="jvascript:void(0)" class="rounded">Beauty</a>
                                        <a href="jvascript:void(0)" class="rounded">Video</a>
                                        <a href="jvascript:void(0)" class="rounded">Audio</a>
                                    </div>
                                </div>
                                <!-- TAG CLOUDS -->

                                <!-- SOCIAL -->
                                <div class="widget">
                                    <h5 class="widget-title">Follow us</h5>
                                    <ul class="list-unstyled social-icon mb-0 mt-4">
                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i data-feather="facebook" class="fea icon-sm fea-social"></i></a></li>
                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i data-feather="instagram" class="fea icon-sm fea-social"></i></a></li>
                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i data-feather="twitter" class="fea icon-sm fea-social"></i></a></li>
                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i data-feather="linkedin" class="fea icon-sm fea-social"></i></a></li>
                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i data-feather="github" class="fea icon-sm fea-social"></i></a></li>
                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i data-feather="youtube" class="fea icon-sm fea-social"></i></a></li>
                                        <li class="list-inline-item"><a href="javascript:void(0)" class="rounded"><i data-feather="gitlab" class="fea icon-sm fea-social"></i></a></li>
                                    </ul><!--end icon-->
                                </div>
                                <!-- SOCIAL -->
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->        
            </div>    

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
    </body>        
</html>

