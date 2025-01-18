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
        <title>MediSyns System</title>
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

      
        <div class="back-to-home rounded d-none d-sm-block">
            <a href="index.html" class="btn btn-icon btn-success"><i data-feather="home" class="icons"></i></a>
        </div>F
        <section class="bg-home d-flex bg-light align-items-center" style="background: url('assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Sign In</h4>
                                 <c:set var="cookie"  value="${pageContext.request.cookies}"/>
                                <form action="login" method="post" class="login-form mt-4">                                        <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Your Email <span class="text-danger">*</span></label>
                                            <input type="email" class="form-control" placeholder="Email" value="${cookie.cEmail.value}" name="email" required="">
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Password <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control" placeholder="Password" name="password" value="${cookie.cPassword.value}" required="">
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
                                            <a href="forgot-password.jsp" class="text-dark h6 mb-0">Forgot password?</a>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 mb-0">
                                        <div class="d-grid">
                                            <button class="btn" style="background-color: #2CA052;">Sign in</button>
                                        </div>
                                    </div>

                                    <div class="col-lg-12 mt-3 text-center">
                                        <h6 class="text-muted">Or</h6>
                                    </div>

                                    <div class="col-12 mt-3">
                                        <div class="d-grid">
                                            <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:9999/MediSyncSys/logingg&response_type=code&client_id=185858868190-ph9uql7ag8caujm9vkspa2qs8j46dgkc.apps.googleusercontent.com&approval_prompt=force" class="btn" style="color: #2CA052;"><i class="uil uil-google"></i> Google</a>
                                        </div>
                                    </div>

                                    <div class="col-12 text-center">
                                        <p class="mb-0 mt-3"><small class="text-dark me-2">Don't have an account?</small> <a href="register.jsp" class="text-dark fw-bold">Register</a></p>
                                    </div>

                            </div>
                            </form>
                        </div>
                    </div>
                </div> <!--end col-->
            </div><!--end row-->
        </div> <!--end container-->
    </section>

    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>

</html>
