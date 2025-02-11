<%-- 
    Document   : updateStaff
    Created on : Feb 9, 2025, 9:03:20 AM
    Author     : Acer
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Staff</title>
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <style>
            /* Định nghĩa màu sắc chủ đạo */
            :root {
                --primary-color: #4CAF50; /* Màu xanh lá chủ đạo */
                --primary-dark: #388E3C; /* Màu xanh lá đậm hơn */
                --primary-light: #C8E6C9; /* Màu xanh lá nhạt */
                --text-color: #ffffff; /* Màu chữ trên nền xanh */
                --border-color: #2E7D32;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: var(--primary-light);
                color: #333;
                padding: 20px;
            }

            form {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .form-label {
                font-weight: bold;
                color: var(--primary-dark);
            }

            .form-control {
                border: 1px solid var(--border-color);
                border-radius: 5px;
                padding: 8px;
            }

            .form-control:focus {
                border-color: var(--primary-dark);
                box-shadow: 0 0 5px var(--primary-light);
            }

            .btn-primary {
                background-color: var(--primary-color);
                border: none;
                color: var(--text-color);
                padding: 10px 15px;
                border-radius: 5px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .btn-primary:hover {
                background-color: var(--primary-dark);
            }

            .btn-primary:active {
                background-color: var(--border-color);
            }

            select.form-control, input.form-control {
                width: 100%;
                margin-bottom: 10px;
            }

            /* Căn chỉnh hàng ngang */
            .row {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
            }

            .col-md-6 {
                flex: 1 1 calc(50% - 10px);
            }

            @media (max-width: 768px) {
                .col-md-6 {
                    flex: 1 1 100%;
                }
            }
        </style>

    </head>
    <body>
        <form class="mt-4" method="post" action="UpdateStaffServlet">
            <!-- Input Hidden -->
            <input type="hidden" name="staffId" id="staffId" value="${staff.staffId}">

            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Name</label>
                        <input name="name" id="name" type="text" class="form-control" placeholder="Name" value ="${staff.name}">
                    </div>
                </div><!--end col-->

                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input name="email" id="email" type="email" class="form-control" placeholder="Email" value ="${staff.email}">
                    </div>
                </div><!--end col-->

                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input name="phone" id="phone" type="text" class="form-control" placeholder="Phone" value ="${staff.phone}" >
                    </div>
                </div><!--end col-->

                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input name="password" id="password" type="password" class="form-control" placeholder="Password" value ="${staff.password}" >
                    </div>
                </div><!--end col-->

                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Date of Birth</label>
                        <input name="dateOfBirth" id="dateOfBirth" type="date" class="form-control"value ="${staff.dateOfBirth}">
                    </div>
                </div><!--end col-->

                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Position</label>

                        <select name="position" id="position" class="form-control">
                            <option value="Doctor">Doctor</option>
                            <option value="Expert">Expert</option>
                            <option value="Receptionist">Receptionist</option>
                        </select>
                    </div>
                </div><!--end col-->

                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Gender</label>
                        <select name="gender" id="gender" class="form-control">
                            <option value="M">Male</option>
                            <option value="F">Female</option>
                        </select>
                    </div>
                </div><!--end col-->

                <div class="col-md-6">
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <select name="status" id="status" class="form-control">
                            <option value="Active">Active</option>
                            <option value="Inactive">Inactive</option>
                        </select>
                    </div>
                </div><!--end col-->
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <input name="description" id="description" type="text" class="form-control" placeholder="Description" value ="${staff.description}">
                        </div>
                    </div><!--end col-->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Department</label>
                            <select name="departmentId" id="departmentId" class="form-control">
                                <option value="1">Khoa nội tổng quát</option>
                                <option value="2">Khoa Tai Mũi Họng</option>
                                <option value="3">Khoa Xét Nghiệm</option>
                                <option value="4">Khoa Ngoại Cơ Bản</option>
                                <option value="5">Hành Chính</option>
                            </select>
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select name="roleId" id="roleId" class="form-control">
                                <option value="2">Doctor</option>
                                <option value="3">Expert</option>
                                <option value="4">Receptionist</option>
                            </select>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row">
                    <div class="col-sm-12">
                        <input type="submit" id="submit" name="update" class="btn btn-primary" value="Save Changes">
                    </div><!--end col-->
                </div><!--end row-->
                <div>
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger mt-3">${error}</div>
                    </c:if>
                </div>

        </form><!--end form-->
    </body>
</html>
