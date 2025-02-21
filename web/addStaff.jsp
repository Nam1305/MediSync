<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <div class="page-wrapper doctris-theme toggled">
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                    <div class="sidebar-brand">
                        <a href="home">
                            <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                            <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                        </a>
                    </div>

                    <ul class="sidebar-menu pt-3">
                        <li><a href="adminDashBoard.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                        <li><a href="appointment.html"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Danh sách lịch hẹn</a></li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Nhân viên</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="ListDoctor">Danh sách nhân viên</a></li>
                                    <li><a href="AddStaffServlet">Thêm nhân viên</a></li>

                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Bệnh nhân</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="listCustomer">Danh sách bệnh nhân</a></li>
                                    <li><a href="addCustomer">Thêm bệnh nhân</a></li>

                                </ul>
                            </div>
                        </li>
                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Phòng Ban</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="ListDepartment">Danh sách Phòng Ban</a></li>
                                    <li><a href="AddDepartment">Thêm Phòng Ban</a></li>

                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Tin tức</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="blogs.html">Danh sách bài đăng</a></li>
                                    <li><a href="blog-detail.html">Bài đăng</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- sidebar-menu  -->
                </div>
                <!-- sidebar-content  -->
                <ul class="sidebar-footer list-unstyled mb-0">
                    <li class="list-inline-item mb-0 ms-1">
                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                            <i class="uil uil-comment icons"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
                        <div class="d-flex align-items-center">
                            <a href="#" class="logo-icon">
                                <img src="assets/images/logo-icon.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                    <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                                </span>
                            </a>
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>

                        </div>

                        <ul class="list-unstyled mb-0">
                            <li class="list-inline-item mb-0">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="assets/images/language/american.png" class="avatar avatar-ex-small rounded-circle p-2" alt=""></button>
                                    <div class="dropdown-menu dd-menu drop-ups dropdown-menu-end bg-white shadow border-0 mt-3 p-2" data-simplebar style="height: 175px;">
                                        <a href="javascript:void(0)" class="d-flex align-items-center">
                                            <img src="assets/images/language/chinese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Chinese</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="assets/images/language/european.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">European</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="assets/images/language/indian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Indian</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="assets/images/language/japanese.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Japanese</small>
                                            </div>
                                        </a>

                                        <a href="javascript:void(0)" class="d-flex align-items-center mt-2">
                                            <img src="assets/images/language/russian.png" class="avatar avatar-client rounded-circle shadow" alt="">
                                            <div class="flex-1 text-left ms-2 overflow-hidden">
                                                <small class="text-dark mb-0">Russian</small>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </li>

                            <li class="list-inline-item mb-0 ms-1">
                                <a href="javascript:void(0)" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
                                    <div class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="settings" class="fea icon-sm"></i></div>
                                </a>
                            </li>

                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i data-feather="mail" class="fea icon-sm"></i></button>
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">4 <span class="visually-hidden">unread mail</span></span>

                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow rounded border-0 mt-3 px-2 py-2" data-simplebar style="height: 320px; width: 300px;">
                                        <a href="#" class="d-flex align-items-center justify-content-between py-2">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Janalia</b> <small class="text-muted fw-normal d-inline-block">1 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="assets/images/client/Codepen.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>codepen</b>  <small class="text-muted fw-normal d-inline-block">4 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Cristina</b> <small class="text-muted fw-normal d-inline-block">5 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="assets/images/client/dribbble.svg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Dribbble</b> <small class="text-muted fw-normal d-inline-block">24 hour ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="assets/images/client/06.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Donald Aghori</b> <small class="text-muted fw-normal d-inline-block">1 day ago</small></small>
                                            </div>
                                        </a>

                                        <a href="#" class="d-flex align-items-center justify-content-between py-2 border-top">
                                            <div class="d-inline-flex position-relative overflow-hidden">
                                                <img src="assets/images/client/07.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                <small class="text-dark mb-0 d-block text-truncat ms-3">You received a new email from <b>Calvin</b> <small class="text-muted fw-normal d-inline-block">2 day ago</small></small>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </li>

                            <li class="list-inline-item mb-0 ms-1">
                                <div class="dropdown dropdown-primary">
                                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                        <a class="dropdown-item d-flex align-items-center text-dark" href="https://shreethemes.in/doctris/layouts/admin/profile.html">
                                            <img src="assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="flex-1 ms-2">
                                                <span class="d-block mb-1">Calvin Carlo</span>
                                                <small class="text-muted">Orthopedic</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item text-dark" href="index.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                        <a class="dropdown-item text-dark" href="dr-profile.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span>Thông tin cá nhân</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="lock-screen.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span>Đăng xuất</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Thêm Nhân Viên</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><button class="btn btn-primary mt-4 mt-sm-0" onclick="window.location.href = 'ListDoctor'">
                                            Danh Sách Nhân Viên
                                        </button></li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-8 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-4">
                                            <img src="assets/images/doctors/01.jpg" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                        </div><!--end col-->



                                        <form class="mt-4" action="AddStaffServlet" method="POST" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Họ và tên</label>
                                                        <input name="name" id="name" type="text" class="form-control" placeholder="Full Name :" required>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Email</label>
                                                        <input name="email" id="email" type="email" class="form-control" placeholder="Your email :" required>
                                                    </div> 
                                                </div><!--end col-->
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Avatar</label>
                                                        <input name="avatar" id="avatar" type="file" class="form-control" accept="image/*" placeholder="Your avatar :" required>
                                                        <small id="avatar-error" class="text-danger"></small>
                                                    </div> 
                                                </div><!--end col-->
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Số Điện Thoại</label>
                                                        <input name="phone" id="phone" type="text" class="form-control" placeholder="Phone no :" required>
                                                    </div>                                                                               
                                                </div><!--end col-->


                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Ngày Sinh</label>
                                                        <input name="dateOfBirth"  type="date" class="form-control" required>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Phòng Ban</label>
                                                        <select name="departmentId" class="form-control department-name select2input" required>
                                                            <c:forEach var="department" items="${requestScope.listDepartment}">
                                                                <option value="${department.departmentId}">${department.departmentName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Role</label>
                                                        <select name="roleId" class="form-control department-name select2input" required>
                                                            <option value="2">Doctor</option>
                                                            <option value="3">Expert</option>
                                                            <option value="4">Receptionist</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Giới Tính</label>
                                                        <select name="gender" class="form-control gender-name select2input" required>
                                                            <option value="M">Male</option>
                                                            <option value="F">Female</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->


                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Vị trí Làm việc </label>

                                                        <select name="position" id="position" class="form-control department-name select2input" required>
                                                            <option value="Doctor">Doctor</option>
                                                            <option value="Expert">Expert</option>
                                                            <option value="Receptionist">Receptionist</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Giới Thiệu Bản Thân</label>
                                                        <input name="description" id="desctiption" type="text" class="form-control" placeholder="Your Description :" required>
                                                    </div> 
                                                </div><!--end col-->
                                                <div>
                                                    <c:if test="${not empty error}">
                                                        <div style="color: red">${error}</div>
                                                    </c:if>
                                                </div>

                                            </div><!--end row-->

                                            <button type="submit" class="btn btn-primary">Thêm Nhân Viên</button>
                                        </form>


                                    </div><!--end row-->
                                </div>
                            </div><!--end container-->

                            <!-- Footer Start -->
                            <footer class="bg-white shadow py-3">
                                <div class="container-fluid">
                                    <div class="row align-items-center">
                                        <div class="col">
                                            <div class="text-sm-start text-center">
                                                <p class="mb-0 text-muted"><script>document.write(new Date().getFullYear())</script> © MediSync. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="index.html" target="_blank" class="text-reset">Phúc Sơn</a>.</p>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </div><!--end container-->
                            </footer><!--end footer-->
                            <!-- End -->
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

                        <!-- View Appintment Start -->
                        <div class="modal fade" id="viewappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header border-bottom p-3">
                                        <h5 class="modal-title" id="exampleModalLabel">Appointment Detail</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-3 pt-4">
                                        <div class="d-flex align-items-center">
                                            <img src="assets/images/client/01.jpg" class="avatar avatar-small rounded-pill" alt="">
                                            <h5 class="mb-0 ms-3">Howard Tanner</h5>
                                        </div>
                                        <ul class="list-unstyled mb-0 d-md-flex justify-content-between mt-4">
                                            <li>
                                                <ul class="list-unstyled mb-0">
                                                    <li class="d-flex">
                                                        <h6>Age:</h6>
                                                        <p class="text-muted ms-2">25 year old</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6>Gender:</h6>
                                                        <p class="text-muted ms-2">Male</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6 class="mb-0">Department:</h6>
                                                        <p class="text-muted ms-2 mb-0">Cardiology</p>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li>
                                                <ul class="list-unstyled mb-0">
                                                    <li class="d-flex">
                                                        <h6>Date:</h6>
                                                        <p class="text-muted ms-2">20th Dec 2020</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6>Time:</h6>
                                                        <p class="text-muted ms-2">11:00 AM</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6 class="mb-0">Doctor:</h6>
                                                        <p class="text-muted ms-2 mb-0">Dr. Calvin Carlo</p>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- View Appintment End -->

                        <!-- Accept Appointment Start -->
                        <div class="modal fade" id="acceptappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-body py-5">
                                        <div class="text-center">
                                            <div class="icon d-flex align-items-center justify-content-center bg-soft-success rounded-circle mx-auto" style="height: 95px; width:95px;">
                                                <i class="uil uil-check-circle h1 mb-0"></i>
                                            </div>
                                            <div class="mt-4">
                                                <h4>Accept Appointment</h4>
                                                <p class="para-desc mx-auto text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment.</p>
                                                <div class="mt-4">
                                                    <a href="#" class="btn btn-soft-success">Accept</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accept Appointment End -->

                        <!-- Cancel Appointment Start -->
                        <div class="modal fade" id="cancelappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-body py-5">
                                        <div class="text-center">
                                            <div class="icon d-flex align-items-center justify-content-center bg-soft-danger rounded-circle mx-auto" style="height: 95px; width:95px;">
                                                <i class="uil uil-times-circle h1 mb-0"></i>
                                            </div>
                                            <div class="mt-4">
                                                <h4>Cancel Appointment</h4>
                                                <p class="para-desc mx-auto text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment.</p>
                                                <div class="mt-4">
                                                    <a href="#" class="btn btn-soft-danger">Cancel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Cancel Appointment End -->
                        <!-- Modal end -->

                        <!-- javascript -->
                        <script src="assets/js/jquery.min.js"></script>
                        <script src="assets/js/bootstrap.bundle.min.js"></script>
                        <!-- simplebar -->
                        <script src="assets/js/simplebar.min.js"></script>
                        <!-- Select2 -->
                        <script src="assets/js/select2.min.js"></script>
                        <script src="assets/js/select2.init.js"></script>
                        <!-- Icons -->
                        <script src="assets/js/feather.min.js"></script>
                        <!-- Main Js -->
                        <script src="assets/js/app.js"></script>
                        <script>
                                                        document.getElementById("avatar").addEventListener("change", function () {
                                                            var file = this.files[0];
                                                            var errorElement = document.getElementById("avatar-error");

                                                            if (file) {
                                                                var fileSize = file.size / 1024 / 1024; // Đổi sang MB
                                                                var fileType = file.type;

                                                                // Danh sách định dạng ảnh hợp lệ
                                                                var validImageTypes = ["image/jpeg", "image/png", "image/gif"];

                                                                if (!validImageTypes.includes(fileType)) {
                                                                    errorElement.textContent = "Chỉ được chọn file ảnh (JPG, PNG, GIF)!";
                                                                    this.value = ""; // Xóa file đã chọn
                                                                } else if (fileSize > 3) {
                                                                    errorElement.textContent = "File không được vượt quá 3MB!";
                                                                    this.value = ""; // Xóa file đã chọn
                                                                } else {
                                                                    errorElement.textContent = ""; // Xóa lỗi nếu hợp lệ
                                                                }
                                                            }
                                                        });
                        </script>
                        </body>

                        </html>