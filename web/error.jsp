<%-- 
    Document   : 404
    Created on : Jan 31, 2025, 2:25:00 PM
    Author     : DIEN MAY XANH
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lỗi - Medisync</title>
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
                background: rgba(25, 135, 84, 0.1); /* Lớp phủ màu success nhạt */
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
                color: #198754; /* Màu success */
                text-shadow: 2px 2px 5px rgba(25, 135, 84, 0.3);
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
            .btn-home {
                background-color: #198754;
                border: none;
                padding: 12px 30px;
                font-size: 1.1rem;
                font-weight: 600;
                border-radius: 50px;
                transition: all 0.3s ease;
            }
            .btn-home:hover {
                background-color: #146c43;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(20, 108, 67, 0.4);
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
            }
        </style>
    </head>
    <body>
        <section class="bg-home">
            <div class="error-container">
                <div class="error-code"><%= response.getStatus() %></div>
                <div class="error-message">
                    <% 
                        if (response.getStatus() == 404) {
                            out.print("Không tìm thấy trang bạn yêu cầu!");
                        } else if (response.getStatus() == 500) {
                            out.print("Máy chủ gặp lỗi, chúng tôi rất tiếc về sự cố này!");
                        }
                    %>
                </div>
                <p class="description">Medisync - Hệ thống đặt lịch khám bác sĩ trực tuyến</p>
                <a href="<%= request.getContextPath() %>/home" class="btn btn-home" style="color: white;">Về trang chủ</a>
            </div>
        </section>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>