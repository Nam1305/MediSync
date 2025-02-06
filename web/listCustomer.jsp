
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                        <a href="index.html">
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
                                    <li><a href="ListDoctor">Staff list</a></li>
                                    <li><a href="addStaff.jsp">Add Staff</a></li>
                                  
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="listCustomer">All Patients</a></li>
                                    <li><a href="addCustomer">Add Patients</a></li>
                                    <!--                                    <li><a href="patient-profile.html">Profile</a></li>-->
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
                            <div class="search-bar p-0 d-none d-lg-block ms-2">
                                <div id="search" class="menu-search mb-0">
                                    <form role="search" method="post" id="searchform" class="searchform" action="listCustomer">
                                        <div>
                                            <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Tìm kiếm bệnh nhân: tên, sđt" style="width: 100%; max-width: 600px;">
                                            <input type="hidden" name="action" value="search">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <ul class="list-unstyled mb-0">
                            <!--                            <li class="list-inline-item mb-0">
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
                                                        </li>-->

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
                                        <a class="dropdown-item text-dark" href="adminDashBoard.jsp"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
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
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Danh sách bệnh nhân</h5>



                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Doctris</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Patients</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row" >
                            <div class="col-sm-12">
                                <c:if test="${not empty noti}">
                                    <c:choose>
                                        <c:when test="${noti == 'success'}">
                                            <div class="alert alert-success" id="statusMess">Customer edited successfully!</div>
                                        </c:when>
                                        <c:when test="${noti == 'fail'}">
                                            <div class="alert alert-danger" id="statusMess">Failed to edit customer. Please try again.</div>
                                        </c:when>
                                        <c:when test="${noti == 'failDelete'}">
                                            <div class="alert alert-danger" id="statusMess">Failed to delete customer. Please try again.</div>
                                        </c:when>
                                        <c:when test="${noti == 'successDelete'}">
                                            <div class="alert alert-success" id="statusMess">Customer is deleted.</div>
                                        </c:when>    
                                    </c:choose>
                                </c:if>
                            </div>
                        </div>
                        <form action="listCustomer" method="get">
                            <input type="hidden" name="page" value="${requestScope.currentPage != null ? requestScope.currentPage : 1}" />
                            <div class="d-flex justify-content-between mb-3">
                                <div class="d-flex">
                                    <!-- Dropdown menu để chọn trạng thái -->
                                    <select class="form-select me-2" name="status">
                                        <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả</option>
                                        <option value="Active" <c:if test="${status == 'Active'}">selected</c:if>>Active</option>
                                        <option value="Inactive" <c:if test="${status == 'Inactive'}">selected</c:if>>Inactive</option>
                                        </select>

                                        <!-- Dropdown menu để chọn giới tính -->
                                        <select class="form-select" name="gender">
                                            <option value="" <c:if test="${empty gender}">selected</c:if>>Tất cả</option>
                                        <option value="M" <c:if test="${gender == 'M'}">selected</c:if>>Nam</option>
                                        <option value="F" <c:if test="${gender == 'F'}">selected</c:if>>Nữ</option>
                                        </select>
                                    </div>
                                </div>
                                <!-- Thêm tham số 'page' vào form để đảm bảo nó luôn được gửi -->
                                
                            <!-- Nút gửi form -->
                            <button type="submit" class="btn btn-primary">Lọc</button>
                        </form>

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 50px;">ID</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Họ và Tên</th>
                                                <!--                                                <th class="border-bottom p-3">Age</th>-->
                                                <th class="border-bottom p-3">Giới tính</th>
                                                <!--                                                <th class="border-bottom p-3">Address</th>-->
                                                <th class="border-bottom p-3">Địa chỉ</th>
                                                <th class="border-bottom p-3">Số Điện Thoại</th>
                                                <th class="border-bottom p-3" style="min-width: 150px;">Ngày sinh</th>
                                                <th class="border-bottom p-3">Email</th>
                                                <th class="border-bottom p-3">Trạng thái</th>
                                                <th class="border-bottom p-3" style="min-width: 100px;"></th>
                                            </tr>
                                        </thead>
                                        <!--tbody-start-->
                                        <c:set var="profile" value="${requestScope.profile}" />

                                        <tbody>
                                            <c:forEach var="customers" items="${customers}">
                                                <tr>
                                                    <th class="p-3">${customers.customerId}</th>
                                                    <td class="py-3">
                                                        <a href="#" class="text-dark">
                                                            <div class="d-flex align-items-center">
                                                                <img src="${not empty customers.avatar && customers.avatar.contains('/uploads/') ? pageContext.request.contextPath.concat(customers.avatar) : customers.avatar}" 
                                                                     class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                <span class="ms-2">${customers.name}</span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td class="p-3">${customers.gender}</td>
                                                    <td class="p-3">${customers.address}</td>
                                                    <td class="p-3">${customers.phone}</td>
                                                    <td class="p-3">${customers.dateOfBirth}</td>
                                                    <td class="p-3">${customers.email}</td>
                                                    <td class="p-3"><span class="badge bg-soft-success">${customers.status}</span></td>
                                                    <!--                                                    <td class="p-3"></td>-->
                                                    <td class="text-end p-3">
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-primary" 
                                                           data-bs-toggle="modal" 
                                                           data-bs-target="#viewprofile"
                                                           data-customer-id="${customers.customerId}"
                                                           data-customer-avatar="${customers.avatar}"
                                                           data-customer-name="${customers.name}"
                                                           data-customer-age="${customers.getAge()}"
                                                           data-customer-gender="${customers.gender}"
                                                           data-customer-department="${customers.getDepartment()}"
                                                           data-customer-doctor="${customers.getDoctor()}"
                                                           data-customer-date="${customers.getAppointmentDate()}"
                                                           data-customer-time="${customers.getAppointmentTime()}">

                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                        <!-- Edit button with data-* attributes for customer info -->
                                                        <a href="#" class="btn btn-icon btn-pills btn-soft-success" 
                                                           data-bs-toggle="modal" 
                                                           data-bs-target="#editprofile"
                                                           data-customer-id="${customers.customerId}"
                                                           data-customer-name="${customers.name}"
                                                           data-customer-gender="${customers.gender}"
                                                           data-customer-email="${customers.email}"
                                                           data-customer-phone="${customers.phone}"
                                                           data-customer-address="${customers.address}"
                                                           data-customer-dob="${customers.dateOfBirth}">
                                                            <i class="uil uil-pen"></i>
                                                        </a>
                                                        <a href="deleteCustomer?id=${customers.customerId}" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-trash"></i></a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <!--Tbody-end-->
                                    </table>

                                </div>
                            </div>
                        </div><!--end row-->

                        <div class="row text-center">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">Showing 1 - 10 out of ${requestScope.totalCustomers}</span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <!--                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Previous">Prev</a></li>-->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="listCustomer?status=${requestScope.status}&gender=${requestScope.gender}&page=${currentPage - 1}" aria-label="Previous">Prev</a>
                                            </li>
                                        </c:if>
                                        <!--                                        <li class="page-item active"><a class="page-link" href="javascript:void(0)">1</a></li>
                                                                                <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
                                                                                <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>-->

                                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="listCustomer?status=${requestScope.status}&gender=${requestScope.gender}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <!--                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Next">Next</a></li>-->
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="listCustomer?status=${requestScope.status}&gender=${requestScope.gender}&page=${currentPage + 1}" aria-label="Next">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div><!--end col-->

                            <!-- PAGINATION END -->
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

        <!-- Modal start -->
        <div class="modal fade" id="editprofile" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title" id="exampleModalLabel">Profile Settings</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <form class="mt-4" method="POST" action="editCustomer">
                            <!--input hidden-->
                            <input type="hidden" name="customerId" id="customerId">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Họ và Tên</label>
                                        <input name="full-name" id="full-name" type="text" class="form-control" placeholder="Full name:">
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Giới tính</label>
                                        <div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="male" value="M">
                                                <label class="form-check-label" for="male">Male</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="female" value="F">
                                                <label class="form-check-label" for="female">Female</label>
                                            </div>
                                        </div>
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Your Email</label>
                                        <input name="email" id="email" type="email" class="form-control" placeholder="Your email :">
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Số Điện Thoại</label>
                                        <input name="number" id="number" type="text" class="form-control" placeholder="Phone number:">
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Địa chỉ</label>
                                        <input name="address" id="address" type="text" class="form-control" placeholder="Your address:">
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Ngày sinh</label>
                                        <input name="dob" id="dob" type="date" class="form-control" placeholder="Your date of birth:">
                                    </div>
                                </div><!--end col-->

                            </div><!--end row-->

                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="submit" id="submit" name="send" class="btn btn-primary" value="Lưu thay đổi">
                                </div><!--end col-->
                            </div><!--end row-->
                        </form><!--end form-->
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal end -->

        <!-- Profile-Start -->
        <div class="modal fade" id="viewprofile" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title" id="exampleModalLabel1">Thông tin chi tiết</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <div class="d-flex align-items-center">
                            <!--Avatar-Detail-Profile  -->
                            <img id="profileAvatar" src="" class="avatar avatar-small rounded-pill" alt="">
                            <h5 class="mb-0 ms-3" id="profileName"></h5>
                        </div>
                        <ul class="list-unstyled mb-0 d-md-flex justify-content-between mt-4">
                            <li>
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex">
                                        <h6>Age:</h6>
                                        <p class="text-muted ms-2" id="profileAge"></p>
                                    </li>

                                    <li class="d-flex">
                                        <h6>Gender:</h6>
                                        <p class="text-muted ms-2" id="profileGender"></p>
                                    </li>

                                    <li class="d-flex">
                                        <h6 class="mb-0">Department:</h6>
                                        <p class="text-muted ms-2 mb-0" id="profileDepartment"></p>
                                    </li>
                                </ul>
                            </li>
                            <li>
                                <ul class="list-unstyled mb-0">
                                    <li class="d-flex">
                                        <h6>Date:</h6>
                                        <p class="text-muted ms-2" id="profileDate"></p>
                                    </li>

                                    <li class="d-flex">
                                        <h6>Time:</h6>
                                        <p class="text-muted ms-2" id="profileTime"></p>
                                    </li>

                                    <li class="d-flex">
                                        <h6 class="mb-0">Doctor:</h6>
                                        <p class="text-muted ms-2 mb-0" id="profileDoctor"></p>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- Profile End -->
        <!-- Modal end -->

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

        <script>

                                        document.addEventListener("DOMContentLoaded", function () {
                                            // Xử lý sự kiện khi nhấn "Xem chi tiết"
                                            document.querySelectorAll('[data-bs-target="#viewprofile"]').forEach(button => {
                                                button.addEventListener("click", function () {
                                                    // Lấy dữ liệu từ data-attribute
                                                    const customerId = this.getAttribute("data-customer-id");
                                                    const customerName = this.getAttribute("data-customer-name");
                                                    const customerGender = this.getAttribute("data-customer-gender");
                                                    const customerAge = this.getAttribute("data-customer-age");
                                                    const customerDepartment = this.getAttribute("data-customer-department");
                                                    const customerDoctor = this.getAttribute("data-customer-doctor");
                                                    const customerDate = this.getAttribute("data-customer-date");
                                                    const customerTime = this.getAttribute("data-customer-time");
                                                    const customerAvatar = this.getAttribute("data-customer-avatar");

                                                    // Hiển thị dữ liệu trong modal "Xem chi tiết"
                                                    document.getElementById("profileName").textContent = customerName;
                                                    document.getElementById("profileAge").textContent = customerAge;
                                                    document.getElementById("profileDepartment").textContent = customerDepartment;
                                                    document.getElementById("profileDoctor").textContent = customerDoctor;
                                                    document.getElementById("profileDate").textContent = customerDate;
                                                    document.getElementById("profileTime").textContent = customerTime;
                                                    document.getElementById("profileGender").textContent = customerGender;
                                                    document.getElementById("profileAvatar").src = customerAvatar;
                                                });
                                            });

                                            // Xử lý sự kiện khi nhấn "Chỉnh sửa"
                                            document.querySelectorAll('[data-bs-target="#editprofile"]').forEach(button => {
                                                button.addEventListener("click", function () {
                                                    // Lấy dữ liệu từ data-attribute
                                                    const customerId = this.getAttribute("data-customer-id");
                                                    const customerName = this.getAttribute("data-customer-name");
                                                    const customerGender = this.getAttribute("data-customer-gender");
                                                    const customerEmail = this.getAttribute("data-customer-email");
                                                    const customerPhone = this.getAttribute("data-customer-phone");
                                                    const customerAddress = this.getAttribute("data-customer-address");
                                                    const customerDob = this.getAttribute("data-customer-dob");

                                                    // Điền dữ liệu vào form trong modal "Chỉnh sửa"
                                                    document.getElementById("customerId").value = customerId;
                                                    document.getElementById("full-name").value = customerName;
                                                    document.getElementById("email").value = customerEmail;
                                                    document.getElementById("number").value = customerPhone;
                                                    document.getElementById("address").value = customerAddress;
                                                    document.getElementById("dob").value = customerDob;

                                                    // Chọn giới tính
                                                    if (customerGender === "M") {
                                                        document.getElementById("male").checked = true;
                                                    } else if (customerGender === "F") {
                                                        document.getElementById("female").checked = true;
                                                    }
                                                });
                                            });

                                            // Ẩn thông báo sau 5 giây nếu có
                                            var statusMessage = document.getElementById("statusMess");
                                            if (statusMessage) {
                                                setTimeout(function () {
                                                    statusMessage.style.display = "none";
                                                }, 5000);
                                            }
                                        });
        </script>

    </body>

</html>
