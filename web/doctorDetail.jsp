<%-- 
    Document   : doctorDetail
    Created on : Feb 24, 2025, 9:35:58 AM
    Author     : Phạm Hoàng Nam
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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


        <!-- Danh sách lịch khám còn trống để đặt lịch -->
        <div class="card mt-4 p-4">
            <h4 class="text-primary">Chọn ngày khám</h4>
            <div class="d-flex overflow-auto border rounded p-2 bg-light">
                <c:forEach var="day" items="${availableDays}">
                    <button class="btn btn-outline-success mx-1" onclick="showAppointments('${day}')">${day}</button>
                </c:forEach>
            </div>
        </div>

        <!-- Danh sách ca khám trống -->
        <div class="card mt-4 p-4">
            <h4 class="text-primary">Lịch khám trống</h4>
            <table class="table table-bordered prescription-table">
                <thead>
                    <tr>
                        <th>Giờ khám</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody id="appointmentTable">
                    <c:forEach var="appointment" items="${availableAppointments}">
                        <tr class="appointment-row" data-date="${appointment.date}">
                            <td>${appointment.time}</td>
                            <td>
                                <form action="BookAppointmentServlet" method="post">
                                    <input type="hidden" name="appointmentId" value="${appointment.id}">
                                    <button type="submit" class="btn btn-primary">Đặt lịch</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- JavaScript để lọc lịch khám -->
        <script>
            function showAppointments(selectedDate) {
                document.querySelectorAll('.appointment-row').forEach(row => {
                    row.style.display = row.getAttribute('data-date') === selectedDate ? '' : 'none';
                });
            }
        </script>



        <!-- Scripts -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
