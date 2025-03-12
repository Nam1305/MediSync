<%-- 
    Document   : blog-detail
    Created on : Feb 2, 2025, 10:11:23 PM
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
        <script src="https://cdn.tiny.cloud/1/vnufc6yakojjcovpkijlauot8hfpbxd3uscxatfq2m4yijay/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>        
        <script src="assets/js/tinymce-init.js"></script>

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

        <!-- Blog Detail -->
        <div class="container-fluid ">
            <div class="blog-detail-container layout-specing">
                <div class="d-md-flex justify-content-between">
                    <div>
                        <h4 class="mb-0">${blog.blogName}</h4>

                        <ul class="list-unstyled mt-2 mb-0">
                            <li class="list-inline-item user text-muted me-2"><i class="mdi mdi-account"></i> ${blog.author}</li>
                            <li class="list-inline-item date text-muted"><i class="mdi mdi-calendar-check"></i> ${blog.date}</li>
                        </ul>
                    </div>
                </div>       

                <div class="row">
                    <div class="col-lg-8 col-lg-7 mt-4">
                        <div class="card rounded shadow border-0 overflow-hidden">
                            <img src="${blog.image}" class="img-fluid" alt="">

                            <div class="p-4">
                                <!-- <ul class="list-unstyled">
                                    <li class="list-inline-item user text-muted me-2"><i class="mdi mdi-account"></i> Calvin Carlo</li>
                                    <li class="list-inline-item date text-muted"><i class="mdi mdi-calendar-check"></i> 1st January, 2021</li>
                                </ul> -->
                                <p class="text-muted mb-0">${blog.content}</p>

                                <h5 class="card-title mt-4 mb-0">Bình luận :</h5>

                                <ul class="list-unstyled">
                                    <li class="mt-4">
                                        <ul>
                                            <c:forEach var="comment" items="${comments}">
                                                <li class="mt-4">
                                                    <div class="d-flex justify-content-between">
                                                        <div class="d-flex align-items-center">
                                                            <a class="pe-3" href="#">
                                                                <img src="${comment.avatar}" class="img-fluid avatar avatar-md-sm rounded-circle shadow" alt="img">
                                                            </a>
                                                            <div class="commentor-detail">
                                                                <h6 class="mb-0">
                                                                    <a href="javascript:void(0)" class="text-dark media-heading">${comment.name}</a>
                                                                </h6>
                                                                <small class="text-muted">
                                                                    <fmt:formatDate value="${comment.date}" pattern="dd/MM/yyyy"/>
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="mt-3">
                                                        <p class="text-muted font-italic p-3 bg-light rounded">"${comment.content}"</p>
                                                    </div>
                                                </li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </ul>
                                <div class="pagination">
                                    <c:if test="${currentPage > 1}">
                                        <a href="?blogId=${blog.blogId}&page=${currentPage - 1}">Previous</a>
                                    </c:if>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <a href="?blogId=${blog.blogId}&page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                    </c:forEach>
                                    <c:if test="${currentPage < totalPages}">
                                        <a href="?blogId=${blog.blogId}&page=${currentPage + 1}">Next</a>
                                    </c:if>
                                </div>
                                <form method="post" action="blogDetail">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="mb-3">
                                                <label class="form-label">Bình luận của bạn:</label>
                                                <input type="hidden" name="blogId" value="${blog.blogId}">
                                                <textarea name="content" placeholder="Nhập bình luận..." class="form-control" required></textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="send d-grid">
                                                <c:choose>
                                                    <c:when test="${empty sessionScope.customer}">
                                                        <a href="login" class="btn btn-primary">Đăng nhập để bình luận</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="submit" class="btn btn-primary">Bình luận</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>



                    <div class="col-lg-4 col-md-5 mt-4">
                        <div class="card border-0 sidebar sticky-bar rounded shadow">
                            <div class="card-body">
                                <!-- RECENT POST -->
                                <div class="widget mb-4 pb-2">
                                    <h5 class="widget-title">Blog gần đây</h5>
                                    <c:forEach items="${topBlog}" var="blog">
                                        <div class="mt-4">
                                            <div class="clearfix post-recent">
                                                <div class="post-recent-thumb float-start">
                                                    <a href="blogDetail?blogId=${blog.blogId}">
                                                        <img alt="${blog.blogName}" src="${blog.image}" class="img-fluid rounded">
                                                    </a>
                                                </div>
                                                <div class="post-recent-content float-start">
                                                    <a href="blogDetail?blogId=${blog.blogId}">${blog.blogName}</a>
                                                    <span class="text-muted mt-2">
                                                        <fmt:formatDate value="${blog.date}" pattern="dd/MM/yyyy"/>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <!-- RECENT POST -->

                            </div>
                        </div>                   
                    </div><!--end col-->
                </div><!--end row-->        
            </div>    
        </div>    





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

