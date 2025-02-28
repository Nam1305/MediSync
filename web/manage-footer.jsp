<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Footer Management</title>
        <!-- Include CSS files -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
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
                <jsp:include page="layout/navbar.jsp" />

                <div class="container mt-5">
                    <h2 class="text-center mb-4">Footer Management</h2>

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

                    <!-- Footer Content Form -->
                    <div class="card mb-4">
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
                                    <label for="addressContent" class="form-label"><i class="fas fa-map-marker-alt me-2"></i>Address</label>
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
                                    <label for="phoneContent" class="form-label"><i class="fas fa-phone me-2"></i>Phone Number</label>
                                    <textarea class="form-control" id="phoneContent" name="phoneContent" rows="2" required>${phoneContent.content}</textarea>
                                    <c:if test="${phoneContent != null}">
                                        <input type="hidden" name="phoneId" value="${phoneContent.blogId}">
                                    </c:if>
                                </div>

                                <div class="d-flex justify-content-end">
                                    <button type="reset" class="btn btn-secondary me-2">
                                        <i class="fas fa-undo me-1"></i> Reset
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <c:choose>
                                            <c:when test="${footerContentExists}">
                                                <i class="fas fa-save me-1"></i> Update
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-save me-1"></i> Save
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
                                <h5 class="mb-0"><i class="fas fa-eye me-2"></i>Preview Current Footer Content</h5>
                                <span class="text-muted">
                                    <c:choose>
                                        <c:when test="${addressContent != null}">
                                            Last Updated: ${addressContent.date}
                                        </c:when>
                                        <c:when test="${emailContent != null}">
                                            Last Updated: ${emailContent.date}
                                        </c:when>
                                        <c:when test="${phoneContent != null}">
                                            Last Updated: ${phoneContent.date}
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
                                                    <i class="fas fa-map-marker-alt me-2"></i>Address
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
                                                    <i class="fas fa-phone me-2"></i>Phone Number
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
            </div>
        </main>
    </body>
</html>