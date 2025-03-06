<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div id="preloader">
    <div id="status">
        <div class="spinner">
            <div class="double-bounce1"></div>
            <div class="double-bounce2"></div>
        </div>
    </div>
</div>
<!-- Loader -->


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
            <li><a href="appointment.html"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Thông tin cuộc hẹn</a></li>

            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Nhân Viên</a>
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
                        <!--                                    <li><a href="patient-profile.html">Profile</a></li>-->
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
                <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Dịch Vụ</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="AddService">Thêm Dịch Vụ</a></li>
                        <li><a href="ListService">Danh Sách Dịch Vụ</a></li>
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
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Banner</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="manage-banners">Banner Management</a></li>
                    </ul>
                </div>
            </li>
            <li class="sidebar-dropdown">
                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Footer</a>
                <div class="sidebar-submenu">
                    <ul>
                        <li><a href="manage-footer">Footer Management</a></li>
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
