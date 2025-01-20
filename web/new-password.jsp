<%-- 
    Document   : new-password
    Created on : Jan 11, 2025, 10:07:49 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>MediSyns System - New Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Các thẻ meta giữ nguyên như template -->
    <link rel="shortcut icon" href="assets/images/favicon.ico.png">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
    <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
</head>

<body>
    <!-- Loader -->
    <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>

    <div class="back-to-home rounded d-none d-sm-block">
        <a href="index.html" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
    </div>

    <section class="bg-home d-flex bg-light align-items-center" style="background: url('assets/images/bg/bg-lines-one.png') center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5 col-md-8">
                    <img src="assets/images/logo-dark.png" height="24" class="mx-auto d-block" alt="">
                    <div class="card login-page bg-white shadow mt-4 rounded border-0">
                        <div class="card-body">
                            <h4 class="text-center">Set New Password</h4>
                            
                            <!-- Hiển thị thông báo lỗi nếu có -->
                            <% if(request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger" role="alert">
                                    <%= request.getAttribute("error") %>
                                </div>
                            <% } %>

                            <form action="reset-password" method="post" class="login-form mt-4" onsubmit="return validatePassword()">
                                <input type="hidden" name="action" value="reset">
                                <input type="hidden" name="email" value="${email}">
                                
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">New Password <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control" id="newPassword" 
                                                   name="newPassword" placeholder="Enter new password" required="">
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                                            <input type="password" class="form-control" id="confirmPassword" 
                                                   name="confirmPassword" placeholder="Confirm password" required="">
                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-12">
                                        <div class="d-grid">
                                            <button class="btn btn-primary">Reset Password</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- javascript -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/feather.min.js"></script>
    <script src="assets/js/app.js"></script>
    <script>
        function validatePassword() {
            var newPassword = document.getElementById('newPassword').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                alert('Passwords do not match!');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
