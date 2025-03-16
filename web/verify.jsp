<%-- 
    Document   : verify
    Created on : Jan 11, 2025, 11:31:59 AM
    Author     : DIEN MAY XANH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->       

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <title>Verify Code</title>
        <style>
            .error-message {
                color: red;
            }
            .verification-table {
                margin-top: 100px; /* Đẩy bảng xuống giữa màn hình */
                max-width: 400px; /* Chiều rộng tối đa của bảng */
                margin-left: auto;
                margin-right: auto; /* Giữa màn hình */
                padding: 20px; /* Khoảng cách trong bảng */
                border: 1px solid #ced4da; /* Viền bảng */
                border-radius: 5px; /* Bo góc viền */
                background-color: #ffffff; /* Màu nền bảng */
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ cho bảng */
            }
        </style>
    </head>
    <body>

        <div class="container">
            <div class="verification-table">
                <h2 class="text-center">Xác nhận mã để hoàn thành đăng kí!</h2>
                <form action="register" class="verify-form mt-4" method="get" id="verification-form">
                    <div class="mb-3">
                        <label class="form-label">Hãy nhập mã để xác nhận!<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" placeholder="Code" name="code" required>
                        <input type="hidden" name="email" value="${email}">
                        <input type="hidden" name="password" value="${password}">
                        <input type="hidden" name="phone" value="${phone}">
                        <input type="hidden" name="address" value="${address}">
                        <input type="hidden" name="name" value="${name}">
                    </div>
                    <div class="error-message" id="error-message" style="color: red;">
                        ${error}
                    </div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-success" style="width: 100%;">Xác nhận</button>
                    </div>
                </form>
            </div>
        </div>


    </body>
</html>