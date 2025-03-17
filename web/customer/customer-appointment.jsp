<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Quản lý lịch hẹn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="assets/css/style.min.css" rel="stylesheet" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            /* Appointment Table Styles */
            .container {
                max-width: 100%;
                width: 100%;
            }

            .nav-pills .nav-link {
                width: 100%;
            }

            .table-container {
                width: 100%;
            }
            .table-appointments {
                width: 100% !important;
                min-width: 1200px !important; /* Ensure minimum width for content */
                border-collapse: separate !important;
                border-spacing: 0 !important;
                border-radius: 8px !important;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1) !important;
                margin-bottom: 2rem !important;
            }

            .table-appointments thead th {
                background-color: #28a745 !important;
                color: white !important;
                font-weight: 600 !important;
                padding: 0.75rem 1rem !important;
                font-size: 0.95rem !important;
                border: none !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px !important;
                white-space: nowrap !important;
            }

            .table-appointments tbody tr {
                transition: all 0.2s ease !important;
            }

            .table-appointments tbody tr:hover {
                background-color: #f8f9fa !important;
            }

            .table-appointments tbody td {
                padding: 0.75rem 1rem !important;
                vertical-align: middle !important;
                border-bottom: 1px solid #e9ecef !important;
                color: #495057 !important;
                font-size: 12px !important;
                white-space: nowrap !important;
            }

            /* Column widths */
            .table-appointments th:nth-child(1),
            .table-appointments td:nth-child(1) {
                min-width: 80px !important;
            } /* Tên bác sĩ */

            .table-appointments th:nth-child(2),
            .table-appointments td:nth-child(2) {
                min-width: 50px !important;
            } /* Giới tính */

            .table-appointments th:nth-child(3),
            .table-appointments td:nth-child(3) {
                min-width: 120px !important;
            } /* Ngày hẹn */

            .table-appointments th:nth-child(4),
            .table-appointments td:nth-child(4) {
                min-width: 80px !important;
            } /* Bắt đầu */

            .table-appointments th:nth-child(5),
            .table-appointments td:nth-child(5) {
                min-width: 80px !important;
            } /* Kết thúc */

            .table-appointments th:nth-child(6),
            .table-appointments td:nth-child(6) {
                min-width: 120px !important;
            } /* Trạng thái */

            .table-appointments th:nth-child(7),
            .table-appointments td:nth-child(7) {
                min-width: 150px !important;
            } /* Hành động */

            /* Status styles */
            .table-appointments [class^="status-"] {
                padding: 0.5rem 1rem !important;
                border-radius: 20px !important;
                font-weight: 500 !important;
                display: inline-block !important;
            }

            .table-appointments .status-pending {
                color: #f4a100 !important;
                background-color: #fff8e9 !important;
            }

            .table-appointments .status-confirmed {
                color: #0d6efd !important;
                background-color: #e7f1ff !important;
            }

            .table-appointments .status-paid {
                color: #198754 !important;
                background-color: #e8f5e9 !important;
            }

            .table-appointments .status-cancelled {
                color: #dc3545 !important;
                background-color: #ffebee !important;
            }

            .table-appointments .status-waitpay {
                color: #6c757d !important;
                background-color: #f8f9fa !important;
            }

            .table-appointments .status-absent {
                color: #862e9c !important;
                background-color: #f3e8ff !important;
            }

            /* Action buttons styling */
            .table-appointments .btn {
                padding: 0.4rem !important;
                margin: 0 0.2rem !important;
                border-radius: 50% !important;
                width: 35px !important;
                height: 35px !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                transition: all 0.3s ease !important;
            }

            .table-appointments .btn:hover {
                transform: translateY(-2px) !important;
            }

            .table-appointments .btn i {
                font-size: 1rem !important;
            }

            /* Table container with horizontal scroll */
            .table-container {
                width: 100% !important;
                overflow-x: auto !important;
                padding-bottom: 1rem !important; /* Space for scrollbar */
                margin-bottom: 1rem !important;
            }

            /* Ensure smooth scrolling */
            .table-container::-webkit-scrollbar {
                height: 8px !important;
            }

            .table-container::-webkit-scrollbar-track {
                background: #f1f1f1 !important;
                border-radius: 4px !important;
            }

            .table-container::-webkit-scrollbar-thumb {
                background: #888 !important;
                border-radius: 4px !important;
            }

            .table-container::-webkit-scrollbar-thumb:hover {
                background: #555 !important;
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
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid" style="margin-top: 100px">
                    <form action="listAppointments" method="GET" class="mb-3 mt-5">


                        <div class="row g-3"> <!-- Thêm g-3 để tạo khoảng cách giữa các cột -->
                            <!-- Ô tìm kiếm theo tên bác sĩ -->
                            <div class="col-md-4">
                                <input type="text" name="search" value="${not empty search ? search : ''}" class="form-control" placeholder="Tìm theo tên bác sĩ...">
                            </div>

                            <!-- Lọc theo giới tính -->
                            <div class="col-md-2">
                                <select name="gender" class="form-control">
                                    <option value="" <c:if test="${empty gender}">selected</c:if>>Giới tính</option>
                                    <option value="M" <c:if test="${gender == 'M'}">selected</c:if>>Nam</option>
                                    <option value="F" <c:if test="${gender == 'F'}">selected</c:if>>Nữ</option>
                                    </select>
                                </div>

                                <!-- Lọc theo trạng thái -->
                                <div class="col-md-2">
                                    <select name="status" class="form-control">
                                        <option value="all" <c:if test="${empty status or status == 'all'}">selected</c:if>>Trạng thái</option>
                                    <option value="pending" <c:if test="${status == 'pending'}">selected</c:if>>Chờ xác nhận</option>
                                    <option value="confirmed" <c:if test="${status == 'confirmed'}">selected</c:if>>Đã xác nhận</option>
                                    <option value="paid" <c:if test="${status == 'paid'}">selected</c:if>>Đã thanh toán</option>
                                    <option value="cancelled" <c:if test="${status == 'cancelled'}">selected</c:if>>Đã hủy</option>
                                    <option value="waitpay" <c:if test="${status == 'waitpay'}">selected</c:if>>Chờ thanh toán</option>
                                    <option value="absent" <c:if test="${status == 'absent'}">selected</c:if>>Vắng mặt</option>
                                    </select>
                                </div>

                                <!-- Sắp xếp -->
                                <div class="col-md-2">
                                    <select name="sort" class="form-control">
                                        <option value="desc" <c:if test="${sort == 'desc'}">selected</c:if>>Ngày mới → cũ</option>
                                    <option value="asc" <c:if test="${sort == 'asc'}"></c:if>>Ngày cũ → mới</option>
                                    </select>
                                </div>

                                <!-- Input số lượng/trang -->
                                <!-- Ô nhập số lượng/trang, sẽ bị vô hiệu hóa nếu không có kết quả -->
                                <div class="col-md-2">
                                    <input type="number" class="form-control" name="pageSize" min="1" max="${totalAppointment}" 
                                       value="${not empty pageSize ? pageSize : 2}" placeholder="Số lượng/trang"
                                       <c:if test="${totalAppointment == 0}">disabled</c:if>>
                                </div>

                                <!-- Nút submit -->
                                <div class="col-md-2 d-flex gap-2">
                                    <button type="submit" class="btn btn-primary w-100 text-nowrap">Lọc</button>
                                    <button type="button" class="btn btn-primary w-100 text-nowrap" onclick="resetForm()">Bỏ lọc</button>
                                </div>
                            </div>
                        </form>
                        <div class="row">
                            <div class="table-container col-lg-6 col-12 mt-4">
                                <table class="table table-bordered table-hover table-appointments" >
                                    <thead class="table-success">
                                        <tr>
                                            <th>Tên bác sĩ</th>
                                            <th>Giới tính</th>
                                            <th>Ngày hẹn</th>
                                            <th>Thời gian</th>
                                            <th>Trạng thái</th>
                                            <th class="text-center">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Dữ liệu sẽ được xử lý và thêm vào đây -->
                                    <c:forEach var="appointment" items="${appointments}">
                                        <tr>
                                            <td>${appointment.staff.name}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${appointment.staff.gender.trim() == 'M'}">Nam</c:when>
                                                    <c:when test="${appointment.staff.gender.trim() == 'F'}">Nữ</c:when>
                                                    <c:otherwise>Khác</c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td>
                                                <fmt:formatDate value="${appointment.date}" pattern="dd-MM-yyyy"/>
                                            </td>
                                            <td>${appointment.start} - ${appointment.end} </td>
                                            <!--                                                            <td></td>-->
                                            <td>
                                                <c:choose>
                                                    <c:when test="${appointment.status == 'pending'}">Chờ xác nhận</c:when>
                                                    <c:when test="${appointment.status == 'confirmed'}">Đã xác nhận</c:when>
                                                    <c:when test="${appointment.status == 'paid'}">Đã thanh toán</c:when>
                                                    <c:when test="${appointment.status == 'cancelled'}">Đã hủy</c:when>
                                                    <c:when test="${appointment.status == 'waitpay'}">Chờ thanh toán</c:when>
                                                    <c:when test="${appointment.status == 'absent'}">Vắng mặt</c:when>
                                                </c:choose>
                                            </td>

                                            <td class="text-center">
                                                <!-- Link: Xem chi tiết thông tin: bác sĩ, bệnh án, đơn thuốc -->
                                                <c:choose>
                                                    <c:when test="${appointment.status == 'cancelled'}">
                                                        <button class="btn btn-icon btn-pills btn-soft-danger" disabled>
                                                            <i class="uil uil-ban"></i>
                                                        </button>
                                                        <small class="text-danger">Cuộc hẹn đã bị hủy</small>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="appointmentDetail?appointmentId=${appointment.appointmentId}" class="btn btn-icon btn-pills btn-soft-warning">
                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>

                                                <!-- Hủy lịch hẹn -->
                                                <c:if test="${appointment.status != 'confirmed' && appointment.status != 'waitpay' && appointment.status != 'paid'}">
                                                    <!-- Hủy lịch hẹn -->
                                                    <a href="cancelAppointment?appointmentId=${appointment.appointmentId}"
                                                       class="btn btn-icon btn-pills btn-soft-danger"
                                                       onclick="return confirm('Bạn có chắc muốn hủy lịch hẹn ngày: ${appointment.date} không?');">
                                                        <i class="uil uil-check-circle"></i>
                                                    </a>
                                                </c:if>

                                                <!-- Link xem hóa đơn chi tiết -->
                                                <a href="invoiceDetail?appointmentId=${appointment.appointmentId}"
                                                   class="btn btn-icon btn-pills btn-soft-success">
                                                    <i class="uil uil-receipt"></i> <!-- Đổi icon tại đây -->
                                                </a>
                                            </td>
                                        </tr>

                                    </c:forEach>

                                </tbody>
                            </table>
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">Showing 1 - 5 out of ${requestScope.totalAppointment}</span>
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <!--                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Previous">Prev</a></li>-->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="listAppointments?search=${requestScope.search}&gender=${requestScope.gender}&status=${not empty requestScope.status ? requestScope.status : 'all'}&sort=${not empty requestScope.sort ? requestScope.sort : 'desc'}&page=${currentPage - 1}&pageSize=${requestScope.pageSize}" aria-label="Previous">
                                                    Trước
                                                </a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="listAppointments?search=${requestScope.search}&gender=${requestScope.gender}&status=${not empty requestScope.status ? requestScope.status : 'all'}&sort=${not empty requestScope.sort ? requestScope.sort : 'desc'}&page=${i}&pageSize=${requestScope.pageSize}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="listAppointments?search=${requestScope.search}&gender=${requestScope.gender}&status=${not empty requestScope.status ? requestScope.status : 'all'}&sort=${not empty requestScope.sort ? requestScope.sort : 'desc'}&page=${currentPage + 1}&pageSize=${requestScope.pageSize}" aria-label="Next">
                                                    Sau
                                                </a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div><!--end col-->
                            <!-- PAGINATION END -->
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
        <script>
                                                           function resetForm() {
                                                               window.location.href = './listAppointments?search=&gender=&status=all&sort=asc&pageSize=2';
                                                           }
        </script>