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
                <a href="shift-approval">
                    <i class="uil uil-calendar-alt me-2"></i> Duyệt ca làm việc
                </a>
            </li>
            <li>
                <a href="confirmappointment">
                    <i class="uil uil-check-circle me-2"></i> Xác nhận lịch hẹn bệnh nhân
                </a>
            </li>
            <li>
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



