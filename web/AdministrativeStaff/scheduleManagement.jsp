<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <title>Thêm lịch làm việc</title>
        <!-- CSS -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" />
        <!-- jQuery và jQuery UI -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

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
        </style>
    </head>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="left-navbar.jsp" />
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <h5 class="mb-0">Thêm lịch làm việc</h5>

                        <!-- Thông báo -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-success">${message}</div>
                        </c:if>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <!-- Form tạo lịch -->
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
                                                    ID: ${registration.registrationId} - Ca: ${registration.shift} - 
                                                    Ngày đăng ký: <fmt:formatDate value="${registration.regisDate}" pattern="dd/MM/yyyy" />
                                                </option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="filter-item">
                                        <label for="startDate" class="form-label">Ngày bắt đầu</label>
                                        <input type="text" class="form-control datepicker" id="startDate" name="startDate" required placeholder="dd/mm/yyyy">
                                    </div>

                                    <div class="filter-item">
                                        <label for="endDate" class="form-label">Ngày kết thúc</label>
                                        <input type="text" class="form-control datepicker" id="endDate" name="endDate" required placeholder="dd/mm/yyyy">
                                    </div>
                                </div>

                                <div class="text-end">
                                    <button type="button" class="btn btn-outline-secondary me-2" id="resetBtn">Làm mới</button>
                                    <button type="submit" class="btn btn-primary" ${empty pendingRegistrations ? 'disabled' : ''}>Tạo lịch</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <jsp:include page="footer.jsp" />
            </main>
        </div>

        <!-- JavaScript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script>
                                            $(document).ready(function () {
                                                // Khởi tạo Datepicker với định dạng dd/mm/yy
                                                $(".datepicker").datepicker({
                                                    dateFormat: "dd/mm/yy",
                                                    changeMonth: true,
                                                    changeYear: true,
                                                    minDate: 1 // Không cho chọn ngày trước ngày hiện tại
                                                });

                                                // Đặt giá trị mặc định
                                                const today = new Date();
                                                const tomorrow = new Date(today);
                                                tomorrow.setDate(tomorrow.getDate() + 1);
                                                const nextWeek = new Date(today);
                                                nextWeek.setDate(nextWeek.getDate() + 7);

                                                if (!$("#startDate").val()) {
                                                    $("#startDate").datepicker("setDate", tomorrow);
                                                }
                                                if (!$("#endDate").val()) {
                                                    $("#endDate").datepicker("setDate", nextWeek);
                                                }

                                                // Load ngày từ shift registration
                                                $("#shiftRegistrationId").change(function () {
                                                    const registrationId = $(this).val();
                                                    if (!registrationId)
                                                        return;

                                                    $.ajax({
                                                        url: 'schedule-management',
                                                        type: 'GET',
                                                        data: {action: 'getRegistrationDates', registrationId: registrationId},
                                                        dataType: 'json',
                                                        success: function (response) {
                                                            if (response.startDate)
                                                                $("#startDate").val(response.startDate);
                                                            if (response.endDate)
                                                                $("#endDate").val(response.endDate);
                                                        },
                                                        error: function (xhr, status, error) {
                                                            console.error('Error fetching dates:', error);
                                                        }
                                                    });
                                                });

                                                // Reset form
                                                $("#resetBtn").click(function () {
                                                    $("#scheduleForm")[0].reset();
                                                    $("#startDate").datepicker("setDate", tomorrow);
                                                    $("#endDate").datepicker("setDate", nextWeek);
                                                });

                                                // Validate form
                                                $("#scheduleForm").submit(function (e) {
                                                    const startDateStr = $("#startDate").val();
                                                    const endDateStr = $("#endDate").val();
                                                    const startDate = $.datepicker.parseDate("dd/mm/yy", startDateStr);
                                                    const endDate = $.datepicker.parseDate("dd/mm/yy", endDateStr);

                                                    if (endDate < startDate) {
                                                        e.preventDefault();
                                                        alert("Ngày kết thúc không thể trước ngày bắt đầu!");
                                                    }
                                                });
                                            });
        </script>
    </body>
</html>