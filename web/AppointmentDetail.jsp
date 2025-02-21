<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Doctris - Appointment Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="assets/images/favicon.ico.png">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
</head>

<body>
    <div class="container mt-5">
        <h2 class="text-center">Thông tin chi tiết cuộc hẹn</h2>
        
        <!-- Sử dụng d-flex để căn chỉnh bảng và nút quay lại thẳng hàng -->
        <div class="card mt-4 p-4">
            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Tên dịch vụ</th>
                            <th>Thời gian bắt đầu</th>
                            <th>Thời gian kết thúc</th>
                            <th>Bác sĩ phụ trách</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="service" items="${services}">
                            <tr>
                                <td>${service.name}</td>
                                <td>${startTime}</td>
                                <td>${endTime}</td>
                                <td>${doctorName}</td>
                                <td>${status}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Nút quay lại được căn giữa bằng text-center -->
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/listAppointments" class="btn btn-primary mb-3">Quay lại danh sách cuộc hẹn</a>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>

</html>
