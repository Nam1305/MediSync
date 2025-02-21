<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Customer Details</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>
        <div class="container mt-5">
            <h2 class="text-center">Thông tin chi tiết khách hàng</h2>
            <div class="card mt-4 p-4">
                <div class="d-flex align-items-center">
                    <img id="profileAvatar" 
                         src="${empty customer.avatar ? 'assets/images/client/09.jpg' : customer.avatar}" 
                         class="avatar avatar-small rounded-pill" 
                         alt="">
                    <h5 class="mb-0 ms-3" id="profileName">${customer.name}</h5>
                </div>
                <div class="row mt-4">
                    <div class="col-md-6">
                        <p><strong>Tuổi:</strong> <span id="profileAge" class="text-muted">${customer.getAge()}</span></p>
    <!--                    <p><strong>Giới tính:</strong> <span id="profileGender" class="text-muted">${customer.gender}</span></p>-->
                        <p><strong>Giới tính:</strong> 
                            <span id="profileGender" class="text-muted">
                                <c:choose>
                                    <c:when test="${customer.gender == 'M'}">Nam</c:when>
                                    <c:when test="${customer.gender == 'F'}">Nữ</c:when>
                                    <c:otherwise>Khác</c:otherwise>
                                </c:choose>
                            </span>
                        </p>
                        <p><strong>Chuyên khoa:</strong> <span id="profileDepartment" class="text-muted">${customer.getDepartment()}</span></p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Ngày khám bệnh:</strong> <span id="profileDate" class="text-muted">${customer.getAppointmentDate()}</span></p>
                        <p><strong>Thời gian khám:</strong> <span id="profileTime" class="text-muted">${customer.getAppointmentTime()}</span></p>
                        <p><strong>Bác sĩ phụ trách:</strong> <span id="profileDoctor" class="text-muted">${customer.getDoctor()}</span></p>
                        <p><strong>Phân loại:</strong> <span id="profileDoctor" class="text-muted">${customer.isVipCustomer()}</span></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Scripts -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>
