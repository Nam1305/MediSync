<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <link href="../assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="../assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="../assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <style>
            .table-container {
                background: white;
                padding: 15px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            h5 {
                font-size: 20px;
            }

            .table {
                font-size: 13px;
            }

            .table th, .table td {
                padding: 10px;
            }

            .table img {
                width: 30px;
                height: 30px;
                border-radius: 50%;
            }

            .btn {
                font-size: 12px;
                padding: 6px 10px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="top-navbar.jsp" />
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <!-- Left Navbar - Chiếm 1/4 -->
                    <div class="col-xl-3 col-lg-3 col-md-4 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <jsp:include page="left-navbar.jsp" />
                        </div>
                    </div><!-- End Left Navbar -->

                    <!-- Appointment - Chiếm 3/4 -->
                    <div class="col-xl-9 col-lg-9 col-md-8 col-12 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="table-container">
                            <h4 class="mb-3 text-center">Danh sách lịch hẹn</h4>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-success">
                                        <tr>
                                            <th>#</th>
                                            <th>Tên bệnh nhân</th>
                                            <th>Giới tính</th>
                                            <th>Ngày hẹn</th>
                                            <th>Giờ hẹn</th>
                                            <th class="text-center">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th class="p-3">1</th>
                                            <td class="p-3">
                                                <a href="#" class="text-dark">
                                                    <div class="d-flex align-items-center">
                                                        <img src="../assets/images/client/01.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                        <span class="ms-2">Howard Tanner</span>
                                                    </div>
                                                </a>
                                            </td>
                                            <td class="p-3">Male</td>
                                            <td class="p-3">20th Dec 2020</td>
                                            <td class="p-3">11:00AM</td>
                                            <td class="text-end p-3">
                                                <a href="#" class="btn btn-icon btn-pills btn-soft-primary" data-bs-toggle="modal" data-bs-target="#viewappointment"><i class="uil uil-eye"></i></a>
                                                <a href="#" class="btn btn-icon btn-pills btn-soft-success" data-bs-toggle="modal" data-bs-target="#acceptappointment"><i class="uil uil-check-circle"></i></a>
                                                <a href="#" class="btn btn-icon btn-pills btn-soft-danger" data-bs-toggle="modal" data-bs-target="#cancelappointment"><i class="uil uil-times-circle"></i></a>
                                            </td>
                                        </tr>

                                    </tbody>
                                </table>
                            </div>
                        </div><!-- End Table Container -->

                        <!-- Pagination -->
                        <div class="row text-center mt-4">
                            <div class="col-12">
                                <div class="d-md-flex align-items-center justify-content-between">
                                    <span class="text-muted">Hiển thị 1 - 10 trong tổng số ${totalAppointments}</span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item"><a class="page-link" href="#">Trước</a></li>
                                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                                        <li class="page-item"><a class="page-link" href="#">Sau</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div><!-- End Pagination -->
                    </div><!-- End Appointment -->
                </div><!-- End Row -->
            </div><!-- End Container -->
        </section>


        <jsp:include page="footer.jsp" />

        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/feather.min.js"></script>
        <script src="../assets/js/app.js"></script>
    </body>

</html>
