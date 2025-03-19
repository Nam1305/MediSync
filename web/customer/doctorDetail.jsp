<%-- 
    Document   : doctorDetail
    Created on : Feb 24, 2025, 9:35:58 AM
    Author     : Phạm Hoàng Nam
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <style>
            table {
                table-layout: fixed;
                width: 100%;
            }

            td, th {
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
                color: #333;
            }

            h2, h4, h5 {
                color: #28a745;
            }

            .card {
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: none;
            }

            .card h4 {
                border-bottom: 2px solid #28a745;
                padding-bottom: 10px;
            }

            .table {
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
            }

            th {
                background-color: #28a745 !important;
                color: white;
                text-align: center;
            }

            td {
                text-align: center;
                vertical-align: middle;
            }

            p {
                margin: 8px 0;
                font-size: 16px;
            }

            .border {
                border-radius: 8px;
            }

            .btn-primary {
                background-color: #28a745;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 6px;
            }

            .btn-primary:hover {
                background-color: #218838;
            }

            /* Điều chỉnh bảng Đơn thuốc */
            .prescription-table th:nth-child(1),
            .prescription-table td:nth-child(1) {
                width: 15%;
            }

            .prescription-table th:nth-child(2),
            .prescription-table td:nth-child(2) {
                width: 9%;
            }

            .prescription-table th:nth-child(3),
            .prescription-table td:nth-child(3) {
                width: 22%;
            }

            .prescription-table th:nth-child(4),
            .prescription-table td:nth-child(4) {
                width: 50%;
                max-width: 50%;
                white-space: normal;
            }

            .scrollable-note {
                max-height: 80px;
                overflow-y: auto;
                padding: 5px;
                background-color: #f9f9f9;
                border-radius: 5px;
            }

            /* ======= 1. Bố cục tổng thể ======= */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
                color: #333;
            }

            h2, h4, h5 {
                color: #28a745;
            }

            .card {
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: none;
            }

            .card h4 {
                border-bottom: 2px solid #28a745;
                padding-bottom: 10px;
            }

            /* ======= 2. Bảng thông tin bác sĩ ======= */
            .table {
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
            }

            th {
                background-color: #28a745 !important;
                color: white;
                text-align: center;
            }

            td {
                text-align: center;
                vertical-align: middle;
            }

            p {
                margin: 8px 0;
                font-size: 16px;
            }

            .border {
                border-radius: 8px;
            }

            /* ======= 3. Form chọn tuần ======= */
            select[name="week"] {
                padding: 10px;
                font-size: 16px;
                border-radius: 6px;
                border: 1px solid #28a745;
                background: #fff;
                color: #28a745;
                cursor: pointer;
                transition: all 0.3s;
            }

            select[name="week"]:hover {
                background: #28a745;
                color: #fff;
            }

            /* ======= 4. Danh sách ngày chọn lịch ======= */
            .list-group-item {
                text-align: center;
                font-size: 16px;
                font-weight: bold;
                transition: all 0.3s;
                cursor: pointer;
                background: #fff;
                border: 1px solid #28a745;
                color: #28a745;
            }

            .list-group-item:hover {
                background: #28a745;
                color: white;
            }

            .list-group-item.active {
                background: #218838 !important;
                color: white !important;
                border: 1px solid #218838;
            }

            /* ======= 5. Bảng lịch khám ======= */
            .prescription-table {
                width: 100%;
                border-collapse: collapse;
            }

            .prescription-table th {
                background: #28a745;
                color: white;
                text-align: center;
            }

            .prescription-table td {
                text-align: center;
                vertical-align: middle;
                font-size: 16px;
            }

            /* ======= 6. Nút đặt lịch ======= */
            .btn-primary {
                background-color: #28a745;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 6px;
                transition: all 0.3s;
            }

            .btn-primary:hover {
                background-color: #218838;
            }

            .btn-primary:disabled {
                background-color: gray;
                cursor: not-allowed;
            }

            /* ======= 7. Điều chỉnh ảnh bác sĩ ======= */
            .doctor-info img {
                width: 120px;
                height: 120px;
                object-fit: cover;
                border-radius: 50%;
                border: 3px solid #28a745;
                margin-right: 10px;
            }

            /* ======= 8. Nút quay về danh sách lịch hẹn ======= */
            .text-center a {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-size: 16px;
                transition: all 0.3s;
            }

            .text-center a:hover {
                background: #0056b3;
            }

        </style>
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
    </head>
    <body>
        <jsp:include page="../layout/header.jsp" />
        <div class="card mt-4 p-4">
            <c:if test="${param.message == 'success'}">
                <div id="success-alert" class="alert alert-success text-center fw-bold p-4" role="alert" style="font-size: 24px; position: relative; top: 10px;">
                    🎉 Đặt lịch hẹn thành công!
                </div>
            </c:if>

            <c:if test="${param.message == 'error'}">
                <div id="error-alert" class="alert alert-danger text-center fw-bold p-4" role="alert" style="font-size: 24px; position: relative; top: 10px;">
                    ❌ Đặt lịch hẹn thất bại! Vui lòng thử lại.
                </div>
            </c:if>
            <div class="card mt-4 p-4">
                <h4 class="text-primary">Thông tin bác sĩ phụ trách</h4>
                <div class="doctor-info mb-3">
                    <img src="${doctor.avatar}" alt="Avatar của bác sĩ" class="rounded-circle shadow-md avatar avatar-md-md">
                    <h5>${doctor.name}</h5>
                </div>
                <table class="table table-bordered">
                    <tr>
                        <th>Họ và tên</th>
                        <th>Giới tính</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Chuyên khoa</th>
                    </tr>
                    <tr>
                        <td>${doctor.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${doctor.gender.trim() == 'M'}">Nam</c:when>
                                <c:when test="${doctor.gender.trim() == 'F'}">Nữ</c:when>

                            </c:choose>
                        </td>
                        <td>${doctor.email}</td>
                        <td>${doctor.phone}</td>
                        <td>${doctor.getDepartment().getDepartmentName()}</td>
                    </tr>
                </table>
                <div class="mt-3">
                    <h5 class="text-primary">Giới thiệu bác sĩ ${doctor.name}:</h5>
                    <p class="border p-3 bg-light">${doctor.description}</p>
                </div>

                <div class="mt-3">
                    <h5 class="text-primary">Bằng cấp của bác sĩ ${doctor.name}:</h5>
                    <ul class="list-group border p-3 bg-light">
                        <c:forEach var="degree" items="${doctor.certificate}">
                            <li class="list-group-item">${degree}</li>
                            </c:forEach>
                    </ul>
                </div>
            </div>


            <c:if test="${not hasSchedule}">
                <div class="d-flex justify-content-center align-items-center" style="height: 100px;">
                    <p class="text-warning">Bác sĩ chưa có lịch làm việc.</p>
                </div>
            </c:if> 

            <c:if test="${hasSchedule}">
                <!-- Danh sách lịch khám còn trống để đặt lịch -->
                <!-- Chọn tuần -->
                <h4 class="text-primary">Chọn tuần</h4>
                <form action="doctorDetail" method="get">
                    <input type="hidden" name="doctorId" value="${doctor.staffId}">
                    <select name="week" onchange="this.form.submit()">
                        <c:forEach var="week" items="${groupedWeeks}">
                            <c:set var="start" value="${week[0]}" />
                            <c:set var="end" value="${week[week.size()-1]}" />
                            <option value="${start}" ${start == selectedWeek[0] ? 'selected' : ''}>
                                <fmt:formatDate value="${start}" pattern="dd-MM-yyyy"/> - 
                                <fmt:formatDate value="${end}" pattern="dd-MM-yyyy"/>
                            </option>
                        </c:forEach>
                    </select>
                </form>



                <!-- Hiển thị khoảng thời gian của tuần được chọn -->
                <h4 class="text-primary">
                    Lịch khám từ 
                    <fmt:formatDate value="${selectedWeek[0]}" pattern="dd-MM-yyyy"/> 
                    đến 
                    <fmt:formatDate value="${selectedWeek[selectedWeek.size()-1]}" pattern="dd-MM-yyyy"/>
                </h4>

                <!-- Hiển thị danh sách ngày -->
                <table class="table table-bordered text-center selected-week">
                    <tr>
                        <c:forEach var="day" items="${selectedWeek}">
                            <td>
                                <form action="doctorDetail" method="get">
                                    <input type="hidden" name="doctorId" value="${doctor.staffId}">
                                    <input type="hidden" name="week" value="<fmt:formatDate value='${selectedWeek[0]}' pattern='MM-dd-yyyy'/>">
                                    <input type="hidden" name="date" value="<fmt:formatDate value='${day}' pattern='yyy-MM-dd'/>">
                                    <button type="submit" class="btn btn-outline-success ${day == selectedDate ? 'active' : ''}"  
                                            ${day < today ? 'disabled' : ''}>
                                        
                                        <fmt:formatDate value="${day}" pattern="dd-MM-yyyy"/>
                                    </button>
                                </form>
                            </td>
                        </c:forEach>
                    </tr>
                </table>

                <!-- Hiển thị ngày được chọn -->
                <h4 class="text-primary">Lịch khám ngày 
                    <fmt:formatDate value="${selectedDate}" pattern="dd-MM-yyyy"/>
                </h4>
                <table class="table table-bordered prescription-table">
                    <thead>
                        <tr>
                            <th>Giờ khám</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="appointmentTable">
                        <c:set var="isPastDate" value="${selectedDate < today}" />
                        <c:forEach var="appointment" items="${availableSlot}">
                            <tr>
                                <td>${appointment.startTime} - ${appointment.endTime}</td>
                                <td>
                                    <form action="bookAppointment" method="post">
                                        <input type="hidden" name="doctorId" value="${doctor.staffId}">
                                        <input type="hidden" name="startTime" value="${appointment.startTime}">
                                        <input type="hidden" name="endTime" value="${appointment.endTime}">
                                        <input type="hidden" name="date" value="${selectedDate}">
                                        <button type="submit" class="btn btn-primary"  ${isPastDate || appointment.isIsBooked() ? 'disabled' : ''}>
                                            Đặt lịch
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if> 



            <div class="text-center mb-3 mt-4">
                <a href="listAppointments" class="btn btn-primary">Quay về danh sách lịch hẹn</a>
            </div>

            <!-- Scripts -->
            <script src="assets/js/bootstrap.bundle.min.js"></script>
            <script>
                        setTimeout(function () {
                            var successAlert = document.getElementById('success-alert');
                            var errorAlert = document.getElementById('error-alert');
                            if (successAlert)
                                successAlert.style.display = 'none';
                            if (errorAlert)
                                errorAlert.style.display = 'none';
                        }, 5000);
            </script>
    </body>
</html>
