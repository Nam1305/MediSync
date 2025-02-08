
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Register</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- favicon -->
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .error-message {
                color: red;
                display: none;
            }
            .input-group {
                display: flex;
                align-items: center;
            }

            .input-group .btn {
                border-radius: 0 5px 5px 0;
            }
        </style>
    </head>

    <body>

        <div class="back-to-home rounded d-none d-sm-block">
            <a href="home" class="btn btn-icon btn-success"><i data-feather="home" class="icons"></i></a>
        </div>

        <!-- Hero Start -->
        <section class="bg-half-150 d-table w-100 bg-light" style="background: url('assets/images/bg/bg-lines-one.png') center;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5 col-md-8">
                        <div class="card login-page bg-white shadow mt-4 rounded border-0">
                            <div class="card-body">
                                <h4 class="text-center">Đăng ký</h4>  
                                <form action="register" class="login-form mt-4" method="post" id="registration-form">
                                    <div class="row">

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Tên <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Tên" name="name" required="" value="${name}">
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Số điện thoại <span class="text-danger">*</span></label>
                                                <input type="tel" class="form-control" placeholder="Số điện thoại" name="phone" required="" value="${phone}">
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ <span class="text-danger">*</span></label>
                                                <input type="text" class="form-control" placeholder="Địa chỉ" name="address" required="" value="${address}">
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Email <span class="text-danger">*</span></label>
                                                <input type="email" class="form-control" placeholder="Email" name="email" required="" value="${email}">
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3 position-relative">
                                                <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input type="password" id="password" class="form-control" placeholder="Mật khẩu" required="" name="password" value="${password}">
                                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="togglePasswordVisibility('password', this)">Hiện</button>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="mb-3 position-relative">
                                                <label class="form-label">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                                                <div class="input-group">
                                                    <input type="password" id="confirmPassword" class="form-control" placeholder="Xác nhận mật khẩu" required="" name="confirm" value="${confirm}">
                                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="togglePasswordVisibility('confirmPassword', this)">Hiện</button>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-check">
                                                <input class="form-check-input align-middle" type="checkbox" value="" id="accept-tnc-check" required>
                                                <label class="form-check-label" for="accept-tnc-check">Tôi chấp nhận <a href="#" class="text-success">Điều khoản và điều kiện</a></label>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div style="display: flex; align-items: center; color: red;">${error}</div>
                                            <div class="error-message" id="error-message">Bạn phải chấp nhận Điều khoản và điều kiện để đăng ký.</div>
                                            <div class="d-grid">
                                                <button class="btn btn-success">Đăng ký</button>
                                            </div>
                                        </div>

                                        <div class="mx-auto">
                                            <p class="mb-0 mt-3"><small class="text-dark me-2">Bạn đã có tài khoản?</small> <a href="login.jsp" class="text-dark fw-bold">Đăng nhập</a></p>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div><!--end card-->
                    </div> <!--end col-->
                </div><!--end row-->
            </div> <!--end container-->
        </section><!--end section-->
        <!-- Hero End -->

        <script>
            document.getElementById('registration-form').addEventListener('submit', function (event) {
                // Lấy tất cả các input
                const phone = document.querySelector("input[name='phone']").value.trim();
                const email = document.querySelector("input[name='email']").value.trim();
                const password = document.querySelector("input[name='password']").value;
                const confirmPassword = document.querySelector("input[name='confirm']").value;
                const checkbox = document.getElementById('accept-tnc-check');
                const errorMessage = document.getElementById('error-message');

                let error = "";


                // Kiểm tra số điện thoại hợp lệ (10-11 số, bắt đầu bằng 0)
                if (!/^(0\d{9,10})$/.test(phone)) {
                    error = "Số điện thoại không hợp lệ! Số điện thoại phải có 10-11 chữ số và bắt đầu bằng 0.";
                }

                // Kiểm tra email hợp lệ
                else if (!/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/.test(email)) {
                    error = "Email không hợp lệ!";
                }
               

                // Kiểm tra mật khẩu xác nhận có khớp không
                if (!error && password !== confirmPassword) {
                    error = "Mật khẩu xác nhận không khớp!";
                }
                // Kiểm tra checkbox điều khoản đã được chọn chưa
                if (!error && !checkbox.checked) {
                    error = "Bạn phải chấp nhận Điều khoản và điều kiện để đăng ký.";
                }

                // Nếu có lỗi, hiển thị thông báo và ngăn submit form
                if (error) {
                    event.preventDefault(); // Ngăn form submit
                    errorMessage.innerText = error;
                    errorMessage.style.display = 'block';
                } else {
                    errorMessage.style.display = 'none';
                }
            });

// Hàm bật/tắt hiển thị mật khẩu
            function togglePasswordVisibility(fieldId, buttonElement) {
                const field = document.getElementById(fieldId);
                const isPassword = field.type === 'password';
                field.type = isPassword ? 'text' : 'password';
                buttonElement.innerText = isPassword ? 'Ẩn' : 'Hiện';
            }

        </script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

    </body>

</html>