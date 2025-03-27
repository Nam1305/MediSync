<%-- 
    Document   : listDepartment
    Created on : Feb 14, 2025, 8:38:51 PM
    Author     : Acer
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Danh Sách Phòng Ban</title>
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
                            <h5 class="mb-0" style="color: #218838">Danh sách phòng ban</h5>
                        </div>
                        <div class="d-flex justify-content-end">
                            <form action="ListDepartment" method="get" class="d-flex align-items-center gap-2">
                                <input type="hidden" name="search" value="${search}"> <!-- Giữ lại giá trị search -->
                                <select name="sort" class="form-select">
                                    <option value="ASC" <c:if test="${sort == 'ASC'}">selected</c:if>>Tăng dần</option>
                                    <option value="DESC" <c:if test="${sort == 'DESC'}">selected</c:if>>Giảm dần</option>
                                    </select>

                                    <input type="number" id="pageSizeInput" name="pageSize" value="${pageSize}" class="form-control" placeholder="Số dòng" min="1" max="15">

                                <select name="status" id="statusFilter" class="form-select">
                                    <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả trạng thái</option>
                                    <option value="Active" <c:if test="${status == 'Active'}">selected</c:if>>Hoạt động</option>
                                    <option value="Inactive" <c:if test="${status == 'Inactive'}">selected</c:if>>Ngừng hoạt động</option>
                                    </select>

                                    <button type="submit" class="btn btn-primary form-control">Lọc</button>
                                    <button type="button" class="btn  btn-primary form-control text-nowrap" onclick="resetFilters()">Làm mới</button>

                                </form>
                            </div>

                            <div class="d-flex justify-content-end">
                                <button class="btn btn-primary text-nowrap" onclick="window.location.href = 'AddDepartment'" style="margin: 10px;">
                                    Thêm Phòng Ban
                                </button>
                            </div>
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="table-responsive shadow rounded">
                                        <table class="table table-center bg-white mb-0">
                                            <thead>
                                                <tr>
                                                    <th class="border-bottom p-3" style="min-width: 50px;">ID</th>
                                                    <th class="border-bottom p-3" style="min-width: 180px;">Tên Phòng Ban</th>
                                                    <th class="border-bottom p-3">Trạng thái</th>

                                                    <th class="border-bottom p-3" style="min-width: 100px;">Hành động</th>
                                                </tr>
                                            </thead>
                                            <!--tbody-start-->
                                            <tbody>
                                            <c:forEach var="department" items="${listDepartment}">
                                                <tr>
                                                    <td class="p-3">${department.departmentId}</td>
                                                    <td class="p-3">${department.departmentName}</td>
                                                    <td class="p-3">${department.status == "Active" ? "Hoạt động" : "Ngưng hoạt động"}</td>
                                                    <td class=" p-3">
                                                        <!-- Action Buttons -->
                                                        <a href="ViewDepartmentDetail?id=${department.departmentId}" class="btn btn-icon btn-pills btn-soft-primary" >
                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                        <!-- Edit button with data-* attributes for customer info -->
                                                        <a href="UpdateDepartment?id=${department.departmentId}" class="btn btn-icon btn-pills btn-soft-success">
                                                            <i class="uil uil-pen"></i> 
                                                        </a>
                                                        <form id="deleteForm${department.departmentId}" action="DeleteDepartment" method="post" style="display: inline;">
                                                            <input type="hidden" name="id" value="${department.departmentId}">
                                                            <a href="#" onclick="doDelete(${department.departmentId})" class="btn btn-icon btn-pills btn-soft-danger">
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
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-end">

                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListDepartment?page=${currentPage - 1}&pageSize=${pageSize}&status=${status}&sort=${sort}&search=${search}">Trước</a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="ListDepartment?page=${i}&pageSize=${pageSize}&status=${status}&sort=${sort}&search=${search}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListDepartment?page=${currentPage + 1}&pageSize=${pageSize}&status=${status}&sort=${sort}&search=${search}">Sau<a>
                                                        </li>
                                                    </c:if>
                                                    </ul>
                                                    </div>
                                                    </div>

                                                    <!--PAGINATION END -->
                                                    </div>
                                                    </div>
                                                    </div>
                                                    <!--end container-->

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
                                                                                        window.location.href = './ListDepartment?search=&status=&pageSize=3';
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
