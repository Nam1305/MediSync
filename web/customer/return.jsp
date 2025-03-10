<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Kết quả thanh toán</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div class="container mt-5">
            <div class="card shadow-lg p-4">
                <div class="modal-header border-bottom p-3">
                    <div class="col-lg-8 col-md-6">
                        <img src="assets/images/logo-dark.png" height="22" alt="Logo">
                    </div>
                    <button type="button" class="btn-close" onclick="window.location.href = 'index.jsp'"></button>
                </div>

                <div class="card-body text-center">
                    <c:choose>
                        <c:when test="${not empty orderId}">
                            <!-- Giao dịch thành công -->
                            <div class="alert alert-success p-3 rounded-3">
                                <h4 class="fw-bold">🎉 Giao dịch thành công!</h4>
                                <p class="mb-0">Mã đơn hàng: <strong>${orderId}</strong></p>
                                <p>Số tiền: 
                                    <strong>
                                        <fmt:setLocale value="vi_VN" />
                                        <fmt:formatNumber value="${amount}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                    </strong> VNĐ
                                </p>
                                <p>Ngân hàng: <strong>${bankCode}</strong></p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <!-- Giao dịch thất bại -->
                            <div class="alert alert-danger p-3 rounded-3">
                                <h4 class="fw-bold">❌ Giao dịch thất bại!</h4>
                                <p>${message}</p>
                            </div>
                        </c:otherwise>
                    </c:choose>


                    <div class="mt-4">
                        <a href="listAppointments" class="btn btn-primary px-4">🏠 Quay về danh sách lịch hẹn</a>
                    </div>
                </div>
            </div>
        </div>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
