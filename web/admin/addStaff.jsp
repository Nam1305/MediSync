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
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://cdn.tiny.cloud/1/vnufc6yakojjcovpkijlauot8hfpbxd3uscxatfq2m4yijay/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>        
        <script src="assets/js/tinymce-init.js"></script>
        <script src="https://cdn.tiny.cloud/1/vnufc6yakojjcovpkijlauot8hfpbxd3uscxatfq2m4yijay/tinymce/6/langs/vi.js" referrerpolicy="origin"></script>

    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../layout/navbar.jsp" />


            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0" style="color: green">Thêm Nhân Viên</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><button class="btn btn-primary mt-4 mt-sm-0" onclick="window.location.href = 'ListDoctor'">
                                            Danh Sách Nhân Viên
                                        </button></li>
                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-8 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-4">
                                            <img src="assets/images/doctors/01.jpg" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                        </div><!--end col-->



                                        <form class="mt-4" action="AddStaffServlet" method="POST" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Họ và tên</label>
                                                        <input name="name" id="name" type="text" class="form-control" value="${name}" placeholder="Họ và tên" required>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Email</label>
                                                        <input name="email" id="email" type="email" class="form-control" value="${email}"  placeholder="Email :" required>
                                                    </div> 
                                                </div><!--end col-->
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Avatar</label>
                                                        <input name="avatar" id="avatar" type="file" class="form-control" accept="image/jpeg, image/png, image/gif" placeholder="Ảnh đại diện:" required>
                                                        <small id="avatar-error" class="text-danger"></small>
                                                    </div> 
                                                </div><!--end col-->
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Số Điện Thoại</label>
                                                        <input name="phone" id="phone" type="text" class="form-control" value="${phone}" placeholder="Số điện thoại:" required>
                                                    </div>                                                                               
                                                </div><!--end col-->


                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Ngày Sinh</label>
                                                        <input name="dateOfBirth"  type="date" class="form-control" required>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Phòng Ban</label>
                                                        <select name="departmentId" class="form-control department-name select2input" required>
                                                            <c:forEach var="department" items="${requestScope.listDepartment}">
                                                                <option value="${department.departmentId}">${department.departmentName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->
                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Role</label>
                                                        <select name="roleId" class="form-control department-name select2input" required>
                                                            <option value="2">Doctor</option>
                                                            <option value="3">Expert</option>
                                                            <option value="4">Receptionist</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->

                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Giới Tính</label>
                                                        <select name="gender" class="form-control gender-name select2input" required>
                                                            <option value="M">Nam</option>
                                                            <option value="F">Nữ</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->


                                                <div class="col-md-6">
                                                    <div class="mb-3">
                                                        <label class="form-label">Vị trí Làm việc </label>

                                                        <select name="position" id="position" class="form-control department-name select2input" required>
                                                            <option value="Bác Sĩ">Bác Sĩ</option>
                                                            <option value="Chuyên Gia">Chuyên Gia</option>
                                                            <option value="Nhân viên Hành chính">Nhân viên Hành Chính</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Giới Thiệu Bản Thân</label>
                                                        <textarea name="description" id="desctiption"  class="form-control" placeholder="Mô tả :" required>${description}</textarea>
                                                    </div> 
                                                </div><!--end col-->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Chứng chỉ</label>
                                                        <textarea id="testResults" class="form-control" name="certificate"></textarea>
                                                    </div> 
                                                </div><!--end col-->
                                                <div>
                                                    <c:if test="${not empty error}">
                                                        <ul style="color: red">
                                                            <c:forEach var="err" items="${error}">
                                                                <li>${err}</li>
                                                                </c:forEach>
                                                        </ul>
                                                    </c:if>
                                                    <c:if test="${not empty success}">
                                                        <ul style="color: green">
                                                            <li>${success}</li>    
                                                        </ul>
                                                    </c:if>
                                                </div>

                                            </div><!--end row-->

                                            <button type="submit" class="btn btn-primary">Thêm Nhân Viên</button>
                                        </form>


                                    </div><!--end row-->
                                </div>
                            </div><!--end container-->

                            <jsp:include page="../layout/footer.jsp" />
                            </main>
                            <!--End page-content" -->
                        </div>
                        <!-- page-wrapper -->

                        <!-- Offcanvas Start -->
                        <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                            <div class="offcanvas-header p-4 border-bottom">
                                <h5 id="offcanvasRightLabel" class="mb-0">
                                    <img src="assets/images/logo-dark.png" height="24" class="light-version" alt="">
                                    <img src="assets/images/logo-light.png" height="24" class="dark-version" alt="">
                                </h5>
                                <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
                            </div>
                            <div class="offcanvas-body p-4 px-md-5">
                                <div class="row">
                                    <div class="col-12">
                                        <!-- Style switcher -->
                                        <div id="style-switcher">
                                            <div>
                                                <ul class="text-center list-unstyled mb-0">
                                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                                    <li class="d-grid"><a href="landing/index.html" target="_blank" class="mt-4"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <!-- end Style switcher -->
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div>

                            <div class="offcanvas-footer p-4 border-top text-center">
                                <ul class="list-unstyled social-icon mb-0">
                                    <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                                    <li class="list-inline-item mb-0"><a href="index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
                                </ul><!--end icon-->
                            </div>
                        </div>
                        <!-- Offcanvas End -->

                        <!-- View Appintment Start -->
                        <div class="modal fade" id="viewappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header border-bottom p-3">
                                        <h5 class="modal-title" id="exampleModalLabel">Appointment Detail</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body p-3 pt-4">
                                        <div class="d-flex align-items-center">
                                            <img src="assets/images/client/01.jpg" class="avatar avatar-small rounded-pill" alt="">
                                            <h5 class="mb-0 ms-3">Howard Tanner</h5>
                                        </div>
                                        <ul class="list-unstyled mb-0 d-md-flex justify-content-between mt-4">
                                            <li>
                                                <ul class="list-unstyled mb-0">
                                                    <li class="d-flex">
                                                        <h6>Age:</h6>
                                                        <p class="text-muted ms-2">25 year old</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6>Gender:</h6>
                                                        <p class="text-muted ms-2">Male</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6 class="mb-0">Department:</h6>
                                                        <p class="text-muted ms-2 mb-0">Cardiology</p>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li>
                                                <ul class="list-unstyled mb-0">
                                                    <li class="d-flex">
                                                        <h6>Date:</h6>
                                                        <p class="text-muted ms-2">20th Dec 2020</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6>Time:</h6>
                                                        <p class="text-muted ms-2">11:00 AM</p>
                                                    </li>

                                                    <li class="d-flex">
                                                        <h6 class="mb-0">Doctor:</h6>
                                                        <p class="text-muted ms-2 mb-0">Dr. Calvin Carlo</p>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- View Appintment End -->

                        <!-- Accept Appointment Start -->
                        <div class="modal fade" id="acceptappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-body py-5">
                                        <div class="text-center">
                                            <div class="icon d-flex align-items-center justify-content-center bg-soft-success rounded-circle mx-auto" style="height: 95px; width:95px;">
                                                <i class="uil uil-check-circle h1 mb-0"></i>
                                            </div>
                                            <div class="mt-4">
                                                <h4>Accept Appointment</h4>
                                                <p class="para-desc mx-auto text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment.</p>
                                                <div class="mt-4">
                                                    <a href="#" class="btn btn-soft-success">Accept</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Accept Appointment End -->

                        <!-- Cancel Appointment Start -->
                        <div class="modal fade" id="cancelappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-body py-5">
                                        <div class="text-center">
                                            <div class="icon d-flex align-items-center justify-content-center bg-soft-danger rounded-circle mx-auto" style="height: 95px; width:95px;">
                                                <i class="uil uil-times-circle h1 mb-0"></i>
                                            </div>
                                            <div class="mt-4">
                                                <h4>Cancel Appointment</h4>
                                                <p class="para-desc mx-auto text-muted mb-0">Great doctor if you need your family member to get immediate assistance, emergency treatment.</p>
                                                <div class="mt-4">
                                                    <a href="#" class="btn btn-soft-danger">Cancel</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Cancel Appointment End -->
                        <!-- Modal end -->

                        <!-- javascript -->
                        <script src="assets/js/jquery.min.js"></script>
                        <script src="assets/js/bootstrap.bundle.min.js"></script>
                        <!-- simplebar -->
                        <script src="assets/js/simplebar.min.js"></script>
                        <!-- Select2 -->
                        <script src="assets/js/select2.min.js"></script>
                        <script src="assets/js/select2.init.js"></script>
                        <!-- Icons -->
                        <script src="assets/js/feather.min.js"></script>
                        <!-- Main Js -->
                        <script src="assets/js/app.js"></script>
                        <script>
                                                        document.getElementById("avatar").addEventListener("change", function () {
                                                            var file = this.files[0];
                                                            var errorElement = document.getElementById("avatar-error");

                                                            if (file) {
                                                                var fileSize = file.size; // Đổi sang MB
                                                                var fileType = file.type;

                                                                // Danh sách định dạng ảnh hợp lệ
                                                                var validImageTypes = ["image/jpeg", "image/png", "image/gif"];

                                                                if (!validImageTypes.includes(fileType)) {
                                                                    errorElement.textContent = "Chỉ được chọn file ảnh (JPG, PNG, GIF)!";
                                                                    this.value = ""; // Xóa file đã chọn
                                                                } else if (fileSize > 3 * 1024 * 1024) {
                                                                    errorElement.textContent = "File không được vượt quá 3MB!";
                                                                    this.value = ""; // Xóa file đã chọn
                                                                } else {
                                                                    errorElement.textContent = ""; // Xóa lỗi nếu hợp lệ
                                                                }
                                                            }
                                                        });
                        </script>
                        </body>

                        </html>