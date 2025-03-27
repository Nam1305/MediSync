
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
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
            .footer-card {
                transition: all 0.3s ease;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .footer-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .card-title {
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
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

                    <!-- Footer Content Form -->
                    <div class="card mb-4" style="margin-top: 100px;">
                        <div class="card-header">
                            <h5 class="mb-0">
                                <c:choose>
                                    <c:when test="${footerContentExists}">
                                        <i class="fas fa-edit me-2"></i>Update Footer Content
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-plus-circle me-2"></i>Create New Footer Content
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                        </div>
                        <div class="card-body">
                            <form id="footerForm" action="manage-footer" method="post" onsubmit="return validateForm()">
                                <input type="hidden" name="action" value="saveFooterContent">
                                <input type="hidden" name="isUpdate" value="${footerContentExists}">

                                <div class="mb-3">
                                    <label for="addressContent" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Địa chỉ</label>
                                    <textarea class="form-control" id="addressContent" name="addressContent" rows="3" required>${addressContent.content}</textarea>
                                    <c:if test="${addressContent != null}">
                                        <input type="hidden" name="addressId" value="${addressContent.blogId}">
                                    </c:if>
                                </div>

                                <div class="mb-3">
                                    <label for="emailContent" class="form-label"><i class="fas fa-envelope me-2"></i>Email</label>
                                    <textarea class="form-control" id="emailContent" name="emailContent" rows="2" required>${emailContent.content}</textarea>
                                    <c:if test="${emailContent != null}">
                                        <input type="hidden" name="emailId" value="${emailContent.blogId}">
                                    </c:if>
                                </div>

                                <div class="mb-3">
                                    <label for="phoneContent" class="form-label"><i class="fas fa-phone me-2"></i>Số điện thoại</label>
                                    <textarea class="form-control" id="phoneContent" name="phoneContent" rows="2" required>${phoneContent.content}</textarea>
                                    <c:if test="${phoneContent != null}">
                                        <input type="hidden" name="phoneId" value="${phoneContent.blogId}">
                                    </c:if>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="reset" class="btn btn-secondary me-2">
                                        <i class="fas fa-undo me-1"></i> Đặt lại
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <c:choose>
                                            <c:when test="${footerContentExists}">
                                                <i class="fas fa-save me-1"></i> Cập nhật
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-save me-1"></i> Lưu
                                            </c:otherwise>
                                        </c:choose>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Preview Section -->
                    <c:if test="${footerContentExists}">
                        <div class="card">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="mb-0"><i class="fas fa-eye me-2"></i>Xem trước footer</h5>
                                <span class="text-muted">
                                    <c:choose>
                                        <c:when test="${addressContent != null}">
                                            Cập nhật: ${addressContent.date}
                                        </c:when>
                                        <c:when test="${emailContent != null}">
                                            Cập nhật: ${emailContent.date}
                                        </c:when>
                                        <c:when test="${phoneContent != null}">
                                            Cập nhật: ${phoneContent.date}
                                        </c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="card-body">
                                <div class="row g-4">
                                    <div class="col-md-4">
                                        <div class="card footer-card h-100">
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <i class="fas fa-map-marker-alt me-2"></i>Địa chỉ
                                                </h5>
                                                <p class="card-text" style="height: 100px; overflow: auto;">
                                                    ${addressContent.content}
                                                </p>
                                                <div class="d-flex justify-content-between align-items-center mt-3">
                                                    <small class="text-muted">
                                                        <i class="far fa-user me-1"></i>
                                                        ${addressContent.author}
                                                    </small>
                                                    <small class="text-muted">
                                                        <i class="far fa-calendar-alt me-1"></i>
                                                        ${addressContent.date}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card footer-card h-100">
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <i class="fas fa-envelope me-2"></i>Email
                                                </h5>
                                                <p class="card-text" style="height: 100px; overflow: auto;">
                                                    ${emailContent.content}
                                                </p>
                                                <div class="d-flex justify-content-between align-items-center mt-3">
                                                    <small class="text-muted">
                                                        <i class="far fa-user me-1"></i>
                                                        ${emailContent.author}
                                                    </small>
                                                    <small class="text-muted">
                                                        <i class="far fa-calendar-alt me-1"></i>
                                                        ${emailContent.date}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card footer-card h-100">
                                            <div class="card-body">
                                                <h5 class="card-title">
                                                    <i class="fas fa-phone me-2"></i>Số điện thoại
                                                </h5>
                                                <p class="card-text" style="height: 100px; overflow: auto;">
                                                    ${phoneContent.content}
                                                </p>
                                                <div class="d-flex justify-content-between align-items-center mt-3">
                                                    <small class="text-muted">
                                                        <i class="far fa-user me-1"></i>
                                                        ${phoneContent.author}
                                                    </small>
                                                    <small class="text-muted">
                                                        <i class="far fa-calendar-alt me-1"></i>
                                                        ${phoneContent.date}
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
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
        <!-- Include JS files -->
                <script src="assets/js/bootstrap.bundle.min.js"></script>
                <script src="assets/js/app.js"></script>
                <script src="assets/js/jquery.min.js"></script>
                <script src="assets/js/simplebar.min.js"></script>
                <script src="assets/js/feather.min.js"></script>

                <!-- Form validation script -->
                <script>
                                function validateForm() {
                                    // Validate address
                                    const addressContent = document.getElementById('addressContent');
                                    if (addressContent.value.trim() === '') {
                                        alert('Address content cannot be empty');
                                        addressContent.focus();
                                        return false;
                                    }

                                    // Validate email format
                                    const emailContent = document.getElementById('emailContent');
                                    if (emailContent.value.trim() === '') {
                                        alert('Email content cannot be empty');
                                        emailContent.focus();
                                        return false;
                                    }

                                    // Check if the email content contains a valid email format
                                    const emailRegex = /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/;
                                    if (!emailRegex.test(emailContent.value)) {
                                        alert('Please enter a valid email address format');
                                        emailContent.focus();
                                        return false;
                                    }

                                    // Validate phone
                                    const phoneContent = document.getElementById('phoneContent');
                                    if (phoneContent.value.trim() === '') {
                                        alert('Phone content cannot be empty');
                                        phoneContent.focus();
                                        return false;
                                    }

                                    // Check if the phone content contains a 10-digit number
                                    const phoneRegex = /\b\d{10}\b/;
                                    if (!phoneRegex.test(phoneContent.value)) {
                                        alert('Phone number must contain exactly 10 digits');
                                        phoneContent.focus();
                                        return false;
                                    }

                                    return true;
                                }

    // Add event listeners for real-time validation
                                document.addEventListener('DOMContentLoaded', function () {
                                    const emailContent = document.getElementById('emailContent');
                                    const phoneContent = document.getElementById('phoneContent');

                                    // Add input event listeners for real-time feedback
                                    emailContent.addEventListener('input', function () {
                                        validateEmail(this);
                                    });

                                    phoneContent.addEventListener('input', function () {
                                        validatePhone(this);
                                    });

                                    // Auto-dismiss alerts after 5 seconds
                                    setTimeout(function () {
                                        const alerts = document.querySelectorAll('.alert');
                                        alerts.forEach(function (alert) {
                                            const bsAlert = new bootstrap.Alert(alert);
                                            bsAlert.close();
                                        });
                                    }, 5000);
                                });

                                function validateEmail(input) {
                                    const emailRegex = /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/;
                                    if (input.value.trim() !== '' && !emailRegex.test(input.value)) {
                                        input.classList.add('is-invalid');

                                        // Create or update feedback message
                                        let feedback = input.nextElementSibling;
                                        if (!feedback || !feedback.classList.contains('invalid-feedback')) {
                                            feedback = document.createElement('div');
                                            feedback.className = 'invalid-feedback';
                                            input.after(feedback);
                                        }
                                        feedback.textContent = 'Please enter a valid email address format';
                                    } else {
                                        input.classList.remove('is-invalid');
                                        input.classList.add('is-valid');

                                        // Remove any existing feedback
                                        const feedback = input.nextElementSibling;
                                        if (feedback && feedback.classList.contains('invalid-feedback')) {
                                            feedback.remove();
                                        }
                                    }
                                }

                                function validatePhone(input) {
                                    const phoneRegex = /\b\d{10}\b/;
                                    if (input.value.trim() !== '' && !phoneRegex.test(input.value)) {
                                        input.classList.add('is-invalid');

                                        // Create or update feedback message
                                        let feedback = input.nextElementSibling;
                                        if (!feedback || !feedback.classList.contains('invalid-feedback')) {
                                            feedback = document.createElement('div');
                                            feedback.className = 'invalid-feedback';
                                            input.after(feedback);
                                        }
                                        feedback.textContent = 'Phone number must contain exactly 10 digits';
                                    } else {
                                        input.classList.remove('is-invalid');
                                        input.classList.add('is-valid');

                                        // Remove any existing feedback
                                        const feedback = input.nextElementSibling;
                                        if (feedback && feedback.classList.contains('invalid-feedback')) {
                                            feedback.remove();
                                        }
                                    }
                                }
                </script>

    </body>

</html>