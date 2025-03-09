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
            function confirmDelete(blogId) {
                if (confirm("Bạn có chắc chắn muốn xóa blog này không?")) {
                    document.getElementById("deleteForm" + blogId).submit();
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


                <div class="container-fluid">
                    <div class="layout-specing">
                        <!-- Tiêu đề trang -->
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Danh sách blogs</h5>
                        </div>

                        <div class="row">
                            <div class="col-sm-12">
                                <c:if test="${not empty noti}">
                                    <c:choose>
                                        <c:when test="${noti == 'success'}">
                                            <div class="alert alert-success" id="statusMess">Blog edited successfully!</div>
                                        </c:when>
                                        <c:when test="${noti == 'fail'}">
                                            <div class="alert alert-danger" id="statusMess">Failed to edit blog. Please try again.</div>
                                        </c:when>
                                        <c:when test="${noti == 'failDelete'}">
                                            <div class="alert alert-danger" id="statusMess">Failed to delete blog. Please try again.</div>
                                        </c:when>
                                        <c:when test="${noti == 'successDelete'}">
                                            <div class="alert alert-success" id="statusMess">Blog deleted successfully.</div>
                                        </c:when>
                                    </c:choose>
                                </c:if>
                            </div>
                        </div>

                        <form action="blogs" method="get">
                            <input type="hidden" name="page" value="${requestScope.currentPage != null ? requestScope.currentPage : 1}" />
                            <div class="d-flex justify-content-end mb-3">
                                <div class="d-flex align-items-center">
                                    <!-- Dropdown chọn sắp xếp theo ngày đăng -->
                                    <select class="form-select me-2" name="sort" style="width: 150px;">
                                        <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>Mới nhất</option>
                                        <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                                    </select>

                                    <!-- Input số lượng blog/trang -->
                                    <input type="number" class="form-control me-2" name="itemsPerPage" min="1" max="${requestScope.totalBlogs}" 
                                           value="${not empty itemsPerPage ? itemsPerPage : 6}" placeholder="Số lượng/trang" style="width: 100px;">

                                    <!-- Nút gửi form -->
                                    <button type="submit" class="btn btn-primary">Lọc</button>
                                </div>
                            </div>
                        </form>


                        <!-- Bảng danh sách blog -->
                        <div class="row">
                            <div class="col-12 mt-4">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3" style="min-width: 50px;">ID</th>
                                                <th class="border-bottom p-3" style="min-width: 180px;">Tiêu đề</th>
                                                <th class="border-bottom p-3" style="min-width: 80px;">Ảnh</th>
                                                <th class="border-bottom p-3">Tác giả</th>
                                                <th class="border-bottom p-3" style="min-width: 100px;">Ngày đăng</th>
                                                <th class="border-bottom p-3" style="min-width: 100px; text-align: right; padding-right: 10px;">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="blog" items="${listBlog}">
                                                <tr>
                                                    <th class="p-3">${blog.blogId}</th>
                                                    <td class="py-3">
                                                        <a class="text-dark">${blog.blogName}</a>
                                                    </td>
                                                    <td class="p-3">
                                                        <img src="${blog.image}" alt="${blog.blogName}" class="img-fluid" style="max-width:80px;">
                                                    </td>
                                                    <td class="p-3">${blog.author}</td>
                                                    <td class="p-3">${blog.date}</td>
                                                    <td class="text-end p-3">
                                                        <a href="blogs-detail?blogId=${blog.blogId}" class="btn btn-icon btn-pills btn-soft-primary">
                                                            <i class="uil uil-eye"></i>
                                                        </a>
                                                        <a href="updateBlog?blogId=${blog.blogId}" class="btn btn-icon btn-pills btn-soft-success">
                                                            <i class="uil uil-pen"></i>
                                                        </a>
                                                        <form id="deleteForm${blog.blogId}" action="deleteBlog" method="post" style="display: inline;">
                                                            <input type="hidden" name="blogId" value="${blog.blogId}">
                                                            <a href="#" class="btn btn-icon btn-pills btn-soft-danger" onclick="confirmDelete(${blog.blogId});">
                                                                <i class="uil uil-trash"></i>
                                                            </a>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div><!--end row-->

                        <!-- Phân trang -->
                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="blogs?page=${currentPage - 1}&search=${param.search}" aria-label="Previous">Prev</a>
                                            </li>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="blogs?page=${i}&search=${param.search}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="blogs?page=${currentPage + 1}&search=${param.search}" aria-label="Next">Next</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div><!--end row-->
                        </div>
                    </div><!--end col-->
                </div><!--end container-fluid-->

                <jsp:include page="../layout/footer.jsp" />

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
