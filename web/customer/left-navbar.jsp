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
            <a href="home">
                <img src="assets/images/logo-light.png" height="24" class="logo-light-mode" alt="">
                <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
            </a>
        </div>

        <ul class="sidebar-menu pt-3">


            <li>
                <a href="listAppointments">
                    <i class="uil uil-calendar-alt me-2"></i> Cuộc hẹn của tôi
                </a>
            </li>
            <li>
                <a href="customer-profile">
                    <i class="uil uil-calendar-alt me-2"></i> Tài khoản của tôi
                </a>
            </li>
            <li>
                <a href="home">
                    <i class="uil uil-calendar-alt me-2"></i> Trang chủ
                </a>
            </li>
        </ul>



        <!-- sidebar-menu  -->
    </div>
    <!-- sidebar-content  -->

</nav>



