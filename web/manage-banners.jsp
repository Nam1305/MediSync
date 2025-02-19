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
                            <a href="javascript:void(0)"><i class="uil uil-user me-2 d-inline-block"></i>Nhân Viên</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="ListDoctor">Danh Sách Nhân Viên</a></li>
                                    <li><a href="AddStaffServlet">Thêm Nhân Viên</a></li>

                                </ul>
                            </div>
                        </li>
  
                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Bệnh Nhân</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="listCustomer">Danh Sách Bệnh Nhân</a></li>
                                    <li><a href="addCustomer" >Thêm bệnh Nhân</a></li>
                                    
                                </ul>
                            </div>
                        </li>
                        
                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-wheelchair me-2 d-inline-block"></i>Phòng Ban</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="ListDepartment">Danh sách Phòng Ban</a></li>
                                    <li><a href="addDepartment.jsp">Thêm Phòng Ban</a></li>

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
                            <a href="javascript:void(0)"><i class="uil uil-flip-h me-2 d-inline-block"></i>Banner</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="manage-banners">Banner Management</a></li>
                                </ul>
                            </div>
                        </li>

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

            <!-- Alert Messages -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <strong>Error!</strong> ${sessionScope.errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("errorMessage"); %>
            </c:if>
            
            <c:if test="${not empty sessionScope.successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>Success!</strong> ${sessionScope.successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("successMessage"); %>
            </c:if>

            <!-- New Banner Upload Form -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Upload New Banner</h5>
                </div>
                <div class="card-body">
                    <form id="bannerForm" action="manage-banners" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
                        <input type="hidden" name="action" value="uploadNew">

                        <div class="mb-3">
                            <label for="bannerName" class="form-label">Banner Title</label>
                            <input type="text" class="form-control" id="bannerName" name="bannerName" 
                                   value="${sessionScope.formData.bannerName[0]}" required>
                        </div>

                        <div class="mb-3">
                            <label for="bannerContent" class="form-label">Banner Content</label>
                            <textarea class="form-control" id="bannerContent" name="bannerContent" rows="3" required>${sessionScope.formData.bannerContent[0]}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="bannerImage" class="form-label">Banner Image</label>
                            <input type="file" class="form-control" id="bannerImage" name="bannerImage" 
                                   accept="image/jpeg,image/png,image/jpg,image/gif,image/webp" 
                                   required onchange="validateFileSize()">
                            <div class="form-text">
                                Maximum file size: 10MB. Accepted formats: jpg, jpeg, png, gif, webp
                            </div>
                            <div id="fileError" class="text-danger mt-1" style="display: none;"></div>
                        </div>

                        <button type="submit" class="btn btn-primary">Upload New Banner</button>
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
                document.addEventListener('DOMContentLoaded', function() {
                    setTimeout(function() {
                        const alerts = document.querySelectorAll('.alert');
                        alerts.forEach(function(alert) {
                            const bsAlert = new bootstrap.Alert(alert);
                            bsAlert.close();
                        });
                    }, 5000);
                });
            </script>
            </main>
    </body>
</html>