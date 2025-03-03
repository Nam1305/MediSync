<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : header
    Created on : Feb 24, 2025, 11:45:47 AM
    Author     : Acer
--%>



<!-- Lấy thông tin nhân viên từ session -->
<c:set var="staff" value="${sessionScope.staff}" />

<!-- Kiểm tra nếu có staff và roleId == 1 thì hiển thị header -->
<c:if test="${not empty staff and staff.role.roleId == 1}">
    <!-- Start Page Content -->
    <c:set var="currentPage" value="${pageContext.request.requestURI}" />
    <c:set var="isListDoctorPage" value="${fn:endsWith(currentPage, 'ListDoctor') or fn:contains(currentPage, 'listDoctor.jsp')}" />
    <c:set var="isListDepartmentPage" value="${fn:endsWith(currentPage, 'ListDepartment') or fn:contains(currentPage, 'listDepartment.jsp')}" />
    <c:set var="isListServicePage" value="${fn:endsWith(currentPage, 'ListService') or fn:contains(currentPage, 'listService.jsp')}" />

   
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
                    <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2">
                        <i class="uil uil-bars"></i>
                    </a>

                    <!-- Thanh tìm kiếm -->
                    <c:if test="${isListDoctorPage}">
                        <div class="search-bar p-0 d-none d-lg-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form action="ListDoctor" method="get" class="searchform">
                                    <input type="text" class="form-control border rounded-pill" name="s" placeholder="Search by name or phone...">
                                    <input type="submit" value="Search">
                                </form>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${isListDepartmentPage}">
                        <div class="search-bar p-0 d-none d-lg-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form action="ListDepartment" method="get" class="searchform">
                                    <input type="text" class="form-control border rounded-pill" name="search" placeholder="Search by name ">
                                    <input type="submit" value="Search">
                                </form>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${isListServicePage}">
                        <div class="search-bar p-0 d-none d-lg-block ms-2">
                            <div id="search" class="menu-search mb-0">
                                <form action="ListService" method="get" class="searchform">
                                    <input type="text" class="form-control border rounded-pill" name="search" placeholder="Search by name ">
                                    <input type="submit" value="Search">
                                </form>
                            </div>
                        </div>
                    </c:if>
                </div>

                <li class="list-inline-item mb-0 ms-1">
                    <div class="dropdown dropdown-primary">
                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img src="assets/images/doctors/01.jpg" class="avatar avatar-ex-small rounded-circle" alt="">
                        </button>
                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                            <a class="dropdown-item d-flex align-items-center text-dark" href="doctorProfile">
                                <img src="assets/images/doctors/01.jpg" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                <div class="flex-1 ms-2">
                                    <span class="d-block mb-1">${staff.name}</span>
                                    <small class="text-muted">Admin</small>
                                </div>
                            </a>
                            <a class="dropdown-item text-dark" href="adminDashBoard.jsp">
                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard
                            </a>
                            <a class="dropdown-item text-dark" href="doctorProfile">
                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span>Thông tin cá nhân
                            </a>
                            <div class="dropdown-divider border-top"></div>
                            <a class="dropdown-item text-dark" href="logout">
                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                            </a>
                        </div>
                    </div>
                </li>
            
            </div>
        </div>
   
</c:if>



<!--         Navigation Start 
        <header id="topnav" class="navigation sticky">
            <div class="container">
                 Start Mobile Toggle 
                <div class="menu-extras">
                    <div class="menu-item">
                         Mobile menu toggle
                        <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>

                                <a class="dropdown-item text-dark" href="change-password">
                                    <span class="mb-0 d-inline-block me-1"><i class="uil uil-key-skeleton align-middle h6"></i></span> Đổi mật khẩu
                                </a>
                                <c:if test="${customer != null}">
                                    <a class="dropdown-item text-dark" href="listAppointments">
                                        <span class="mb-0 d-inline-block me-1"><i class="uil uil-calendar-alt align-middle h6"></i></span> Thông tin chi tiết
                                    </a>
                                </c:if>
                                <c:if test="${staff != null}">
                                    <a class="dropdown-item text-dark" href="doctorappointment">
                                        <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> DashBoard
                                    </a>
                                </c:if>

                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="logout">
                                    <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                                </a>

                            </div>
                        </a>
                         End mobile menu toggle
                    </div>
                </div>
                 End Mobile Toggle 

                 Start Dropdown 
                <ul class="dropdowns list-inline mb-0">
                     Profile dropdown section 
                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <c:choose>
                                <c:when test="${staff != null || customer != null}">
                                     Logged in user 
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
                                                            Customer
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
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-calendar-alt align-middle h6"></i></span> Thông tin chi tiết
                                            </a>
                                        </c:if>
                                        <c:if test="${staff != null}">
                                            <a class="dropdown-item text-dark" href="doctorprofile">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Profile
                                            </a>
                                        </c:if>
                                        <c:if test="${staff != null}">
                                            <a class="dropdown-item text-dark" href="doctorappointment">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> DashBoard
                                            </a>
                                        </c:if>

                                        <div class="dropdown-divider border-top"></div>
                                        <a class="dropdown-item text-dark" href="logout">
                                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                     Not logged in 
                                    <a href="login" class="btn btn-soft-primary">
                                        <i class="uil uil-user align-middle"></i> Đăng nhập
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
                 End Dropdown 

                <div id="navigation">
                     Navigation Menu   
                    <ul class="navigation-menu nav-left nav-light">
                        <li class="parent-menu-item">
                            <a href="home">Trang chủ</a><span class="menu-arrow"></span>
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="allDoctors">Bác Sĩ</a><span class="menu-arrow"></span>
                        </li>

                        <li><a href="listBlog" class="sub-menu-item">Blogs</a></li>

                        <li><a href="services" class="sub-menu-item">Dịch vụ</a></li>
                    </ul>end navigation menu
                </div>end navigation
            </div>end container
        </header>
         Navigation End -->



