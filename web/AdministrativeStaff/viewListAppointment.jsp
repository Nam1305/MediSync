<%-- 
    Document   : viewListAppointment
    Created on : Mar 9, 2025, 9:58:55 AM
    Author     : Phạm Hoàng Nam
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Lịch hẹn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
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
            .filter-btn {
                min-height: 38px; /* Fix chiều cao button bằng input */
            }
        </style>
    </head>
    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <!-- sidebar-wrapper  -->
            <jsp:include page="left-navbar.jsp" />
            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../doctor/top-navbar.jsp"></jsp:include>
                    <div class="container-fluid">
                        <div class="layout-specing">
                            <div class="table-container">
                                <h4 class="mb-3 text-center">Danh sách lịch hẹn</h4>
                                <div class="mb-4">
                                    <!-- Form tìm kiếm, lọc dữ liệu -->
                                    <form action="confirmappointment" method="get" class="d-flex justify-content-between">
                                        <!-- Ô tìm kiếm bệnh nhân -->
                                        <input type="text" name="search" class="form-control" placeholder="Tìm kiếm bệnh nhân" value="${param.search}" style="width: 200px;">

                                    <!-- Bộ lọc trạng thái -->
                                    <select name="status" class="form-control" style="width: 150px;">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ xác nhận</option>
                                        <option value="confirmed" ${param.status == 'confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option value="paid" ${param.status == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                                        <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                        <option value="waitpay" ${param.status == 'waitpay' ? 'selected' : ''}>Chờ thanh toán</option>
                                        <option value="absent" ${param.status == 'absent' ? 'selected' : ''}>Vắng mặt</option>
                                    </select>

                                    <!-- Bộ lọc theo ngày -->
                                    <input type="date" name="date" class="form-control" value="${param.date}" style="width: 150px;">

                                    <!-- Bộ lọc số lượng hiển thị trên trang -->
                                    <div class="col-md-2">
                                        <input type="number" class="form-control" name="pageSize" min="1" max="${totalAppointment}" 
                                               value="${not empty pageSize ? pageSize : 2}" placeholder="Số lượng/trang">
                                    </div>

                                    <!-- Bộ lọc sắp xếp theo giờ hẹn -->
                                    <select name="sort" class="form-control" style="width: 150px;">
                                        <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Giảm dần theo ngày</option>
                                        <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Tăng dần theo ngày</option>
                                    </select>


                                    <div class="col-md-2 d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">Lọc</button>
                                        <button type="button" class="btn btn-primary text-nowrap" onclick="resetForm()">Bỏ lọc</button>
                                    </div>
                                </form>

                            </div>
                            <!-- Bảng hiển thị danh sách appointment -->
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-success">
                                        <tr>
                                            <th>ID</th>
                                            <th>Tên bệnh nhân</th>
                                            <th>Giới tính</th>
                                            <th>Ngày hẹn</th>
                                            <th>Giờ hẹn</th>
                                            <th>Trạng thái</th>
                                            <th class="text-center">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listA}" var="appointment">
                                            <tr class="status-${appointment.status}">
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
                                                    <c:choose>
                                                        <c:when test="${appointment.customer.gender == 'M'}">Nam</c:when>
                                                        <c:otherwise>Nữ</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="p-3">
                                                    <fmt:formatDate value="${appointment.date}" pattern="dd/MM/yyyy" />
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${appointment.start}" pattern="HH:mm" /> - 
                                                    <fmt:formatDate value="${appointment.end}" pattern="HH:mm" />
                                                </td>
                                                <td class="p-3">
                                                    <c:choose>
                                                        <c:when test="${appointment.status == 'pending'}">
                                                            <span class="badge bg-warning">Chờ xác nhận</span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'confirmed'}">
                                                            <span class="badge bg-primary">Đã xác nhận</span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'paid'}">
                                                            <span class="badge bg-success">Đã thanh toán</span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'cancelled'}">
                                                            <span class="badge bg-danger">Đã hủy</span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'waitpay'}">
                                                            <span class="badge bg-info">Chờ thanh toán</span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'absent'}">
                                                            <span class="badge bg-secondary">Vắng mặt</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>

                                                <td class="text-end p-3">
                                                    <!-- Link chuyển trạng thái: Hủy lịch -->
                                                    <a href="confirmappointment?appointmentId=${appointment.appointmentId}&newStatus=cancelled&page=${currentPage}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}&sort=${param.sort}"
                                                       class="btn btn-icon btn-pills btn-soft-danger"
                                                       onclick="return confirm('Bạn có chắc muốn chuyển trạng thái của lịch hẹn ${appointment.appointmentId} sang Hủy lịch hẹn?');">
                                                        <i class="uil uil-times-circle"></i>
                                                    </a>

                                                    <!-- Link chuyển trạng thái: Xác nhận -->
                                                    <a href="confirmappointment?appointmentId=${appointment.appointmentId}&newStatus=confirmed&page=${currentPage}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}&sort=${param.sort}"
                                                       class="btn btn-icon btn-pills btn-soft-danger"
                                                       onclick="return confirm('Bạn có chắc muốn chuyển trạng thái của lịch hẹn ${appointment.appointmentId} sang Đã xác nhận?');">
                                                        <i class="uil uil-check-circle"></i>
                                                    </a>

                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!-- Phân trang -->
                        <div class="col-12" style="margin-top: 1%;">
                            <div class="d-md-flex align-items-center justify-content-end">
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage - 1}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}&sort=${param.sort}">Trước</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${totalPages}" var="p">
                                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${p}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}&sort=${param.sort}">${p}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}&sort=${param.sort}">Sau</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>


                    </div>
                </div><!--end container-->
                <!-- Footer Start -->
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->



        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>

        <script>
                                                           function resetForm() {
                                                               window.location.href = './confirmappointment?search=&status=&pageSize=10&sort=desc';
                                                           }
        </script>
    </body>
</html>

