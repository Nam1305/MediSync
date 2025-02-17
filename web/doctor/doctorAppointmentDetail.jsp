<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết lịch hẹn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                background-color: #f0f4f7; /* Màu nền nhẹ nhàng hơn */
                font-family: 'Arial', sans-serif;
            }
            .container {
                max-width: 900px;
                margin-top: 30px;
            }
            .card {
                border-radius: 15px; /* Bo góc đẹp hơn */
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ */
            }
            .card-header {
                background-color: #3b8b3a; /* Màu xanh đậm hơn */
                color: white;
                font-size: 20px; /* Kích thước chữ lớn hơn */
                font-weight: bold;
                border-top-left-radius: 15px; /* Bo góc trên bên trái */
                border-top-right-radius: 15px; /* Bo góc trên bên phải */
            }
            .customer-image {
                width: 150px;
                height: 150px;
                border-radius: 50%; /* Hình tròn */
                object-fit: cover;
                border: 3px solid #3b8b3a; /* Đường viền xung quanh ảnh */
                margin-bottom: 15px;
            }
            .info-label {
                font-weight: bold;
                color: #333; /* Màu chữ dễ đọc hơn */
            }
        </style>
    </head>
    <body>

        <div class="container">
            <a href="#" class="btn btn-secondary mb-3" onclick="history.back(); return false;">Quay lại</a>
            <h3 class="text-center text-success">Chi tiết lịch hẹn</h3>

            <!-- Thông tin khách hàng -->
            <div class="card mb-3">
                <div class="card-header">Thông tin khách hàng</div>
                <div class="card-body d-flex align-items-start">
                    <img src="data:image/jpeg;base64,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" alt="Ảnh khách hàng" class="customer-image">
                    <div class="ms-3">
                        <div class="row">
                            <div class="col-md-6">
                                <p><span class="info-label">Tên:</span> Duc</p>
                                <p><span class="info-label">Email:</span> hello@example.com</p>
                                <p><span class="info-label">Địa chỉ:</span> 123 Đường ABC</p>
                                <p><span class="info-label">Ngày sinh:</span> 2004-01-01</p>
                            </div>
                            <div class="col-md-6">
                                <p><span class="info-label">Số điện thoại:</span> 100</p>
                                <p><span class="info-label">Giới tính:</span> Nam</p>
                                <p><span class="info-label">Nhóm máu:</span> O</p>
                                <p><span class="info-label">Trạng thái:</span> Hoạt động</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Treatment Plan -->
            <div class="card mb-3">
                <div class="card-header">Hướng điều trị (Treatment Plan)</div>
                <div class="card-body">
                    <form action="saveTreatment" method="post">
                        <input type="hidden" name="appointmentId" value="" />
                        <div class="mb-2">
                            <label>Triệu chứng:</label>
                            <textarea class="form-control" name="symptoms" required></textarea>
                        </div>
                        <div class="mb-2">
                            <label>Chẩn đoán:</label>
                            <textarea class="form-control" name="diagnosis" required></textarea>
                        </div>
                        <div class="mb-2">
                            <label>Kết quả xét nghiệm:</label>
                            <textarea class="form-control" name="testResults"></textarea>
                        </div>
                        <div class="mb-2">
                            <label>Kế hoạch điều trị:</label>
                            <textarea class="form-control" name="treatmentPlan" required></textarea>
                        </div>
                        <div class="mb-2">
                            <label>Theo dõi:</label>
                            <textarea class="form-control" name="followUp"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Lưu Treatment Plan</button>
                    </form>
                </div>
            </div>

            <!-- Đơn thuốc -->
            <div class="card">
                <div class="card-header">Đơn thuốc</div>
                <div class="card-body">
                    <form action="savePrescription" method="post">
                        <input type="hidden" name="appointmentId" value="" />
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Tên thuốc</th>
                                    <th>Tổng số lượng</th>
                                    <th>Liều lượng</th>
                                    <th>Ghi chú</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="prescriptionTable">
                                <tr>
                                    <td><input type="text" name="medicineName[]" class="form-control" required></td>
                                    <td><input type="text" name="totalQuantity[]" class="form-control" required></td>
                                    <td><input type="text" name="dosage[]" class="form-control" required></td>
                                    <td><input type="text" name="note[]" class="form-control"></td>
                                    <td><button type="button" class="btn btn-danger remove-medicine">Xóa</button></td>
                                </tr>
                            </tbody>
                        </table>
                        <button type="button" class="btn btn-success" id="addMedicine">Thêm thuốc</button>
                        <button type="submit" class="btn btn-primary">Lưu đơn thuốc</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                $("#addMedicine").click(function () {
                    $("#prescriptionTable").append(`
                        <tr>
                            <td><input type="text" name="medicineName[]" class="form-control" required></td>
                            <td><input type="text" name="totalQuantity[]" class="form-control" required></td>
                            <td><input type="text" name="dosage[]" class="form-control" required></td>
                            <td><input type="text" name="note[]" class="form-control"></td>
                            <td><button type="button" class="btn btn-danger remove-medicine">Xóa</button></td>
                        </tr>
                    `);
                });

                $(document).on("click", ".remove-medicine", function () {
                    $(this).closest("tr").remove();
                });

                // Thêm hiệu ứng cho nút thêm thuốc
                $("#addMedicine").hover(
                        function () {
                            $(this).addClass("btn-light"); // Thay đổi màu nền khi hover
                        }, function () {
                    $(this).removeClass("btn-light");
                }
                );
            });
        </script>
    </body>
</html>