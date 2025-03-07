<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Feedback</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- CSS dependencies -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <!-- JS dependencies -->
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
                font-size: 16px; /* tăng font size lên 16px */
                color: #333;
                margin-top: 10px;
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
                                    <div>
                                        <span class="text-primary h1 mb-0">
                                            <span class="fw-bold">${feedbackStar[0]}</span>
                                        </span>
                                        <span class="h6 align-self-end ms-2">Trung bình</span>
                                    </div>
                                    <div class="mt-4">
                                        <!-- 5 sao -->
                                        <div class="progress-box">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Rất hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">5 Sao</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[1]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 4 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">4 Sao</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[2]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 3 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Bình thường</h6>
                                                <div class="progress-value d-block text-muted h6">3 Sao</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[3]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 2 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Không hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">2 Sao</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[4]}%;"></div>
                                            </div>
                                        </div>
                                        <!-- 1 sao -->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Rất không hài lòng</h6>
                                                <div class="progress-value d-block text-muted h6">1 Sao</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width: ${feedbackStar[5]}%;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Left Column -->

                            <!-- Right Column: Danh sách Feedback -->
                            <div class="col-xl-9 col-lg-7 col-md-7 col-12 mt-4 pt-2">
                                <!-- Bộ lọc -->
                                <div class="card p-3 shadow-sm mb-4">
                                    <form action="mfeedback" method="GET" class="d-flex align-items-center gap-3">
                                        <!-- Lọc theo số sao -->
                                        <select class="form-select" name="starFilter" onchange="this.form.submit()">
                                            <option value="0" ${param.starFilter == null || param.starFilter == '0' ? 'selected' : ''}>Tất cả</option>
                                            <c:forEach var="i" begin="1" end="5">
                                                <option value="${i}" ${param.starFilter == i ? 'selected' : ''}>${i} sao</option>
                                            </c:forEach>
                                        </select>

                                        <!-- Chọn số bản ghi trên mỗi trang -->
                                        <input type="number" name="pageSize" min="1" step="1" 
                                               value="${param.pageSize != null ? param.pageSize : 5}" 
                                               class="form-control" style="width: 100px;" onchange="this.form.submit()">

                                        <!-- Sắp xếp theo thời gian -->
                                        <select class="form-select" name="sortOrder" onchange="this.form.submit()">
                                            <option value="desc" ${param.sortOrder == 'desc' ? 'selected' : ''}>Mới nhất</option>
                                            <option value="asc" ${param.sortOrder == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                                        </select>
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
                                                            <span><fmt:formatDate value="${f.date}" pattern="dd/MM/yyyy" /></span>
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
                                                <!-- Divider giữa header và nội dung feedback -->
                                                <hr class="feedback-divider" />
                                                <!-- Nội dung feedback -->
                                                <div class="feedback-content">
                                                    ${f.content}
                                                </div>
                                            </div>
                                        </c:forEach>


                                    </div>
                                </div>
                            </div>
                            <!-- End Right Column -->
                        </div>
                        <!-- Phân trang -->
                        <div class="col-12" style="margin-top: 1%;">
                            <div class="d-md-flex align-items-center justify-content-end">
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="mfeedback?page=${currentPage - 1}&pageSize=${pageSize}&starFilter=${starFilter}&sortOrder=${sortOrder}">Trước</a>
                                        </li>
                                    </c:if>
                                    <c:forEach begin="1" end="${totalPages}" var="p">
                                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="mfeedback?page=${p}&pageSize=${pageSize}&starFilter=${starFilter}&sortOrder=${sortOrder}">${p}</a>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="mfeedback?page=${currentPage + 1}&pageSize=${pageSize}&starFilter=${starFilter}&sortOrder=${sortOrder}">Sau</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div><!-- end container -->
                <jsp:include page="footer.jsp" />
            </main>
        </div>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
