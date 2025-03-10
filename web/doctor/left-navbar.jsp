<%-- 
    Document   : left-navbar
    Created on : Feb 15, 2025, 4:03:56 PM
    Author     : DIEN MAY XANH
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="index.html">
                <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>

        <ul class="sidebar-menu pt-3">
            <li>
                <a href="doctorappointment">
                    <i class="uil uil-calendar-alt me-2"></i> Lịch hẹn
                </a>
            </li>

            <li>
                <a href="schedule">
                    <i class="uil uil-clock me-2"></i> Lịch làm việc
                </a>
            </li>                   

            <li>
                <a href="registershift">
                    <i class="uil uil-user-plus me-2"></i> Đăng ký ca làm
                </a>
            </li>

            <li>
                <a href="listinvoice">
                    <i class="uil uil-receipt me-2"></i> Hóa đơn
                </a>
            </li>

            <li>
                <a href="ListPatient">
                    <i class="uil uil-user-nurse me-2"></i> Bệnh nhân
                </a>
            </li>

            <li>
                <a href="mfeedback">
                    <i class="uil uil-star me-2"></i> Đánh giá của bệnh nhân
                </a>
            </li>

            <li class="has-submenu parent-menu-item">
                <a href="doctorprofile">
                    <i class="uil uil-user-circle me-2"></i> Tài khoản của tôi
                </a>
            </li>

            <li class="has-submenu parent-menu-item">
                <a href="home">
                    <i class="uil uil-home me-2"></i> Trang chủ
                </a>
            </li>
        </ul>



        <!-- sidebar-menu  -->
    </div>
    <!-- sidebar-content  -->

</nav>



