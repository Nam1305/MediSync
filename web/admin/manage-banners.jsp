
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Banner Management</title>
        <!-- Include your existing CSS files -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <style>
            .banner-preview {
                width: 200px;
                height: 120px;
                object-fit: cover;
                border-radius: 8px;
            }
            .banner-card {
                transition: all 0.3s ease;
            }
            .banner-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }
            .banner-preview {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }

            .banner-card {
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .banner-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .card-title {
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .pagination .page-link {
                padding: 0.5rem 0.75rem;
                font-size: 0.9rem;
            }

            .pagination .fas {
                font-size: 0.8rem;
            }
            
            .alert-dismissible {
                position: relative;
            }
            
            .alert-dismissible .close {
                position: absolute;
                top: 0;
                right: 0;
                padding: 0.75rem 1.25rem;
                color: inherit;
            }
        </style>
    </head>

    <body>
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="../layout/navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="../layout/header.jsp" />

                <div class="container-fluid">
                    <div class="container mt-5" style="margin-top: 200px;">
                        <!-- Alert Messages -->
                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="margin-top: 150px;">
                                <strong>Error!</strong> ${sessionScope.errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% session.removeAttribute("errorMessage"); %>
                        </c:if>

                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert" style="margin-top: 150px;">
                                <strong>Success!</strong> ${sessionScope.successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                            <% session.removeAttribute("successMessage"); %>
                        </c:if>

                        <!-- New Banner Upload Form -->
                        <div class="card mb-4" style="margin-top: 100px;">
                            <div class="card-header">
                                <h5 class="mb-0">Upload Banner mới</h5>
                            </div>
                            <div class="card-body">
                                <form id="bannerForm" action="manage-banners" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                                    <input type="hidden" name="action" value="uploadNew">

                                    <div class="mb-3">
                                        <label for="bannerName" class="form-label">Tiêu đề Banner</label>
                                        <input type="text" class="form-control" id="bannerName" name="bannerName" 
                                               value="${sessionScope.formData.bannerName[0]}" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="bannerContent" class="form-label">Nội dung của Banner</label>
                                        <textarea class="form-control" id="bannerContent" name="bannerContent" rows="3" required>${sessionScope.formData.bannerContent[0]}</textarea>
                                    </div>

                                    <div class="mb-3">
                                        <label for="bannerImage" class="form-label">Ảnh banner</label>
                                        <input type="file" class="form-control" id="bannerImage" name="bannerImage" 
                                               accept="image/jpeg,image/png,image/jpg,image/gif,image/webp" 
                                               required onchange="validateFileSize()">
                                        <div class="form-text">
                                            Kích thước file tối đa: 10MB. Các format được chấp nhận: jpg, jpeg, png, gif, webp
                                        </div>
                                        <div id="fileError" class="text-danger mt-1" style="display: none;"></div>
                                    </div>

                                    <button type="submit" class="btn btn-primary">Upload banner mới</button>
                                </form>
                                <% session.removeAttribute("formData"); %>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-body">
                                <form action="manage-banners" method="get" class="row g-3">
                                    <div class="col-md-6">
                                        <div class="input-group">
                                            <input type="text" class="form-control" name="search" 
                                                   placeholder="Tìm theo tên banner..." 
                                                   value="${searchQuery}">
                                            <button class="btn btn-outline-secondary" type="submit">Tìm kiếm</button>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <select name="sortOrder" class="form-select" onchange="this.form.submit()">
                                            <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Mới nhất</option>
                                            <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>Cũ nhất</option>
                                        </select>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <!-- Existing Banners -->
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Quản lý các Banner đã đăng</h5>
                                <span class="text-muted">Tổng cộng: ${blogs.size()} banners</span>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${empty blogs}">
                                        <div class="text-center py-5">
                                            <div class="mb-3">
                                                <i class="fas fa-image fa-3x text-muted"></i>
                                            </div>
                                            <h5>Không tìm thấy banner</h5>
                                            <p class="text-muted">
                                                ${not empty searchQuery ? 'Try adjusting your search criteria' : 'Start by uploading a new banner'}
                                            </p>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="row g-4">
                                            <c:forEach items="${blogs}" var="blog">
                                                <div class="col-md-6 col-lg-4">
                                                    <div class="card banner-card h-100 ${blog.selectedBanner == 1 ? 'border-primary' : ''}">
                                                        <div class="position-relative">
                                                            <img src="${blog.image}" 
                                                                 class="banner-preview card-img-top" 
                                                                 alt="${blog.blogName}"
                                                                 style="height: 200px; object-fit: cover;">

                                                            <c:if test="${blog.selectedBanner == 1}">
                                                                <div class="position-absolute top-0 start-0 m-2">
                                                                    <span class="badge bg-primary">Kích hoạt banner</span>
                                                                </div>
                                                            </c:if>
                                                        </div>

                                                        <div class="card-body">
                                                            <h5 class="card-title text-truncate" title="${blog.blogName}">
                                                                ${blog.blogName}
                                                            </h5>

                                                            <div class="mb-3">
                                                                <p class="card-text text-muted small" style="height: 60px; overflow: hidden;">
                                                                    ${blog.content}
                                                                </p>
                                                            </div>

                                                            <div class="d-flex justify-content-between align-items-center">
                                                                <small class="text-muted">
                                                                    <i class="far fa-calendar-alt"></i>
                                                                    ${blog.date}
                                                                </small>

                                                                <form action="manage-banners" method="post" class="d-inline">
                                                                    <input type="hidden" name="action" value="updateBanner">
                                                                    <input type="hidden" name="blogId" value="${blog.blogId}">
                                                                    <input type="hidden" name="setAsBanner" value="${blog.selectedBanner == 1 ? 'false' : 'true'}">
                                                                    <input type="hidden" name="page" value="${currentPage}">
                                                                    <input type="hidden" name="pageSize" value="${pageSize}">
                                                                    <input type="hidden" name="search" value="${searchQuery}">
                                                                    <input type="hidden" name="sortOrder" value="${sortOrder}">

                                                                    <button type="submit" 
                                                                            class="btn btn-sm ${blog.selectedBanner == 1 ? 'btn-outline-danger' : 'btn-outline-primary'}"
                                                                            title="${blog.selectedBanner == 1 ? 'Remove from active banners' : 'Set as active banner'}">
                                                                        <i class="fas ${blog.selectedBanner == 1 ? 'fa-times' : 'fa-check'}"></i>
                                                                        ${blog.selectedBanner == 1 ? 'Deactivate' : 'Activate'}
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>

                                        <!-- Pagination section -->
                                        <c:if test="${totalPages > 1}">
                                            <nav aria-label="Banner navigation" class="mt-4">
                                                <ul class="pagination justify-content-center">
                                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                        <a class="page-link" href="manage-banners?page=${currentPage - 1}&search=${searchQuery}&sortOrder=${sortOrder}&pageSize=${pageSize}">
                                                            <i class="fas fa-chevron-left"></i>
                                                        </a>
                                                    </li>

                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                            <a class="page-link" href="manage-banners?page=${i}&search=${searchQuery}&sortOrder=${sortOrder}&pageSize=${pageSize}">
                                                                ${i}
                                                            </a>
                                                        </li>
                                                    </c:forEach>

                                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                        <a class="page-link" href="manage-banners?page=${currentPage + 1}&search=${searchQuery}&sortOrder=${sortOrder}&pageSize=${pageSize}">
                                                            <i class="fas fa-chevron-right"></i>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div><!--end container-->

                <!-- Footer Start -->
                <footer class="bg-white shadow py-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col">
                                <div class="text-sm-start text-center">
                                    <p class="mb-0 text-muted"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
                                </div>
                            </div><!--end col-->
                        </div><!--end row-->
                    </div><!--end container-->
                </footer><!--end footer-->
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
        <!-- Offcanvas End -->

        <!-- Include your existing JS files -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/app.js"></script>
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/simplebar.min.js"></script>
        <script src="assets/js/feather.min.js"></script>

        <!-- File validation script -->
        <script>
                                        const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB in bytes

                                        function validateFileSize() {
                                            const fileInput = document.getElementById('bannerImage');
                                            const fileError = document.getElementById('fileError');

                                            if (fileInput.files.length > 0) {
                                                const fileSize = fileInput.files[0].size;
                                                const fileType = fileInput.files[0].type;

                                                // Check file size
                                                if (fileSize > MAX_FILE_SIZE) {
                                                    fileError.textContent = 'File size exceeds 10MB limit. Please select a smaller file.';
                                                    fileError.style.display = 'block';
                                                    fileInput.value = ''; // Clear the input
                                                    return false;
                                                }

                                                // Check file type
                                                const acceptedTypes = ['image/jpeg', 'image/png', 'image/jpg', 'image/gif', 'image/webp'];
                                                if (!acceptedTypes.includes(fileType)) {
                                                    fileError.textContent = 'Invalid file type. Please select an image file (JPG, JPEG, PNG, GIF, WEBP).';
                                                    fileError.style.display = 'block';
                                                    fileInput.value = ''; // Clear the input
                                                    return false;
                                                }

                                                // If all checks pass
                                                fileError.style.display = 'none';
                                                return true;
                                            }

                                            return true; // No file selected yet
                                        }

                                        function validateForm() {
                                            // Add banner name check
                                            const bannerNameInput = document.getElementById('bannerName');
                                            const bannerName = bannerNameInput.value.trim();

                                            if (bannerName === '') {
                                                alert('Banner name cannot be empty');
                                                bannerNameInput.focus();
                                                return false;
                                            }

                                            return validateFileSize();
                                        }

                                        // Auto-dismiss alerts after 5 seconds
                                        document.addEventListener('DOMContentLoaded', function () {
                                            setTimeout(function () {
                                                const alerts = document.querySelectorAll('.alert');
                                                alerts.forEach(function (alert) {
                                                    const bsAlert = new bootstrap.Alert(alert);
                                                    bsAlert.close();
                                                });
                                            }, 5000);
                                        });
        </script>

    </body>

</html>