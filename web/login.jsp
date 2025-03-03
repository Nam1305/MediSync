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


        <!-- Navbar STart -->
        <jsp:include page="layout/header.jsp" /><!--end header-->
        <!-- Navbar End -->
        
        
        
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
