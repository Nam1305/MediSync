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
                background-color: #f8f9fa; /* Màu nền sáng, dễ nhìn */
                font-family: 'Arial', sans-serif;
            }

            .container {
                max-width: 900px;
                margin-top: 40px;
            }

            .card {
                border-radius: 15px;
                box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }

            .card-header {
                background-color: #28a745; /* Màu xanh success */
                color: white;
                font-size: 20px;
                font-weight: bold;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                text-align: center;
            }

            .customer-image {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #28a745;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 15px;
            }

            .info-label {
                font-weight: bold;
                color: #007bff;
            }

            .btn-secondary, .btn-success, .btn-primary {
                background-color: #28a745;
                border-color: #28a745;
            }

            .btn-secondary:hover, .btn-success:hover, .btn-primary:hover {
                background-color: #218838;
                border-color: #1e7e34;
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }

            .btn-danger:hover {
                background-color: #c82333;
                border-color: #bd2130;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <a href="#" class="btn btn-secondary mb-3" onclick="history.back(); return false;">Quay lại</a>
            <h3 class="text-center text-success mb-4">Chi tiết lịch hẹn</h3>

            <!-- Thông tin khách hàng -->
            <div class="card">
                <div class="card-header">
                    Thông tin khách hàng
                </div>
                <div class="card-body d-flex flex-column flex-md-row align-items-start">
                    <img src="https://png.pngtree.com/png-clipart/20210129/ourmid/pngtree-default-male-avatar-png-image_2811083.jpg" alt="Avatar" class="customer-image"/>
                    <div class="ms-3">
                        <div class="row">
                            <div class="col-md-6">
                                <p><span class="info-label">Tên:</span> Customer Name</p>
                                <p><span class="info-label">Email:</span> name@example.com</p>
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

            <!-- Bệnh án -->
            <div class="card">
                <div class="card-header">
                    Bệnh án
                </div>
                <div class="card-body">
                    <form action="saveTreatment" method="post">
                        <input type="hidden" name="appointmentId" value="" />
                        <div class="mb-2">
                            <label for="symptoms">Triệu chứng:</label>
                            <textarea id="symptoms" class="form-control" name="symptoms" required></textarea>
                        </div>
                        <div class="mb-2">
                            <label for="diagnosis">Chẩn đoán:</label>
                            <textarea id="diagnosis" class="form-control" name="diagnosis" required></textarea>
                        </div>
                        <div class="mb-2">
                            <label for="testResults">Kết quả xét nghiệm:</label>
                            <textarea id="testResults" class="form-control" name="testResults"></textarea>
                        </div>
                        <div class="mb-2">
                            <label for="treatmentPlan">Kế hoạch điều trị:</label>
                            <textarea id="treatmentPlan" class="form-control" name="treatmentPlan" required></textarea>
                        </div>
                        <div class="mb-2">
                            <label for="followUp">Theo dõi:</label>
                            <textarea id="followUp" class="form-control" name="followUp"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Lưu Treatment Plan</button>
                    </form>
                </div>
            </div>

            <!-- Đơn thuốc -->
            <div class="card">
                <div class="card-header">
                    Đơn thuốc
                </div>
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
                            $(this).addClass("btn-light");
                        }, function () {
                    $(this).removeClass("btn-light");
                }
                );
            });
        </script>
    </body>
</html>
