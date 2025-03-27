<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Thêm Nhân Viên</title>
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
                                                        <label class="form-label">Ảnh đại diện</label>
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
                                                        <label class="form-label">Vai Trò</label>
                                                        <select name="roleId" class="form-control department-name select2input" required>
                                                            <c:forEach var="role" items="${listRoles}">
                                                                <option value="${role.roleId}" ${staff.role.roleId == role.roleId ? 'selected' : ''}>${role.role}</option>
                                                            </c:forEach>
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
                                                        <label class="form-label">Vị trí làm việc </label>

                                                        <select name="position" id="position" class="form-control department-name select2input" required>
                                                            <option value="Bác Sĩ">Bác Sĩ</option>
                                                            <option value="Chuyên Gia">Chuyên Gia</option>
                                                            <option value="Nhân viên Hành chính">Nhân viên Hành Chính</option>
                                                        </select>
                                                    </div>
                                                </div><!--end col-->
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Giới thiệu Bản Thân</label>
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