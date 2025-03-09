<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <script>
            function confirmDeleteComment(commentId) {
                if (confirm("Bạn có chắc chắn muốn xóa bình luận này không?")) {
                    document.getElementById("deleteCommentForm" + commentId).submit();
                }
            }
        </script>
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../layout/navbar.jsp" />


            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../layout/header.jsp" />


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
                                        <div class="blog-content mb-5">
                                            <p class="text-muted mb-0">${blog.content}</p>
                                        </div>

                                        <div class="comment-section mt-5 pt-4 border-top">
                                            <h5 class="card-title mb-4">Bình luận :</h5>

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

                                                                    <!-- Nút xóa comment -->
                                                                    <div>
                                                                        <form id="deleteCommentForm${comment.commentId}" action="deleteComment" method="post" style="display: inline;">
                                                                            <input type="hidden" name="commentId" value="${comment.commentId}">
                                                                            <input type="hidden" name="blogId" value="${blog.blogId}">
                                                                            <input type="hidden" name="page" value="${currentPage}">
                                                                            <button type="button" class="btn btn-soft-danger btn-sm" 
                                                                                    onclick="confirmDeleteComment(${comment.commentId})">
                                                                                <i class="uil uil-trash-alt"></i>
                                                                            </button>
                                                                        </form>
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

                                            <!--phan trang-->
                                            <div class="row text-center">
                                                <div class="col-12 mt-4">
                                                    <div class="d-md-flex align-items-center text-center justify-content-center">
                                                        <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                                            <c:if test="${currentPage > 1}">
                                                                <li class="page-item">
                                                                    <a class="page-link" href="blogs-detail?blogId=${blog.blogId}&page=${currentPage - 1}">Prev</a>
                                                                </li>
                                                            </c:if>

                                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                                    <a class="page-link" href="blogs-detail?blogId=${blog.blogId}&page=${i}">${i}</a>
                                                                </li>
                                                            </c:forEach>

                                                            <c:if test="${currentPage < totalPages}">
                                                                <li class="page-item">
                                                                    <a class="page-link" href="blogs-detail?blogId=${blog.blogId}&page=${currentPage + 1}">Next</a>
                                                                </li>
                                                            </c:if>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!--end row-->        
                    </div>    
                </div>  <!-- end container-->


                <jsp:include page="../layout/footer.jsp" />

                <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

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
