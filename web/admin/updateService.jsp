<%-- 
    Document   : updateDepartment
    Created on : Feb 18, 2025, 11:34:48 PM
    Author     : Acer
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Select2 -->
        <link href="assets/css/select2.min.css" rel="stylesheet" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <title>Cập nhật dịch vụ</title>
    </head>
    <body>
        <div class="container mt-5">
            <h3>Chỉnh Sửa Thông Tin Dịch Vụ</h3>
            <form class="mt-4" method="post" action="UpdateService">
                <!-- Input Hidden -->
                <input type="hidden" name="serviceId" id="serviceId" value="${service.serviceId}">

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Name</label>
                            <input name="name" id="name" type="text" class="form-control" placeholder="Name" value ="${service.name}">
                        </div>
                    </div><!--end col-->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Mô tả </label>
                            <textarea name="content" id="content" type="text" class="form-control" placeholder="Mô tả" >${service.content}</textarea>
                        </div>
                    </div><!--end col-->
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Giá</label>
                            <input name="price" id="price" type="number" class="form-control" placeholder="Giá" value ="${service.price}">
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
                            <a href="ListService" class="btn btn-secondary">Back to List</a>
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
                </div>
            </form><!--end form-->
        </div>
    </body>
</html>
