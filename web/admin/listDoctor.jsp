
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Danh Sách Nhân Viên</title>
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
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <script type="text/javascript">
            function doDelete(id) {
                if (confirm("Are you sure you want to delete Staff with ID: " + id + "?")) {
                    document.getElementById("deleteForm" + id).submit();
                }
            }
        </script>
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
                            <h5 class="mb-0" style="color: #218838">Danh sách nhân viên</h5>
                        </div>

                        <div class="d-flex justify-content-end">
                            <form action="ListDoctor" method="get" class="row gx-2 gy-2 align-items-center">
                                <input type="hidden" name="s" value="${s}"> <!-- Giữ lại giá trị search -->
                                <div class="col-auto">
                                    <select name="sort" class="form-select">
                                        <option value="ASC" <c:if test="${sort == 'ASC'}">selected</c:if>>Tăng dần</option>
                                        <option value="DESC" <c:if test="${sort == 'DESC'}">selected</c:if>>Giảm dần</option>
                                        </select>
                                    </div>

                                    <div class="col-auto">
                                        <select name="roleId" id="roleFilter" class="form-select">
                                            <option value="">Tất cả</option>
                                            <option value="2" <c:if test="${roleId == '2'}">selected</c:if>>Bác sĩ</option>
                                        <option value="3" <c:if test="${roleId == '3'}">selected</c:if>>Chuyên gia</option>
                                        <option value="4" <c:if test="${roleId == '4'}">selected</c:if>>Lễ tân</option>
                                        </select>
                                    </div>

                                    <div class="col-auto">
                                        <select name="status" id="statusFilter" class="form-select">
                                            <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả trạng thái</option>
                                        <option value="Active" <c:if test="${status == 'Active'}">selected</c:if>>Hoạt động</option>
                                        <option value="Inactive" <c:if test="${status == 'Inactive'}">selected</c:if>>Ngừng hoạt động</option>
                                        </select>
                                    </div>

                                    <div class="col-auto">
                                        <input type="number" id="pageSizeInput" name="pageSize" value="${pageSize}" class="form-control" placeholder="Số dòng" min="1" max="15">
                                </div>

                                <div class="col-auto">
                                    <button type="submit" class="btn btn-primary form-control">Lọc</button>
                                </div>

                                <div class="col-auto">
                                    <button type="button" class="btn btn-primary form-control text-nowrap" onclick="resetFilters()">Làm mới</button>
                                </div>
                            </form>
                        </div>

                        <div class="d-flex justify-content-end">
                            <button class="btn btn-primary" onclick="window.location.href = 'AddStaffServlet'" style="margin: 10px;">
                                Thêm Nhân Viên
                            </button>
                        </div>


                        <!-- navbar-of-table -->
                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 50px;">ID</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Họ và Tên</th>

                                                <th class="border-bottom p-3">Vị trí </th>

                                                <th class="border-bottom p-3">số điện thoại</th>
                                                <th class="border-bottom p-3" style="min-width: 150px;">Ngày sinh</th>
                                                <th class="border-bottom p-3">Email</th>
                                                <th class="border-bottom p-3">Trạng thái</th>

                                                <th class="border-bottom p-3" style="min-width: 100px;">Hành động</th>
                                            </tr>
                                        </thead>
                                        <!--tbody-start-->
                                        <tbody>
                                            <c:forEach var="doctors" items="${listDoctor}">
                                                <tr>
                                                    <td class="p-3">${doctors.staffId}</td>
                                                    <td class="py-3">
                                                        <a href="#" class="text-dark">
                                                            <div class="d-flex align-items-center">
                                                                <img src="${doctors.avatar}" 
                                                                     class="avatar avatar-md-sm rounded-circle shadow" alt="">

                                                                <span class="ms-2">${doctors.name}</span>
                                                            </div>
                                                        </a>
                                                    </td>

                                                    <td class="p-3">${doctors.position}</td>

                                                    <td class="p-3">${doctors.phone}</td>
                                                    <td class="p-3"><fmt:formatDate value="${staff.dateOfBirth}" pattern="dd/MM/yyyy"/></td>
                                                    <td class="p-3">${doctors.email}</td>
                                                    <td class="p-3">
                                                        ${doctors.status == "Active" ? "Hoạt động" : "Ngưng hoạt động"}
                                                    </td>
                                                    <td class="text-end p-3">
                                                        <!-- Action Buttons -->
                                                        <a href="ViewStaffDetail?id=${doctors.staffId}" class="btn btn-icon btn-pills btn-soft-primary" >
                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                        <!-- Edit button with data-* attributes for customer info -->
                                                        <a href="UpdateStaffServlet?id=${doctors.staffId}" class="btn btn-icon btn-pills btn-soft-success">
                                                            <i class="uil uil-pen"></i> 
                                                        </a>
                                                        <form id="deleteForm${doctors.staffId}" action="deleteStaffServlet" method="post" style="display: inline;">
                                                            <input type="hidden" name="id" value="${doctors.staffId}">
                                                            <a href="#" onclick="doDelete(${doctors.staffId})" class="btn btn-icon btn-pills btn-soft-danger">
                                                                <i class="uil uil-trash"></i>
                                                            </a>
                                                        </form>

                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                        <!--Tbody-end-->

                                    </table>
                                    <!-- Phân trang -->


                                </div>
                            </div>
                        </div><!--end row-->

                        <div class="row text-center">
                            <!--                                                     PAGINATION START -->
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-end">

                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListDoctor?page=${currentPage - 1}&pageSize=${pageSize}&roleId=${roleId}&status=${status}&sort=${sort}&s=${s}">Trước</a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="ListDoctor?page=${i}&pageSize=${pageSize}&roleId=${roleId}&status=${status}&sort=${sort}&s=${s}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListDoctor?page=${currentPage + 1}&pageSize=${pageSize}&roleId=${roleId}&status=${status}&sort=${sort}&s=${s}">Sau</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>


                            <!--PAGINATION END -->
                        </div>
                    </div>
                </div><!--end container-->

                <jsp:include page="../layout/footer.jsp" />

            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->


        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
        <script>
                                                                function resetFilters() {
                                                                    window.location.href = './ListDoctor?search=&status=&roleId=&pageSize=5';
                                                                }

        </script>
        <script>
            function validatePageSize() {
                let input = document.getElementById("pageSizeInput");
                let value = parseInt(input.value);

                if (value < 1 || value > 15) {
                    alert("Giá trị phải từ 1 đến 15!");
                    input.value = ""; // Xóa giá trị không hợp lệ
                }
            }
        </script>

    </body>

</html>
