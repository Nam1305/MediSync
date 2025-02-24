
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Đăng kí</title>
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

                    <!-- Replace the profile dropdown section in home.jsp -->
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
                                    <!-- Not logged in -->
                                    <a href="login" class="btn btn-soft-primary">
                                        <i class="uil uil-user align-middle"></i> Đăng nhập
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left nav-light">
                        <li class="parent-menu-item">
                            <a href="home">Trang chủ</a><span class="menu-arrow"></span>
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="listDoctor.jsp">Bác Sĩ</a><span class="menu-arrow"></span>
                        </li>

                        <li><a href="listBlog" class="sub-menu-item">Blogs</a></li>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->
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