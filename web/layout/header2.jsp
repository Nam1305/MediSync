<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Navigation Start -->
<header id="topnav" class="navigation sticky">
    <div class="container">
        <!-- Start Mobile Toggle -->
        <div class="menu-extras">
            <div class="menu-item">
                <!-- Mobile menu toggle-->
                <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                    <div class="lines">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </a>
                <!-- End mobile menu toggle-->
            </div>
        </div>
        <!-- End Mobile Toggle -->

        <!-- Start Dropdown -->
        <ul class="dropdowns list-inline mb-0">
            <!-- Profile dropdown section -->
            <li class="list-inline-item mb-0 ms-1">
                <div class="dropdown dropdown-primary">
                    <c:choose>
                        <c:when test="${staff != null || customer != null}">
                            <!-- Logged in user -->
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <img src="${staff != null ? staff.avatar : customer.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                            </button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" 
                                   href="${staff != null ? 'staffProfile' : (customer != null ? 'customer-profile' : '#')}">
                                    <img src="${staff != null ? staff.avatar : customer.avatar}" 
                                         class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">${staff != null ? staff.name : customer.name}</span>
                                        <small class="text-muted">
                                            <c:choose>
                                                <c:when test="${staff != null}">
                                                    ${staff.department.departmentName}
                                                </c:when>
                                                <c:otherwise>
                                                    Khách hàng
                                                </c:otherwise>
                                            </c:choose>
                                        </small>
                                    </div>
                                </a>

                                <a class="dropdown-item text-dark" href="change-password">
                                    <span class="mb-0 d-inline-block me-1"><i class="uil uil-key-skeleton align-middle h6"></i></span> Đổi mật khẩu
                                </a>
                                <c:if test="${customer != null}">
                                    <a class="dropdown-item text-dark" href="listAppointments">
                                        <span class="mb-0 d-inline-block me-1"><i class="uil uil-calendar-alt align-middle h6"></i></span> Danh sách cuộc hẹn
                                    </a>
                                </c:if>

                                <c:if test="${staff != null}">
                                    <a class="dropdown-item text-dark" href="doctorappointment">
                                        <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span>Bảng điều khiển
                                    </a>
                                </c:if>

                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="logout">
                                    <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Not logged in -->
                            <a href="login" class="btn btn-soft-primary">
                                <i class="uil uil-user align-middle"></i> Đăng nhập
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </li>
        </ul>
        <!-- End Dropdown -->

        <div id="navigation">
            <!-- Navigation Menu-->   
            <ul class="navigation-menu nav-left">
                <li class="parent-menu-item">
                    <a href="home">Trang chủ</a><span class="menu-arrow"></span>
                </li>

                <li class="has-submenu parent-parent-menu-item">
                    <a href="listDoctor.jsp">Bác Sĩ</a><span class="menu-arrow"></span>
                </li>

                <li><a href="listBlog" class="sub-menu-item">Tin tức</a></li>
                
                <li><a href="services" class="sub-menu-item">Dịch vụ</a></li>
            </ul><!--end navigation menu-->
        </div><!--end navigation-->
    </div><!--end container-->
</header>
<!-- Navigation End -->