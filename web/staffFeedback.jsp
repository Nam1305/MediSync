<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Đánh giá bác sĩ</title>
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            body {
                font-family: Arial, sans-serif;
                color: #333;
                margin: 0;
                padding: 0;
                background-color: #f9f9f9;
            }


            .position {
                color: #666;
                margin-bottom: 5px;
            }

            .review-header {
                border-bottom: 1px solid #eee;
                padding-bottom: 15px;
                margin-bottom: 20px;
            }

            .review-score {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }

            .score-number {
                font-size: 32px;
                color: #666;
                font-weight: bold;
                margin-right: 10px;
            }

            .score-text {
                font-size: 16px;
                color: #666;
            }

            .stars {
                color: #ffc107;
                font-size: 24px;
                margin-bottom: 15px;
            }

            .rating-bars {
                margin-bottom: 20px;
            }

            .rating-bar {
                display: flex;
                align-items: center;
                margin-bottom: 5px;
            }

            .rating-label {
                width: 50px;
                text-align: right;
                margin-right: 10px;
            }

            .bar-container {
                width: 60%;
                background-color: #f1f1f1;
                border-radius: 4px;
                height: 15px;
                margin-right: 10px;
            }

            .bar {
                height: 15px;
                background-color: #2c80b9;
                border-radius: 4px;
            }

            .rating-percent {
                width: 40px;
                font-size: 14px;
                margin-right: 8px;

            }

            .rating-count {
                width: 40px;
                font-size: 14px;
                color: #666;
            }

            .filter-buttons {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-bottom: 15px;
            }

            .filter-button {
                padding: 8px 15px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: #fff;
                cursor: pointer;
                font-size: 14px;
            }

            .filter-button.active {
                background-color: #28a745;
                color: white;
                border-color: #28a745;
            }

            .sort-options {
                margin-bottom: 20px;
                display: flex;
                justify-content: flex-end;
            }

            .sort-button {
                padding: 5px 10px;
                border: none;
                background: none;
                cursor: pointer;
                color: #28a745;
                font-size: 14px;
            }

            .sort-button.active {
                color: #28a745;
                font-weight: bold;
            }

            .user-review {
                padding: 15px 0;
                border-bottom: 1px solid #eee;
                display: flex;
            }

            .user-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                overflow: hidden;
                margin-right: 15px;
            }

            .user-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .review-content {
                flex: 1;
            }

            .user-name {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .user-stars {
                color: #ffc107;
                margin-bottom: 5px;
            }

            .review-date {
                color: #999;
                font-size: 14px;
                margin-bottom: 10px;
            }

            .review-text {
                margin-bottom: 10px;
                line-height: 1.5;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination a {
                color: #333;
                padding: 8px 12px;
                text-decoration: none;
                border: 1px solid #ddd;
                margin: 0 4px;
            }

            .pagination a.active {
                background-color: #28a745;
                color: white;
                border-color: #28a745;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
            }

            .feedback-stats {
                display: flex;
                justify-content: space-around;
                margin-bottom: 20px;
                text-align: center;
            }

            .stat-item {
                background-color: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
                min-width: 150px;
            }

            .stat-value {
                font-size: 24px;
                font-weight: bold;
                color: #2c80b9;
            }

            .stat-label {
                color: #666;
                font-size: 14px;
            }

            .empty-message {
                text-align: center;
                padding: 30px;
                color: #666;
            }
            /* Add these styles to your existing CSS */

            .feedback-list {
                margin-top: 20px;
            }

            .user-review {
                padding: 20px;
                border-bottom: 1px solid #eee;
                display: flex;
                margin-bottom: 15px;
                background-color: #f9f9f9;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .user-review:hover {
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .user-avatar {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                overflow: hidden;
                margin-right: 20px;
                border: 3px solid #fff;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            .user-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .filter-button {
                text-decoration: none;
            }

            .review-content {
                flex: 1;
            }

            .review-header-info {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                margin-bottom: 10px;
            }

            .user-name {
                font-weight: bold;
                font-size: 18px;
                margin-right: 15px;
                color: #2c80b9;
            }

            .user-stars {
                color: #ffc107;
                font-size: 18px;
                margin-right: 15px;
            }

            .review-date {
                color: #999;
                font-size: 14px;
            }

            .review-text {
                background-color: #fff;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 10px;
                line-height: 1.6;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
            }

            .review-text.no-comment {
                color: #999;
                font-style: italic;
                background-color: #f5f5f5;
            }

            .feedback-meta {
                display: flex;
                justify-content: space-between;
                font-size: 13px;
                color: #777;
                margin-top: 10px;
            }

            .feedback-id {
                background-color: #e9f7fe;
                padding: 3px 8px;
                border-radius: 4px;
                color: #2c80b9;
            }

            .feedback-encounter {
                background-color: #f0f0f0;
                padding: 3px 8px;
                border-radius: 4px;
            }

            /* Add a responsive adjustment for mobile */
            @media (max-width: 768px) {
                .user-review {
                    flex-direction: column;
                }

                .user-avatar {
                    margin-bottom: 15px;
                }

                .review-header-info {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .user-name, .user-stars, .review-date {
                    margin-bottom: 5px;
                }
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
        <jsp:include page="layout/header.jsp" /><!--end header-->
        <!-- Navbar End -->

        <div class="container">
            <div class="review-header">
                <h4>Đánh giá: </h4>
                <div class="review-score">
                    <div class="score-number">
                        <fmt:formatNumber value="${avgRating}" pattern="#.#" />
                    </div>
                    <div class="score-text">trên 5</div>
                </div>

                <div class="stars">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= Math.round(avgRating)}">★</c:when>
                            <c:otherwise>☆</c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>

                <div class="filter-buttons">
                    <a href="staffFeedback?staffId=${staffId}" class="filter-button ${star == 0 && !hasComment ? 'active' : ''}">Tất Cả (${commentCount})</a>
                    <a href="staffFeedback?staffId=${staffId}&star=5" class="filter-button ${star == 5 ? 'active' : ''}">5 Sao (${ratingStats[2]})</a>
                    <a href="staffFeedback?staffId=${staffId}&star=4" class="filter-button ${star == 4 ? 'active' : ''}">4 Sao (${ratingStats[4]})</a>
                    <a href="staffFeedback?staffId=${staffId}&star=3" class="filter-button ${star == 3 ? 'active' : ''}">3 Sao (${ratingStats[6]})</a>
                    <a href="staffFeedback?staffId=${staffId}&star=2" class="filter-button ${star == 2 ? 'active' : ''}">2 Sao (${ratingStats[8]})</a>
                    <a href="staffFeedback?staffId=${staffId}&star=1" class="filter-button ${star == 1 ? 'active' : ''}">1 Sao (${ratingStats[10]})</a>
                </div>

                <div class="sort-options">
                    <a href="staffFeedback?staffId=${staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=desc" class="sort-button ${param.sort == 'desc' || param.sort == null ? 'active' : ''}">Mới nhất</a> | 
                    <a href="staffFeedback?staffId=${staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=asc" class="sort-button ${param.sort == 'asc' ? 'active' : ''}">Cũ nhất</a>
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
                                                        <img src="${feedback.customer.avatar}" class="img-fluid avatar avatar-md-sm rounded-circle shadow" alt="Avatar">
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


            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="staffFeedback?staffId=${staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=${param.sort}&page=${currentPage - 1}">&laquo;</a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:choose>
                            <c:when test="${i == currentPage}">
                                <a class="active" href="#">${i}</a>
                            </c:when>
                            <c:otherwise>
                                <a href="staffFeedback?staffId=${staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=${param.sort}&page=${i}">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="staffFeedback?staffId=${staffId}&star=${star}${hasComment ? '&hasComment=true' : ''}&sort=${param.sort}&page=${currentPage + 1}">&raquo;</a>
                    </c:if>
                </div>
            </c:if>

            <div class="text-center mb-3">
                <a href="allDoctors" class="btn btn-primary">Quay về danh sách</a>
            </div>
        </div>

        <!-- Start Footer -->
        <jsp:include page="layout/customer-side-footer.jsp" />
        <!-- End Footer -->
        
                
        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <!-- Counter -->
        <script src="assets/js/counter.init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
        
    </body>
</html>