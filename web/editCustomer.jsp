<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Doctris - Edit Customer</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    </head>

    <body>
        <div class="container mt-5">
            <h2 class="mb-4">Chỉnh sửa thông tin khách hàng</h2>
            <c:if test="${not empty customer.avatar}">
                <div class="d-flex align-items-center mb-3">
                    <img src="${customer.avatar.startsWith('/uploads/') ? pageContext.request.contextPath.concat(customer.avatar) : customer.avatar}" 
                         class="avatar avatar-md-sm rounded-circle shadow" alt="Avatar">
                    <span class="ms-2 fw-bold">${customer.name}</span>
                </div>
            </c:if>
            <form class="mt-4" method="POST" action="editCustomer">
                <input type="hidden" name="id" id="id" value="${customer.customerId}">
                <input type="hidden" name="avatar" id="avatar" value="${customer.avatar}">

                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Họ và Tên</label>
                            <input name="full-name" id="full-name" type="text" class="form-control" placeholder="Full name:" value="${customer.name}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Giới tính</label>
                            <div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="male" value="M" ${customer.gender == 'M' ? 'checked' : ''} >
                                    <label class="form-check-label" for="male">Male</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="gender" id="female" value="F" value="F" ${customer.gender == 'F' ? 'checked' : ''} >
                                    <label class="form-check-label" for="female">Female</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Your Email</label>
                            <input name="email" id="email" type="email" class="form-control" placeholder="Your email :" value="${customer.email}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Số Điện Thoại</label>
                            <input name="number" id="number" type="text" class="form-control" placeholder="Phone number:" value="${customer.phone}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ</label>
                            <input name="address" id="address" type="text" class="form-control" placeholder="Your address:" value="${customer.address}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label">Ngày sinh</label>
                            <input name="dob" id="dob" type="date" class="form-control" value="${customer.dateOfBirth}" required>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12">
                        <input type="submit" id="submit" name="send" class="btn btn-primary" value="Lưu thay đổi">
                        <a href="listCustomer" class="btn btn-secondary ms-2">Quay về danh sách khách hàng</a>
                    </div>
                </div>
                <c:if test="${not empty errors}">
                    <div class="alert alert-danger mt-3">

                        <c:forEach var="error" items="${errors}">
                            <p>${error}</p>
                        </c:forEach>

                    </div>
                </c:if>

                <c:if test="${not empty message}">
                    <div class="alert alert-success mt-3">${message}</div>
                </c:if>  
            </form>
        </div>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>

</html>