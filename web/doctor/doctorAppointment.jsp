<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <title>Appointment</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="../assets/images/favicon.ico.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
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
                    <div class="col-xl-3 col-lg-3 col-md-4 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <jsp:include page="left-navbar.jsp" />
                        </div>
                    </div>

                    <div class="col-xl-9 col-lg-9 col-md-8 col-12 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="table-container">
                            <h4 class="mb-3 text-center">Danh sách lịch hẹn</h4>
                            <div class="mb-4">
                                <form action="doctor/appointments.jsp" method="get" class="d-flex justify-content-between">
                                    <input type="text" name="search" class="form-control" placeholder="Tìm kiếm bệnh nhân" value="${param.search}" style="width: 200px;">

                                    <select name="status" class="form-control" style="width: 150px;">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Chờ xác nhận</option>
                                        <option value="Confirmed" ${param.status == 'Confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option value="Completed" ${param.status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
                                        <option value="Cancelled" ${param.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
                                    </select>

                                    <input type="date" name="date" class="form-control" value="${param.date}" style="width: 150px;">

                                    <!-- Input cho số bản ghi mỗi trang -->
                                    <input type="number" name="pageSize" class="form-control" value="${param.pageSize != null ? param.pageSize : 10}" min="1" max="100" step="1" style="width: 150px;">

                                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                </form>


                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-success">
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên bệnh nhân</th>
                                            <th>Giới tính</th>
                                            <th>Ngày hẹn</th>
                                            <th>Giờ hẹn</th>
                                            <th>Loại hẹn</th>
                                            <th>Trạng thái</th>
                                            <th class="text-center">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listA}" var="appointment">
                                            <tr>
                                                <th class="p-3">${appointment.appointmentId}</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-dark">
                                                        <div class="d-flex align-items-center">
                                                            <img src="${appointment.customer.avatar}" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">${appointment.customer.name}</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="p-3">
                                                    ${appointment.customer.gender == 'M' ? 'Nam' : 'Nữ'}
                                                </td>
                                                <td class="p-3">${appointment.date}</td>
                                                <td>
                                                    <fmt:formatDate value="${appointment.start}" pattern="HH:mm" /> - 
                                                    <fmt:formatDate value="${appointment.end}" pattern="HH:mm" />
                                                </td>
                                                <td class="p-3">${appointment.type}</td>
                                                <td class="p-3">${appointment.status}</td>
                                                <td class="text-end p-3">
                                                    <a href="doctor/doctorAppointmentDetail.jsp?appointmentId=${appointment.appointmentId}" class="btn btn-icon btn-pills btn-soft-primary">
                                                        <i class="uil uil-eye"></i>
                                                    </a>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-success" data-bs-toggle="modal" data-bs-target="#acceptappointment">
                                                        <i class="uil uil-check-circle"></i>
                                                    </a>
                                                    <a href="#" class="btn btn-icon btn-pills btn-soft-danger" data-bs-toggle="modal" data-bs-target="#cancelappointment">
                                                        <i class="uil uil-times-circle"></i>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Accept Appointment Start -->
                        <div class="modal fade" id="acceptappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-body py-5">
                                        <div class="text-center">
                                            <div class="icon d-flex align-items-center justify-content-center bg-soft-success rounded-circle mx-auto" style="height: 95px; width:95px;">
                                                <span class="mb-0"><i class="uil uil-check-circle h1"></i></span>
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
                        <!-- Cancel Appointment Start -->
                        <div class="modal fade" id="cancelappointment" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-body py-5">
                                        <div class="text-center">
                                            <div class="icon d-flex align-items-center justify-content-center bg-soft-danger rounded-circle mx-auto" style="height: 95px; width:95px;">
                                                <span class="mb-0"><i class="uil uil-times-circle h1"></i></span>
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
                        <!-- Pagination -->
                        <div class="col-12" style="margin-top: 1%;">
                            <div class="d-md-flex align-items-center justify-content-end">
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <li class="page-item"><a class="page-link" href="?page=${currentPage - 1}">Trước</a></li>
                                        <c:forEach begin="1" end="${totalPages}" var="page">
                                        <li class="page-item ${page == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${page}">${page}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item"><a class="page-link" href="?page=${currentPage + 1}">Sau</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>
