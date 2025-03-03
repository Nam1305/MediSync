<%-- 
    Document   : header
    Created on : Feb 24, 2025, 11:45:47 AM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <!-- Start Page Content -->
        <%
        String currentPage = request.getRequestURI();
        boolean isListDoctorPage = currentPage.endsWith("ListDoctor") || currentPage.contains("listDoctor.jsp");
        boolean isListDepartmentPage = currentPage.endsWith("ListDepartment") || currentPage.contains("listDepartment.jsp");
        boolean isListServicePage = currentPage.endsWith("ListService") || currentPage.contains("listService.jsp");
        %>

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
                        <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" >
                            <i class="uil uil-bars"></i>
                        </a>
                        <% if (isListDoctorPage) { %>
                        <div class="search-bar p-0 d-none d-lg-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form action="ListDoctor" method="get" class="searchform">
                                    <input type="text" class="form-control border rounded-pill" name="s" placeholder="Search by name or phone...">
                                    <input type="submit" value="Search">
                                </form>
                            </div>
                        </div>
                        <% } %>
                        <% if (isListDepartmentPage) { %>
                        <div class="search-bar p-0 d-none d-lg-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form action="ListDepartment" method="get" class="searchform">
                                    <input type="text" class="form-control border rounded-pill" name="search" placeholder="Search by name ">
                                    <input type="submit" value="Search">
                                </form>
                            </div>
                        </div>
                        <% } %>
                        <% if (isListServicePage) { %>
                        <div class="search-bar p-0 d-none d-lg-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form action="ListService" method="get" class="searchform">
                                    <input type="text" class="form-control border rounded-pill" name="search" placeholder="Search by name ">
                                    <input type="submit" value="Search">
                                </form>
                            </div>
                        </div>
                        <% } %>
                    </div>
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
                                <a class="dropdown-item text-dark" href="doctorProfile"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span>Thông tin cá nhân</a>
                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất</a>
                            </div>
                        </div>
                    </li>
                    </ul>
                </div>
            </div>
    </body>
</html>
