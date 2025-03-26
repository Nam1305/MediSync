<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Department Detail</title>
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Thông tin chi tiết Phòng Ban</h2>
            
            <div class="card mt-4 p-4">
                <h4 class="mb-3">${department.departmentName}</h4>
                
                <h5 class="mt-4">Số lượng nhân viên theo vai trò</h5>
                <table class="table table-bordered mt-3">
                    <thead class="table-dark">
                        <tr>
                            <th>Vai trò</th>
                            <th>Số lượng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Bác sĩ</td>
                            <td>${staffCount[0]}</td>
                        </tr>
                        <tr>
                            <td>Chuyên gia</td>
                            <td>${staffCount[1]}</td>
                        </tr>
                        <tr>
                            <td>Nhân viên</td>
                            <td>${staffCount[2]}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <a href="ListDepartment" class="btn btn-secondary mt-3">Quay lại danh sách phòng ban</a>
        </div>
    </body>
</html>
