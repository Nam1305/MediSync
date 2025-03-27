<%-- 
    Document   : addDepartment
    Created on : Feb 17, 2025, 2:47:22 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Thêm Phòng Ban</title>
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
                            <h5 class="mb-0" style="color: green">Thêm Phòng Ban</h5>

                            <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">

                                    <button class="btn btn-primary mt-4 mt-sm-0" onclick="window.location.href = 'ListDepartment'">
                                        Danh Sách Phòng Ban
                                    </button>

                                </ul>
                            </nav>
                        </div>

                        <div class="row">
                            <div class="col-lg-8 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="row align-items-center">

                                        <form class="mt-4" action="AddDepartment" method="post" >
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="mb-3">
                                                        <label class="form-label">Tên Phòng Ban</label>
                                                        <input name="departmentname" id="departmentname" type="text" class="form-control" placeholder="Tên Phòng Ban" required>
                                                    </div>
                                                </div><!--end col-->

                                                <div>
                                                    <c:if test="${not empty error}">
                                                        <div style="color: red">${error}</div>
                                                    </c:if>
                                                    <c:if test="${not empty success}">
                                                        <div style="color: green">${success}</div>
                                                    </c:if>
                                                </div>

                                            </div><!--end row-->

                                            <button type="submit" class="btn btn-primary">Thêm Phòng Ban </button>
                                        </form>


                                    </div><!--end row-->
                                </div>
                            </div><!--end container-->


                            <!-- Footer Start -->
                            <footer class="bg-white shadow py-3" style="background-color: #ffffff;
                                    box-shadow: 0px -2px 5px rgba(0, 0, 0, 0.1);
                                    padding: 15px 0;
                                    text-align: center;
                                    width: 100%;
                                    position: absolute;
                                    bottom: 0;">
                                <jsp:include page="../layout/footer.jsp" />
                            </footer><!--end footer-->
                            <!-- End -->

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

                        </body>

                        </html>