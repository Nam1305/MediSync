<%-- 
    Document   : allDoctor
    Created on : Feb 23, 2025, 1:50:27 PM
    Author     : Phạm Hoàng Nam
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>

    <body>



        <!-- Start Page Content -->
        <main class="page-content bg-light">
            <jsp:include page="../layout/header.jsp" />   

            <!-- Start Hero -->
            <section class="bg-half-150 bg-light d-table w-100">
                <div class="container">
                    <!-- Form tìm kiếm & lọc -->
                    <form action="allDoctors" method="GET" class="mb-4">
                        <div class="row g-3">
                            <!-- Tìm kiếm theo tên -->
                            <div class="col-md-4">
                                <input type="text" name="name" class="form-control" placeholder="Tìm kiếm theo tên" value="${name}">
                            </div>

                            <!-- Lọc theo khoa -->
                            <div class="col-md-3">
                                <select name="departmentId" class="form-control">
                                    <option value="">-- Chọn khoa --</option>
                                    <c:forEach var="dept" items="${departments}">
                                        <option value="${dept.departmentId}" ${departmentId == dept.departmentId ? 'selected' : ''}>${dept.departmentName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Lọc theo giới tính -->
                            <div class="col-md-3">
                                <select name="gender" class="form-control">
                                    <option value="">-- Chọn giới tính --</option>
                                    <option value="M" ${gender == 'M' ? 'selected' : ''}>Nam</option>
                                    <option value="F" ${gender == 'F' ? 'selected' : ''}>Nữ</option>
                                </select>
                            </div>

                            <!-- Lọc theo số lượng bác sĩ -->
                            <div class="col-md-2">
                                <input type="number" name="pageSize" class="form-control" placeholder="Số lượng bác sĩ" value="${pageSize}">
                            </div>

                            <!-- Nút lọc & reset -->
                            <div class="col-12 d-flex justify-content-end">
                                <button type="submit" class="btn btn-primary me-2">Lọc</button>
                                <a href="allDoctors" class="btn btn-primary me-2">Reset</a>
                            </div>
                        </div>
                    </form>


                    <div class="row mt-5 justify-content-center">
                        <div class="col-12">
                            <div class="section-title text-center">
                                <h3 class="sub-title mb-4">Đội ngũ bác sĩ</h3>
                                <p class="para-desc mx-auto text-muted">Đội ngũ bác sĩ của chúng tôi với những bác sĩ chuyên môn cao, tận tâm luôn sẵn sàng hỗ trợ bạn trong mọi tình huống!</p>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end container-->
            </section><!--end section-->
            <!-- End Hero -->

            <!-- Start -->
            <section class="section">
                <div class="container">
                    <div class="row align-items-center g-4"> <!-- Thêm khoảng cách giữa các cột -->
                        <c:forEach var="doctor" items="${doctors}"> 
                            <div class="col-lg-6 col-md-12 mb-4"> <!-- Thêm khoảng cách giữa các hàng -->
                                <div class="card team border-0 rounded shadow overflow-hidden">
                                    <div class="row align-items-center">
                                        <div class="col-md-6">
                                            <div class="team-person position-relative overflow-hidden">
                                                <img src="${doctor.avatar}" class="img-fluid" alt="" 
                                                     style="width: 150px; height: 150px; object-fit: cover; ">
                                                <ul class="list-unstyled team-like">
                                                    <li>
                                                        <a href="doctorDetail?doctorId=${doctor.staffId}" class="btn btn-icon btn-pills btn-soft-danger">
                                                            <i data-feather="eye" class="icons"></i>
                                                        </a>
                                                    </li>
                                                    <li class="mt-2">
                                                        <a href="staffFeedback?staffId=${doctor.staffId}" class="btn btn-icon btn-pills btn-soft-warning">
                                                            <i data-feather="star" class="icons"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="card-body">
                                                <a href="#" class="title text-dark h5 d-block mb-0">${doctor.name}</a>
                                                <small class="text-muted speciality">${doctor.getDepartment().getDepartmentName()}</small>
                                                <div class="d-flex justify-content-between align-items-center mt-2">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </c:forEach>
                    </div><!--end row-->
                </div><!--end container-->
                <c:if test="${totalPages > 1}">
                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="allDoctors?name=${name}&departmentId=${departmentId}&gender=${gender}&pageSize=${pageSize}&page=${currentPage - 1}" aria-label="Previous">
                                    Prev
                                </a>
                            </li>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="allDoctors?name=${name}&departmentId=${departmentId}&gender=${gender}&pageSize=${pageSize}&page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="allDoctors?name=${name}&departmentId=${departmentId}&gender=${gender}&pageSize=${pageSize}&page=${currentPage + 1}" aria-label="Next">
                                    Next
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </c:if>

            </section><!--end section-->
            <!-- End -->


            <!-- Start -->
            <jsp:include page="../layout/footer.jsp" />   
            <!-- End -->

            <!-- Back to top -->
            <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>


            <!-- javascript -->
            <script src="assets/js/bootstrap.bundle.min.js"></script>
            <!-- Icons -->
            <script src="assets/js/feather.min.js"></script>
            <!-- Main Js -->
            <script src="assets/js/app.js"></script>

    </body>

</html> 
