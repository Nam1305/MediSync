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
        <script src="https://cdn.tiny.cloud/1/vnufc6yakojjcovpkijlauot8hfpbxd3uscxatfq2m4yijay/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>        
        <script src="assets/js/tinymce-init.js"></script>
    </head>
    <body>


        <div class="container mt-5">
            <h3>Chỉnh Sửa Thông Tin Nhân Viên</h3>
            <form class="mt-4" method="post" action="UpdateStaffServlet">
                <!-- Input Hidden -->
                <input type="hidden" name="staffId" id="staffId" value="${staff.staffId}">

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">

                            <img src="${staff.avatar}" 
                                 class="avatar avatar-md-sm rounded-circle shadow" alt="">

                            <label class="form-label">Họ và Tên</label>
                            <input name="name" id="name" type="text" class="form-control" placeholder="Họ và tên" value ="${param.name != null ? param.name : staff.name}">
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
                            <label class="form-label">Số điện thoại</label>
                            <input name="phone" id="phone" type="text" class="form-control" placeholder="Số điện thoại" value ="${param.phone != null ? param.phone : staff.phone}">
                        </div>
                    </div><!--end col-->


                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Ngày sinb</label>
                            <input name="dateOfBirth" id="dateOfBirth" type="date" class="form-control" value ="${param.dateOfBirth != null ? param.dateOfBirth : staff.dateOfBirth}">
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Vị trí làm việc</label>

                            <select name="position" id="position" class="form-control">
                                <option value="Doctor">Bác sĩ</option>
                                <option value="Expert">Chuyên gia</option>
                                <option value="Receptionist">Nhân viên hành chính</option>
                            </select>
                        </div>
                    </div><!--end col-->

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Giới tính</label>
                            <select name="gender" id="gender" class="form-control">
                                <option value="M">Nam</option>
                                <option value="F">Nữ</option>
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
                            <label class="form-label">Phòng Ban</label>
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
                            <label class="form-label">Mô tả</label>
                            <input name="description" id="description" type="text" class="form-control" placeholder="Mô tả" value ="${param.description != null ? param.description : staff.description}">
                        </div>
                    </div><!--end col-->
                    <div class="col-md-12">
                        <div class="mb-3">
                            <label class="form-label">Chứng chỉ</label>
                            <textarea id="testResults" class="form-control" name="certificate" >${param.certificate != null ? param.certificate : staff.certificate}</textarea>
                        </div> 
                    </div><!--end col-->
                    <div class="col-sm-12">
                        <div class="mb-3">
                            <input type="submit" id="submit" name="update" class="btn btn-primary" value="Lưu thay đổi">
                            <a href="ListDoctor" class="btn btn-secondary">Trở lại danh sách</a>
                        </div>

                    </div>
                    <div>
                        <c:if test="${not empty errors}">
                            <ul style="color: red">
                                <c:forEach var="err" items="${errors}">
                                    <li>${err}</li>
                                    </c:forEach>
                            </ul>
                        </c:if>
                        <c:if test="${not empty success}">
                            <ul style="color: green">

                                <li>${success}</li>

                            </ul>
                        </c:if>
                    </div>


            </form><!--end form-->
        </div>
    </body>
</html>
