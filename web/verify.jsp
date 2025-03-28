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
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <title>Xác nhận OTP</title>
        <style>
            .error-message {
                color: red;
            }
            .verification-table {
                margin-top: 100px;
                max-width: 400px;
                margin-left: auto;
                margin-right: auto;
                padding: 20px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                background-color: #ffffff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="verification-table">
                <h2 class="text-center">Xác nhận OTP!</h2>
                <form action="register" class="verify-form mt-4" method="get" id="verification-form">
                    <div class="mb-3">
                        <label class="form-label">Hãy nhập mã OTP đã được gửi qua mail!<span class="text-danger">*</span></label>
                        <input type="text" class="form-control" placeholder="OTP" name="code" required>
                        <input type="hidden" name="email" value="${email}">
                        <input type="hidden" name="password" value="${password}">
                        <input type="hidden" name="phone" value="${phone}">
                        <input type="hidden" name="address" value="${address}">
                        <input type="hidden" name="name" value="${name}">
                    </div>
                    <div class="error-message text-center" id="error-message">${error}</div>
                    <div class="d-grid">
                        <button type="submit" class="btn btn-success" style="width: 100%;">Xác nhận</button>
                    </div>
                </form>
                <!-- Form gửi lại mã -->
                <form action="register" method="get" class="mt-3 text-center">
                    <input type="hidden" name="action" value="resend">
                    <input type="hidden" name="email" value="${email}">
                    <input type="hidden" name="password" value="${password}">
                    <input type="hidden" name="phone" value="${phone}">
                    <input type="hidden" name="address" value="${address}">
                    <input type="hidden" name="name" value="${name}">
                    <button type="submit" class="btn btn-link">Gửi lại mã</button>
                </form>
            </div>
        </div>
    </body>
</html>