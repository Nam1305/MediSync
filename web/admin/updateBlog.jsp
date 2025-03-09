<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Chỉnh sửa blog</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    </head>

    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../layout/navbar.jsp" />


            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../layout/header.jsp" />


                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Chỉnh sửa Blog</h5>
                        </div>

                        <div class="row">
                            <div class="col-lg-8 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <c:if test="${not empty blog.image}">
                                        <div class="mb-3">
                                            <img src="${blog.image}" class="img-thumbnail" alt="Blog Image" width="200">
                                        </div>
                                    </c:if>

                                    <!-- Form chỉnh sửa Blog -->
                                    <form class="mt-4" method="POST" action="updateBlog" enctype="multipart/form-data">
                                        <input type="hidden" name="id" value="${blog.blogId}">

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Tiêu đề</label>
                                                    <input name="blogName" type="text" class="form-control" value="${blog.blogName}" required>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Tác giả</label>
                                                    <input name="author" type="text" class="form-control" value="${blog.author}" required>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Ngày đăng</label>
                                                    <input name="date" type="date" class="form-control" value="${blog.date}" required>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="mb-3">
                                                    <label class="form-label">Nội dung</label>
                                                    <textarea name="content" class="form-control" rows="5" required>${blog.content}</textarea>
                                                </div>
                                            </div>

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Hình ảnh</label>
                                                    <input type="file" name="image" class="form-control">
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Hiển thị thông báo lỗi -->
                                        <c:if test="${not empty errors}">
                                            <div class="alert alert-danger mt-3">
                                                <c:forEach var="error" items="${errors}">
                                                    <p>${error}</p>
                                                </c:forEach>
                                            </div>
                                        </c:if>

                                        <!-- Hiển thị thông báo thành công -->
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-success mt-3">${message}</div>
                                        </c:if>

                                        <div>
                                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            <a href="blogs" class="btn btn-secondary ms-2">Quay về</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../layout/footer.jsp" />

            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>
