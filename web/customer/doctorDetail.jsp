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
        </style>
    </head>
    <body>
        <jsp:include page="../layout/header.jsp" />
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
        </div>

        <c:if test="${not hasSchedule}">
            <div class="d-flex justify-content-center align-items-center" style="height: 100px;">
                <p class="text-warning">Bác sĩ chưa có lịch làm việc.</p>
            </div>
        </c:if>

        <!-- Danh sách lịch khám còn trống để đặt lịch -->
        <c:if test="${hasSchedule}">
            <div class="card mt-4 p-4">
                <h4 class="text-primary">Chọn ngày khám</h4>
                <div class="d-flex overflow-auto border rounded p-2 bg-light">

                    <c:forEach var="day" items="${schedule}">
                        <form action="doctorDetail" method="get" class="d-inline">
                            <input type="hidden" name="doctorId" value="${doctor.staffId}">
                            <button type="submit" name="date" value="${day.getUrlDate()}" 
                                    class="btn mx-1 ${selectedDate == day.getUrlDate() ? 'btn-success' : 'btn-outline-success'}">
                                ${day.getFormatDate()}
                            </button>
                        </form>
                    </c:forEach>

                </div>
            </div>        
            <div class="card mt-4 p-4">
                <c:if test="${param.message == 'success'}">
                    <div class="alert alert-success" role="alert">
                        🎉 Đặt lịch hẹn thành công!
                    </div>
                </c:if>

                <c:if test="${param.message == 'error'}">
                    <div class="alert alert-danger" role="alert">
                        ❌ Đặt lịch hẹn thất bại! Vui lòng thử lại.
                    </div>
                </c:if>
                <h4 class="text-primary">Lịch khám trống</h4>
                <table class="table table-bordered prescription-table">
                    <thead>
                        <tr>
                            <th>Giờ khám</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="appointmentTable">
                        <c:forEach var="appointment" items="${availableSlot}">
                            <tr>
                                <td>${appointment.startTime} - ${appointment.endTime}</td>
                                <td>
                                    <form action="bookAppointment" method="post">
                                        <input type="hidden" name="doctorId" value="${doctor.staffId}">
                                        <input type="hidden" name="startTime" value="${appointment.startTime}">
                                        <input type="hidden" name="endTime" value="${appointment.endTime}">
                                        <input type="hidden" name="date" value="${selectedDate}">
                                        <button type="submit" class="btn btn-primary" ${appointment.isIsBooked() ? 'disabled' : ''}>
                                            Đặt lịch
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>


            <div class="text-center mb-3">
                <a href="listAppointments" class="btn btn-primary">Quay về danh sách lịch hẹn</a>
            </div>


        </div>
        <!-- Scripts -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
