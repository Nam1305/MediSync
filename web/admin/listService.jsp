<%-- 
    Document   : listDepartment
    Created on : Feb 14, 2025, 8:38:51 PM
    Author     : Acer
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Danh Sách Dịch Vụ</title>
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
                if (confirm("Are you sure you want to delete Service with ID: " + id + "?")) {
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
                            <h5 class="mb-0" style="color: #218838">Danh sách Dịch Vụ</h5>
                        </div>
                        <div class="d-flex justify-content-end">
                            <form action="ListService" method="get" class="d-flex align-items-center gap-2">
                                <input type="hidden" name="search" value="${search}"> <!-- Giữ lại giá trị search -->
                                <select name="sort" class="form-select">
                                    <option value="ASC" <c:if test="${sort == 'ASC'}">selected</c:if>>Tăng dần</option>
                                    <option value="DESC" <c:if test="${sort == 'DESC'}">selected</c:if>>Giảm dần</option>
                                    </select>

                                    <select name="status" id="statusFilter" class="form-select">
                                        <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả</option>
                                    <option value="Active" <c:if test="${status == 'Active'}">selected</c:if>>Active</option>
                                    <option value="Inactive" <c:if test="${status == 'Inactive'}">selected</c:if>>Inactive</option>
                                    </select>                                        
                                    <input type="number" id="pageSizeInput" name="pageSize" value="${pageSize}" class="form-control" style="width: 100px;" placeholder="Kích thước" min="1" max="15">
                                <button type="submit" class="btn btn-primary form-control text-nowrap">Lọc</button>

                                <button type="button" class="btn  btn-primary form-control text-nowrap" onclick="resetFilters()">Làm Mới</button>

                            </form>
                        </div>
                        <div class="d-flex justify-content-end">
                            <button class="btn btn-primary text-nowrap " onclick="window.location.href = 'AddService'" style="margin: 10px;">
                                Thêm Dịch Vụ
                            </button>
                        </div>      

                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 50px;">ID</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Tên Dịch Vụ</th>

                                                <th class="border-bottom p-3">Giá</th>
                                                <th class="border-bottom p-3">Trạng thái</th>

                                                <th class="border-bottom p-3" style="min-width: 100px;">Hành động</th>
                                            </tr>
                                        </thead>
                                        <!--tbody-start-->
                                        <tbody>
                                            <c:forEach var="service" items="${listService}">
                                                <tr>
                                                    <td class="p-3">${service.serviceId}</td>
                                                    <td class="p-3">${service.name}</td>

                                                    <td class="p-3"><fmt:formatNumber value="${service.price}" type="number" groupingUsed="true"/></td>
                                                    <td class="p-3">${service.status}</td>
                                                    <td class=" p-3">
                                                        <!-- Action Buttons -->
                                                        <a href="ViewServiceDetail?id=${service.serviceId}" class="btn btn-icon btn-pills btn-soft-primary" >
                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                        <!-- Edit button with data-* attributes for customer info -->
                                                        <a href="UpdateService?id=${service.serviceId}" class="btn btn-icon btn-pills btn-soft-success">
                                                            <i class="uil uil-pen"></i> 
                                                        </a>
                                                        <form id="deleteForm${service.serviceId}" action="DeleteService" method="post" style="display: inline;">
                                                            <input type="hidden" name="id" value="${service.serviceId}">
                                                            <a onclick="doDelete(${service.serviceId})" class="btn btn-icon btn-pills btn-soft-danger">
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
                                <div class="d-md-flex align-items-center text-center justify-content-between">

                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListService?page=${currentPage - 1}&pageSize=${pageSize}&status=${status}&sort=${sort}&search=${search}">Trước</a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="ListService?page=${i}&pageSize=${pageSize}&status=${status}&sort=${sort}&search=${search}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListService?page=${currentPage + 1}&pageSize=${pageSize}&status=${status}&sort=${sort}&search=${search}">Sau</a>
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

        <!-- Modal end -->

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
                                            window.location.href = './ListService?search=&status=&pageSize=5';
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
