<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.net.URLEncoder" %>

<%
    String bloodTypeParam = request.getParameter("bloodType");
    String encodedBloodType = (bloodTypeParam != null) ? URLEncoder.encode(bloodTypeParam, "UTF-8") : "";
    request.setAttribute("encodedBloodType", encodedBloodType);
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Lịch hẹn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
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
                <!-- Start Hero -->

                <section class="bg-dashboard">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12 mt-4 pt-2 mt-sm-0 pt-sm-0"> <!-- Thay col-xl-9 col-lg-8 col-md-7 thành col-12 -->
                                <h5 class="mb-0">Patients List</h5>
                                <div class="row">
                                    <div class="d-flex justify-content-end">
                                        <form action="ListPatient" method="get" class="row gx-2 gy-2 align-items-center">
                                            <input type="hidden" name="s" class="form-control" placeholder="Search..." value="${search}">
                                            <div class="col-auto">
                                                <select name="sort" class="form-select">
                                                    <option value="ASC" <c:if test="${sort == 'ASC'}">selected</c:if>>Tăng dần</option>
                                                    <option value="DESC" <c:if test="${sort == 'DESC'}">selected</c:if>>Giảm dần</option>
                                                    </select>
                                                </div>
                                                <div class="col-auto">
                                                    <select name="bloodType" id="statusFilter" class="form-select">
                                                        <option value="" <c:if test="${empty bloodType}">selected</c:if>>Tất cả nhóm máu</option>
                                                    <option value="A+" <c:if test="${bloodType == 'A+'}">selected</c:if>>A(+)</option>
                                                    <option value="A-" <c:if test="${bloodType == 'A-'}">selected</c:if>>A(-)</option>
                                                    <option value="B+" <c:if test="${bloodType == 'B+'}">selected</c:if>>B(+)</option>
                                                    <option value="B-" <c:if test="${bloodType == 'B-'}">selected</c:if>>B(-)</option>
                                                    <option value="AB+" <c:if test="${bloodType == 'AB+'}">selected</c:if>>AB(+)</option>
                                                    <option value="AB-" <c:if test="${bloodType == 'AB-'}">selected</c:if>>AB(-)</option>
                                                    <option value="O+" <c:if test="${bloodType == 'O+'}">selected</c:if>>O(+)</option>
                                                    <option value="O-" <c:if test="${bloodType == 'O-'}">selected</c:if>>O(-)</option>
                                                    </select>
                                                </div>

                                                <div class="col-auto">
                                                    <input type="number" name="pageSize" value="${pageSize}" class="form-control" placeholder="Số dòng">
                                            </div>

                                            <div class="col-auto">
                                                <button type="submit" class="btn btn-success">Lọc</button>
                                            </div>

                                            <div class="col-auto">
                                                <button type="button" class="btn btn-secondary" onclick="resetFilters()">Reset</button>
                                            </div>
                                        </form>
                                    </div>
                                    <c:forEach var="patient" items="${patientList}">
                                        <div class="col-md-4 col-sm-6 col-12 mt-4 pt-2"> <!-- Đảm bảo 3 cột trên màn lớn -->
                                            <div class="card border-0 shadow rounded p-4">
                                                <div class="d-flex justify-content-between">
                                                    <img src="${patient.avatar}" class="avatar avatar-md-md rounded-pill shadow" alt="">
                                                    <div class="dropdown dropdown-primary">
                                                        <button type="button" class="btn btn-icon btn-pills btn-soft-primary dropdown-toggle p-0" 
                                                                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                            <i class="uil uil-ellipsis-h icons"></i>
                                                        </button>
                                                        <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3">
                                                            <a class="dropdown-item text-dark" href="PatientDetail?id=${patient.customerId}"><i class="uil uil-user align-middle h6"></i>Thông tin chi tiết</a>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="card-body p-0 pt-3">
                                                    <a href="#" class="text-dark h6">${patient.name}</a>
                                                    <p class="text-muted">ID: ${patient.customerId}</p>

                                                    <ul class="mb-0 list-unstyled mt-2">
                                                        <li class="mt-1"><span class="text-muted me-2">Nhóm Máu</span> ${patient.bloodType}</li>
                                                        <li class="mt-1"><span class="text-muted me-2">
                                                                <c:choose>
                                                                    <c:when test="${patient.gender.trim() == 'M'}">Nam</c:when>
                                                                    <c:when test="${patient.gender.trim() == 'F'}">Nữ</c:when>
                                                                    <c:otherwise>Khác</c:otherwise>
                                                                </c:choose>
                                                        </li>
                                                        <li class="mt-1"><span class="text-muted me-2">Tuổi:</span> 
                                                            <fmt:formatDate value="${patient.dateOfBirth}" pattern="yyyy" var="birthYear"/>
                                                            <c:set var="currentYear" value="<%= java.time.Year.now().getValue() %>" />
                                                            ${currentYear - birthYear} tuổi
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="row text-center">
                                    <!--                                                     PAGINATION START -->
                                    <!-- PAGINATION START -->
                                    <div class="col-12 mt-4">
                                        <div class="d-md-flex align-items-center text-center justify-content-between">
                                            <span class="text-muted me-3">Showing 1 - 10 out of 50</span>
                                            <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                                <c:if test="${currentPage > 1}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="ListPatient?page=${currentPage - 1}&pageSize=${pageSize}&sort=${sort}&search=${search}&bloodType=${bloodType}">Previous</a>
                                                    </li>
                                                </c:if>

                                                <c:forEach var="i" begin="1" end="${totalPages}">
                                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                        <a class="page-link" href="ListPatient?page=${i}&pageSize=${pageSize}&sort=${sort}&search=${search}&bloodType=${encodedBloodType}">${i}</a>
                                                    </li>
                                                </c:forEach>

                                                <c:if test="${currentPage < totalPages}">
                                                    <li class="page-item">
                                                        <a class="page-link" href="ListPatient?page=${currentPage + 1}&pageSize=${pageSize}&sort=${sort}&search=${search}&bloodType=${bloodType}">Next</a>
                                                    </li>
                                                </c:if>
                                            </ul>

                                        </div>
                                    </div>
                                    <!--PAGINATION END -->
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end container-->

                </section><!--end section-->
                <!-- Footer Start -->
                <jsp:include page="footer.jsp" />
                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->
         <script>
            function resetFilters() {
                window.location.href = './ListPatient?search=&status=&bloodType=&pageSize=6';
            }

        </script>


        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
