<%-- 
    Document   : login
    Created on : Jan 10, 2025, 11:50:43 PM
    Author     : DIEN MAY XANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Đăng nhập</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" />

    </head>

    <body>
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <header id="topnav" class="navigation sticky" style="background: white; color: black; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);">
            <div class="container">
                <!-- Start Mobile Toggle -->
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
                <!-- End Mobile Toggle -->

                <!-- Start Dropdown -->
                <ul class="dropdowns list-inline mb-0">
                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <c:choose>
                                <c:when test="${staff != null || customer != null}">
                                    <!-- Logged in user -->
                                    <button type="button" class="btn btn-pills btn-outline-dark dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
                                                <span class="mb-0 d-inline-block me-1"><i class="uil uil-user align-middle h6"></i></span> Profile
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
                                    <!-- Not logged in -->
                                    <a href="login" class="btn btn-outline-success login-btn">
                                        <i class="uil uil-user align-middle"></i> Đăng nhập
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
                <!-- End Dropdown -->

                <div id="navigation">
                    <ul class="navigation-menu nav-left">
                        <li class="parent-menu-item">
                            <a href="home" class="text-dark">Trang chủ</a>
                        </li>
                        <li class="has-submenu parent-parent-menu-item">
                            <a href="listDoctor.jsp" class="text-dark">Bác Sĩ</a>
                        </li>
                        <li><a href="listBlog" class="text-dark">Blogs</a></li>
                    </ul>
                </div>
            </div>
        </header>



        <section class="bg-home d-flex bg-light align-items-center" style="background: url('assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Đăng nhập</h4>
                                <c:set var="cookie"  value="${pageContext.request.cookies}"/>
                                <form action="login" method="post" class="login-form mt-4">                                        <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Email <span class="text-danger">*</span></label>
                                            <input type="email" class="form-control" placeholder="Email" value="${cookie.cEmail.value}" name="email" required="">
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="password" placeholder="Password" name="password" value="${cookie.cPassword.value}" required>
                                                <button type="button" class="btn btn-outline-secondary" id="togglePasswordBtn" onclick="togglePassword()">
                                                    <span id="togglePasswordText">Hiện</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-12">
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger mt-3">
                                                ${error}
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="d-flex justify-content-between">
                                            <div class="mb-3">
                                                <div class="form-check">
                                                    <input class="form-check-input align-middle" type="checkbox" value="" id="remember-check" name="remember" ${(cookie.cRemember != null) ? 'checked' : ''}>
                                                    <label class="form-check-label" for="remember-check">Remember me</label>
                                                </div>
                                            </div>
                                            <a href="forgot-password.jsp" class="text-dark h6 mb-0">Quên mật khẩu?</a>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 mb-0">
                                        <div class="d-grid">
                                            <button class="btn" style="background-color: #2CA052;">Đăng nhập</button>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 mt-3 text-center">
                                        <h6 class="text-muted">Hoặc</h6>
                                    </div>

                                    <div class="col-12 mt-3">
                                        <div class="d-grid">
                                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/MediSyncSys/logingg&response_type=code&client_id=185858868190-ph9uql7ag8caujm9vkspa2qs8j46dgkc.apps.googleusercontent.com&approval_prompt=force" class="btn" style="color: #2CA052;"><i class="uil uil-google"></i> Google</a>
                                        </div>
                                    </div>

                                    <div class="col-12 text-center">
                                        <p class="mb-0 mt-3"><small class="text-dark me-2">Bạn chưa có tài khoản?</small> <a href="register.jsp" class="text-dark fw-bold">Đăng kí</a></p>
                                    </div>

                            </div>
                            </form>
                        </div>
                    </div>
                </div> <!--end col-->
            </div><!--end row-->
        </div> <!--end container-->
    </section>

    <footer class="footer bg-dark footer-bar">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-6 col-md-6">
                    <p class="mb-0 text-light">© 2025 MediSynC. Code by Duc.</p>
                </div>
            </div>
        </div>
    </footer>

    <script>
        function togglePassword() {
            var passwordInput = document.getElementById("password");
            var togglePasswordText = document.getElementById("togglePasswordText");

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                togglePasswordText.textContent = "Ẩn";  // Hiển thị "Ẩn"
            } else {
                passwordInput.type = "password";
                togglePasswordText.textContent = "Hiện";  // Hiển thị "Hiện"
            }
        }
    </script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>

</html>
