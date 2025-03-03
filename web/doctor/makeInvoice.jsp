<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Nhập Hóa Đơn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <!-- CSS -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="assets/css/remixicon.css" rel="stylesheet" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />

        <!-- JavaScript -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            body {
                background-color: #f8f9fa;
            }
            .card {
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }
            .table th, .table td {
                vertical-align: middle;
            }
            .btn-custom {
                background-color: #007bff;
                color: white;
                border-radius: 6px;
            }
            .btn-custom:hover {
                background-color: #0056b3;
            }
            .btn-delete {
                background-color: #dc3545;
                color: white;
                border-radius: 6px;
            }
            .btn-delete:hover {
                background-color: #a71d2a;
            }
        </style>
    </head>
    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="left-navbar.jsp" />

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />

                <div class="container-fluid" style="margin-top: -4%;">
                    <div class="layout-specing">
                        <div class="container mt-5">
                            <h2 class="text-center mb-4">📋 Nhập Hóa Đơn Khám Bệnh</h2>

                            <!-- Thông tin cuộc hẹn -->
                            <div class="card p-3 mb-4">
                                <h5 class="mb-3">Thông tin cuộc hẹn</h5>
                                <p><strong>Bệnh nhân:</strong> Nguyễn Văn A</p>
                                <p><strong>Ngày:</strong> 22/02/2025</p>
                                <p><strong>Giờ:</strong> 10:00 - 10:30</p>
                                <p><strong>Loại cuộc hẹn:</strong> Khám tổng quát</p>
                            </div>

                            <!-- Dịch vụ đã chọn -->
                            <div class="card p-3 mb-4">
                                <h5 class="mb-3">✅ Dịch vụ đã chọn</h5>
                                <table class="table table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Dịch vụ</th>
                                            <th>Giá</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody id="invoice-items">
                                        <!-- Các dịch vụ sẽ hiển thị ở đây -->
                                    </tbody>
                                </table>
                                <h5 class="text-end mt-3">💰 Tổng tiền: <span id="total-price">0</span> VNĐ</h5>
                            </div>

                            <!-- Thêm dịch vụ vào hóa đơn -->
                            <div class="card p-3">
                                <h5 class="mb-3">➕ Thêm dịch vụ vào hóa đơn</h5>
                                <div class="row g-2">
                                    <div class="col-md-8">
                                        <select class="form-select" id="service-select">
                                            <option value="200000" data-name="Khám tổng quát">Khám tổng quát - 200,000 VNĐ</option>
                                            <option value="500000" data-name="Xét nghiệm máu">Xét nghiệm máu - 500,000 VNĐ</option>
                                            <option value="800000" data-name="Chụp X-Quang">Chụp X-Quang - 800,000 VNĐ</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <button class="btn btn-success w-100" onclick="addService()">Thêm</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div><!-- end container -->

                <!-- Footer -->
                <jsp:include page="footer.jsp" />
            </main>
        </div>

        <!-- Script quản lý hóa đơn -->
        <script>
            let invoiceItems = [];
            let totalPrice = 0;

            function addService() {
                let select = document.getElementById("service-select");
                let price = parseInt(select.value);
                let name = select.options[select.selectedIndex].getAttribute("data-name");

                // Kiểm tra nếu dịch vụ đã tồn tại
                if (invoiceItems.some(item => item.name === name)) {
                    alert("Dịch vụ đã được thêm vào!");
                    return;
                }

                // Thêm vào danh sách
                let id = invoiceItems.length + 1;
                invoiceItems.push({id, name, price});
                updateTable();
            }

            function removeService(id) {
                invoiceItems = invoiceItems.filter(item => item.id !== id);
                updateTable();
            }

            function updateTable() {
                let table = document.getElementById("invoice-items");
                let rows = "";
                totalPrice = 0;

                invoiceItems.forEach((item) => {
                    totalPrice += item.price;
                    rows += `<tr>
                                <td>${item.name}</td>
                                <td>${item.price.toLocaleString()} VNĐ</td>
                                <td>
                                    <button class="btn btn-delete btn-sm" onclick="removeService(${item.id})">Xóa</button>
                                </td>
                            </tr>`;
                });

                table.innerHTML = rows;
                document.getElementById("total-price").innerText = totalPrice.toLocaleString();
            }
        </script>

        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
