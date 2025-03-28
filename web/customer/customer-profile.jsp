<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Thông tin cá nhân</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <link href="assets/css/style.min.css" rel="stylesheet" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Thông tin cá nhân</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-2 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Thông tin cá nhân</li>
                                </ul>
                            </nav>
                        </div>

                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-experience" role="tabpanel" aria-labelledby="experience-tab">
                                <!-- Display avatar section -->
                                <!-- Profile Picture Section -->
                                <div class="card border-0 rounded shadow">
                                    <div class="card-body">
                                        <h5 class="mb-0">Ảnh đại diện</h5>
                                        <div class="row align-items-center mt-4">
                                            <!-- Avatar Preview Column -->
                                            <div class="col-lg-3 col-md-4 text-center mb-4 mb-md-0">
                                                <div class="position-relative">
                                                    <c:choose>
                                                        <c:when test="${customer.avatar != null && not empty customer.avatar}">
                                                            <img id="avatarPreview" src="${customer.avatar}" class="avatar avatar-large rounded-circle shadow mx-auto" 
                                                                 alt="Profile Picture" style="width: 120px; height: 120px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img id="avatarPreview" src="assets/images/default-avatar.jpg" class="avatar avatar-large rounded-circle shadow mx-auto" 
                                                                 alt="Default Profile" style="width: 120px; height: 120px; object-fit: cover;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <!-- Text Column -->
                                            <div class="col-lg-4 col-md-8 text-center text-md-start">
                                                <h6 class="mb-2">Upload ảnh đại diện</h6>
                                                <p class="text-muted mb-0">Để có kết quả ưng ý nhất, sử dụng ảnh có độ phân giải 256px đổ lên với format .jpg hoặc .jpeg</p>
                                            </div>

                                            <!-- Buttons Column -->
                                            <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                                <form id="avatarUploadForm" action="customer-profile" method="post" enctype="multipart/form-data">
                                                    <input type="hidden" name="action" value="uploadAvatar">
                                                    <input type="file" name="profileImage" id="profileImage" style="display: none;" accept="image/jpeg, image/png">
                                                    <button type="button" id="uploadButton" class="btn btn-primary" onclick="document.getElementById('profileImage').click();">Tải lên</button>
                                                    <a href="customer-profile?action=removeAvatar" class="btn btn-soft-primary ms-2" 
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa ảnh đại diện không?')" 
                                                       ${empty customer.avatar ? 'disabled' : ''}>Xóa</a>
                                                </form>
                                                <div id="uploadError" class="text-danger mt-2 text-start" style="display: none;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Profile update form -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <form class="mt-4" action="customer-profile" method="post" id="profileUpdateForm" onsubmit="return validateForm()">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Tên</label>
                                                <input name="name" type="text" class="form-control" placeholder="Full Name" 
                                                       value="${customer.name}" required>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ email</label>
                                                <input name="email" type="email" class="form-control" placeholder="Email" 
                                                       value="${customer.email}" required>
                                            </div> 
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">SĐT</label>
                                                <input name="phone" type="text" class="form-control" placeholder="Phone number (10 digits)" 
                                                       value="${customer.phone}" required maxlength="10">
                                            </div>                                                                               
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Ngày sinh</label>
                                                <input name="dateOfBirth" type="text" class="form-control" placeholder="dd/mm/yyyy" 
                                                       value="<fmt:formatDate value='${customer.dateOfBirth}' pattern='dd/MM/yyyy'/>" 
                                                       pattern="\d{2}/\d{2}/\d{4}">
                                            </div>                                                                               
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Nhóm máu</label>
                                                <select name="bloodType" class="form-control">
                                                    <option value="" ${empty customer.bloodType ? 'selected' : ''}>Chọn nhóm máu</option>
                                                    <option value="A+" ${customer.bloodType == 'A+' ? 'selected' : ''}>A+</option>
                                                    <option value="A-" ${customer.bloodType == 'A-' ? 'selected' : ''}>A-</option>
                                                    <option value="B+" ${customer.bloodType == 'B+' ? 'selected' : ''}>B+</option>
                                                    <option value="B-" ${customer.bloodType == 'B-' ? 'selected' : ''}>B-</option>
                                                    <option value="AB+" ${customer.bloodType == 'AB+' ? 'selected' : ''}>AB+</option>
                                                    <option value="AB-" ${customer.bloodType == 'AB-' ? 'selected' : ''}>AB-</option>
                                                    <option value="O+" ${customer.bloodType == 'O+' ? 'selected' : ''}>O+</option>
                                                    <option value="O-" ${customer.bloodType == 'O-' ? 'selected' : ''}>O-</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Giới tính</label>
                                                <select name="gender" class="form-control">
                                                    <option value="" ${empty customer.bloodType ? 'selected' : ''}>Chọn giới tính</option>
                                                    <option value="F" ${customer.gender == 'F' ? 'selected' : ''}>Nữ</option>
                                                    <option value="M" ${customer.gender == 'M' ? 'selected' : ''}>Nam</option>
                                                    <option value="D" ${customer.gender == 'D' ? 'selected' : ''}>Khác</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <input type="submit" id="submit" name="send" class="btn btn-primary" value="Cập nhật">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div><!--end container-->
                <!-- Footer Start -->
                <jsp:include page="footer.jsp" />
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- Scripts at the end of the body -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>

        <script>
                                    // Handle image upload and validation
                                    document.getElementById('profileImage').addEventListener('change', function () {
                                        const file = this.files[0];
                                        const errorElement = document.getElementById('uploadError');
                                        const avatarPreview = document.getElementById('avatarPreview');
                                        errorElement.style.display = 'none';

                                        // Reset error message
                                        errorElement.textContent = '';

                                        if (!file) {
                                            return;
                                        }

                                        // Check file type
                                        const validTypes = ['image/jpeg', 'image/png'];
                                        if (!validTypes.includes(file.type)) {
                                            errorElement.textContent = 'Chỉ chấp nhận file JPG hoặc PNG';
                                            errorElement.style.display = 'block';
                                            this.value = '';
                                            return;
                                        }

                                        // Check file size (max 5MB)
                                        const maxSize = 5 * 1024 * 1024; // 5MB in bytes
                                        if (file.size > maxSize) {
                                            errorElement.textContent = 'Kích thước ảnh không được vượt quá 5MB';
                                            errorElement.style.display = 'block';
                                            this.value = '';
                                            return;
                                        }

                                        // Show image preview before upload
                                        const reader = new FileReader();
                                        reader.onload = function (e) {
                                            avatarPreview.src = e.target.result;
                                        };
                                        reader.readAsDataURL(file);

                                        // Check image dimensions
                                        const img = new Image();
                                        img.onload = function () {
                                            URL.revokeObjectURL(img.src); // Clean up

                                            if (img.width < 256 || img.height < 256) {
                                                errorElement.textContent = 'Ảnh phải có kích thước tối thiểu 256px x 256px';
                                                errorElement.style.display = 'block';
                                                document.getElementById('profileImage').value = '';
                                                return;
                                            }

                                            // All validations passed, submit the form
                                            document.getElementById('avatarUploadForm').submit();
                                        };

                                        img.onerror = function () {
                                            URL.revokeObjectURL(img.src); // Clean up
                                            errorElement.textContent = 'Không thể đọc file ảnh, vui lòng thử lại';
                                            errorElement.style.display = 'block';
                                            document.getElementById('profileImage').value = '';
                                        };

                                        // Load image to check dimensions
                                        img.src = URL.createObjectURL(file);
                                    });

                                    // Form validation
                                    function validateForm() {
                                        // Email validation
                                        const emailInput = document.querySelector('input[name="email"]');
                                        const emailRegex = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
                                        if (!emailRegex.test(emailInput.value)) {
                                            alert('Vui lòng nhập địa chỉ email hợp lệ');
                                            emailInput.focus();
                                            return false;
                                        }

                                        // Phone number validation (10 digits)
                                        const phoneInput = document.querySelector('input[name="phone"]');
                                        const phoneRegex = /^[0-9]{10}$/;
                                        if (!phoneRegex.test(phoneInput.value)) {
                                            alert('Số điện thoại phải đúng 10 chữ số');
                                            phoneInput.focus();
                                            return false;
                                        }

                                        const dobInput = document.querySelector('input[name="dateOfBirth"]');
                                        const dobRegex = /^\d{2}\/\d{2}\/\d{4}$/;
                                        if (dobInput.value && !dobRegex.test(dobInput.value)) {
                                            alert('Vui lòng nhập ngày sinh đúng định dạng dd/mm/yyyy');
                                            dobInput.focus();
                                            return false;
                                        }

                                        return true;
                                    }

                                    // Real-time validation while typing
                                    document.querySelector('input[name="email"]').addEventListener('input', function () {
                                        const emailRegex = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
                                        this.setCustomValidity(
                                                emailRegex.test(this.value) ? '' : 'Vui lòng nhập địa chỉ email hợp lệ'
                                                );
                                    });

                                    document.querySelector('input[name="phone"]').addEventListener('input', function () {
                                        const phoneRegex = /^[0-9]{10}$/;
                                        this.setCustomValidity(
                                                phoneRegex.test(this.value) ? '' : 'Số điện thoại phải đúng 10 chữ số'
                                                );
                                    });

                                    document.querySelector('input[name="dateOfBirth"]').addEventListener('input', function (event) {
                                        // Bỏ qua xử lý nếu đang trong quá trình soạn thảo IME
                                        if (event.isComposing) {
                                            return;
                                        }

                                        // Auto-format date as user types
                                        let value = this.value.replace(/[^0-9]/g, '');
                                        if (value.length > 8)
                                            value = value.slice(0, 8);

                                        if (value.length >= 2)
                                            value = value.slice(0, 2) + '/' + value.slice(2);
                                        if (value.length >= 5)
                                            value = value.slice(0, 5) + '/' + value.slice(5);

                                        this.value = value;

                                        // Validate format
                                        const dobRegex = /^\d{2}\/\d{2}\/\d{4}$/;
                                        this.setCustomValidity(
                                                dobRegex.test(value) ? '' : 'Vui lòng nhập ngày sinh đúng định dạng dd/mm/yyyy'
                                                );
                                    });


        </script>
    </body>
</html>