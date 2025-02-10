<%@ page contentType="text/html" pageEncoding="UTF-8"%>
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
        </style>
    </head>
    <body>
        <div id="preloader">
        <div id="status">
            <div class="spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
        </div>
    </div>
    <!-- Loader -->
<main class="page-content bg-light">
    <div class="page-wrapper doctris-theme toggled">
        <nav id="sidebar" class="sidebar-wrapper">
            <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                <div class="sidebar-brand">
                    <a href="index.html">
                        <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                        <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                    </a>
                </div>

                <ul class="sidebar-menu pt-3">
                    <li><a href="adminDashBoard.jsp"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                    <li><a href="appointment.html"><i class="uil uil-stethoscope me-2 d-inline-block"></i>Appointment</a></li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Doctors</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="ListDoctor">Staffs</a></li>
                                <li><a href="addStaff.jsp">Add Doctor</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Patients</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="patients.html">All Patients</a></li>
                                <li><a href="add-patient.html">Add Patients</a></li>
                                <li><a href="patient-profile.html">Profile</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-apps me-2 d-inline-block"></i>Apps</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="chat.html">Chat</a></li>
                                <li><a href="email.html">Email</a></li>
                                <li><a href="calendar.html">Calendar</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-shopping-cart me-2 d-inline-block"></i>Pharmacy</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="shop.html">Shop</a></li>
                                <li><a href="product-detail.html">Shop Detail</a></li>
                                <li><a href="shopcart.html">Shopcart</a></li>
                                <li><a href="checkout.html">Checkout</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Blogs</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="blogs.html">Blogs</a></li>
                                <li><a href="blog-detail.html">Blog Detail</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-file me-2 d-inline-block"></i>Pages</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="faqs.html">FAQs</a></li>
                                <li><a href="review.html">Reviews</a></li>
                                <li><a href="invoice-list.html">Invoice List</a></li>
                                <li><a href="invoice.html">Invoice</a></li>
                                <li><a href="terms.html">Terms & Policy</a></li>
                                <li><a href="privacy.html">Privacy Policy</a></li>
                                <li><a href="error.html">404 !</a></li>
                                <li><a href="manage-banners">Manage Banners</a></li>
                            </ul>
                        </div>
                    </li>

                    <li class="sidebar-dropdown">
                        <a href="javascript:void(0)"><i class="uil uil-sign-in-alt me-2 d-inline-block"></i>Authentication</a>
                        <div class="sidebar-submenu">
                            <ul>
                                <li><a href="login.html">Login</a></li>
                                <li><a href="signup.html">Signup</a></li>
                                <li><a href="forgot-password.html">Forgot Password</a></li>
                                <li><a href="lock-screen.html">Lock Screen</a></li>
                                <li><a href="thankyou.html">Thank you...!</a></li>
                            </ul>
                        </div>
                    </li>

                    <li><a href="components.html"><i class="uil uil-cube me-2 d-inline-block"></i>Components</a></li>

                    <li><a href="landing/index-two.html" target="_blank"><i class="uil uil-window me-2 d-inline-block"></i>Landing page</a></li>
                </ul>
            </div>
            <!-- sidebar-content  -->
            <ul class="sidebar-footer list-unstyled mb-0">
                <li class="list-inline-item mb-0 ms-1">
                    <a href="#" class="btn btn-icon btn-pills btn-soft-primary">
                        <i class="uil uil-comment icons"></i>
                    </a>
                </li>
            </ul>
        </nav>
        
        <div class="container mt-5">
            <h2 class="text-center mb-4">Banner Management</h2>

            <!-- New Banner Upload Form -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Upload New Banner</h5>
                </div>
                <div class="card-body">
                    <form action="manage-banners" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="uploadNew">

                        <div class="mb-3">
                            <label for="bannerName" class="form-label">Banner Title</label>
                            <input type="text" class="form-control" id="bannerName" name="bannerName" required>
                        </div>

                        <div class="mb-3">
                            <label for="bannerContent" class="form-label">Banner Content</label>
                            <textarea class="form-control" id="bannerContent" name="bannerContent" rows="3" required></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="bannerImage" class="form-label">Banner Image</label>
                            <input type="file" class="form-control" id="bannerImage" name="bannerImage" accept="image/*" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Upload New Banner</button>
                    </form>
                </div>
            </div>
            <div class="card mb-4">
                <div class="card-body">
                    <form action="manage-banners" method="get" class="row g-3">
                        <div class="col-md-6">
                            <div class="input-group">
                                <input type="text" class="form-control" name="search" 
                                       placeholder="Search by banner name..." 
                                       value="${searchQuery}">
                                <button class="btn btn-outline-secondary" type="submit">Search</button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <select name="sortOrder" class="form-select" onchange="this.form.submit()">
                                <option value="desc" ${sortOrder == 'desc' ? 'selected' : ''}>Newest First</option>
                                <option value="asc" ${sortOrder == 'asc' ? 'selected' : ''}>Oldest First</option>
                            </select>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Existing Banners -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Manage Existing Banners</h5>
                    <span class="text-muted">Total: ${blogs.size()} banners</span>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty blogs}">
                            <div class="text-center py-5">
                                <div class="mb-3">
                                    <i class="fas fa-image fa-3x text-muted"></i>
                                </div>
                                <h5>No banners found</h5>
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
                                                        <span class="badge bg-primary">Active Banner</span>
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

            <!-- Include your existing JS files -->
            <script src="assets/js/bootstrap.bundle.min.js"></script>
            <script src="assets/js/app.js"></script>
            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/js/simplebar.min.js"></script>
            <script src="assets/js/feather.min.js"></script>
            </main>
    </body>
</html>