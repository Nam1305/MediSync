<%-- 
    Document   : updateDepartment
    Created on : Feb 18, 2025, 11:34:48 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <title>Update Department</title>
    </head>
    <body>
        <div class="container mt-5">
            <h3>Chỉnh Sửa Thông Tin Phòng Ban</h3>
            <form class="mt-4" method="post" action="UpdateDepartment">
                <!-- Input Hidden -->
                <input type="hidden" name="departmentId" id="departmentId" value="${param.departmentId != null ? param.departmentId : department.departmentId}">

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input name="name" id="name" type="text" class="form-control" placeholder="Name" value ="${param.departmentName != null ? param.departmentName : department.departmentName}">
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
                    
                    <div class="col-sm-12">
                        <div class="mb-3">
                            <input type="submit" id="submit" name="update" class="btn btn-primary" value="Save Changes">
                            <a href="ListDepartment" class="btn btn-secondary">Back to List</a>
                        </div>

                    </div>
                    <div>
                        <c:if test="${not empty error}">
                            <div style="color: red">${error}</div>
                        </c:if>
                        <c:if test="${not empty success}">
                            <div style="color: green">${success}</div>
                        </c:if>
                    </div>
            </form><!--end form-->
        </div>
    </body>
</html>
