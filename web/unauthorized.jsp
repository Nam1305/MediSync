<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Không có quyền truy cập</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
        }
        .error-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            background-color: #f8f8f8;
        }
        .error-message {
            color: #d9534f;
            font-size: 18px;
            margin-bottom: 20px;
        }
        .home-link {
            display: inline-block;
            padding: 10px 20px;
            background-color: #5bc0de;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            margin: 10px;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h2>Thông báo</h2>
        <div class="error-message">
            ${errorMessage}
        </div>
        
        <div>
            <a href="javascript:history.back()" class="home-link">Quay lại trang trước</a>
        </div>
    </div>
</body>
</html>