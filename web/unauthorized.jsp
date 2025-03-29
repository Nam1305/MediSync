<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Không có quyền truy cập - Medisync</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Favicon -->
    <link rel="shortcut icon" href="assets/images/logo-icon.png">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            font-family: 'Poppins', sans-serif;
            overflow: hidden;
        }
        .bg-home {
            height: 100vh;
            width: 100vw;
            background: url('assets/images/bg/bg-lines-one.png') center/cover no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
        }
        .bg-home::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(220, 53, 69, 0.1); /* Lớp phủ màu danger nhạt */
            z-index: 1;
        }
        .error-container {
            text-align: center;
            padding: 50px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            max-width: 700px;
            position: relative;
            z-index: 2;
            animation: fadeIn 0.5s ease-in-out;
        }
        .error-code {
            font-size: 6rem;
            font-weight: 700;
            color: #dc3545; /* Màu danger */
            text-shadow: 2px 2px 5px rgba(220, 53, 69, 0.3);
            margin-bottom: 20px;
        }
        .error-message {
            font-size: 1.6rem;
            font-weight: 600;
            color: #333;
            margin: 20px 0;
            line-height: 1.4;
        }
        .description {
            font-size: 1rem;
            color: #666;
            margin-bottom: 30px;
        }
        .btn-action {
            border: none;
            padding: 12px 30px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            margin: 0 10px;
            color: white;
        }
        .btn-back {
            background-color: #6c757d;
        }
        .btn-back:hover {
            background-color: #5a6268;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(90, 98, 104, 0.4);
        }
        .btn-home {
            background-color: #dc3545;
        }
        .btn-home:hover {
            background-color: #bb2d3b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(187, 45, 59, 0.4);
        }
        /* Animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        /* Icon */
        .lock-icon {
            font-size: 3rem;
            color: #dc3545;
            margin-bottom: 15px;
        }
        /* Responsive */
        @media (max-width: 576px) {
            .error-code {
                font-size: 4rem;
            }
            .error-message {
                font-size: 1.2rem;
            }
            .error-container {
                padding: 30px;
            }
            .btn-action { 
                display: block;
                width: 100%;
                margin: 10px 0;
            }
        }
    </style>
</head>
<body>
    <section class="bg-home">
        <div class="error-container">
            <div class="error-code">403</div>
            <div class="lock-icon">
                <svg xmlns="http://www.w3.org/2000/svg" width="64" height="64" fill="currentColor" class="bi bi-lock-fill" viewBox="0 0 16 16">
                    <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z"/>
                </svg>
            </div>
            <div class="error-message">
                Không có quyền truy cập
            </div>
            <p class="description">${errorMessage}</p>
            <div class="d-flex flex-wrap justify-content-center">
                <a href="javascript:history.back()" class="btn btn-action btn-back">Quay lại trang trước</a>
                <a href="<%= request.getContextPath() %>/home" class="btn btn-action btn-home">Về trang chủ</a>
            </div>
        </div>
    </section>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>