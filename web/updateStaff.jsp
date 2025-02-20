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
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <body>


        <div class="container mt-5">
            <h3>Chỉnh Sửa Thông Tin Nhân Viên</h3>
            <form class="mt-4" method="post" action="UpdateStaffServlet">
                <!-- Input Hidden -->
                <input type="hidden" name="staffId" id="staffId" value="${param.staffId != null ? param.staffId : staff.staffId}">

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">

                            <img src="${staff.avatar}" 
                                 class="avatar avatar-md-sm rounded-circle shadow" alt="">

                            <label class="form-label">Name</label>
                            <input name="name" id="name" type="text" class="form-control" placeholder="Name" value ="${param.name != null ? param.name : staff.name}">
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input name="email" id="email" type="email" class="form-control" placeholder="Email" value ="${param.email != null ? param.email : staff.email}">                        
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Phone</label>
                            <input name="phone" id="phone" type="text" class="form-control" placeholder="Phone" value ="${param.phone != null ? param.phone : staff.phone}">
                        </div>
                    </div><!--end col-->


                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Date of Birth</label>
                            <input name="dateOfBirth" id="dateOfBirth" type="date" class="form-control" value ="${param.dateOfBirth != null ? param.dateOfBirth : staff.dateOfBirth}">
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

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Department</label>
                            <select name="departmentId" id="departmentId" class="form-control department-name select2input">
                                <c:forEach var="department" items="${requestScope.listDepartment}">
                                    <option value="${department.departmentId}">${department.departmentName}</option>
                                </c:forEach>
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

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <input name="description" id="description" type="text" class="form-control" placeholder="Description" value ="${param.description != null ? param.description : staff.description}">
                        </div>
                    </div><!--end col-->

                    <div class="col-sm-12">
                        <div class="mb-3">
                            <input type="submit" id="submit" name="update" class="btn btn-primary" value="Save Changes">
                            <a href="ListDoctor" class="btn btn-secondary">Back to List</a>
                        </div>

                    </div>
                    <div>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger mt-3">${error}</div>
                        </c:if>
                    </div>

            </form><!--end form-->
        </div>
    </body>
</html>
