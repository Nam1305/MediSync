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
                        <!-- Filter Section: Lọc theo số sao -->
                        <div class="mb-4">
                            <select class="form-select" id="starFilter" name="starFilter">
                                <option value="all">Tất cả</option>
                                <option value="5">5 sao</option>
                                <option value="4">4 sao</option>
                                <option value="3">3 sao</option>
                                <option value="2">2 sao</option>
                                <option value="1">1 sao</option>
                            </select>
                        </div>
                        <!-- End Filter Section -->

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
                                <div class="card p-4 rounded shadow border-0">
                                    <div class="row">
                                        <c:if test="${empty listFeedback}">
                                            <p class="text-danger">Không có phản hồi nào!</p>
                                        </c:if>
                                        <c:forEach items="${listFeedback}" var="f">
                                            <div class="col-xl-4 col-md-6 mb-4">
                                                <div class="text-center">
                                                    <img src="${f.customer.avatar}" class="img-fluid avatar avatar-small rounded-circle mx-auto shadow" alt="Avatar">
                                                    <h6 class="text-primary mt-3">${f.customer.name}</h6>
                                                    <p class="text-muted h6 fw-normal fst-italic">"${f.content}"</p>
                                                    <ul class="list-unstyled d-inline-flex mb-0">
                                                        <c:forEach begin="1" end="${f.ratings}" var="i">
                                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                                            </c:forEach>
                                                    </ul>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <!-- End Right Column -->
                        </div>

                        <!-- Pagination --> 
                        <nav aria-label="Page navigation example" class="mt-4">
                            <ul class="pagination justify-content-end">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Trước</a>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item active"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Sau</a>
                                </li>
                            </ul>
                        </nav>
                        <!-- End Pagination -->
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
