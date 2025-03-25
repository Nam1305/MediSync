<%-- 
    Document   : top-navbar
    Created on : Feb 15, 2025, 4:15:19 PM
    Author     : DIEN MAY XANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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

            <li class="list-inline-item mb-0 ms-1">
                <div class="dropdown dropdown-primary">
                    <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="${customer.avatar}" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                        <a class="dropdown-item d-flex align-items-center text-dark" href="customer-profile">
                            <img src="${customer.avatar}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                            <div class="flex-1 ms-2">
                                <span class="d-block mb-1">${customer.name}</span>

                            </div>
                        </a>
                        <a class="dropdown-item text-dark" href="change-password"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span>Đổi mật khẩu</a>
                        <a class="dropdown-item text-dark" href="listAppointments">
                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-calendar-alt align-middle h6"></i></span> Danh sách cuộc hẹn
                        </a>
                        <div class="dropdown-divider border-top"></div>
                        <a class="dropdown-item text-dark" href="logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span>Đăng xuất</a>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>

