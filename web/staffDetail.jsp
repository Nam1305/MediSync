<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Staff Detail</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center">Thông tin chi tiết nhân viên</h2>
            <div class="card mt-4 p-4">
                <div class="d-flex align-items-center">
                    <img id="profileAvatar" src="${staff.avatar}" class="avatar avatar-small rounded-pill" alt="">

                    <h5 class="mb-0 ms-3" id="profileName">${staff.name}</h5>
                </div>
                <div class="row mt-4">
                    <div class="col-md-6">
                        <p><strong>Giới tính:</strong> 
                            <span id="profileGender" class="text-muted">
                                ${staff.gender}
                                </span>
                            </p>
                            <p><strong>Chức vụ:</strong> <span id="profilePosition" class="text-muted">${staff.position}</span></p>
                        <p><strong>Phòng ban:</strong> <span id="profileDepartment" class="text-muted">${staff.department.departmentName}</span></p>
                    </div>
                    <div class="col-md-6">
                        <p><strong>Số điện thoại:</strong> <span id="profilePhone" class="text-muted">${staff.phone}</span></p>
                        <p><strong>Email:</strong> <span id="profileEmail" class="text-muted">${staff.email}</span></p>
                        <p><strong>Ngày sinh:</strong> <span id="profileDob" class="text-muted">${staff.dateOfBirth}</span></p>
                    </div>
                </div>
                <p><strong>Mô tả:</strong> <span id="profileDescription" class="text-muted">${staff.description}</span></p>
            </div>
            <a href="ListDoctor" class="btn btn-secondary">Back to Staff List</a>
        </div>
    </body>
</html>
