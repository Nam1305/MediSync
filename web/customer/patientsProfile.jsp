<%-- 
    Document   : patientsProfile.jsp
    Created on : Feb 17, 2025, 10:33:48 AM
    Author     : Phạm Hoàng Nam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        <!-- Select2 -->
        <link href="assets/css/select2.min.css" rel="stylesheet" />
        <!-- Date picker -->
        <link rel="stylesheet" href="assets/css/flatpickr.min.css">
        <link href="assets/css/jquery.timepicker.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

        <style>
            /* Appointment Table Styles */
            .container {
                max-width: 100%;
                width: 100%;
            }

            .nav-pills .nav-link {
                width: 100%;
            }

            .table-container {
                width: 100%;
            }
            .table-appointments {
                width: 100% !important;
                min-width: 1200px !important; /* Ensure minimum width for content */
                border-collapse: separate !important;
                border-spacing: 0 !important;
                border-radius: 8px !important;
                box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1) !important;
                margin-bottom: 2rem !important;
            }

            .table-appointments thead th {
                background-color: #28a745 !important;
                color: white !important;
                font-weight: 600 !important;
                padding: 0.75rem 1rem !important;
                font-size: 0.95rem !important;
                border: none !important;
                text-transform: uppercase !important;
                letter-spacing: 0.5px !important;
                white-space: nowrap !important;
            }

            .table-appointments tbody tr {
                transition: all 0.2s ease !important;
            }

            .table-appointments tbody tr:hover {
                background-color: #f8f9fa !important;
            }

            .table-appointments tbody td {
                padding: 0.75rem 1rem !important;
                vertical-align: middle !important;
                border-bottom: 1px solid #e9ecef !important;
                color: #495057 !important;
                font-size: 12px !important;
                white-space: nowrap !important;
            }

            /* Column widths */
            .table-appointments th:nth-child(1),
            .table-appointments td:nth-child(1) {
                min-width: 80px !important;
            } /* Tên bác sĩ */

            .table-appointments th:nth-child(2),
            .table-appointments td:nth-child(2) {
                min-width: 50px !important;
            } /* Giới tính */

            .table-appointments th:nth-child(3),
            .table-appointments td:nth-child(3) {
                min-width: 120px !important;
            } /* Ngày hẹn */

            .table-appointments th:nth-child(4),
            .table-appointments td:nth-child(4) {
                min-width: 80px !important;
            } /* Bắt đầu */

            .table-appointments th:nth-child(5),
            .table-appointments td:nth-child(5) {
                min-width: 80px !important;
            } /* Kết thúc */

            .table-appointments th:nth-child(6),
            .table-appointments td:nth-child(6) {
                min-width: 120px !important;
            } /* Trạng thái */

            .table-appointments th:nth-child(7),
            .table-appointments td:nth-child(7) {
                min-width: 150px !important;
            } /* Hành động */

            /* Status styles */
            .table-appointments [class^="status-"] {
                padding: 0.5rem 1rem !important;
                border-radius: 20px !important;
                font-weight: 500 !important;
                display: inline-block !important;
            }

            .table-appointments .status-pending {
                color: #f4a100 !important;
                background-color: #fff8e9 !important;
            }

            .table-appointments .status-confirmed {
                color: #0d6efd !important;
                background-color: #e7f1ff !important;
            }

            .table-appointments .status-paid {
                color: #198754 !important;
                background-color: #e8f5e9 !important;
            }

            .table-appointments .status-cancelled {
                color: #dc3545 !important;
                background-color: #ffebee !important;
            }

            .table-appointments .status-waitpay {
                color: #6c757d !important;
                background-color: #f8f9fa !important;
            }

            .table-appointments .status-absent {
                color: #862e9c !important;
                background-color: #f3e8ff !important;
            }

            /* Action buttons styling */
            .table-appointments .btn {
                padding: 0.4rem !important;
                margin: 0 0.2rem !important;
                border-radius: 50% !important;
                width: 35px !important;
                height: 35px !important;
                display: inline-flex !important;
                align-items: center !important;
                justify-content: center !important;
                transition: all 0.3s ease !important;
            }

            .table-appointments .btn:hover {
                transform: translateY(-2px) !important;
            }

            .table-appointments .btn i {
                font-size: 1rem !important;
            }

            /* Table container with horizontal scroll */
            .table-container {
                width: 100% !important;
                overflow-x: auto !important;
                padding-bottom: 1rem !important; /* Space for scrollbar */
                margin-bottom: 1rem !important;
            }

            /* Ensure smooth scrolling */
            .table-container::-webkit-scrollbar {
                height: 8px !important;
            }

            .table-container::-webkit-scrollbar-track {
                background: #f1f1f1 !important;
                border-radius: 4px !important;
            }

            .table-container::-webkit-scrollbar-thumb {
                background: #888 !important;
                border-radius: 4px !important;
            }

            .table-container::-webkit-scrollbar-thumb:hover {
                background: #555 !important;
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

        <!-- Navbar STart -->
        <jsp:include page="../layout/header.jsp" /><!--end header-->
        <!-- Navbar End -->

        <!-- Start -->
        <section class="bg-hero">
            <div class="container">
                <div class="row mt-lg-5">
                    <div class="col-md-6 col-lg-4">
                        <div class="rounded shadow overflow-hidden sticky-bar">

                        </div>
                    </div>
                </div><!--end col-->

                <!--                    <div class="col-lg-8 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">-->
                <div class="col-12 mt-4">
                    <div class="card border-0 shadow overflow-hidden">
                        <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded-0 shadow overflow-hidden bg-light mb-0" id="pills-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link rounded-0 active" id="overview-tab" data-bs-toggle="pill" href="#pills-overview" role="tab" aria-controls="pills-overview" aria-selected="false">
                                    <div class="text-center pt-1 pb-1">
                                        <h4 class="title fw-normal mb-0">Lịch hẹn</h4>
                                    </div>
                                </a><!--end nav link-->
                            </li><!--end nav item-->

                            <li class="nav-item">
                                <a class="nav-link rounded-0" id="experience-tab" data-bs-toggle="pill" href="#pills-experience" role="tab" aria-controls="pills-experience" aria-selected="false">
                                    <div class="text-center pt-1 pb-1">
                                        <h4 class="title fw-normal mb-0">Cập nhật thông tin</h4>
                                    </div>
                                </a><!--end nav link-->
                            </li><!--end nav item-->
                        </ul>

                        <!-- Thêm lớp mt-4 để tạo khoảng cách -->
                        <form action="listAppointments" method="GET" class="mb-3 mt-4">


                            <div class="row g-3"> <!-- Thêm g-3 để tạo khoảng cách giữa các cột -->
                                <!-- Ô tìm kiếm theo tên bác sĩ -->
                                <div class="col-md-4">
                                    <input type="text" name="search" value="${not empty search ? search : ''}" class="form-control" placeholder="Tìm theo tên bác sĩ...">
                                </div>

                                <!-- Lọc theo giới tính -->
                                <div class="col-md-2">
                                    <select name="gender" class="form-control">
                                        <option value="" <c:if test="${empty gender}">selected</c:if>>Giới tính</option>
                                        <option value="M" <c:if test="${gender == 'M'}">selected</c:if>>Nam</option>
                                        <option value="F" <c:if test="${gender == 'F'}">selected</c:if>>Nữ</option>
                                        </select>
                                    </div>

                                    <!-- Lọc theo trạng thái -->
                                    <div class="col-md-2">
                                        <select name="status" class="form-control">
                                            <option value="all" <c:if test="${empty status or status == 'all'}">selected</c:if>>Trạng thái</option>
                                        <option value="pending" <c:if test="${status == 'pending'}">selected</c:if>>Chờ xác nhận</option>
                                        <option value="confirmed" <c:if test="${status == 'confirmed'}">selected</c:if>>Đã xác nhận</option>
                                        <option value="paid" <c:if test="${status == 'paid'}">selected</c:if>>Đã thanh toán</option>
                                        <option value="cancelled" <c:if test="${status == 'cancelled'}">selected</c:if>>Đã hủy</option>
                                        <option value="waitpay" <c:if test="${status == 'waitpay'}">selected</c:if>>Chờ thanh toán</option>
                                        <option value="absent" <c:if test="${status == 'absent'}">selected</c:if>>Vắng mặt</option>
                                        </select>
                                    </div>

                                    <!-- Sắp xếp -->
                                    <div class="col-md-2">
                                        <select name="sort" class="form-control">
                                            <option value="asc" <c:if test="${sort == 'asc'}">selected</c:if>>Ngày cũ → mới</option>
                                        <option value="desc" <c:if test="${sort == 'desc'}">selected</c:if>>Ngày mới → cũ</option>
                                        </select>
                                    </div>

                                    <!-- Input số lượng/trang -->
                                    <div class="col-md-2">
                                        <input type="number" class="form-control" name="pageSize" min="1" max="${totalAppointment}" 
                                           value="${not empty pageSize ? pageSize : 2}" placeholder="Số lượng/trang">
                                </div>

                                <!-- Nút submit -->
                                <div class="col-md-2 d-flex gap-2">
                                    <button type="submit" class="btn btn-primary w-100">Lọc</button>
                                    <button type="button" class="btn btn-primary w-100" onclick="resetForm()">Reset</button>
                                </div>
                            </div>
                        </form>




                        <div class="tab-content p-4" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-overview" role="tabpanel" aria-labelledby="overview-tab">
                                <div class="row">
                                    <div class="table-container col-lg-6 col-12 mt-4">
                                        <table class="table table-bordered table-hover table-appointments" >
                                            <thead class="table-success">
                                                <tr>
                                                    <th>Tên bác sĩ</th>
                                                    <th>Giới tính</th>
                                                    <th>Ngày hẹn</th>
                                                    <th>Thời gian</th>
                                                    <th>Trạng thái</th>
                                                    <th class="text-center">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <!-- Dữ liệu sẽ được xử lý và thêm vào đây -->
                                                <c:forEach var="appointment" items="${appointments}">
                                                    <tr>
                                                        <td>${appointment.staff.name}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${appointment.staff.gender.trim() == 'M'}">Nam</c:when>
                                                                <c:when test="${appointment.staff.gender.trim() == 'F'}">Nữ</c:when>
                                                                <c:otherwise>Khác</c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                        <td>
                                                            <fmt:formatDate value="${appointment.date}" pattern="dd-MM-yyyy"/>
                                                        </td>
                                                        <td>${appointment.start} - ${appointment.end} </td>
                                                        <!--                                                            <td></td>-->
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${appointment.status == 'pending'}">Chờ xác nhận</c:when>
                                                                <c:when test="${appointment.status == 'confirmed'}">Đã xác nhận</c:when>
                                                                <c:when test="${appointment.status == 'paid'}">Đã thanh toán</c:when>
                                                                <c:when test="${appointment.status == 'cancelled'}">Đã hủy</c:when>
                                                                <c:when test="${appointment.status == 'waitpay'}">Chờ thanh toán</c:when>
                                                                <c:when test="${appointment.status == 'absent'}">Vắng mặt</c:when>
                                                            </c:choose>
                                                        </td>

                                                        <td class="text-center">
                                                            <!-- Link: Xem chi tiết thông tin: bác sĩ, bệnh án, đơn thuốc -->
                                                            <a href="appointmentDetail?appointmentId=${appointment.appointmentId}" class="btn btn-icon btn-pills btn-soft-warning">
                                                                <i class="uil uil-eye"></i>
                                                            </a>

                                                            <!-- Hủy lịch hẹn -->
                                                            <a href="#"
                                                               class="btn btn-icon btn-pills btn-soft-danger"
                                                               onclick="return confirm('Bạn có chắc muốn hủy lịch hẹn ngày: ${appointment.date} không?');">
                                                                <i class="uil uil-check-circle"></i>
                                                            </a>

                                                            <!-- Link xem hóa đơn chi tiết-->
                                                            <a href="#"
                                                               class="btn btn-icon btn-pills btn-soft-success">
                                                                <i class="uil uil-times-circle"></i>
                                                            </a>
                                                        </td>
                                                    </tr>

                                                </c:forEach>

                                            </tbody>
                                        </table>
                                        <!-- PAGINATION START -->
                                        <div class="col-12 mt-4">
                                            <div class="d-md-flex align-items-center text-center justify-content-between">
                                                <span class="text-muted me-3">Showing 1 - 5 out of ${requestScope.totalAppointment}</span>
                                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                                    <!--                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Previous">Prev</a></li>-->
                                                    <c:if test="${currentPage > 1}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="listAppointments?search=${requestScope.search}&gender=${requestScope.gender}&status=${not empty requestScope.status ? requestScope.status : 'all'}&sort=${not empty requestScope.sort ? requestScope.sort : 'asc'}&page=${currentPage - 1}&pageSize=${requestScope.pageSize}" aria-label="Previous">
                                                                Prev
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                    <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                            <a class="page-link" href="listAppointments?search=${requestScope.search}&gender=${requestScope.gender}&status=${not empty requestScope.status ? requestScope.status : 'all'}&sort=${not empty requestScope.sort ? requestScope.sort : 'asc'}&page=${i}&pageSize=${requestScope.pageSize}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                    <c:if test="${currentPage < totalPages}">
                                                        <li class="page-item">
                                                            <a class="page-link" href="listAppointments?search=${requestScope.search}&gender=${requestScope.gender}&status=${not empty requestScope.status ? requestScope.status : 'all'}&sort=${not empty requestScope.sort ? requestScope.sort : 'asc'}&page=${currentPage + 1}&pageSize=${requestScope.pageSize}" aria-label="Next">
                                                                Next
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div><!--end col-->
                                        <!-- PAGINATION END -->
                                    </div>
                                </div>  
                            </div>
                            <!-- hết jsp của Nam-->

                            <div class="tab-pane fade" id="pills-experience" role="tabpanel" aria-labelledby="experience-tab">
                                <h5 class="mb-0">Personal Information:</h5>

                                <!-- Display avatar section -->
                                <!-- Profile Picture Section -->
                                <div class="card border-0 rounded shadow">
                                    <div class="card-body">
                                        <h5 class="mb-0">Ảnh đại diện</h5>
                                        <div class="row align-items-center mt-4">
                                            <!-- Avatar Preview Column - Increased width and added proper spacing -->
                                            <div class="col-lg-3 col-md-4 text-center mb-4 mb-md-0">
                                                <div class="position-relative">
                                                    <c:choose>
                                                        <c:when test="${customer.avatar != null && not empty customer.avatar}">
                                                            <img id="avatarPreview" src="${customer.avatar}" class="avatar avatar-large rounded-circle shadow mx-auto" 
                                                                 alt="Profile Picture" style="width: 120px; height: 120px; object-fit: cover;">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img id="avatarPreview" src="${customer.avatar}" class="avatar avatar-large rounded-circle shadow mx-auto" 
                                                                 alt="Default Profile" style="width: 120px; height: 120px; object-fit: cover;">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <!-- Text Column - Added proper spacing -->
                                            <div class="col-lg-4 col-md-8 text-center text-md-start">
                                                <h6 class="mb-2">Upload ảnh đại diện</h6>
                                                <p class="text-muted mb-0">Để có kết quả ưng ý nhất, sử dụng ảnh có độ phân giải 256px đổ lên với format .jpg hoặc .jpeg</p>
                                            </div>

                                            <!-- Buttons Column - Modified spacing and alignment -->
                                            <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                                <form id="avatarUploadForm" action="customer-profile" method="post" enctype="multipart/form-data">
                                                    <input type="hidden" name="action" value="uploadAvatar">
                                                    <input type="file" name="profileImage" id="profileImage" style="display: none;" accept="image/jpeg, image/png">
                                                    <button type="button" id="uploadButton" class="btn btn-primary" onclick="document.getElementById('profileImage').click();">Upload</button>
                                                    <a href="customer-profile?action=removeAvatar" class="btn btn-soft-primary ms-2" 
                                                       onclick="return confirm('Are you sure you want to remove your profile picture?')" 
                                                       ${empty customer.avatar ? 'disabled' : ''}>Xóa</a>
                                                </form>
                                                <div id="uploadError" class="text-danger mt-2 text-start" style="display: none;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Profile update form -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <form class="mt-4" action="customer-profile" method="post">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Tên</label>
                                                <input name="name" type="text" class="form-control" placeholder="Full Name" 
                                                       value="${customer.name}" required>
                                            </div>
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ email</label>
                                                <input name="email" type="email" class="form-control" placeholder="Email" 
                                                       value="${customer.email}" required>
                                            </div> 
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">SĐT</label>
                                                <input name="phone" type="text" class="form-control" placeholder="Phone number" 
                                                       value="${customer.phone}" required>
                                            </div>                                                                               
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Ngày sinh</label>
                                                <input name="dateOfBirth" type="date" class="form-control" 
                                                       value="${customer.dateOfBirth}">
                                            </div>                                                                               
                                        </div>

                                        <div class="col-lg-6">
                                            <div class="mb-3">
                                                <label class="form-label">Giới tính</label>
                                                <select name="gender" class="form-select">
                                                    <option value="M" ${customer.gender == 'M' ? 'selected' : ''}>Nam</option>
                                                    <option value="F" ${customer.gender == 'F' ? 'selected' : ''}>Nữ</option>
                                                    <option value="Other" ${customer.gender == 'Other' ? 'selected' : ''}>Khác</option>
                                                </select>
                                            </div>                                                                               
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Địa chỉ</label>
                                                <textarea name="address" class="form-control" rows="3">${customer.address}</textarea>
                                            </div>                                                                               
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <input type="submit" id="submit" name="send" class="btn btn-primary" value="Update Profile">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>                     
                    </div>
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->
    </section><!--end section-->
    <!-- End -->

    <!-- Start -->
    <jsp:include page="../layout/footer.jsp" /><!--end header-->
    <!-- End -->

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
    <!-- Back to top -->

    <!-- Offcanvas Start -->
    <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
        <div class="offcanvas-body d-flex align-items-center align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="text-center">
                            <h4>Search now.....</h4>
                            <div class="subcribe-form mt-4">
                                <form>
                                    <div class="mb-0">
                                        <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Search">
                                        <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </div>
    </div>
    <!-- Offcanvas End -->

    <!-- Offcanvas Start -->
    <div class="offcanvas offcanvas-end bg-white shadow" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
        <div class="offcanvas-header p-4 border-bottom">
            <h5 id="offcanvasRightLabel" class="mb-0">
                <img src="assets/images/logo-dark.png" height="24" class="light-version" alt="">
                <img src="assets/images/logo-light.png" height="24" class="dark-version" alt="">
            </h5>
            <button type="button" class="btn-close d-flex align-items-center text-dark" data-bs-dismiss="offcanvas" aria-label="Close"><i class="uil uil-times fs-4"></i></button>
        </div>
        <div class="offcanvas-body p-4 px-md-5">
            <div class="row">
                <div class="col-12">
                    <!-- Style switcher -->
                    <div id="style-switcher">
                        <div>
                            <ul class="text-center list-unstyled mb-0">
                                <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="assets/images/layouts/landing-light-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="assets/images/layouts/landing-dark-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="assets/images/layouts/landing-dark.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                <li class="d-grid"><a href="admin/index.html" target="_blank" class="mt-4"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Admin Dashboard</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- end Style switcher -->
                </div><!--end col-->
            </div><!--end row-->
        </div>

        <div class="offcanvas-footer p-4 border-top text-center">
            <ul class="list-unstyled social-icon mb-0">
                <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
                <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
                <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
                <li class="list-inline-item mb-0"><a href="index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
            </ul><!--end icon-->
        </div>
    </div>
    <!-- Offcanvas End -->

    <!-- View Invoice Start -->
    <div class="modal fade" id="view-invoice" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-bottom p-3">
                    <h5 class="modal-title" id="exampleModalLabel">Patient Invoice</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-3 pt-4">
                    <div class="row mb-4">
                        <div class="col-lg-8 col-md-6">
                            <img src="assets/images/logo-dark.png" height="22" alt="">
                            <h6 class="mt-4 pt-2">Address :</h6>
                            <small class="text-muted mb-0">1419 Riverwood Drive, <br>Redding, CA 96001</small>
                        </div><!--end col-->

                        <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <ul class="list-unstyled">
                                <li class="d-flex">
                                    <small class="mb-0 text-muted">Invoice no. : </small>
                                    <small class="mb-0 text-dark">&nbsp;&nbsp;#54638990jnn</small>
                                </li>
                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Email : </small>
                                    <small class="mb-0">&nbsp;&nbsp;<a href="mailto:contact@example.com" class="text-dark">info@doctris.com</a></small>
                                </li>
                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Phone : </small>
                                    <small class="mb-0">&nbsp;&nbsp;<a href="tel:+152534-468-854" class="text-dark">(+12) 1546-456-856</a></small>
                                </li>
                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Website : </small>
                                    <small class="mb-0">&nbsp;&nbsp;<a href="#" class="text-dark">www.doctris.com</a></small>
                                </li>
                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Patient Name : </small>
                                    <small class="mb-0">&nbsp;&nbsp;Mary Skeens</small>
                                </li>
                            </ul>
                        </div><!--end col-->
                    </div><!--end row-->

                    <div class="pt-4 border-top">
                        <div class="row">
                            <div class="col-lg-8 col-md-6">
                                <h5 class="text-muted fw-bold">Invoice <span class="badge badge-pill badge-soft-success fw-normal ms-2">Paid</span></h5>
                                <h6>Surgery (Gynecology)</h6>
                            </div><!--end col-->

                            <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <ul class="list-unstyled">
                                    <li class="d-flex mt-2">
                                        <small class="mb-0 text-muted">Issue Dt. : </small>
                                        <small class="mb-0 text-dark">&nbsp;&nbsp;25th Sep. 2020</small>
                                    </li>

                                    <li class="d-flex mt-2">
                                        <small class="mb-0 text-muted">Due Dt. : </small>
                                        <small class="mb-0 text-dark">&nbsp;&nbsp;11th Oct. 2020</small>
                                    </li>

                                    <li class="d-flex mt-2">
                                        <small class="mb-0 text-muted">Dr. Name : </small>
                                        <small class="mb-0 text-dark">&nbsp;&nbsp;Dr. Calvin Carlo</small>
                                    </li>
                                </ul>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="invoice-table pb-4">
                            <div class="table-responsive shadow rounded mt-4">
                                <table class="table table-center invoice-tb mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col" class="text-start border-bottom p-3" style="min-width: 60px;">No.</th>
                                            <th scope="col" class="text-start border-bottom p-3" style="min-width: 220px;">Item</th>
                                            <th scope="col" class="text-center border-bottom p-3" style="min-width: 60px;">Qty</th>
                                            <th scope="col" class="border-bottom p-3" style="min-width: 130px;">Rate</th>
                                            <th scope="col" class="border-bottom p-3" style="min-width: 130px;">Total</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row" class="text-start p-3">1</th>
                                            <td class="text-start p-3">Hospital Charges</td>
                                            <td class="text-center p-3">1</td>
                                            <td class="p-3">$ 125</td>
                                            <td class="p-3">$ 125</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" class="text-start p-3">2</th>
                                            <td class="text-start p-3">Medicine</td>
                                            <td class="text-center p-3">1</td>
                                            <td class="p-3">$ 245</td>
                                            <td class="p-3">$ 245</td>
                                        </tr>
                                        <tr>
                                            <th scope="row" class="text-start p-3">3</th>
                                            <td class="text-start p-3">Special Visit Fee(Doctor)</td>
                                            <td class="text-center p-3">1</td>
                                            <td class="p-3">$ 150</td>
                                            <td class="p-3">$ 150</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="row">
                                <div class="col-lg-4 col-md-5 ms-auto">
                                    <ul class="list-unstyled h6 fw-normal mt-4 mb-0 ms-md-5 ms-lg-4">
                                        <li class="text-muted d-flex justify-content-between pe-3">Subtotal :<span>$ 520</span></li>
                                        <li class="text-muted d-flex justify-content-between pe-3">Taxes :<span> 0</span></li>
                                        <li class="d-flex justify-content-between pe-3">Total :<span>$ 520</span></li>
                                    </ul>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>

                        <div class="border-top pt-4">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="text-sm-start text-muted text-center">
                                        <small class="mb-0">Customer Services : <a href="tel:+152534-468-854" class="text-warning">(+12) 1546-456-856</a></small>
                                    </div>
                                </div><!--end col-->

                                <div class="col-sm-6">
                                    <div class="text-sm-end text-muted text-center">
                                        <small class="mb-0"><a href="#" class="text-primary">Terms & Conditions</a></small>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div>

                    <!-- <div class="text-end mt-4 pt-2">
                        <a href="javascript:window.print()" class="btn btn-soft-primary d-print-none"><i class="uil uil-print"></i> Print</a>
                    </div> -->
                </div>
            </div>
        </div>
    </div>
    <!-- View Invoice End -->

    <!-- javascript -->
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <!-- Select2 -->
    <script src="assets/js/select2.min.js"></script>
    <script src="assets/js/select2.init.js"></script>
    <!-- Datepicker -->
    <script src="assets/js/flatpickr.min.js"></script>
    <script src="assets/js/flatpickr.init.js"></script>
    <!-- Datepicker -->
    <script src="assets/js/jquery.timepicker.min.js"></script> 
    <script src="assets/js/timepicker.init.js"></script>
    <!-- Icons -->
    <script src="assets/js/feather.min.js"></script>
    <!-- Main Js -->
    <script src="assets/js/app.js"></script>

    <script>
                                    document.getElementById('profileImage').addEventListener('change', function () {
                                        if (this.files && this.files[0]) {
                                            // Show loading indicator or preview if needed
                                            document.getElementById('avatarUploadForm').submit();
                                        }
                                    });
    </script>

    <script>
        document.getElementById('profileImage').addEventListener('change', function () {
            const file = this.files[0];
            const errorElement = document.getElementById('uploadError');
            const avatarPreview = document.getElementById('avatarPreview');
            errorElement.style.display = 'none';

            // Reset error message
            errorElement.textContent = '';

            if (!file) {
                return;
            }

            // Check file type
            const validTypes = ['image/jpeg', 'image/png'];
            if (!validTypes.includes(file.type)) {
                errorElement.textContent = 'Chỉ chấp nhận file JPG hoặc PNG';
                errorElement.style.display = 'block';
                this.value = '';
                return;
            }

            // Check file size (max 5MB)
            const maxSize = 5 * 1024 * 1024; // 5MB in bytes
            if (file.size > maxSize) {
                errorElement.textContent = 'Kích thước ảnh không được vượt quá 5MB';
                errorElement.style.display = 'block';
                this.value = '';
                return;
            }

            // Check image dimensions
            const img = new Image();
            img.onload = function () {
                URL.revokeObjectURL(img.src); // Clean up

                if (img.width < 256 || img.height < 256) {
                    errorElement.textContent = 'Ảnh phải có kích thước tối thiểu 256px x 256px';
                    errorElement.style.display = 'block';
                    document.getElementById('profileImage').value = '';
                    return;
                }

                // All validations passed, submit the form
                document.getElementById('avatarUploadForm').submit();
            };

            img.onerror = function () {
                URL.revokeObjectURL(img.src); // Clean up
                errorElement.textContent = 'Không thể đọc file ảnh, vui lòng thử lại';
                errorElement.style.display = 'block';
                document.getElementById('profileImage').value = '';
            };

            // Show image preview before upload
            const reader = new FileReader();
            reader.onload = function (e) {
                avatarPreview.src = e.target.result;
            };
            reader.readAsDataURL(file);

            // Load image to check dimensions
            img.src = URL.createObjectURL(file);
        });
    </script>
    <script>
        function resetForm() {
            window.location.href = './listAppointments?search=&gender=&status=all&sort=asc&pageSize=2';
        }
    </script>

</body>

</html>
