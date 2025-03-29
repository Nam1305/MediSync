<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết nhân viên</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <style>
            .review-header {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                margin-bottom: 20px;
                gap: 15px;
            }
            .review-score {
                display: flex;
                flex-direction: column;
                align-items: center;
                margin-left: 10px;
            }
            .score-number {
                font-size: 24px;
                font-weight: bold;
            }
            .score-text {
                font-size: 14px;
            }
            .stars {
                font-size: 20px;
                color: #FFD700;
                margin-left: 10px;
            }
            .filter-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
                width: 100%;
            }
            .filter-button, .sort-button {
                padding: 6px 12px;
                border-radius: 20px;
                text-decoration: none;
                color: #28a745;
                background-color: #f0f0f0;
                font-size: 14px;
            }
            .filter-button.active, .sort-button.active {
                background-color: #28a745;
                color: white;
            }
            .sort-options {
                margin-top: 10px;
                width: 100%;
            }
            .empty-message {
                padding: 20px;
                text-align: center;
                background-color: #f8f9fa;
                border-radius: 5px;
                margin-top: 20px;
            }
            .user-stars {
                color: #FFD700;
            }
            .avatar {
                width: 50px;
                height: 50px;
                object-fit: cover;
            }
            .feedback-section {
                margin-top: 30px;
            }
            /* Thêm padding-top cho main content để tránh bị navbar che mất */
            main.page-content {
                padding-top: 80px; /* Điều chỉnh giá trị này tùy theo chiều cao của navbar */
            }
            /* Thêm margin-top cho container đầu tiên để tạo khoảng cách */
            .staff-detail-container {
                margin-top: 2rem;
            }
            /* Điều chỉnh lại phần tiêu đề */
            .page-title {
                margin-bottom: 1.5rem;
            }
            /* Thêm margin-bottom cho footer */
            .pagination {
                margin-bottom: 2rem;
                display: flex;
                justify-content: center;
                margin-top: 1.5rem;
            }
            .pagination a {
                color: #28a745;
                padding: 8px 16px;
                text-decoration: none;
                border: 1px solid #ddd;
                margin: 0 4px;
            }
            .pagination a.active {
                background-color: #28a745;
                color: white;
                border: 1px solid #28a745;
            }
            .pagination a:hover:not(.active) {
                background-color: #f1f1f1;
            }
            /* Thêm button style */
            .btn-back {
                margin-top: 1.5rem;
                margin-bottom: 2rem;
            }
        </style>
    </head>
    <body>

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../layout/navbar.jsp" />


            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../layout/header.jsp" />

                <div class="container staff-detail-container">
                    <h2 class="text-center page-title">Thông tin chi tiết nhân viên</h2>
                    <div class="card mt-4 p-4">
                        <div class="d-flex align-items-center">
                            <img id="profileAvatar" src="${staff.avatar}" class="avatar avatar-small rounded-pill" alt="">

                            <h5 class="mb-0 ms-3" id="profileName">${staff.name}</h5>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <p><strong>Giới tính:</strong> 
                                    <span id="profileGender" class="text-muted">
                                        <c:choose>
                                            <c:when test="${staff.gender.trim() == 'M'}">Nam</c:when>
                                            <c:when test="${staff.gender.trim() == 'F'}">Nữ</c:when>
                                            <c:otherwise>Khác</c:otherwise>
                                        </c:choose>
                                    </span>
                                </p>
                                <p><strong>Chức vụ:</strong> <span id="profilePosition" class="text-muted">${staff.position}</span></p>
                                <p><strong>Phòng ban:</strong> <span id="profileDepartment" class="text-muted">${staff.department.departmentName}</span></p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Số điện thoại:</strong> <span id="profilePhone" class="text-muted">${staff.phone}</span></p>
                                <p><strong>Ngày sinh:</strong> <span id="profileDob" class="text-muted"> <fmt:formatDate value="${staff.dateOfBirth}" pattern="dd/MM/yyyy"/></span></p>
                                <p><strong>Rating:</strong> <span id="profileRating" class="text-muted">${rating}</span></p>
                            </div>
                        </div>
                        <p><strong>Mô tả:</strong> <span id="profileDescription" class="text-muted">${staff.description}</span></p>
                    </div>

                    <div class="card mt-4 p-4 position-history-section">
                        <h3 class="mb-4">Lịch Sử Thăng Tiến</h3>

                        <c:choose>
                            <c:when test="${not empty positionHistories}">
                                <table class="table position-history-table">
                                    <thead>
                                        <tr>
                                            <th>Vị Trí</th>
                                            <th>Ngày Bắt Đầu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${positionHistories}" var="history">
                                            <tr>
                                                <td>${history.position}</td>
                                                <td>
                                                    <fmt:formatDate value="${history.date}" pattern="dd/MM/yyyy"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info text-center">
                                    Không có thông tin lịch sử thăng tiến cho nhân viên này.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>


                    <div class="card mt-4 p-4 feedback-section">
                        <h3 class="mb-4">Đánh giá từ khách hàng</h3>

                        <div class="review-header">

                            <div class="filter-buttons">
                                <a href="ViewStaffDetail?id=${staff.staffId}" class="filter-button ${star == 0 && !hasComment ? 'active' : ''}">Tất Cả (${commentCount})</a>
                                <a href="ViewStaffDetail?id=${staff.staffId}&star=5" class="filter-button ${star == 5 ? 'active' : ''}">5 Sao (${ratingStats[2]})</a>
                                <a href="ViewStaffDetail?id=${staff.staffId}&star=4" class="filter-button ${star == 4 ? 'active' : ''}">4 Sao (${ratingStats[4]})</a>
                                <a href="ViewStaffDetail?id=${staff.staffId}&star=3" class="filter-button ${star == 3 ? 'active' : ''}">3 Sao (${ratingStats[6]})</a>
                                <a href="ViewStaffDetail?id=${staff.staffId}&star=2" class="filter-button ${star == 2 ? 'active' : ''}">2 Sao (${ratingStats[8]})</a>
                                <a href="ViewStaffDetail?id=${staff.staffId}&star=1" class="filter-button ${star == 1 ? 'active' : ''}">1 Sao (${ratingStats[10]})</a>
                            </div>

                            <div class="sort-options">
                                <a href="ViewStaffDetail?staffId=${staff.staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=desc" class="sort-button ${param.sort == 'desc' || param.sort == null ? 'active' : ''}">Mới nhất</a> | 
                                <a href="ViewStaffDetail?staffId=${staff.staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=asc" class="sort-button ${param.sort == 'asc' ? 'active' : ''}">Cũ nhất</a>
                            </div>
                        </div>

                        <c:choose>
                            <c:when test="${empty feedbacks}">
                                <div class="empty-message">
                                    <p>Không có đánh giá nào phù hợp với tiêu chí tìm kiếm.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="feedback-list">
                                    <ul class="list-unstyled">
                                        <li class="mt-4">
                                            <ul>
                                                <c:forEach items="${feedbacks}" var="feedback" varStatus="status">
                                                    <li class="mt-4">
                                                        <div class="d-flex justify-content-between">
                                                            <div class="d-flex align-items-center">
                                                                <a class="pe-3" href="#">
                                                                    <img src="${feedback.customer.avatar}" class="img-fluid avatar rounded-circle shadow" alt="Avatar">
                                                                </a>
                                                                <div class="commentor-detail">
                                                                    <h6 class="mb-0">
                                                                        <a href="javascript:void(0)" class="text-dark media-heading">${feedback.customer.name}</a>
                                                                    </h6>
                                                                    <small class="text-muted">
                                                                        <fmt:formatDate value="${feedback.date}" pattern="dd/MM/yyyy"/>
                                                                    </small>
                                                                    <!-- Display star rating -->
                                                                    <div class="user-stars mt-1">
                                                                        <c:forEach begin="1" end="5" var="i">
                                                                            <c:choose>
                                                                                <c:when test="${i <= feedback.ratings}">★</c:when>
                                                                                <c:otherwise>☆</c:otherwise>
                                                                            </c:choose>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="mt-3">
                                                            <c:if test="${not empty feedback.content}">
                                                                <p class="text-muted font-italic p-3 bg-light rounded">"${feedback.content}"</p>
                                                            </c:if>
                                                            <c:if test="${empty feedback.content}">
                                                                <p class="text-muted font-italic p-3 bg-light rounded fst-italic"><i>Bệnh nhân không để lại bình luận</i></p>
                                                            </c:if>
                                                        </div>
                                                        <!-- Add a divider between comments except for the last one -->
                                                        <c:if test="${!status.last}">
                                                            <hr class="my-4">
                                                        </c:if>
                                                    </c:forEach>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <c:if test="${currentPage > 1}">
                                <a href="ViewStaffDetail?id=${staff.staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=${param.sort}&page=${currentPage - 1}">&laquo;</a>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <a class="active" href="#">${i}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="ViewStaffDetail?id=${staff.staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=${param.sort}&page=${i}">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a href="ViewStaffDetail?id=${staff.staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=${param.sort}&page=${currentPage + 1}">&raquo;</a>
                            </c:if>
                        </div>
                    </c:if>      

                    <a href="ListDoctor" class="btn btn-secondary btn-back">Quay về Danh sách nhân viên</a>
                </div>

                <jsp:include page="../layout/footer.jsp" />

            </main>
            <!--End page-content" -->
        </div>

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
                                    <li class="d-grid"><a href="javascript:void(0)" class="rtl-version t-rtl-light" onclick="setTheme('style-rtl')"><img src="assets/images/layouts/light-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="ltr-version t-ltr-light" onclick="setTheme('style')"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-rtl-version t-rtl-dark" onclick="setTheme('style-dark-rtl')"><img src="assets/images/layouts/dark-dash-rtl.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">RTL Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-ltr-version t-ltr-dark" onclick="setTheme('style-dark')"><img src="assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">LTR Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="dark-version t-dark mt-4" onclick="setTheme('style-dark')"><img src="assets/images/layouts/dark-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Dark Version</span></a></li>
                                    <li class="d-grid"><a href="javascript:void(0)" class="light-version t-light mt-4" onclick="setTheme('style')"><img src="assets/images/layouts/light-dash.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Light Version</span></a></li>
                                    <li class="d-grid"><a href="landing/index.html" target="_blank" class="mt-4"><img src="assets/images/layouts/landing-light.png" class="img-fluid rounded-md shadow-md d-block" alt=""><span class="text-muted mt-2 d-block">Landing Demos</span></a></li>
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

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

    </body>
</html>