<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Chi tiết bện nhân</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
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
            .status-cancelled {
                background-color: #f4c7c3;
            } /* Đỏ hồng nhạt */
            .status-pending {
                background-color: #fae3b0;
            }   /* Cam nhạt */
            .status-confirmed {
                background-color: #b3e5fc;
            } /* Xanh dương nhạt */
            .status-paid {
                background-color: #c8e6c9;
            }        /* Xanh lá pastel */
            .status-waiting_payment {
                background-color: #ffe0b2;
            } /* Vàng nhạt */
            .status-absent {
                background-color: #d1c4e9;
            }        /* Tím nhạt */
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
                                       
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Nhóm máu :</strong> <span id="profileDate" class="text-muted">${customer.bloodType}</span></p>
                                        <p><strong>Phân loại:</strong> <span id="profileDoctor" class="text-muted">${customer.isVipCustomer()}</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="container mt-5">
                            <h3 class="text-center">Danh sách lịch hẹn của bệnh nhân</h3>
                            <table class="table table-center bg-white mb-0">
                                <thead>
                                    <tr>
                                        <th class="border-bottom p-3" style="min-width: 50px;">ID</th>
                                        <th class="border-bottom p-3" style="min-width: 180px;">Ngày</th>
                                        <th class="border-bottom p-3">Giờ Bắt Đầu </th>
                                        <th class="border-bottom p-3">Giờ kết thúc </th>                                   
                                        
                                        <th class="border-bottom p-3">Bác Sĩ</th>
                                    </tr>
                                </thead>
                                <!--tbody-start-->
                                <tbody>
                                    <c:if test="${not empty listAppointment}">
                                        <c:forEach var="appointment" items="${listAppointment}">
                                            <tr>
                                                <td class="p-3">${appointment.appointmentId}</td>
                                                <td class="p-3"><fmt:formatDate value="${appointment.date}" pattern="dd/MM/yyyy"/></td>
                                                <td class="p-3">${appointment.start}</td>
                                                <td class="p-3">${appointment.end}</td>
                                                                                     
                                                <td class="p-3">${appointment.staff.name}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>

                                    <c:if test="${empty listAppointment}">
                                        <tr><td colspan="6" class="text-center p-3">Không có lịch hẹn</td></tr>
                                    </c:if>
                                </tbody>

                            </table>
                        </div>

                        <div class="container mt-5">
                            <h2 class="text-center">Chi tiết Bệnh Án</h2>

<!--                             Bệnh án -->
                            <c:if test="${not empty patientDetail}">
                                <div class="card mt-4 p-4">
                                    <h4 class="text-center">Bệnh án</h4>
                                    <p><strong>Triệu chứng:</strong> ${patientDetail.symptoms}</p>
                                    <p><strong>Chẩn đoán:</strong> ${patientDetail.diagnosis}</p>
                                    <p><strong>Kết quả xét nghiệm:</strong> ${patientDetail.testResults}</p>
                                    <p><strong>Kế hoạch điều trị:</strong> 
                                        <span style="font-weight: bold; color: blue;">${patientDetail.treatmentPlan}</span>
                                    </p>
                                    <p><strong>Theo dõi:</strong> ${patientDetail.followUp}</p>
                                </div>
                            </c:if>

<!--                             Nút quay lại -->
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/ListPatient" class="btn btn-primary">Quay lại danh sách Bệnh nhân</a>
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
    </body>
</html>
