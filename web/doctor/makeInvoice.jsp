<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Nhập Hóa Đơn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <style>
            body {
                background-color: #f8f9fa;
            }
            .card {
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
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
                            <a href="doctorappointment" class="btn btn-success mb-3">Quay lại</a>

                            <h2 class="text-center mb-4">📋 Nhập Hóa Đơn Khám Bệnh</h2>

                            <!-- Thông tin cuộc hẹn -->
                            <div class="card p-3 mb-4">
                                <h5 class="mb-3">Thông tin cuộc hẹn</h5>
                                <p><strong>Bệnh nhân:</strong> ${app.customer.name}</p>
                                <p><strong>Ngày:</strong> <fmt:formatDate value="${app.date}" pattern="dd/MM/yyyy"/></p>
                                <p><strong>Giờ:</strong> ${app.start} - ${app.end}</p>
                            </div>
                            <form id="invoiceForm" action="makeinvoice" method="post">

                                <!-- Bảng hiển thị các dịch vụ đã chọn (Invoice) -->
                                <div class="card p-3 mb-4">
                                    <h5 class="mb-3">✅ Dịch vụ đã chọn</h5>
                                    <table class="table table-hover" id="selectedInvoiceTable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Dịch vụ</th>
                                                <th>Giá</th>
                                                <th>Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Load các invoice đã có từ database -->
                                            <c:forEach var="invoice" items="${invoices}">
                                                <tr>
                                                    <td>
                                                        ${invoice.service.name}
                                                        <input type="hidden" name="serviceId[]" value="${invoice.service.serviceId}">
                                                    </td>
                                                    <td class="price" data-price="${invoice.price}">
                                                        <fmt:formatNumber value="${invoice.price}" type="currency" currencySymbol="VNĐ"/>
                                                        <input type="hidden" name="price[]" value="${invoice.price}">
                                                    </td>
                                                    <td>
                                                        <button type="button" class="btn btn-danger btn-sm btnRemoveService">Xóa</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <h5 class="text-end mt-3">💰 Tổng tiền: <span id="total-price">0</span> VNĐ</h5>
                                </div>

                                <!-- Phần chọn và thêm dịch vụ mới -->
                                <div class="card p-3 mb-4">
                                    <h5 class="mb-3">➕ Thêm dịch vụ</h5>
                                    <div class="row g-2">
                                        <div class="col-md-8">
                                            <select class="form-select" id="serviceSelect">
                                                <c:forEach var="service" items="${services}">
                                                    <option value="${service.serviceId}" data-price="${service.price}">
                                                        ${service.name} - <fmt:formatNumber value="${service.price}" type="currency" currencySymbol="VNĐ"/>
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <button type="button" class="btn btn-success w-100" id="btnAddService">Thêm dịch vụ</button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Nút Lưu hóa đơn -->
                                <div class="text-end">
                                    <!-- Bao bọc bảng và nút lưu bên trong form để các input ẩn được gửi trực tiếp -->
                                    <input type="hidden" name="appointmentId" value="${app.appointmentId}">
                                    <!-- Phần table đã chứa các input ẩn sẽ được submit kèm theo -->

                                    <button type="submit" class="btn btn-success">Lưu hóa đơn</button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div><!-- end container -->

                <jsp:include page="footer.jsp" />
            </main>
        </div>

        <!-- Các thư viện JavaScript -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>

        <!-- Script xử lý thêm, xóa dịch vụ (Invoice) động -->
        <script>
            $(document).ready(function () {
                // Khi nhấn "Thêm dịch vụ", lấy dữ liệu từ dropdown và thêm dòng vào bảng "Dịch vụ đã chọn"
                $("#btnAddService").click(function () {
                    var selected = $("#serviceSelect option:selected");
                    var serviceId = selected.val();
                    // Tách lấy tên dịch vụ từ option (giả sử định dạng: "Tên Dịch Vụ - Giá")
                    var serviceName = selected.text().split(" - ")[0].trim();
                    var price = parseFloat(selected.data("price")) || 0;

                    // Tạo dòng mới với các input ẩn cho serviceId và price
                    var rowHtml = '<tr>' +
                            '<td>' + serviceName +
                            '<input type="hidden" name="serviceId[]" value="' + serviceId + '">' +
                            '</td>' +
                            '<td class="price" data-price="' + price + '">' +
                            price.toLocaleString('vi-VN') +
                            '<input type="hidden" name="price[]" value="' + price + '">' +
                            '</td>' +
                            '<td><button type="button" class="btn btn-danger btn-sm btnRemoveService">Xóa</button></td>' +
                            '</tr>';

                    $("#selectedInvoiceTable tbody").append(rowHtml);
                    updateTotalPrice();
                });

                // Xóa dòng dịch vụ khi nhấn nút "Xóa" trên mỗi hàng
                $(document).on("click", ".btnRemoveService", function () {
                    $(this).closest("tr").remove();
                    updateTotalPrice();
                });

                // Hàm tính tổng tiền của các dịch vụ đã chọn
                function updateTotalPrice() {
                    var total = 0;
                    $("#selectedInvoiceTable tbody tr").each(function () {
                        var rowPrice = parseFloat($(this).find(".price").data("price")) || 0;
                        total += rowPrice;
                    });
                    $("#total-price").text(total.toLocaleString('vi-VN'));
                }

                // Gọi hàm updateTotalPrice() khi trang load để tính tổng các dịch vụ có sẵn
                updateTotalPrice();
            });
        </script>
    </body>
</html>
