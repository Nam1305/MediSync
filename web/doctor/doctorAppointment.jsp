<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Lịch hẹn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
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
            .status-cancelled {
                background-color: #f4c7c3;
            } /* Đỏ hồng nhạt */
            .status-pending {
                background-color: #fae3b0;
            }   /* Cam nhạt */
            .status-confirmed {
                background-color: #b3e5fc;
            } /* Xanh dương nhạt */
            .status-paid {
                background-color: #c8e6c9;
            }        /* Xanh lá pastel */
            .status-waiting_payment {
                background-color: #ffe0b2;
            } /* Vàng nhạt */
            .status-absent {
                background-color: #d1c4e9;
            }        /* Tím nhạt */
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
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="table-container">
                            <h4 class="mb-3 text-center">Danh sách lịch hẹn</h4>
                            <div class="mb-4">
                                <!-- Form tìm kiếm, lọc dữ liệu -->
                                <form action="doctorappointment" method="get" class="d-flex justify-content-between">
                                    <input type="text" name="search" class="form-control" placeholder="Tìm kiếm bệnh nhân" value="${param.search}" style="width: 200px;">
                                    <select name="status" class="form-control" style="width: 150px;">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="pending" ${param.status == 'pending' ? 'selected' : ''}>Chờ xác nhận</option>
                                        <option value="confirmed" ${param.status == 'confirmed' ? 'selected' : ''}>Đã xác nhận</option>
                                        <option value="paid" ${param.status == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                                        <option value="cancelled" ${param.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
                                        <option value="waitpay" ${param.status == 'waitpay' ? 'selected' : ''}>Chờ thanh toán</option>
                                        <option value="absent" ${param.status == 'absent' ? 'selected' : ''}>Vắng mặt</option>
                                    </select>
                                    <input type="date" name="date" class="form-control" value="${param.date}" style="width: 150px;">
                                    <input type="number" name="pageSize" class="form-control" value="${param.pageSize != null ? param.pageSize : 10}" min="1" max="100" step="1" style="width: 150px;">
                                    <button type="submit" class="btn btn-primary">Lọc</button>
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
                                                        <c:when test="${appointment.status == 'pending'}">Chờ xác nhận</c:when>
                                                        <c:when test="${appointment.status == 'confirmed'}">Đã xác nhận</c:when>
                                                        <c:when test="${appointment.status == 'paid'}">Đã thanh toán</c:when>
                                                        <c:when test="${appointment.status == 'cancelled'}">Đã hủy</c:when>
                                                        <c:when test="${appointment.status == 'waitpay'}">Chờ thanh toán</c:when>
                                                        <c:when test="${appointment.status == 'absent'}">Vắng mặt</c:when>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end p-3">
                                                    <form action="makeinvoice" method="post" style="display:inline;">
                                                        <button type="submit" class="btn btn-icon btn-pills btn-soft-primary">
                                                            <i class="uil uil-shopping-cart"></i>
                                                        </button>
                                                    </form>
                                                    <a href="doctorappdetail?appointmentId=${appointment.appointmentId}" class="btn btn-icon btn-pills btn-soft-warning">
                                                        <i class="uil uil-eye"></i>
                                                    </a>
                                                    <!-- Link chuyển trạng thái: Vắng mặt -->
                                                    <a href="doctorappointment?appointmentId=${appointment.appointmentId}&newStatus=absent&page=${currentPage}&search=${param.search}&filterStatus=${param.status}&date=${param.date}&pageSize=${param.pageSize}"
                                                       class="btn btn-icon btn-pills btn-soft-danger"
                                                       onclick="return confirm('Bạn có chắc muốn chuyển trạng thái của lịch hẹn ${appointment.appointmentId} sang Vắng mặt?');">
                                                        <i class="uil uil-check-circle"></i>
                                                    </a>
                                                    <!-- Link chuyển trạng thái: Chờ thanh toán -->
                                                    <a href="doctorappointment?appointmentId=${appointment.appointmentId}&newStatus=waitpay&page=${currentPage}&search=${param.search}&filterStatus=${param.status}&date=${param.date}&pageSize=${param.pageSize}"
                                                       class="btn btn-icon btn-pills btn-soft-success"
                                                       onclick="return confirm('Bạn có chắc muốn chuyển trạng thái của lịch hẹn ${appointment.appointmentId} sang Chờ thanh toán?');">
                                                        <i class="uil uil-times-circle"></i>
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
                                            <a class="page-link" href="?page=${currentPage - 1}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}">Trước</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${totalPages}" var="p">
                                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${p}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}">${p}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&search=${param.search}&status=${param.status}&date=${param.date}&pageSize=${param.pageSize}">Sau</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>


                    </div>
                </div><!--end container-->
                <!-- Footer Start -->
                <jsp:include page="footer.jsp" />
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->



        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
