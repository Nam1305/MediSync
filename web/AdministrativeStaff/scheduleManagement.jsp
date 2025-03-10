<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thêm lịch làm việc</title>
    <!-- CSS -->
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
                        <h5 class="mb-0">Thêm lịch làm việc</h5>
                        <nav aria-label="breadcrumb" class="d-inline-block mt-2 mt-sm-0">
                            <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                                <li class="breadcrumb-item"><a href="index.html">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Thêm lịch làm việc</li>
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
                    
                    <!-- Tạo lịch làm việc -->
                    <div class="card shadow rounded border-0 p-4 mb-4">
                        <h5 class="mb-3">Tạo lịch làm việc mới</h5>
                        <form id="scheduleForm" action="schedule-management" method="post">
                            <input type="hidden" name="action" value="createSchedule">
                            
                            <div class="filter-row">
                                <div class="filter-item">
                                    <label for="staffId" class="form-label">Chọn nhân viên</label>
                                    <select class="form-select" id="staffId" name="staffId" required onchange="this.form.submit()">
                                        <option value="">-- Chọn nhân viên --</option>
                                        <c:forEach var="staff" items="${staffs}">
                                            <option value="${staff.staffId}" ${staff.staffId eq selectedStaffId ? 'selected' : ''}>
                                                ${staff.name} - ID: ${staff.staffId}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="filter-item">
                                    <label for="shiftRegistrationId" class="form-label">Chọn ca đăng ký</label>
                                    <select class="form-select" id="shiftRegistrationId" name="shiftRegistrationId" required ${empty pendingRegistrations ? 'disabled' : ''}>
                                        <option value="">-- Chọn ca đăng ký --</option>
                                        <c:forEach var="registration" items="${pendingRegistrations}">
                                            <option value="${registration.registrationId}">
                                                ID: ${registration.registrationId} - 
                                                Ca: ${registration.shift} - 
                                                Ngày đăng ký: <fmt:formatDate value="${registration.regisDate}" pattern="dd/MM/yyyy" /> - 
                                                Trạng thái: ${registration.status}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="filter-item">
                                    <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate" required>
                                </div>
                                
                                <div class="filter-item">
                                    <label for="endDate" class="form-label">Ngày kết thúc</label>
                                    <input type="date" class="form-control" id="endDate" name="endDate" required>
                                </div>
                            </div>
                            
                            <div class="text-end">
                                <button type="button" class="btn btn-outline-secondary me-2" id="resetBtn">
                                    <i class="mdi mdi-refresh me-1"></i>Làm mới
                                </button>
                                <button type="submit" class="btn btn-primary" ${empty pendingRegistrations ? 'disabled' : ''}>
                                    <i class="mdi mdi-calendar-check me-1"></i>Tạo lịch làm việc
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Thông tin lịch làm việc -->
                    <div class="card shadow rounded border-0 p-4">
                        <h5 class="mb-3">Thông tin lịch làm việc</h5>
                        
                        <div class="alert alert-info">
                            <h5 class="alert-heading"><i class="mdi mdi-lightbulb me-2"></i>Lưu ý quan trọng</h5>
                            <ul>
                                <li>Lịch làm việc sẽ được tạo cho các ngày <b>từ thứ 2 đến thứ 6</b> trong khoảng thời gian đã chọn.</li>
                                <li>Thứ 7 và Chủ nhật sẽ tự động được bỏ qua khi tạo lịch.</li>
                                <li>Ca 1: 08:00 - 12:00, Ca 2: 13:00 - 17:00, Ca 3: 18:00 - 22:00.</li>
                                <li>Hệ thống sẽ kiểm tra và chỉ tạo lịch cho những ngày mà nhân viên chưa được xếp lịch.</li>
                            </ul>
                        </div>
                        
                        <!-- Display explanation about staff selection criteria -->
                        <div class="mt-3">
                            <h5><i class="mdi mdi-filter me-2"></i>Tiêu chí hiển thị nhân viên</h5>
                            <p>Nhân viên sẽ được hiển thị trong danh sách chọn khi:</p>
                            <ol>
                                <li>Nhân viên chưa từng được xếp ca làm việc.</li>
                                <li>Hoặc ngày hiện tại sau ngày cuối cùng trong lịch làm việc hiện tại và ngày đăng ký ca mới nhất không diễn ra trước ngày đầu tiên của lịch làm việc trước đó.</li>
                                <li>Hoặc nhân viên không có lịch làm việc trong ngày hiện tại.</li>
                            </ol>
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
    
    <!-- JavaScript -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/app.js"></script>
    
    <script>
        // Reset form button
        document.getElementById('resetBtn').addEventListener('click', function() {
            document.getElementById('scheduleForm').reset();
        });
        
        // Form validation
        document.getElementById('scheduleForm').addEventListener('submit', function(e) {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);
            
            if (endDate < startDate) {
                e.preventDefault();
                alert('Ngày kết thúc không thể trước ngày bắt đầu!');
                return;
            }
            
            // Validate that a shift registration is selected
            const shiftRegistrationId = document.getElementById('shiftRegistrationId').value;
            if (!shiftRegistrationId) {
                e.preventDefault();
                alert('Vui lòng chọn ca đăng ký!');
                return;
            }
        });
        
        // Set default dates
        window.addEventListener('load', function() {
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            
            const nextWeek = new Date(today);
            nextWeek.setDate(nextWeek.getDate() + 7);
            
            document.getElementById('startDate').valueAsDate = tomorrow;
            document.getElementById('endDate').valueAsDate = nextWeek;
        });
        
        // Auto-close alerts after 5 seconds
        setTimeout(function() {
            $('.alert').alert('close');
        }, 5000);
    </script>
</body>
</html>