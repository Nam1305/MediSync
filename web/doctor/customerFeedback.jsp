<%-- 
    Document   : customerFeedback
    Created on : Mar 3, 2025, 4:21:44 PM
    Author     : DIEN MAY XANH
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Feedback</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/fullcalendar.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
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
                        <!-- Nội dung ban đầu -->

                        <!-- Bắt đầu: Lọc theo số sao -->
                        <div class="mb-4">
                            <label for="starFilter" class="form-label">Lọc theo số sao:</label>
                            <select class="form-select" id="starFilter" name="starFilter">
                                <option value="all">Tất cả</option>
                                <option value="5">5 sao</option>
                                <option value="4">4 sao</option>
                                <option value="3">3 sao</option>
                                <option value="2">2 sao</option>
                                <option value="1">1 sao</option>
                            </select>
                        </div>
                        <!-- Kết thúc: Lọc theo số sao -->

                        <!-- Bắt đầu: Feedback Section -->
                        <h5 class="mb-0">Patients Review</h5>
                        <div class="row">
                            <div class="col-xl-3 col-lg-5 col-md-5 col-12 mt-4 pt-2">
                                <div class="card p-4 border-0 shadow rounded">
                                    <div>
                                        <span class="text-primary h1 mb-0"><span class="fw-bold">4.9</span></span>
                                        <span class="h6 align-self-end ms-2">Avg. Ratings..</span>
                                    </div>

                                    <div class="mt-4">
                                        <div class="progress-box">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Very satisfied</h6>
                                                <div class="progress-value d-block text-muted h6">5 Star</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width:70%;">
                                                </div>
                                            </div>
                                        </div><!--end process box-->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Satisfied</h6>
                                                <div class="progress-value d-block text-muted h6">4 Star</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width:10%;">
                                                </div>
                                            </div>
                                        </div><!--end process box-->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Neutral</h6>
                                                <div class="progress-value d-block text-muted h6">3 Star</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width:10%;">
                                                </div>
                                            </div>
                                        </div><!--end process box-->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Dissatisfied</h6>
                                                <div class="progress-value d-block text-muted h6">2 Star</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width:5%;">
                                                </div>
                                            </div>
                                        </div><!--end process box-->
                                        <div class="progress-box mt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="title text-muted">Very Dissatisfied</h6>
                                                <div class="progress-value d-block text-muted h6">1 Star</div>
                                            </div>
                                            <div class="progress">
                                                <div class="progress-bar position-relative bg-primary" style="width:5%;">
                                                </div>
                                            </div>
                                        </div><!--end process box-->
                                    </div>
                                </div>
                            </div><!--end col-->

                            <div class="col-xl-9 col-lg-7 col-md-7 col-12 mt-4 pt-2">
                                <div class="card p-4 rounded shadow border-0">
                                    <div class="row">
                                        <c:forEach items="listFeedback" var="o" >
                                            <tr>
                                                <td>${o.content}</td>
                                            </tr>
                                        </c:forEach>

                                        <!-- Các review khác có thể được lặp tương tự -->
                                    </div>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                        <!-- Kết thúc: Feedback Section -->

                        <!-- Bắt đầu: Phân trang -->
                        <nav aria-label="Page navigation example" class="mt-4">
                            <ul class="pagination justify-content-end">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                                </li>
                                <li class="page-item"><a class="page-link" href="#">1</a></li>
                                <li class="page-item active"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                        <!-- Kết thúc: Phân trang -->

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
