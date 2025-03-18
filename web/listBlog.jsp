<%-- 
    Document   : list-blog
    Created on : Feb 2, 2025, 7:25:11 PM
    Author     : Admin
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Home Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <style>
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            .pagination a {
                text-decoration: none;
                padding: 10px 15px;
                margin: 0 5px;
                border: 1px solid #ddd;
                border-radius: 5px;
                background-color: #f1f1f1;
                color: #333;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .pagination a:hover {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
            }

            .pagination a.active {
                background-color: #007bff;
                color: white;
                border-color: #007bff;
                font-weight: bold;
            }

            .pagination a:disabled {
                background-color: #ddd;
                color: #aaa;
                border-color: #ddd;
                pointer-events: none;
            }

            .pagination .prev, .pagination .next {
                font-weight: bold;
            }

            .pagination .prev:hover, .pagination .next:hover {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .pagination .prev, .pagination .next {
                font-size: 16px;
                padding: 10px 20px;
                border-radius: 25px;
            }

        </style>
    </head>

    <body>

        <!-- Start Page Content -->
        <jsp:include page="layout/header.jsp" />


        <!-- ListBlog -->
        <div class="container mt-100 mt-60">
            <div class="row justify-content-center">
                <div class="col-12 text-center">
                    <div class="section-title mb-4 pb-2">
                        <span class="badge badge-pill badge-soft-primary mb-3" style="font-size: 2rem; padding: 10px 20px;">Danh sách blog</span>
                    </div>
                </div>
            </div><!--end row-->

            <div class="row mb-4">
                <div class="col-md-6">
                    <form action="listBlog" method="get" class="d-flex">
                        <input type="hidden" name="page" value="${requestScope.currentPage != null ? requestScope.currentPage : 1}" />
                        <input type="text" name="search" class="form-control me-2" 
                               placeholder="Tìm kiếm blog..." value="${param.search}" style="max-width: 300px;">
                        <button type="submit" class="btn btn-success">Tìm</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <form action="listBlog" method="get" class="d-flex justify-content-end">
                        <input type="hidden" name="page" value="1" /> 
                        <input type="hidden" name="search" value="${param.search}" />

                        <!-- Sort dropdown -->
                        <label class="me-2 align-self-center fw-bold">Sắp xếp:</label>
                        <select name="sort" class="form-select me-2" style="max-width: 150px;">
                            <option value="desc" ${param.sort == 'desc' || param.sort == null ? 'selected' : ''}>Mới nhất</option>
                            <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                        </select>

                        <!-- Items per page input -->
                        <label class="me-2 align-self-center fw-bold">Số lượng:</label>
                        <input type="number" class="form-control me-2" name="itemsPerPage" min="1" max="${requestScope.totalBlogs}" 
                               value="${requestScope.itemsPerPage}" placeholder="Số lượng/trang" style="width: 100px;">

                        <!-- Submit button -->
                        <button type="submit" class="btn btn-primary">Lọc</button>
                    </form>
                </div>
            </div>



            <!-- list blog -->
            <div class="row">
                <c:forEach items="${listBlog}" var="blog">
                    <div class="col-xl-4 col-lg-4 col-md-4 col-12 mt-4 pt-2">
                        <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                            <div class="blog-image-container" style="height: 200px; overflow: hidden; position: relative;">
                                <img src="${blog.image}" class="img-fluid w-100" alt="${blog.blogName}" 
                                     style="object-fit: cover; height: 100%; width: 100%; position: absolute; top: 0; left: 0;">
                            </div>
                            <div class="card-body p-4">
                                <ul class="list-unstyled mb-2">
                                    <li class="list-inline-item text-muted small me-3">
                                        <i class="uil uil-calendar-alt text-dark h6 me-1"></i>
                                        <fmt:formatDate value="${blog.date}" pattern="dd/MM/yyyy"/>
                                    </li>
                                </ul>
                                <a href="blogDetail?blogId=${blog.blogId}" class="text-dark title h5">${blog.blogName}</a>
                                <div class="post-meta d-flex justify-content-between mt-3">
                                    <!--                                <ul class="list-unstyled mb-0">
                                                                        <li class="list-inline-item"><a href="#" class="text-muted comments"><i class="mdi mdi-comment-outline me-1"></i>3</a></li>
                                                                    </ul>-->
                                    <a href="blogDetail?blogId=${blog.blogId}" class="link">Chi Tiết<i class="mdi mdi-chevron-right align-middle"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- phan trang -->
            <div class="row text-center">
                <div class="col-12 mt-4">
                    <div class="d-md-flex align-items-center text-center justify-content-between">
                        <span class="text-muted me-3">Showing 1 - ${requestScope.itemsPerPage} out of ${requestScope.totalBlogs}</span>
                        <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="listBlog?page=${currentPage - 1}&search=${param.search}&sort=${param.sort}&itemsPerPage=${itemsPerPage}" aria-label="Previous">Trước</a>
                                </li>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="listBlog?page=${i}&search=${param.search}&sort=${param.sort}&itemsPerPage=${itemsPerPage}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="listBlog?page=${currentPage + 1}&search=${param.search}&sort=${param.sort}&itemsPerPage=${itemsPerPage}" aria-label="Next">Sau</a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div><!--end col-->
            </div><!--end pagination-->
        </div><!--end container-->

        <!-- End -->

        <!-- Footer Start -->
        <jsp:include page="layout/customer-side-footer.jsp" />
        <!-- End -->


        <!-- Start -->
        <!--    <footer class="bg-footer" style="margin-top: 5%;">
                <div class="container">
                    <div class="row">
                        <div class="col-md-6 mb-4">
                            <p>Đội ngũ bác sĩ xuất sắc sẵn sàng cung cấp sự hỗ trợ kịp thời, điều trị khẩn cấp và tư vấn chuyên sâu cho gia đình bạn.</p>
        
                            <div class="mt-4">
                                <h5 class="text-light title-dark footer-head">Địa chỉ</h5>
                                <div id="google-map" style="height: 200px; width: 100%; overflow: hidden;">
                                     Nhúng Google Map tại đây 
                                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d33006.67071116369!2d105.51462100371513!3d21.005883448895787!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e1!3m2!1svi!2s!4v1737175663000!5m2!1svi!2s" 
                                            width="100%" height="200" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                                </div>
                            </div>
                        </div>end col
        
                        <div class="col-md-6">
                            <h5 class="text-light title-dark footer-head">Liên hệ với chúng tôi</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li class="d-flex align-items-center">
                                    <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="mailto:contact@fpt.edu.vn" class="text-foot ms-2">contact@fpt.edu.vn</a>
                                </li>
                                <li class="d-flex align-items-center">
                                    <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="tel:+152534468854" class="text-foot ms-2">+114</a>
                                </li>
                            </ul>
                        </div>end col
                    </div>end row
                </div>end container
        
                <div class="container mt-5">
                    <div class="pt-4 footer-bar">
                        <div class="text-center">
                            <p class="mb-0">2025 © MediSync. Code backend by Group 3 - SE1885</p>
                        </div>
                    </div>
                </div>end container
            </footer>end footer-->
        <!-- End -->







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