<%-- 
    Document   : doctorProfile
    Created on : Jan 31, 2025, 1:56:45 PM
    Author     : DIEN MAY XANH
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Tài khoản của tôi</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="assets/css/style.min.css" rel="stylesheet" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->       
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
            .alert {
                display: none;
                padding: 15px;
                margin-bottom: 10px;
                border-radius: 5px;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
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
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="doctor/left-navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="doctor/top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <c:if test="${not empty success}">
                            <div id="successMessage" class="alert alert-success text-center" style="display: block;">
                                ${success}
                            </div>
                        </c:if>

                        <!-- Change Avatar Form -->
                        <div class="rounded shadow mt-4">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0 text-center">Đổi ảnh đại diện</h5>

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
                                <h5 class="mb-0 text-center">Cập nhật thông tin cá nhân</h5>
                                <c:if test="${not empty error}">
                                    <div id="errorMessage" class="alert alert-danger text-center" style="display: block;">
                                        ${error}
                                    </div>
                                </c:if>
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

                                        <c:if test="${sessionScope.staff.role.roleId == 2 or sessionScope.staff.role.roleId == 3}">
                                            <div class="col-md-12 mb-3">
                                                <label for="description" class="form-label">Mô tả ngắn</label>
                                                <textarea class="form-control" id="description" name="des" rows="4"
                                                          placeholder="Nhập tiểu sử của bạn (tối đa 500 từ)"
                                                          oninput="countWords()" style="width: 100%;">${staff.description}</textarea>
                                                <p id="wordCount">${fn:length(staff.description)} / 500 từ</p>
                                            </div>
                                            <div class="col-md-12 mb-3">
                                                <label for="certificate" class="form-label">Bằng cấp/Chứng chỉ</label><br>
                                                <c:choose>
                                                    <c:when test="${empty staff.certificate}">
                                                        Chưa cập nhật
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${staff.certificate}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>


                                            <div class="col-md-6 mb-3">
                                                <label for="department" class="form-label">Khoa</label>
                                                <select class="form-control" id="department" name="depart">
                                                    <c:forEach var="dept" items="${listd}">
                                                        <option value="${dept.departmentId}" 
                                                                ${dept.departmentId == staff.department.departmentId ? 'selected' : ''}>
                                                            ${dept.departmentName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </c:if>


                                        <!-- Thông báo lỗi sẽ hiển thị ở đây -->
                                        <div id="error-message" class="error-message"></div>

                                        <div class="col-md-12">
                                            <button type="submit" class="btn btn-primary w-100">Lưu thay đổi</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>


                    </div>
                </div><!--end container-->
                <!-- Footer Start -->
                <jsp:include page="doctor/footer.jsp" />
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

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
                const errorMessage = document.querySelector('.error-message');
                const submitBtn = document.getElementById('submitBtn');

                if (file) {
                    const maxSize = 3 * 1024 * 1024; // 3MB tính theo bytes

                    // Kiểm tra kích thước file
                    if (file.size > maxSize) {
                        errorMessage.textContent = "Kích thước file không được vượt quá 3MB.";
                        event.target.value = ""; // Xóa file đã chọn
                        document.getElementById('avatarPreview').src = ""; // Xóa preview ảnh (nếu cần)
                        submitBtn.style.display = 'none'; // Ẩn nút cập nhật
                        return;
                    } else {
                        errorMessage.textContent = ""; // Xóa thông báo lỗi nếu file hợp lệ
                    }

                    // Đọc file và hiển thị preview
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('avatarPreview').src = e.target.result; // Thay đổi ảnh hiển thị
                        submitBtn.style.display = 'block'; // Hiển thị nút "Cập nhật"
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


            function hideMessageAfterDelay(elementId, delay) {
                const messageElement = document.getElementById(elementId);
                if (messageElement) {
                    setTimeout(() => {
                        messageElement.style.display = 'none';
                    }, delay);
                }
            }

            // Gọi hàm cho cả hai phần tử với thời gian trì hoãn 4000 ms
            hideMessageAfterDelay('errorMessage', 3000);
            hideMessageAfterDelay('successMessage', 3000);

        </script>




        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>

    </body>


</html>


