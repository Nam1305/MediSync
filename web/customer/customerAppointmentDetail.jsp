<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <title>Chi tiết lịch hẹn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" />
        <style>
            table {
                table-layout: fixed;
                width: 100%;
            }

            td, th {
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            body {
                font-family: 'Arial', sans-serif;
                background-color: #f8f9fa;
                color: #333;
            }

            h2, h4, h5 {
                color: #28a745;
            }

            .card {
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                border: none;
            }

            .card h4 {
                border-bottom: 2px solid #28a745;
                padding-bottom: 10px;
            }

            .table {
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
            }

            th {
                background-color: #28a745 !important;
                color: white;
                text-align: center;
            }

            td {
                text-align: center;
                vertical-align: middle;
            }

            p {
                margin: 8px 0;
                font-size: 16px;
            }

            .border {
                border-radius: 8px;
            }

            .btn-primary {
                background-color: #28a745;
                border: none;
                padding: 10px 20px;
                font-size: 16px;
                border-radius: 6px;
            }

            .btn-primary:hover {
                background-color: #218838;
            }

            /* Điều chỉnh bảng Đơn thuốc */
            .prescription-table th:nth-child(1),
            .prescription-table td:nth-child(1) {
                width: 15%;
            }

            .prescription-table th:nth-child(2),
            .prescription-table td:nth-child(2) {
                width: 9%;
            }

            .prescription-table th:nth-child(3),
            .prescription-table td:nth-child(3) {
                width: 22%;
            }

            .prescription-table th:nth-child(4),
            .prescription-table td:nth-child(4) {
                width: 50%;
                max-width: 50%;
                white-space: normal;
            }

            .scrollable-note {
                max-height: 80px;
                overflow-y: auto;
                padding: 5px;
                background-color: #f9f9f9;
                border-radius: 5px;
            }
        </style>
    </head>



    <body>
        <div class="container mt-5">
            <h2 class="text-center">Chi tiết lịch hẹn</h2>

            <!-- Thông tin bác sĩ phụ trách -->
            <div class="card mt-4 p-4">
                <h4 class="text-primary">Thông tin bác sĩ phụ trách</h4>
                <div class="doctor-info mb-3">
                    <img src="${doctor.avatar}" alt="Avatar của bác sĩ" class="rounded-circle shadow-md avatar avatar-md-md">
                    <h5>${doctor.name}</h5>
                </div>
                <table class="table table-bordered">
                    <tr>
                        <th>Họ và tên</th>
                        <th>Giới tính</th>
                        <th>Email</th>
                        <th>Số điện thoại</th>
                        <th>Chuyên khoa</th>
                    </tr>
                    <tr>
                        <td>${doctor.name}</td>
                        <td>
                            <c:choose>
                                <c:when test="${doctor.gender.trim() == 'M'}">Nam</c:when>
                                <c:when test="${doctor.gender.trim() == 'F'}">Nữ</c:when>
                                <c:otherwise>Khác</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${doctor.email}</td>
                        <td>${doctor.phone}</td>
                        <td>${doctor.department.departmentName}</td>
                    </tr>
                </table>
                <div class="mt-3">
                    <h5 class="text-primary">Giới thiệu bác sĩ ${doctor.name}:</h5>
                    <p class="border p-3 bg-light">${doctor.description}</p>
                </div>
            </div>

            <!-- Bệnh án -->
            <c:if test="${not empty treat}">
                <div class="card mt-4 p-4">
                    <h4 class="text-center">Bệnh án</h4>
                    <p><strong>Triệu chứng:</strong> ${treat.symptoms}</p>
                    <p><strong>Chẩn đoán:</strong> ${treat.diagnosis}</p>
                    <p><strong>Kết quả xét nghiệm:</strong> ${treat.testResult}</p>
                    <p><strong>Kế hoạch điều trị:</strong> ${treat.plan}</p>
                    <p><strong>Theo dõi:</strong> ${treat.followUp}</p>
                </div>
            </c:if>




            <!-- Đơn thuốc -->
            <c:if test="${not empty prescription}">
                <div class="card mt-4 p-4">
                    <h4 class="text-primary">Đơn thuốc</h4>
                    <table class="table table-bordered prescription-table">
                        <thead>
                            <tr>
                                <th>Tên thuốc</th>
                                <th>Số lượng</th>
                                <th>Liều lượng</th>
                                <th>Lưu ý</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="prescription" items="${prescription}">
                                <tr>
                                    <td>${prescription.medicineName}</td>
                                    <td>${prescription.totalQuantity}</td>
                                    <td>${prescription.dosage}</td>
                                    <td>
                                        <div class="scrollable-note">${prescription.note}</div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <div class="mt-4 card p-4">
                <h4 class="text-primary">Đánh giá bác sĩ</h4>

                <form action="appointmentDetail" method="post">
                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">

                    <div class="mb-3">
                        <label for="ratings" class="form-label">Chọn số sao (1 - 5):</label>
                        <select name="ratings" class="form-control" required>
                            <option value="5" ${ratings == 5 ? 'selected' : ''}>⭐⭐⭐⭐⭐: Cực kì hài lòng</option>
                            <option value="4" ${ratings == 4 ? 'selected' : ''}>⭐⭐⭐⭐: Hài lòng</option>
                            <option value="3" ${ratings == 3 ? 'selected' : ''}>⭐⭐⭐: Tốt</option>
                            <option value="2" ${ratings == 2 ? 'selected' : ''}>⭐⭐: Không tốt</option>
                            <option value="1" ${ratings == 1 ? 'selected' : ''}>⭐: Tệ</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="content" class="form-label">Nội dung đánh giá (tối đa 500 ký tự):</label>
                        <textarea name="content" class="form-control" maxlength="500" rows="3" required>${content}</textarea>
                    </div>

                    <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
                </form>

                <p class="text-success mt-2">${message}</p> <!-- Hiển thị thông báo nếu có -->
            </div>



            <!-- Nút quay lại -->
            <div class="text-center mt-3">
                <a href="${pageContext.request.contextPath}/listAppointments" class="btn btn-primary">Quay lại danh sách cuộc hẹn</a>
            </div>
        </div>

        <!-- Scripts -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
