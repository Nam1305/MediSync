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
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
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
        <style>
            /* Style chung cho form (trừ form có id bắt đầu bằng "deleteForm") */
            form:not([id^="deleteForm"]) {
                display: flex;
                align-items: center;
                justify-content: center; /* Căn giữa theo chiều ngang */
                gap: 8px;
                background: #fff;
                padding: 8px;
                border-radius: 6px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            /* Căn giữa chữ trong label */
            form:not([id^="deleteForm"]) label {
                font-weight: bold;
                color: #555;
                font-size: 12px;
                display: flex;
                align-items: center; /* Căn giữa chữ theo chiều dọc */
                height: 24px; /* Đồng bộ chiều cao với input */
            }

            /* Style cho input và select */
            form:not([id^="deleteForm"]) select,
            form:not([id^="deleteForm"]) input[type="number"] {
                padding: 3px 5px;
                font-size: 12px;
                border: 1px solid #ddd;
                border-radius: 3px;
                outline: none;
                transition: border-color 0.3s;
                width: 60px;
                height: 24px; /* Đồng bộ chiều cao */
            }

            /* Hiệu ứng focus */
            form:not([id^="deleteForm"]) select:focus,
            form:not([id^="deleteForm"]) input[type="number"]:focus {
                border-color: #28a745;
            }

            /* Style cho button */
            form:not([id^="deleteForm"]) button {
                background: #28a745;
                color: white;
                border: none;
                padding: 3px 6px;
                font-size: 12px;
                border-radius: 3px;
                cursor: pointer;
                transition: background 0.3s;
                height: 24px; /* Đồng bộ chiều cao */
                display: flex;
                align-items: center; /* Căn giữa chữ */
                justify-content: center; /* Căn giữa theo chiều ngang */
            }

            /* Hiệu ứng hover */
            form:not([id^="deleteForm"]) button:hover {
                background: #218838;
            }
        </style>

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
                            <h5 class="mb-0" style="color: #218838">Danh sách Dịch vụ </h5>
                            <form action="ListService" method="get" >
                                 <label for="sort">Sắp xếp </label>
                                <select name="sort" >    
                                    <option value="ASC" <c:if test="${sort == 'ASC'}">selected</c:if>>Tăng dần</option>
                                    <option value="DESC" <c:if test="${sort == 'DESC'}">selected</c:if>>Giảm dần</option>
                                </select>
                                <select name="status" id="statusFilter">
                                    <option value="" <c:if test="${empty status}">selected</c:if>>Tất cả trạng thái</option>
                                    <option value="Active" <c:if test="${status == 'Active'}">selected</c:if>>Active</option>
                                    <option value="Inactive" <c:if test="${status == 'Inactive'}">selected</c:if>>Inactive</option>
                                    </select>
                                    <button type="submit" class="btn btn-primary mt-4 mt-sm-0"  >Filter</button> 
                                    <label for="Page">PageSize</label>
                                    <input type="number" name="pageSize" value="${pageSize}">
                                <button type="submit" class="btn btn-primary mt-4 mt-sm-0" >Paging</button>
                                <button type="button" class="btn btn-secondary mt-4 mt-sm-0" onclick="resetFilters()">Reset</button>
                            </form>
                        </div>

                        <button class="btn btn-primary mt-4 mt-sm-0" onclick="window.location.href = 'AddService'">
                            Thêm Dịch Vụ 
                        </button>
                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 50px;">ID</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Tên Dịch Vụ</th>

                                                <th class="border-bottom p-3">Giá</th>
                                                <th class="border-bottom p-3">Status</th>

                                                <th class="border-bottom p-3" style="min-width: 100px;">Actions</th>
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
                                    <span class="text-muted me-3">Showing 1 - 10 out of 50</span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListService?page=${currentPage - 1}&pageSize=${pageSize}&status=${status}&sort=${sort}">Previous</a>
                                            </li>
                                        </c:if>

                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="ListService?page=${i}&pageSize=${pageSize}&status=${status}&sort=${sort}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="ListService?page=${currentPage + 1}&pageSize=${pageSize}&status=${status}&sort=${sort}">Next</a>
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


    </body>

</html>
