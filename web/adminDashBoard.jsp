
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                        <a href="landing/index-two.html">
                        <!--<a href="index.html">-->
                            <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                            <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                        </a>
                    </div>
                    
                    <ul class="sidebar-menu pt-3">
                        <li><a href="adminDashBoard.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                        <li><a href="appointment.html"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Appointment</a></li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Doctors</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="ListDoctor">Doctors</a></li>
                                    <li><a href="addStaff.jsp">Add Staff</a></li>
                                    
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="listCustomer">All Patients</a></li>
                                    <li><a href="addCustomer" >Add Patients</a></li>
                                    <li><a href="patient-profile.html">Profile</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="chat.html">Chat</a></li>
                                    <li><a href="email.html">Email</a></li>
                                    <li><a href="calendar.html">Calendar</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Pharmacy</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="shop.html">Shop</a></li>
                                    <li><a href="product-detail.html">Shop Detail</a></li>
                                    <li><a href="shopcart.html">Shopcart</a></li>
                                    <li><a href="checkout.html">Checkout</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="blogs.html">Blogs</a></li>
                                    <li><a href="blog-detail.html">Blog Detail</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Pages</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="faqs.html">FAQs</a></li>
                                    <li><a href="review.html">Reviews</a></li>
                                    <li><a href="invoice-list.html">Invoice List</a></li>
                                    <li><a href="invoice.html">Invoice</a></li>
                                    <li><a href="terms.html">Terms & Policy</a></li>
                                    <li><a href="privacy.html">Privacy Policy</a></li>
                                    <li><a href="error.html">404 !</a></li>
                                    <li><a href="blank-page.html">Blank Page</a></li>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="login.html">Login</a></li>
                                    <li><a href="signup.html">Signup</a></li>
                                    <li><a href="forgot-password.html">Forgot Password</a></li>
                                    <li><a href="lock-screen.html">Lock Screen</a></li>
                                    <li><a href="thankyou.html">Thank you...!</a></li>
                                </ul>
                            </div>
                        </li>

                        <li><a href="components.html"><i class="uil uil-cube me-2 d-inline-block"></i>Components</a></li>

                        <li><a href="landing/index-two.html" target="_blank"><i class="uil uil-window me-2 d-inline-block"></i>Landing page</a></li>
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
                            <div class="search-bar p-0 d-none d-md-block ms-2">
                                <div id="search" class="menu-search mb-0">
                                    <form role="search" method="get" id="searchform" class="searchform">
                                        <div>
                                            <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Search Keywords...">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>
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
                                        <a class="dropdown-item text-dark" href="dr-profile.html"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <h5 class="mb-0">Dashboard</h5>

                        <div class="row">
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-bed h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">558</h5>
                                            <p class="text-muted mb-0">Patients</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                            
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-file-medical-alt h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">$2164</h5>
                                            <p class="text-muted mb-0">Avg. costs</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                            
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-social-distancing h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">112</h5>
                                            <p class="text-muted mb-0">Staff Members</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                            
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-ambulance h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">16</h5>
                                            <p class="text-muted mb-0">Vehicles</p>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div><!--end col-->
                            
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-medkit h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">220</h5>
                                            <p class="text-muted mb-0">Appointment</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                            
                            <div class="col-xl-2 col-lg-4 col-md-4 mt-4">
                                <div class="card features feature-primary rounded border-0 shadow p-4">
                                    <div class="d-flex align-items-center">
                                        <div class="icon text-center rounded-md">
                                            <i class="uil uil-medical-drip h3 mb-0"></i>
                                        </div>
                                        <div class="flex-1 ms-2">
                                            <h5 class="mb-0">10</h5>
                                            <p class="text-muted mb-0">Operations</p>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-xl-8 col-lg-7 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h6 class="align-items-center mb-0">Patients visit by Gender</h6>
                                        
                                        <div class="mb-0 position-relative">
                                            <select class="form-select form-control" id="yearchart">
                                                <option selected>2020</option>
                                                <option value="2019">2019</option>
                                                <option value="2018">2018</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div id="dashboard" class="apex-chart"></div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-4 col-lg-5 mt-4">
                                <div class="card shadow border-0 p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h6 class="align-items-center mb-0">Patients by Department</h6>
                                        
                                        <div class="mb-0 position-relative">
                                            <select class="form-select form-control" id="dailychart">
                                                <option selected>Today</option>
                                                <option value="2019">Yesterday</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div id="department" class="apex-chart"></div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="row">
                            <div class="col-xl-4 col-lg-6 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="d-flex justify-content-between align-items-center p-4 border-bottom">
                                        <h6 class="mb-0"><i class="uil uil-calender text-primary me-1 h5"></i> Latest Appointment</h6>
                                        <h6 class="text-muted mb-0">55 Patients</h6>
                                    </div>

                                    <ul class="list-unstyled mb-0 p-4">
                                        <li>
                                            <div class="d-flex align-items-center justify-content-between">
                                                <div class="d-inline-flex">
                                                    <img src="assets/images/client/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                    <div class="ms-3">
                                                        <h6 class="text-dark mb-0 d-block">Calvin Carlo</h6>
                                                        <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                    </div>
                                                </div>
                                                <div>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-check icons"></i></a>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-times icons"></i></a>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="mt-4">
                                            <div class="d-flex align-items-center justify-content-between">
                                                <div class="d-inline-flex">
                                                    <img src="assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                    <div class="ms-3">
                                                        <h6 class="text-dark mb-0 d-block">Joya Khan</h6>
                                                        <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                    </div>
                                                </div>
                                                <div>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-check icons"></i></a>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-times icons"></i></a>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="mt-4">
                                            <div class="d-flex align-items-center justify-content-between">
                                                <div class="d-inline-flex">
                                                    <img src="assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                    <div class="ms-3">
                                                        <h6 class="text-dark mb-0 d-block">Amelia Muli</h6>
                                                        <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                    </div>
                                                </div>
                                                <div>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-check icons"></i></a>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-times icons"></i></a>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="mt-4">
                                            <div class="d-flex align-items-center justify-content-between">
                                                <div class="d-inline-flex">
                                                    <img src="assets/images/client/04.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                    <div class="ms-3">
                                                        <h6 class="text-dark mb-0 d-block">Nik Ronaldo</h6>
                                                        <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                    </div>
                                                </div>
                                                <div>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-check icons"></i></a>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-times icons"></i></a>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="mt-4">
                                            <div class="d-flex align-items-center justify-content-between">
                                                <div class="d-inline-flex">
                                                    <img src="assets/images/client/05.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                    <div class="ms-3">
                                                        <h6 class="text-dark mb-0 d-block">Crista Joseph</h6>
                                                        <small class="text-muted">Booking on 27th Nov, 2020</small>
                                                    </div>
                                                </div>
                                                <div>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-success"><i class="uil uil-check icons"></i></a>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-times icons"></i></a>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-4 col-lg-6 mt-4">
                                <div class="card chat chat-person border-0 shadow rounded">
                                    <div class="d-flex justify-content-between border-bottom p-4">
                                        <div class="d-flex">
                                            <img src="assets/images/doctors/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                            <div class="flex-1 overflow-hidden ms-3">
                                                <a href="#" class="text-dark mb-0 h6 d-block text-truncate">Cristino Murphy</a>
                                                <small class="text-muted"><i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i> Online</small>
                                            </div>
                                        </div>

                                        <ul class="list-unstyled mb-0">
                                            <li class="dropdown dropdown-primary list-inline-item">
                                                <button type="button" class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="uil uil-ellipsis-h icons"></i></button>
                                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3">
                                                    <a class="dropdown-item text-dark" href="#"><span class="mb-0 d-inline-block me-1"><i class="uil uil-user align-middle h6"></i></span> Profile</a>
                                                    <a class="dropdown-item text-dark" href="#"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                                    <a class="dropdown-item text-dark" href="#"><span class="mb-0 d-inline-block me-1"><i class="uil uil-trash align-middle h6"></i></span> Delete</a>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                    <ul class="p-4 list-unstyled mb-0 chat" data-simplebar style="background: url('assets/images/bg/bg-chat.png') center center; max-height: 295px;">
                                        <li>
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative">
                                                        <img src="assets/images/doctors/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">Hey Christopher</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>59 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="chat-right">
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative chat-user-image">
                                                        <img src="assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">Hello Cristino</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>45 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="chat-right">
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative chat-user-image">
                                                        <img src="assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">How can i help you?</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>44 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative">
                                                        <img src="assets/images/doctors/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">Nice to meet you</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>42 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative">
                                                        <img src="assets/images/doctors/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">Hope you are doing fine?</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>40 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="chat-right">
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative chat-user-image">
                                                        <img src="assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">I'm good thanks for asking</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>45 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative">
                                                        <img src="assets/images/doctors/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">I am intrested to know more about your prices and services you offer</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>35 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="chat-right">
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative chat-user-image">
                                                        <img src="assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">Sure please check below link to find more useful information <a href="https://1.envato.market/landrick" target="_blank" class="text-primary">https://shreethemes.in/landrick/</a></p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>25 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li>
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative">
                                                        <img src="assets/images/doctors/02.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">Thank you 😊</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>20 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>

                                        <li class="chat-right">
                                            <div class="d-inline-block">
                                                <div class="d-flex chat-type mb-3">
                                                    <div class="position-relative chat-user-image">
                                                        <img src="assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                                        <i class="mdi mdi-checkbox-blank-circle text-success on-off align-text-bottom"></i>
                                                    </div>
                                                        
                                                    <div class="flex-1 chat-msg" style="max-width: 500px;">
                                                        <p class="text-muted small shadow px-3 py-2 bg-white rounded mb-1">Welcome</p>
                                                        <small class="text-muted msg-time"><i class="uil uil-clock-nine me-1"></i>18 min ago</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>

                                    <div class="p-2 rounded-bottom shadow">
                                        <div class="row">
                                            <div class="col">
                                                <input type="text" class="form-control border" placeholder="Enter Message...">
                                            </div>
                                            <div class="col-auto">
                                                <a href="#" class="btn btn-icon btn-primary"><i class="uil uil-message icons"></i></a>
                                                <a href="#" class="btn btn-icon btn-primary"><i class="uil uil-smile icons"></i></a>
                                                <a href="#" class="btn btn-icon btn-primary"><i class="uil uil-paperclip icons"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-4 col-lg-12 mt-4">
                                <div class="card border-0 shadow rounded">
                                    <div class="p-4 border-bottom">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <h6 class="mb-0"><i class="uil uil-user text-primary me-1 h5"></i> Patients Reviews</h6>
                                            
                                            <div class="mb-0 position-relative">
                                                <select class="form-select form-control" id="dailypatient">
                                                    <option selected>New</option>
                                                    <option value="2019">Old</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <ul class="list-unstyled mb-0 p-4" data-simplebar style="height: 355px;">
                                        <li class="d-flex align-items-center justify-content-between">
                                            <div class="d-flex align-items-center">
                                                <img src="assets/images/doctors/01.jpg" class="avatar avatar-small rounded-circle border shadow" alt="">
                                                <div class="flex-1 ms-3">
                                                    <span class="d-block h6 mb-0">Dr. Calvin Carlo</span>
                                                    <small class="text-muted">Orthopedic</small>

                                                    <ul class="list-unstyled mb-0">
                                                        <li class="list-inline-item text-muted">(45)</li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                    </ul>
                                                </div>
                                            </div>

                                            <p class="text-muted mb-0">150 Patients</p>
                                        </li>

                                        <li class="d-flex align-items-center justify-content-between mt-4">
                                            <div class="d-flex align-items-center">
                                                <img src="assets/images/doctors/02.jpg" class="avatar avatar-small rounded-circle border shadow" alt="">
                                                <div class="flex-1 ms-3">
                                                    <span class="d-block h6 mb-0">Dr. Cristino Murphy</span>
                                                    <small class="text-muted">Gynecology</small>

                                                    <ul class="list-unstyled mb-0">
                                                        <li class="list-inline-item text-muted">(75)</li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                    </ul>
                                                </div>
                                            </div>

                                            <p class="text-muted mb-0">350 Patients</p>
                                        </li>

                                        <li class="d-flex align-items-center justify-content-between mt-4">
                                            <div class="d-flex align-items-center">
                                                <img src="assets/images/doctors/03.jpg" class="avatar avatar-small rounded-circle border shadow" alt="">
                                                <div class="flex-1 ms-3">
                                                    <span class="d-block h6 mb-0">Dr. Alia Reddy</span>
                                                    <small class="text-muted">Psychotherapy</small>

                                                    <ul class="list-unstyled mb-0">
                                                        <li class="list-inline-item text-muted">(48)</li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                    </ul>
                                                </div>
                                            </div>

                                            <p class="text-muted mb-0">450 Patients</p>
                                        </li>

                                        <li class="d-flex align-items-center justify-content-between mt-4">
                                            <div class="d-flex align-items-center">
                                                <img src="assets/images/doctors/04.jpg" class="avatar avatar-small rounded-circle border shadow" alt="">
                                                <div class="flex-1 ms-3">
                                                    <span class="d-block h6 mb-0">Dr. Toni Kover</span>
                                                    <small class="text-muted">Dentist</small>

                                                    <ul class="list-unstyled mb-0">
                                                        <li class="list-inline-item text-muted">(68)</li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                    </ul>
                                                </div>
                                            </div>

                                            <p class="text-muted mb-0">484 Patients</p>
                                        </li>

                                        <li class="d-flex align-items-center justify-content-between mt-4">
                                            <div class="d-flex align-items-center">
                                                <img src="assets/images/doctors/05.jpg" class="avatar avatar-small rounded-circle border shadow" alt="">
                                                <div class="flex-1 ms-3">
                                                    <span class="d-block h6 mb-0">Dr. Jennifer Ballance</span>
                                                    <small class="text-muted">Cardiology</small>

                                                    <ul class="list-unstyled mb-0">
                                                        <li class="list-inline-item text-muted">(55)</li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                        <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                    </ul>
                                                </div>
                                            </div>

                                            <p class="text-muted mb-0">476 Patients</p>
                                        </li>
                                    </ul>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div>
                </div><!--end container-->

                <!-- Footer Start -->
                <footer class="bg-white shadow py-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="text-sm-start text-center">
                                    <p class="mb-0 text-muted"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
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
        
    </body>

</html>