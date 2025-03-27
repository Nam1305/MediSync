<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Phản hồi từ bệnh nhân</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- CSS dependencies -->
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->       

        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <style>
            .feedback-card {
                display: block;
                width: 100%;
                margin-bottom: 20px;
                box-sizing: border-box;
                padding: 15px;
                border-radius: 10px;
                background: #fff;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            .feedback-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 10px;
            }
            .feedback-header-left {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .feedback-avatar img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
            }
            .feedback-info {
                display: flex;
                flex-direction: column;
            }
            .feedback-info h4 {
                margin: 0;
                font-size: 16px;
            }
            .feedback-info span {
                font-size: 14px;
                color: #666;
            }
            .feedback-stars {
                display: flex;
                gap: 3px;
            }
            .feedback-stars i {
                color: gold;
            }
            .feedback-divider {
                border: none;
                border-top: 1px solid #ddd;
                margin: 10px 0;
            }
            .feedback-content {
                font-size: 16px;
                color: #333;
                margin-top: 10px;
            }
            .feedback-summary {
                background-color: #f9f9f9;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 15px;
                max-width: 400px;
                margin: 20px auto;
            }
            .total-feedback {
                font-size: 18px;
                margin-bottom: 10px;
            }
            .feedback-line {
                margin: 0;
                font-size: 14px;
                line-height: 1.6;
            }
            .feedback-label {
                font-weight: 600;
                color: #555;
            }
            .filter-container {
                display: flex;
                flex-direction: column;
                gap: 15px;
                align-items: center;
            }
            .rating-container {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                justify-content: center;
            }
            .rating-box {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 80px;       /* giảm kích thước để tiết kiệm không gian */
                height: 40px;
                border: 2px solid #ddd;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s;
                background-color: #f8f9fa;
                font-size: 14px;
            }
            .rating-box:hover {
                border-color: #007bff;
                background-color: #e9f5ff;
            }
            .rating-box input {
                display: none;
            }
            .rating-box.active {
                border-color: #28a745;
                background-color: #d4edda;
                color: #155724;
            }
            .rating-box i {
                font-size: 1rem; /* icon nhỏ hơn */
            }
            .other-filters {
                display: flex;
                gap: 20px;
                align-items: center;
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

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row" style="margin-top: -3%;">
                            <!-- Left Column: Thống kê đánh giá -->
                            <div class="col-xl-3 col-lg-5 col-md-5 col-12 mt-4 pt-2">
                                <div class="card p-4 border-0 shadow rounded">
                                    <div class="d-flex align-items-center">
                                        <span class="h2 text-primary fw-bold">${feedbackStar[0]}</span>
                                        <span class="h4 ms-2 text-muted">/ 5</span>
                                    </div>

                                    <div class="mt-4">
                                        <!-- 5 sao -->
                                        <!-- 5 sao -->
                                        <div class="progress-box">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Rất hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">
                                                    5 Sao (<fmt:formatNumber value="${feedbackStar[2]}" maxFractionDigits="0" />)
                                                </div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[1]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 4 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">
                                                    4 Sao (<fmt:formatNumber value="${feedbackStar[4]}" maxFractionDigits="0" />)
                                                </div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[3]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 3 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Bình thường</h6>
                                                <div class="progress-value d-block text-muted h6">
                                                    3 Sao (<fmt:formatNumber value="${feedbackStar[6]}" maxFractionDigits="0" />)
                                                </div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[5]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 2 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Không hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">
                                                    2 Sao (<fmt:formatNumber value="${feedbackStar[8]}" maxFractionDigits="0" />)
                                                </div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[7]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 1 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Rất không hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">
                                                    1 Sao (<fmt:formatNumber value="${feedbackStar[10]}" maxFractionDigits="0" />)
                                                </div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[9]}%;"></div>
                                            </div>
                                        </div>

                                        <!-- Thống kê phản hồi -->
                                        <div class="feedback-summary mt-4">
                                            <h5 class="mb-3 total-feedback">
                                                Tổng số phản hồi: <span class="fw-bold"><fmt:formatNumber value="${statistic[0]}" maxFractionDigits="0" /></span>
                                            </h5>      
                                            <p class="feedback-line">
                                                <span class="feedback-label">Tích cực(3->5):</span>
                                                <span style="                font-size: 16px;
                                                      font-weight: bold;
                                                      color: #28a745;
                                                      margin-left: 5px;">${statistic[2]}%</span>
                                            </p>
                                            <p class="feedback-line">
                                                <span class="feedback-label">Tiêu cực(1, 2):</span>
                                                <span style="                font-size: 16px;
                                                      font-weight: bold;
                                                      color: red;
                                                      margin-left: 5px;">${statistic[1]}%</span>
                                            </p>

                                        </div>


                                    </div>
                                </div>
                            </div>
                            <!-- End Left Column -->

                            <!-- Right Column: Danh sách Feedback -->
                            <div class="col-xl-9 col-lg-7 col-md-7 col-12 mt-4 pt-2">
                                <!-- Bộ lọc -->
                                <div class="card p-3 shadow-sm mb-4">
                                    <form action="mfeedback" method="GET" id="filterForm" class="filter-container" onchange="this.submit()">
                                        <!-- Rating Filter: Hiển thị các ô đánh giá -->
                                        <div class="rating-container">
                                            <!-- Lựa chọn từ 1 đến 5 sao: hiển thị số và một icon sao -->
                                            <c:forEach var="i" begin="1" end="5">
                                                <label class="rating-box">
                                                    <input type="radio" name="starFilter" value="${i}" ${param.starFilter == i ? 'checked' : ''}>
                                                    ${i} <i class="fas fa-star text-success"></i>
                                                </label>
                                            </c:forEach>
                                            <!-- Lựa chọn Tiêu cực: value = 6 -->
                                            <label class="rating-box">
                                                <input type="radio" name="starFilter" value="6" ${param.starFilter == '6' ? 'checked' : ''}>
                                                Tiêu cực
                                            </label>
                                            <!-- Lựa chọn Tích cực: value = 7 -->
                                            <label class="rating-box">
                                                <input type="radio" name="starFilter" value="7" ${param.starFilter == '7' ? 'checked' : ''}>
                                                Tích cực
                                            </label>
                                            <!-- Lựa chọn Tất cả: value = 0 -->
                                            <label class="rating-box">
                                                <input type="radio" name="starFilter" value="0" ${param.starFilter == null || param.starFilter == '0' ? 'checked' : ''}>
                                                Tất cả
                                            </label>
                                        </div>
                                        <!-- Other Filters: Số bản ghi & Sắp xếp -->
                                        <div class="other-filters">
                                            <div class="d-flex align-items-center">
                                                <label class="fw-bold me-2">Số bản ghi:</label>
                                                <input type="number" name="pageSize" id="pageSizeInput" min="1" step="1"
                                                       value="${empty param.pageSize ? 5 : param.pageSize}"
                                                       class="form-control" style="width: 80px;" placeholder="Bản ghi">
                                            </div>
                                            <div class="d-flex align-items-center">
                                                <label class="fw-bold me-2">Sắp xếp:</label>
                                                <select class="form-select" name="sortOrder" style="width: 120px;">
                                                    <option value="desc" ${param.sortOrder=='desc' ? 'selected' : ''}>Mới nhất</option>
                                                    <option value="asc" ${param.sortOrder=='asc' ? 'selected' : ''}>Cũ nhất</option>
                                                </select>
                                            </div>
                                        </div>
                                    </form>

                                </div>
                                <div class="card p-4 rounded shadow border-0">
                                    <div class="feedback-container">
                                        <c:if test="${empty feedbackList}">
                                            <p class="text-danger">Không có phản hồi nào!</p>
                                        </c:if>
                                        <c:forEach var="f" items="${feedbackList}">
                                            <div class="feedback-card">
                                                <!-- Header: Avatar + Thông tin bên trái, Sao bên phải -->
                                                <div class="feedback-header">
                                                    <div class="feedback-header-left">
                                                        <div class="feedback-avatar">
                                                            <img src="${f.customer.avatar}" alt="Avatar">
                                                        </div>
                                                        <div class="feedback-info">
                                                            <h4>${f.customer.name}</h4>
                                                            <span>
                                                                <fmt:formatDate value="${f.date}" pattern="dd/MM/yyyy" />
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="feedback-stars">
                                                        <ul class="list-unstyled d-inline-flex mb-0">
                                                            <c:forEach begin="1" end="${f.ratings}" var="i">
                                                                <li class="list-inline-item">
                                                                    <i class="mdi mdi-star text-warning"></i>
                                                                </li>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <hr class="feedback-divider" />
                                                <div class="feedback-content">
                                                    ${f.content}
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <!-- Phân trang -->
                                <div class="col-12" style="margin-top: 1%;">
                                    <div class="d-md-flex align-items-center justify-content-end">
                                        <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                            <c:if test="${currentPage > 1}">
                                                <li class="page-item">
                                                    <a class="page-link" href="mfeedback?page=${currentPage - 1}&pageSize=${pageSize}&starFilter=${param.starFilter}&sortOrder=${param.sortOrder}">Trước</a>
                                                </li>
                                            </c:if>
                                            <c:forEach begin="1" end="${totalPages}" var="p">
                                                <li class="page-item ${p == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="mfeedback?page=${p}&pageSize=${pageSize}&starFilter=${param.starFilter}&sortOrder=${param.sortOrder}">${p}</a>
                                                </li>
                                            </c:forEach>
                                            <c:if test="${currentPage < totalPages}">
                                                <li class="page-item">
                                                    <a class="page-link" href="mfeedback?page=${currentPage + 1}&pageSize=${pageSize}&starFilter=${param.starFilter}&sortOrder=${param.sortOrder}">Sau</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <!-- End Right Column -->
                        </div>

                    </div>
                </div><!-- end container -->
                <jsp:include page="footer.jsp" />
            </main>
        </div>
        <script>
            // Xử lý active state cho rating-box khi click
            document.querySelectorAll(".rating-box").forEach(box => {
                box.addEventListener("click", function () {
                    document.querySelectorAll(".rating-box").forEach(b => b.classList.remove("active"));
                    this.classList.add("active");
                });
            });
            // Khi trang load, nếu có input đã được chọn, thêm active cho thẻ chứa
            document.querySelectorAll('input[name="starFilter"]:checked').forEach(input => {
                input.parentElement.classList.add("active");
            });
        </script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
