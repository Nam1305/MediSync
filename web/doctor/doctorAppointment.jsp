<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Lịch hẹn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->       
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
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="table-container">
                            <h4 class="mb-3 text-center">Danh sách lịch hẹn</h4>
                            <div class="card shadow-sm p-3">
                                <form action="doctorappointment" method="get" class="row row-cols-lg-auto g-2 align-items-end">
                                    <!-- Tìm kiếm bệnh nhân -->
                                    <div class="col">
                                        <label class="form-label fw-bold">Tìm bệnh nhân</label>
                                        <input type="text" name="search" class="form-control" placeholder="Nhập tên" value="${search}">
                                    </div>

                                    <!-- Bộ lọc trạng thái -->
                                    <div class="col">
                                        <label class="form-label fw-bold">Trạng thái</label>
                                        <select name="status" class="form-select">
                                            <option value="">Tất cả</option>
                                            <option value="pending" ${status == 'confirmed' ? 'selected' : ''}>Chờ khám</option>
                                            <option value="completed" ${status == 'waitpay' || status == 'paid' ? 'selected' : ''}>Đã khám</option>
                                            <option value="absent" ${status == 'absent' ? 'selected' : ''}>Vắng mặt</option>
                                        </select>
                                    </div>

                                    <!-- Bộ lọc từ ngày -->
                                    <div class="col">
                                        <label class="form-label fw-bold">Từ ngày</label>
                                        <input type="date" name="fromDate" class="form-control" value="${fromDate}">
                                    </div>

                                    <!-- Bộ lọc đến ngày -->
                                    <div class="col">
                                        <label class="form-label fw-bold">Đến ngày</label>
                                        <input type="date" name="toDate" class="form-control" value="${toDate}">
                                    </div>

                                    <!-- Bộ lọc số lượng hiển thị -->
                                    <div class="col">
                                        <label class="form-label fw-bold">Số dòng/trang</label>
                                        <input type="number" name="pageSize" class="form-control" value="${empty pageSize ? 10 : pageSize}" min="1" max="100">
                                    </div>

                                    <!-- Bộ lọc sắp xếp -->
                                    <div class="col">
                                        <label class="form-label fw-bold">Sắp xếp</label>
                                        <select name="sort" class="form-select">
                                            <option value="asc" ${sort == 'asc' ? 'selected' : ''}>Cũ → Mới</option>
                                            <option value="desc" ${sort == 'desc' ? 'selected' : ''}>Mới → Cũ</option>
                                        </select>
                                    </div>

                                    <!-- Nút lọc & làm mới -->
                                    <div class="col d-flex gap-2 align-items-end">
                                        <button type="submit" class="btn btn-primary filter-btn"><i class="fas fa-search"></i> Lọc</button>
                                        <button type="button" class="btn btn-secondary filter-btn" id="resetFilters"><i class="fas fa-sync-alt"></i> Làm mới</button>
                                    </div>
                                </form>

                                <!-- Thống kê ngay bên dưới -->
                                <div class="row mt-3 text-center">
                                    <div class="col-md-3">
                                        <div class="p-2 border rounded bg-light">
                                            <p class="mb-1 text-muted">Tổng số</p>
                                            <span class="badge bg-primary fs-6">${statis[0]}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="p-2 border rounded bg-light">
                                            <p class="mb-1 text-muted">Đã khám</p>
                                            <span class="badge bg-success fs-6">${statis[1]}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="p-2 border rounded bg-light">
                                            <p class="mb-1 text-muted">Chờ khám</p>
                                            <span class="badge bg-warning fs-6">${statis[2]}</span>
                                        </div>
                                    </div>
                                    <div class="col-md-3">
                                        <div class="p-2 border rounded bg-light">
                                            <p class="mb-1 text-muted">Vắng mặt</p>
                                            <span class="badge bg-danger fs-6">${statis[3]}</span>
                                        </div>
                                    </div>
                                </div>
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
                                                        <c:when test="${appointment.status == 'pending' or appointment.status == 'confirmed' or appointment.status == 'cancelled'}">
                                                            <span class="badge bg-warning">Chờ khám</span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'waitpay' or appointment.status == 'paid'}">
                                                            <span class="badge bg-success">Đã khám</span>
                                                        </c:when>
                                                        <c:when test="${appointment.status == 'absent'}">
                                                            <span class="badge bg-danger">Vắng mặt</span>
                                                        </c:when>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end p-3">
                                                    <a href="makeorder?appointmentId=${appointment.appointmentId}" class="btn btn-icon btn-pills btn-soft-primary">
                                                        <i class="uil uil-shopping-cart"></i>
                                                    </a>
                                                    <a href="doctorappdetail?appointmentId=${appointment.appointmentId}" class="btn btn-icon btn-pills btn-soft-warning">
                                                        <i class="uil uil-eye"></i>
                                                    </a>
                                                    <!-- Link chuyển trạng thái: Chờ thanh toán -->
                                                    <a href="doctorappointment?appointmentId=${appointment.appointmentId}&newStatus=waitpay&page=${currentPage}&search=${search}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}&sort=${sort}"
                                                       class="btn btn-icon btn-pills btn-soft-success"
                                                       onclick="return confirm('Bạn có chắc xác nhận hoàn thành lịch hẹn ${appointment.appointmentId} ?');">
                                                        <i class="uil uil-check-circle"></i>
                                                    </a>
                                                    <!-- Link chuyển trạng thái: Vắng mặt -->
                                                    <a href="doctorappointment?appointmentId=${appointment.appointmentId}&newStatus=absent&page=${currentPage}&search=${search}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}&sort=${sort}"
                                                       class="btn btn-icon btn-pills btn-soft-danger"
                                                       onclick="return confirm('Bạn có chắc muốn chuyển trạng thái của lịch hẹn ${appointment.appointmentId} sang Vắng mặt?');">
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
                                            <a class="page-link" href="?page=${currentPage - 1}&search=${search}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}&sort=${sort}">Trước</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${totalPages}" var="p">
                                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${p}&search=${search}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}&sort=${sort}">${p}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="?page=${currentPage + 1}&search=${search}&status=${status}&fromDate=${fromDate}&toDate=${toDate}&pageSize=${pageSize}&sort=${sort}">Sau</a>
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

        <script>
            document.getElementById("resetFilters").addEventListener("click", function () {
                document.querySelector("[name='search']").value = "";
                document.querySelector("[name='status']").value = "";
                document.querySelector("[name='fromDate']").value = "<%= java.time.LocalDate.now().toString() %>";
                document.querySelector("[name='toDate']").value = "<%= java.time.LocalDate.now().toString() %>";
                document.querySelector("[name='pageSize']").value = "10";
                document.querySelector("[name='sort']").value = "asc";
            });
            // Khi form được submit, kiểm tra giá trị của từ ngày và đến ngày
            document.querySelector("form").addEventListener("submit", function (e) {
                var fromDateVal = document.querySelector("input[name='fromDate']").value;
                var toDateVal = document.querySelector("input[name='toDate']").value;
                // Nếu cả hai đều có giá trị và fromDate lớn hơn toDate
                if (fromDateVal && toDateVal && fromDateVal > toDateVal) {
                    alert("Giá trị \"Từ ngày\" phải nhỏ hơn hoặc bằng \"Đến ngày\".");
                    e.preventDefault(); // Ngăn không cho form submit
                }
            });

        </script>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
