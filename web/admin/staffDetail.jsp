<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Detail</title>
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
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Thông tin chi tiết nhân viên</h2>
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
                        <p><strong>Ngày sinh:</strong> <span id="profileDob" class="text-muted">${staff.dateOfBirth}</span></p>
                        <p><strong>Rating</strong> <span id="profileRating" class="text-muted">${rating}</span></p>
                    </div>
                </div>
                <p><strong>Mô tả:</strong> <span id="profileDescription" class="text-muted">${staff.description}</span></p>
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

            <a href="ListDoctor" class="btn btn-secondary">Back to Staff List</a>
        </div>
    </body>
</html>
