<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết dịch vụ</title>
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Thông tin chi tiết Dịch Vụ</h2>
            <div class="card mt-4 p-4">
                <div class="d-flex align-items-center">
                    <h5 class="mb-0 ms-3" id="profileName">${service.name}</h5>
                </div>
     
                <p><strong>Mô tả:</strong> <span id="profileDescription" class="text-muted">${service.content}</span></p>
            </div>
            <a href="ListService" class="btn btn-secondary">Trở lại Danh Sách Dịch Vụ</a>
        </div>
    </body>
</html>
