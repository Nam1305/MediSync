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
        <jsp:include page="layout/header2.jsp" /><!--end header-->
        <!-- Navbar End -->


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
                <!-- sort -->
                <div class="col-md-6">
                    <form action="listBlog" method="get" class="d-flex">
                        <label class="me-2 align-self-center fw-bold">Sắp xếp:</label>
                        <select name="sort" class="form-select me-2" onchange="this.form.submit()" style="max-width: 200px;">
                            <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Mới nhất</option>
                            <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                        </select>
                    </form>
                </div>

                <!-- search bar -->
                <div class="col-md-6 text-end">
                    <form action="listBlog" method="get" class="d-flex justify-content-end">
                        <input type="text" name="search" class="form-control me-2" 
                               placeholder="Tìm kiếm blog..." value="${param.search}" style="max-width: 300px;">
                        <button type="submit" class="btn btn-success">Tìm</button>
                    </form>
                </div>
            </div>



        <!-- list blog -->
        <div class="row">
            <c:forEach items="${listBlog}" var="blog">
                <div class="col-xl-4 col-lg-4 col-md-4 col-12 mt-4 pt-2">
                    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                        <img src="${blog.image}" class="img-fluid" alt="${blog.blogName}">
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
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="?page=${currentPage - 1}&search=${param.search}&sort=${param.sort}">Prev</a>
            </c:if>

            <c:forEach var="i" begin="1" end="${totalPages}">
                <a href="?page=${i}&search=${param.search}&sort=${param.sort}" class="${i == currentPage ? 'active' : ''}">${i}</a>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="?page=${currentPage + 1}&search=${param.search}&sort=${param.sort}">Next</a>
            </c:if>
        </div>


        </div><!--end container-->
        <!-- End -->



        <!-- Start -->
        <footer class="bg-footer" style="margin-top: 5%;">
            <div class="container">
                <div class="row">
                    <div class="col-md-6 mb-4">
                        <p>Đội ngũ bác sĩ xuất sắc sẵn sàng cung cấp sự hỗ trợ kịp thời, điều trị khẩn cấp và tư vấn chuyên sâu cho gia đình bạn.</p>

                        <div class="mt-4">
                            <h5 class="text-light title-dark footer-head">Địa chỉ</h5>
                            <div id="google-map" style="height: 200px; width: 100%; overflow: hidden;">
                                <!-- Nhúng Google Map tại đây -->
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d33006.67071116369!2d105.51462100371513!3d21.005883448895787!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135abc60e7d3f19%3A0x2be9d7d0b5abcbf4!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgSMOgIE7hu5lp!5e1!3m2!1svi!2s!4v1737175663000!5m2!1svi!2s" 
                                        width="100%" height="200" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
                            </div>
                        </div>
                    </div><!--end col-->

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
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-5">
                <div class="pt-4 footer-bar">
                    <div class="text-center">
                        <p class="mb-0">2025 © MediSync. Code backend by Group 3 - SE1885</p>
                    </div>
                </div>
            </div><!--end container-->
        </footer><!--end footer-->
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