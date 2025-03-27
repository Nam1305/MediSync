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

        <c:choose>
            <c:when test="${not empty sessionScope.staff}">
                <c:choose>
                    <c:when test="${sessionScope.staff.role.roleId == 1}">
                        <ul class="sidebar-menu pt-3">
                            <li><a href="AdminDashBoard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Thống kê</a></li>


                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Nhân Viên</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="ListDoctor">Danh sách nhân viên</a></li>
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


                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Dịch Vụ</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="ListService">Danh Sách Dịch Vụ</a></li>
                                    </ul>
                                </div>
                            </li>

                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Tin tức</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="blogs">Danh sách tin tức</a></li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Banner</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="manage-banners">Quản lý banner</a></li>
                                    </ul>
                                </div>
                            </li>
                            <li class="sidebar-dropdown">
                                <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Chân trang</a>
                                <div class="sidebar-submenu">
                                    <ul>
                                        <li><a href="manage-footer">Quản lý chân trang</a></li>
                                    </ul>
                                </div>
                            </li>

                           
                            
                            
                            <li>
                                <a href="doctorprofile">
                                    <i class="uil uil-user-circle me-2 d-inline-block"></i> Tài khoản của tôi
                                </a>
                            </li>

                        </ul>
                    </c:when>
                    <c:when test="${sessionScope.staff.role.roleId == 2 or sessionScope.staff.role.roleId == 3}">
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
                                <a href="ListPatient">
                                    <i class="uil uil-user-nurse me-2"></i> Bệnh nhân
                                </a>
                            </li>

                            <li>
                                <a href="mfeedback">
                                    <i class="uil uil-star me-2"></i> Đánh giá của bệnh nhân
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
                    </c:when>
                    <c:when test="${sessionScope.staff.role.roleId == 4}">
                        <ul class="sidebar-menu pt-3">
                            <li>
                                <a href="shift-approval">
                                    <i class="uil uil-calendar-alt me-2"></i> Duyệt ca làm việc
                                </a>
                            </li>
                            <li>
                                <a href="schedule-management">
                                    <i class="uil uil-calendar-alt me-2"></i> Xếp lịch làm việc cho bác sỹ/chuyên gia
                                </a>
                            </li>
                            <li>
                                <a href="confirmappointment">
                                    <i class="uil uil-check-circle me-2"></i> Xác nhận lịch hẹn bệnh nhân
                                </a>
                            </li>
                            <li>
                                <a href="listinvoice">
                                    <i class="uil uil-receipt me-2"></i> Hóa đơn
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

                    </c:when>
                </c:choose>
            </c:when>
            <c:otherwise>
                <ul>
                    <li>Không có nhân viên nào trong session!</li>
                    <li class="has-submenu parent-menu-item">
                        <a href="home">
                            <i class="uil uil-home me-2"></i> Trang chủ
                        </a>
                    </li>
                </ul>
            </c:otherwise>
        </c:choose>


        <!-- sidebar-menu  -->
    </div>
    <!-- sidebar-content  -->

</nav>



