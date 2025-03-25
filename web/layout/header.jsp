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
    <c:set var="isListCustomerPage" value="${fn:endsWith(currentPage, 'listCustomer') or fn:contains(currentPage, 'listCustomer.jsp')}" />
    <c:set var="isListBlogPage" value="${fn:endsWith(currentPage, 'blogs') or fn:contains(currentPage, 'blogs.jsp')}" />


    <div class="top-header">
        <div class="header-bar d-flex justify-content-between border-bottom">
            <div class="d-flex align-items-center">
                <a href="#" class="logo-icon">
                    <img src="../assets/images/logo-icon.png" height="30" class="small" alt="">
                    <span class="big">
                        <img src="../assets/images/logo-light.png" height="24" class="logo-light-mode" alt="">
                        <img src="../assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
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
                                <input type="text" class="form-control border rounded-pill" name="s" value="${s}" placeholder="Tìm kiếm theo tên hoặc số điện thoại...">
                                <input type="submit" value="Search">
                            </form>
                        </div>
                    </div>
                </c:if>

                <c:if test="${isListDepartmentPage}">
                    <div class="search-bar p-0 d-none d-lg-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="ListDepartment" method="get" class="searchform">
                                <input type="text" class="form-control border rounded-pill" name="search" value= "${search}"placeholder="Tìm kiếm theo tên ">
                                <input type="submit" value="Search">
                            </form>
                        </div>
                    </div>
                </c:if>

                <c:if test="${isListServicePage}">
                    <div class="search-bar p-0 d-none d-lg-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="ListService" method="get" class="searchform">
                                <input type="text" class="form-control border rounded-pill" name="search" value = "${search}" placeholder="Tìm kiếm theo tên ">
                                <input type="submit" value="Search">
                            </form>
                        </div>
                    </div>
                </c:if>
                <c:if test="${isListCustomerPage}">
                    <div class="search-bar p-0 d-none d-lg-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form role="search" method="post" id="searchform" class="searchform" action="listCustomer">
                                <div>
                                    <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Tìm kiếm bệnh nhân: tên, sđt" style="width: 100%; max-width: 600px;" value="${requestScope.searchQuery}">
                                    <input type="hidden" name="action" value="search">
                                    <input type="submit" id="searchsubmit" value="Search">
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>
                <c:if test="${isListBlogPage}">
                    <div class="search-bar p-0 d-none d-lg-block ms-2">
                        <div id="search" class="menu-search mb-0">
                            <form action="blogs" method="get" class="searchform">
                                <input type="text" class="form-control border rounded-pill" name="search" placeholder="Tìm kiếm tin tức...">
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
                                <small class="text-muted">Quản trị viên</small>
                            </div>
                        </a>
                        <a class="dropdown-item text-dark" href="change-password">
                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-key-skeleton align-middle h6"></i></span> Đổi mật khẩu
                        </a>
                        <a class="dropdown-item text-dark" href="AdminDashBoard">
                            <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Bảng điều khiển
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



<c:if test="${(not empty staff and staff.role.roleId != 1) or not empty customer or empty staff and empty customer}">


    <header id="topnav" class="navigation sticky">
        <div class="container">
            <div class="menu-extras">
                <div class="menu-item">
                    <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                        <div class="lines">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                    </a>
                </div>
            </div>
            <ul class="dropdowns list-inline mb-0">
                <li class="list-inline-item mb-0 ms-1">
                    <div class="dropdown dropdown-primary">
                        <c:choose>
                            <c:when test="${staff != null || customer != null}">
                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <img src="${staff != null ? staff.avatar : customer.avatar}" class="avatar avatar-ex-small rounded-circle" alt="">
                                </button>
                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                    <a class="dropdown-item d-flex align-items-center text-dark" 
                                       href="${staff != null ? 'staffProfile' : 'customer-profile'}">
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

                                        <c:if test="${staff.role.roleId  == 2 or staff.role.roleId  == 3}">
                                            <a class="dropdown-item text-dark" href="doctorappointment">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> 
                                                Bảng điều khiển
                                            </a>
                                        </c:if>
                                        <c:if test="${staff.role.roleId == 4}">
                                            <a class="dropdown-item text-dark" href="confirmappointment">
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> 
                                                Bảng điều khiển
                                            </a>
                                        </c:if>

                                    </c:if>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="logout">
                                        <span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="login" class="btn btn-soft-primary">
                                    <i class="uil uil-user align-middle"></i> Đăng nhập
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </li>
            </ul>
            <div id="navigation">
                <ul class="navigation-menu nav-left nav-light">
                    <li class="parent-menu-item">
                        <a href="home">Trang chủ</a><span class="menu-arrow"></span>
                    </li>



                    <c:if test="${staff == null}">

                        <li class="parent-parent-menu-item">
                            <a href="allDoctors">Bác Sĩ</a><span class="menu-arrow"></span>
                        </li>
                    </c:if>
                    <li><a href="listBlog" class="sub-menu-item">Tin tức</a></li>
                    <li class="parent-menu-item">
                        <button id="openChatbot" style="position: fixed; bottom: 20px; right: 20px; background: green; color: white; padding: 10px 15px; border-radius: 50%; border: none; cursor: pointer;">
                            💬
                        </button>
                    </li>
                    <c:if test="${staff == null}">
                        <li><a href="services" class="sub-menu-item">Dịch vụ</a></li>


                        <li><a href="contact" class="parent-menu-item">Liên hệ</a></li>

                    </c:if>
                </ul>
            </div>
        </div>
    </header>

</c:if>