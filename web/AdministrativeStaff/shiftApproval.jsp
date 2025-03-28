<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Duyệt đăng ký ca làm việc</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <link href="assets/css/style.min.css" rel="stylesheet" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

        <style>
            .filter-row {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 20px;
            }
            .filter-item {
                flex: 1;
                min-width: 200px;
            }
            .btn-action {
                margin: 2px;
            }
            @media (max-width: 768px) {
                .filter-item {
                    min-width: 100%;
                }
            }
            .status-approved {
                background-color: #d1e7dd;
                color: #0f5132;
                padding: 5px 10px;
                border-radius: 4px;
                font-weight: bold;
            }
            .status-rejected {
                background-color: #f8d7da;
                color: #842029;
                padding: 5px 10px;
                border-radius: 4px;
                font-weight: bold;
            }
            .status-pending {
                background-color: #fff3cd;
                color: #664d03;
                padding: 5px 10px;
                border-radius: 4px;
                font-weight: bold;
            }
            .status-scheduled {
                background-color: #cfe2ff;
                color: #084298;
                padding: 5px 10px;
                border-radius: 4px;
                font-weight: bold;
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
                        <div class="d-md-flex justify-content-between align-items-center">
                            <h5 class="mb-0">Duyệt đăng ký ca làm việc</h5>
                            <nav aria-label="breadcrumb" class="d-inline-block mt-2 mt-sm-0">
                                <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                    <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Duyệt đăng ký ca làm</li>
                                </ul>
                            </nav>
                        </div>

                        <!-- Thông báo -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${message}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${error}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Bộ lọc -->
                        <div class="card shadow p-4 mb-4">
                            <h5 class="mb-3">Bộ lọc</h5>
                            <form action="shift-approval" method="GET">
                                <div class="filter-row">
                                    <div class="filter-item">
                                        <label for="staffName">Tên nhân viên:</label>
                                        <input type="text" id="staffName" name="staffName" class="form-control" 
                                               value="${staffName}" placeholder="Nhập tên bác sĩ hoặc y tá">
                                    </div>
                                    <div class="filter-item">
                                        <label for="fromDate">Từ ngày (dd/MM/yyyy):</label>
                                        <input type="text" id="fromDate" name="fromDate" class="form-control" 
                                               value="${fromDate}" placeholder="dd/MM/yyyy">
                                    </div>
                                    <div class="filter-item">
                                        <label for="toDate">Đến ngày (dd/MM/yyyy):</label>
                                        <input type="text" id="toDate" name="toDate" class="form-control" 
                                               value="${toDate}" placeholder="dd/MM/yyyy">
                                    </div>
                                    <div class="filter-item">
                                        <label for="pageSize">Số bản ghi:</label>
                                        <select id="pageSize" name="pageSize" class="form-select">
                                            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5</option>
                                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10</option>
                                            <option value="15" ${pageSize == 15 ? 'selected' : ''}>15</option>
                                            <option value="20" ${pageSize == 20 ? 'selected' : ''}>20</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="text-end">
                                    <button type="submit" class="btn btn-primary">Tìm kiếm</button>
                                    <a href="shift-approval" class="btn btn-outline-secondary">Đặt lại</a>
                                </div>
                            </form>
                        </div>

                        <!-- Bảng dữ liệu -->
                        <div class="card shadow rounded border-0 p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="mb-0">Danh sách đăng ký ca làm việc</h5>
                                <p>Tổng số: ${totalRegistrations} đăng ký</p>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nhân viên</th>
                                            <th>Ngày đăng ký</th>
                                            <th>Ngày bắt đầu</th>
                                            <th>Ngày kết thúc</th>
                                            <th>Ca làm việc</th>
                                            <th>Thời gian ca</th>
                                            <th>Trạng thái</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="registration" items="${registrations}">
                                            <tr>
                                                <td>${registration.registrationId}</td>
                                                <td>${requestScope['staffName_'.concat(registration.registrationId)]}</td>
                                                <td><fmt:formatDate value="${registration.regisDate}" pattern="dd/MM/yyyy" /></td>
                                                <td><fmt:formatDate value="${registration.startDate}" pattern="dd/MM/yyyy" /></td>
                                                <td><fmt:formatDate value="${registration.endDate}" pattern="dd/MM/yyyy" /></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${registration.shift == 1}">Ca 1</c:when>
                                                        <c:when test="${registration.shift == 2}">Ca 2</c:when>
                                                        <c:otherwise>Ca 3</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${registration.shift == 1}">08:00 - 12:00</c:when>
                                                        <c:when test="${registration.shift == 2}">13:00 - 17:00</c:when>
                                                        <c:otherwise>18:00 - 22:00</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${registration.status eq 'Approved'}">
                                                            <span class="status-approved">Đã duyệt</span>
                                                        </c:when>
                                                        <c:when test="${registration.status eq 'Rejected'}">
                                                            <span class="status-rejected">Từ chối</span>
                                                        </c:when>
                                                        <c:when test="${registration.status eq 'Scheduled'}">
                                                            <span class="status-scheduled">Đã lên lịch</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-pending">Chờ duyệt</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${registration.status eq 'Pending'}">
                                                        <div class="d-flex">
                                                            <form action="shift-approval" method="POST" style="margin-right: 5px;">
                                                                <input type="hidden" name="action" value="approve">
                                                                <input type="hidden" name="registrationId" value="${registration.registrationId}">
                                                                <input type="hidden" name="page" value="${currentPage}">
                                                                <input type="hidden" name="pageSize" value="${pageSize}">
                                                                <input type="hidden" name="staffName" value="${staffName}">
                                                                <input type="hidden" name="fromDate" value="${fromDate}">
                                                                <input type="hidden" name="toDate" value="${toDate}">
                                                                <button type="submit" class="btn btn-success btn-sm">Duyệt</button>
                                                            </form>
                                                            <form action="shift-approval" method="POST">
                                                                <input type="hidden" name="action" value="reject">
                                                                <input type="hidden" name="registrationId" value="${registration.registrationId}">
                                                                <input type="hidden" name="page" value="${currentPage}">
                                                                <input type="hidden" name="pageSize" value="${pageSize}">
                                                                <input type="hidden" name="staffName" value="${staffName}">
                                                                <input type="hidden" name="fromDate" value="${fromDate}">
                                                                <input type="hidden" name="toDate" value="${toDate}">
                                                                <button type="submit" class="btn btn-danger btn-sm">Từ chối</button>
                                                            </form>
                                                        </div>
                                                    </c:if>
                                                    <c:if test="${registration.status ne 'Pending'}">
                                                        <span class="text-muted">Đã xử lý</span>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Không có dữ liệu -->
                            <c:if test="${empty registrations}">
                                <div class="text-center p-3">
                                    <p>Không tìm thấy dữ liệu phù hợp</p>
                                </div>
                            </c:if>

                            <!-- Phân trang -->
                            <div class="mt-4 d-flex justify-content-center">
                                <ul class="pagination mb-0">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="shift-approval?page=${currentPage-1}&pageSize=${pageSize}&staffName=${staffName}&fromDate=${fromDate}&toDate=${toDate}">
                                                <i class="mdi mdi-chevron-left"></i> Trước
                                            </a>
                                        </li>
                                    </c:if>

                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="shift-approval?page=${i}&pageSize=${pageSize}&staffName=${staffName}&fromDate=${fromDate}&toDate=${toDate}">
                                                ${i}
                                            </a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="shift-approval?page=${currentPage+1}&pageSize=${pageSize}&staffName=${staffName}&fromDate=${fromDate}&toDate=${toDate}">
                                                Sau <i class="mdi mdi-chevron-right"></i>
                                            </a>
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

        <script>
            function convertDateFormat(dateStr) {
                if (!dateStr)
                    return '';
                var parts = dateStr.split('/');
                if (parts.length === 3) {
                    return parts[2] + '-' + parts[1] + '-' + parts[0];
                }
                return dateStr; // Trả về nguyên gốc nếu định dạng không đúng
            }

            document.querySelector('form').addEventListener('submit', function (e) {
                var fromDateInput = document.getElementById('fromDate');
                var toDateInput = document.getElementById('toDate');

                fromDateInput.value = convertDateFormat(fromDateInput.value);
                toDateInput.value = convertDateFormat(toDateInput.value);
            });

            // Validate date inputs (optional)
            document.getElementById('fromDate').addEventListener('change', function () {
                var toDateInput = document.getElementById('toDate');
                var fromDateValue = convertDateFormat(this.value);
                if (toDateInput.value && fromDateValue > convertDateFormat(toDateInput.value)) {
                    toDateInput.value = this.value;
                }
            });

            // Auto-close alerts after 5 seconds
            setTimeout(function () {
                $('.alert').alert('close');
            }, 5000);
        </script>
    </body>
</html>