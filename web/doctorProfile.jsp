<%-- 
    Document   : doctorProfile
    Created on : Jan 31, 2025, 1:56:45 PM
    Author     : DIEN MAY XANH
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .error-message {
                color: red;
                font-size: 14px;
                margin-bottom: 10px;
            }
             .success-message {
                color: green;
                font-size: 14px;
                margin-bottom: 10px;
            }
            /* Cấu trúc chính của form */
            .form-container {
                width: 100%;
                max-width: 600px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            /* Tạo bố cục flex cho ảnh và nút upload */
            .avatar-upload-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            /* Khối hiển thị ảnh đại diện */
            .avatar-wrapper {
                display: flex;
                flex-direction: column;
                align-items: center;
                text-align: center;
                flex: 1;
            }

            /* Căn chỉnh ảnh avatar */
            .avatar-img {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                border: 2px solid #ddd;
                object-fit: cover;
                margin-bottom: 10px;
                cursor: pointer;
            }

            /* Phần thông báo dưới ảnh */
            .text-muted {
                font-size: 12px;
                color: #6c757d;
            }

            /* Cấu trúc nút upload */
            .upload-btn-container {
                flex: 1;
                text-align: center;
            }

            /* Nút chọn ảnh */
            .upload-btn {
                background-color: #28a745;
                color: white;
                border: 1px solid #fff;
                padding: 10px 20px;
                cursor: pointer;
                border-radius: 5px;
                font-size: 14px;
                text-decoration: none;
                transition: background-color 0.3s ease;
            }

            .upload-btn:hover {
                background-color: #254bb5;
            }

            /* Ẩn input file mặc định */
            .file-input {
                display: none;
            }

            /* Cấu trúc nút submit */
            .submit-btn-container {
                text-align: center;
            }

            .submit-btn {
                display: inline-block;
                padding: 12px 30px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .submit-btn:hover {
                background-color: #218838;
            }

            /* Cửa sổ phóng to ảnh */
            .image-popup {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.8);
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            .popup-img {
                max-width: 90%;
                max-height: 90%;
            }
        </style>
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
        <header id="topnav" class="defaultscroll sticky">
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

                    <li class="list-inline-item mb-0 ms-1">
                        <div class="dropdown dropdown-primary">
                            <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> <img src="${staff.avatar}" 
                                                                                                                                                                                        class="avatar avatar-md-sm rounded-circle border shadow" alt="">        </button>
                            <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">      
                                    <div class="flex-1 ms-2">
                                        <span class="d-block mb-1">${staff.name}</span>
                                        <small class="text-muted">${staff.department.departmentName}</small>

                                    </div>
                                </a>
                                <a class="dropdown-item text-dark" href="change-password">
                                    <span class="mb-0 d-inline-block me-1"><i class="uil uil-key-skeleton align-middle h6"></i></span> Đổi mật khẩu
                                </a>
                                <a class="dropdown-item text-dark" href="doctorprofile"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>

                                <div class="dropdown-divider border-top"></div>
                                <a class="dropdown-item text-dark" href="logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất </a>
                            </div>
                        </div>
                    </li>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left">
                        <li class="has-submenu parent-menu-item">
                            <a href="home">Home</a><span class="menu-arrow"></span>
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="javascript:void(0)">Doctors</a><span class="menu-arrow"></span>
                        </li>

                        <li class="has-submenu parent-parent-menu-item"><a href="javascript:void(0)">Pages</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <li class="has-submenu parent-menu-item">
                                <li><a href="blogs.html" class="sub-menu-item">Blogs</a></li>
                                <li><a href="blog-detail.html" class="sub-menu-item">Blog Details</a></li>
                                <li><a href="error.html" class="sub-menu-item">404 !</a></li>
                            </ul>
                        </li>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->




        <section class="bg-dashboard">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-4 col-lg-4 col-md-5 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <div class="card border-0">
                                <img src="assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
                            </div>

                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${staff.avatar}"
                                     class="avatar avatar-md-sm rounded-circle border shadow" alt="">

                                <h5 class="mt-3 mb-1">${staff.name}</h5>
                                <p class="text-muted mb-0">${staff.department.departmentName}</p>
                            </div>

                            <ul class="list-unstyled sidebar-nav mb-0">
                                <li class="navbar-item"><a href="doctor-appointment.html" class="navbar-link"><i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn</a></li>
                                <li class="navbar-item"><a href="doctor-schedule.html" class="navbar-link"><i class="ri-timer-line align-middle navbar-icon"></i> Lịch làm việc</a></li>
                                <li class="navbar-item"><a href="invoices.html" class="navbar-link"><i class="ri-pages-line align-middle navbar-icon"></i>Hóa đơn</a></li>
                                <li class="navbar-item"><a href="doctor-profile-setting.html" class="navbar-link"><i class="ri-user-settings-line align-middle navbar-icon"></i>Profile</a></li>
                                <li class="navbar-item"><a href="patient-list.html" class="navbar-link"><i class="ri-empathize-line align-middle navbar-icon"></i> Bệnh nhân</a></li>
                                <li class="navbar-item"><a href="patient-review.html" class="navbar-link"><i class="ri-chat-1-line align-middle navbar-icon"></i> Đánh giá của bệnh nhân</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <p class="success-message">${success}</p>

                        <!-- Change Avatar Form -->
                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Đổi ảnh đại diện</h5>

                            </div>

                            <div class="p-4 border-bottom">
                                <form id="avatarForm" method="post" enctype="multipart/form-data" action="doctorprofile?action=updateavatar">
                                    <div class="form-container">
                                        <div class="avatar-upload-container">
                                            <!-- Hiển thị ảnh đại diện -->
                                            <div class="avatar-wrapper">
                                                <img id="avatarPreview" class="avatar-img" 
                                                     src="${staff.avatar}" 
                                                     alt="Avatar" 
                                                     onclick="openImagePreview()"> 

                                                <p class="text-muted mb-0">Để có kết quả tốt nhất, hãy sử dụng hình ảnh có kích thước ít nhất 256px x 256px ở định dạng .jpg hoặc .png</p>
                                            </div>

                                            <!-- Nút để chọn ảnh -->
                                            <div class="upload-btn-container">
                                                <label class="upload-btn" for="avatarInput">Chọn ảnh</label>
                                                <input type="file" id="avatarInput" name="avatar" accept=".jpg,.png" class="file-input" onchange="previewAvatar(event)">
                                            </div>
                                        </div>

                                        <!-- Nút submit form -->
                                        <div class="submit-btn-container">
                                            <button type="submit" class="submit-btn" id="submitBtn" style="display:none;">Cập nhật</button>
                                            <p class="error-message">${erroravatar}</p>

                                        </div>

                                        <!-- Cửa sổ phóng to ảnh -->
                                        <div id="imagePreviewPopup" class="image-popup" onclick="closeImagePreview()">
                                            <img id="imagePreviewPopupContent" class="popup-img" src="" alt="Image Preview">
                                        </div>
                                    </div>
                                </form>


                            </div>
                        </div>

                        <!-- Update Profile Form -->
                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Cập nhật thông tin cá nhân</h5>
                            </div>
                            <div class="p-4">
                                <form onsubmit="validateForm(event)" method="post" action="doctorprofile?action=updateprofile">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="name" class="form-label">Họ và tên</label>
                                            <input type="text" class="form-control" id="name" name="name" value="${staff.name}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" value="${staff.email}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="phone" class="form-label">Số điện thoại</label>
                                            <input type="text" class="form-control" id="phone" name="phone" value="${staff.phone}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="dob" class="form-label">Ngày sinh</label>
                                            <input type="date" class="form-control" id="dob" name="dob" value="${staff.dateOfBirth}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="work_position" class="form-label">Vị trí làm việc</label>
                                            <input type="text" class="form-control" id="work_position" value="${staff.position}" disabled>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="gender" class="form-label">Giới tính</label>
                                            <select class="form-control" id="gender" name="gender">
                                                <option value="M" ${staff.gender == 'M' ? 'selected' : ''}>Nam</option>
                                                <option value="F" ${staff.gender == 'F' ? 'selected' : ''}>Nữ</option>
                                            </select>
                                        </div>

                                        <div class="col-md-12 mb-3">
                                            <label for="description" class="form-label">Mô tả ngắn</label>
                                            <textarea class="form-control" id="description" name="des" rows="4"  placeholder="Nhập tiểu sử của bạn (tối đa 500 từ)"  oninput="countWords()" style="width: 100%;">${staff.description}</textarea>
                                            <p id="wordCount">0 / 500 từ</p>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="department" class="form-label">Khoa</label>
                                            <select class="form-control" id="department" name="depart">
                                                <c:forEach var="dept" items="${listd}">
                                                    <option value="${dept.departmentId}" ${dept.departmentId == staff.department.departmentId ? 'selected' : ''}>${dept.departmentName}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <!-- Thông báo lỗi sẽ hiển thị ở đây -->
                                        <div id="error-message" class="error-message">${error}</div>

                                        <div class="col-md-12">
                                            <button type="submit" class="btn btn-primary w-100">Lưu thay đổi</button>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <footer class="footer bg-dark footer-bar">
            <div class="container">
                <div class="row text-center">
                    <div class="col-lg-6 col-md-6">
                        <p class="mb-0 text-light">© 2025 Doctris. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </footer>
        <script>
            function validateForm(event) {
                const name = document.getElementById('name').value.trim();
                const email = document.getElementById('email').value.trim();
                const phone = document.getElementById('phone').value.trim();
                const dob = document.getElementById('dob').value;
                const phonePattern = /^(0\d{9,10})$/;
                const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                let errorMessages = [];
                let errorMessageDiv = document.getElementById('error-message');

                // Xóa thông báo lỗi cũ
                errorMessageDiv.innerHTML = "";
                if (name === '') {
                    errorMessages.push("Không được để trống tên.");
                }

                if (!phonePattern.test(phone)) {
                    errorMessages.push("Số điện thoại không hợp lệ! Phải có 10-11 chữ số và bắt đầu bằng 0.");
                }

                // Kiểm tra email hợp lệ
                if (!emailPattern.test(email)) {
                    errorMessages.push("Email không hợp lệ!");
                }

                // Kiểm tra ngày sinh hợp lệ
                if (dob) {
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    const dobDate = new Date(dob);
                    dobDate.setHours(0, 0, 0, 0);

                    if (dobDate > today) {
                        errorMessages.push("Ngày sinh không được sau ngày hiện tại.");
                    }
                } else {
                    errorMessages.push("Vui lòng nhập ngày sinh.");
                }

                // Nếu có lỗi, hiển thị thông báo và ngăn chặn submit
                if (errorMessages.length > 0) {
                    errorMessageDiv.innerHTML = errorMessages.join("<br>");
                    event.preventDefault(); // Chặn submit form
                }
            }
            function countWords() {
                var textarea = document.getElementById("description");
                var wordCountDisplay = document.getElementById("wordCount");
                var words = textarea.value.trim().split(/\s+/); // Tách các từ dựa vào khoảng trắng
                var maxWords = 500;

                if (words.length > maxWords) {
                    textarea.value = words.slice(0, maxWords).join(" "); // Chỉ giữ lại 500 từ
                }

                wordCountDisplay.textContent = words.length + " / " + maxWords + " từ";
            }


            function previewAvatar(event) {
                const file = event.target.files[0]; // Lấy tệp người dùng chọn
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('avatarPreview').src = e.target.result; // Thay đổi ảnh hiển thị
                        document.getElementById('submitBtn').style.display = 'block'; // Hiển thị nút "Cập nhật"
                    };
                    reader.readAsDataURL(file); // Đọc file dưới dạng Data URL
                }
            }
            function openImagePreview() {
                const avatarPreview = document.getElementById('avatarPreview');
                const popup = document.getElementById('imagePreviewPopup');
                const popupImage = document.getElementById('imagePreviewPopupContent');
                popup.style.display = 'flex';
                popupImage.src = avatarPreview.src;
            }

            function closeImagePreview() {
                const popup = document.getElementById('imagePreviewPopup');
                popup.style.display = 'none';
            }
        </script>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>
