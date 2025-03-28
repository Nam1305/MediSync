<%-- 
    Document   : reset-verify
    Created on : Jan 11, 2025, 10:07:00 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Nhập mã xác nhận</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Các thẻ meta giữ nguyên như template -->
    <link rel="shortcut icon" href="assets/images/logo-icon.png">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
    <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
    <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    <style>
        .code-input {
            letter-spacing: 8px;
            font-size: 20px;
            text-align: center;
        }
    </style>
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
                    <img src="assets/images/logo-light.png" height="24" class="mx-auto d-block" alt="">
                    <div class="card login-page bg-white shadow mt-4 rounded border-0">
                        <div class="card-body">
                            <h4 class="text-center">Mã xác nhận</h4>
                            
                            <!-- Hiển thị thông báo lỗi nếu có -->
                            <% if(request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger" role="alert">
                                    <%= request.getAttribute("error") %>
                                </div>
                            <% } %>
                            
                            <div class="alert alert-info" role="alert">
                                Một mã xác nhận đã được gửi đến email của bạn
                            </div>

                            <form action="reset-password" method="get" class="login-form mt-4">
                                <input type="hidden" name="step" value="verify">
                                <input type="hidden" name="email" value="${email}">
                                
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Mã xác nhận <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control code-input" maxlength="6" 
                                                   name="code" required="" placeholder="Nhập mã">
                                        </div>
                                    </div>
                                    
                                    <div class="col-lg-12">
                                        <div class="d-grid">
                                            <button class="btn btn-primary">Xác nhận</button>
                                        </div>
                                    </div>

                                    <div class="mx-auto">
                                        <p class="mb-0 mt-3">
                                            <small class="text-dark me-2">Thử lại?</small>
                                            <a href="reset-password" class="text-dark h6 mb-0">Quay lại</a>
                                        </p>
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
</body>
</html>