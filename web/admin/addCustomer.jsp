<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="assets/css/flatpickr.min.css">
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>
            <!-- Start Page Content -->
            <div class="page-wrapper doctris-theme toggled">
                <jsp:include page="../layout/navbar.jsp" />


                <!-- Start Page Content -->
                <main class="page-content bg-light">
                    <jsp:include page="../layout/header.jsp" />


                    <div class="container-fluid">
                        <div class="layout-specing">
                            <div class="d-md-flex justify-content-between">
                                <h5 class="mb-0">Thêm bệnh nhân mới</h5>
                            </div>

                            <div class="row">
                                <div class="col-lg-8 mt-4">
                                    <div class="card border-0 p-4 rounded shadow">
                                        <div class="row align-items-center">
                                            <div class="col-lg-2 col-md-4">
                                                <img src="assets/images/client/01.jpg" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                            </div><!--end col-->

                                            <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                                <!--                                            <h5 class="">Thêm ảnh đại diện</h5>-->
                                                <p class="text-muted mb-0">Sử dụng ảnh kích thước 600x600px định dạng .JPG và .PNG để hiển thị tốt nhất</p>
                                            </div><!--end col-->

                                        </div><!--end row-->

                                        <!--form-start-->
                                        <!--form add customer-->
                                        <form class="mt-4" action="addCustomer" method="POST" enctype="multipart/form-data">

                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Họ và Tên</label>
                                                        <input name="full-name" id="full-name" type="text" 
                                                               class="form-control" placeholder="Full Name:" value="${fullName}">
                                                    </div>
                                                </div><!--end col-->   

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Giới tính</label>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="gender" id="male" value="M" checked  ${gender == 'M' ? 'checked' : ''}>
                                                            <label class="form-check-label" for="male">Nam</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input class="form-check-input" type="radio" name="gender" id="female" value="F" ${gender == 'F' ? 'checked' : ''}>
                                                            <label class="form-check-label" for="female">Nữ</label>
                                                        </div>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Email</label>
                                                        <input name="email" id="email" type="email" class="form-control" placeholder="Your email:" value="${email}">
                                                    </div> 
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Số Điện Thoại</label>
                                                        <input name="number" id="number" type="text" class="form-control" placeholder="Phone number:" value="${phoneNumber}">
                                                    </div>                                                                               
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Ngày sinh</label>
                                                        <input name="date" type="date" class="flatpickr flatpickr-input form-control" value="${dateOfBirth}">
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Địa chỉ</label>
                                                        <input name="address" type="text" class="flatpickr flatpickr-input form-control" value="${address}"  placeholder="Your address :" required>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Chọn ảnh đại diện</label>
                                                        <input name="avatar" id="avatar" type="file" class="form-control" placeholder="Your avatar :" required>
                                                    </div> 
                                                </div><!--end col-->

                                                <!-- Hiển thị thông báo lỗi chung -->
                                                <c:if test="${not empty errors}">
                                                    <div class="alert alert-danger mt-3">

                                                        <c:forEach var="error" items="${errors}">
                                                            <p>${error}</p>
                                                        </c:forEach>

                                                    </div>
                                                </c:if>

                                                <!-- End Error Message -->

                                                <!-- Hiển thị thông báo thành công nếu có -->
                                                <c:if test="${not empty success}">
                                                    <div class="alert alert-success mt-3">${success}</div>
                                                </c:if>  
                                            </div><!--end row-->

                                            <button type="submit" class="btn btn-primary">Thêm bệnh nhân</button>
                                            <a href="listCustomer" class="btn btn-primary me-2 text-nowrap">Quay lại danh sách bệnh nhân</a>
                                        </form>
                                        <!--form-end-->
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div><!--end container-->

                    <!-- Footer Start -->
                    <jsp:include page="../layout/footer.jsp"/>
                </main>
                <!--End page-content" -->
            </div>
            <!-- page-wrapper -->



            <!-- javascript -->
            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/js/bootstrap.bundle.min.js"></script>
            <!-- simplebar -->
            <script src="assets/js/simplebar.min.js"></script>
            <!-- Select2 -->
            <script src="assets/js/select2.min.js"></script>
            <script src="assets/js/select2.init.js"></script>
            <!-- Datepicker -->
            <script src="assets/js/flatpickr.min.js"></script>
            <script src="assets/js/flatpickr.init.js"></script>
            <!-- Icons -->
            <script src="assets/js/feather.min.js"></script>
            <!-- Main Js -->
            <script src="assets/js/app.js"></script>

            <script>
                                            document.addEventListener("DOMContentLoaded", function () {
                                                const form = document.querySelector("form");
                                                const avatarInput = document.getElementById("avatar");
                                                const allowedExtensions = ["png", "jpg", "jpeg", "gif"];
                                                const maxFileSize = 3 * 1024 * 1024; // 3MB

                                                form.addEventListener("submit", function (event) {
                                                    let errors = [];
                                                    // Kiểm tra file ảnh
                                                    if (avatarInput.files.length > 0) {
                                                        const file = avatarInput.files[0];
                                                        const fileSize = file.size;
                                                        const fileExtension = file.name.split(".").pop().toLowerCase();

                                                        if (!allowedExtensions.includes(fileExtension)) {
                                                            errors.push("Ảnh đại diện phải có định dạng PNG, JPG, GIF hoặc JPEG.");
                                                        }

                                                        if (fileSize > maxFileSize) {
                                                            errors.push("Dung lượng ảnh đại diện không được vượt quá 3MB.");
                                                        }
                                                    }

                                                    // Nếu có lỗi, hiển thị và ngăn gửi form
                                                    if (errors.length > 0) {
                                                        event.preventDefault();
                                                        alert(errors.join("\n"));
                                                    }
                                                });
                                            });
            </script>

    </body>

</html>
