<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <title>Chi tiết hóa đơn - Doctris</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/logo-icon.png">
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" />
    </head>

    <style>
        @media print {
            .invoice-container {
                width: 100%;
                padding: 10px;
                margin: 0 auto;
            }

            .invoice-table {
                page-break-before: auto;
                page-break-after: auto;
                page-break-inside: avoid; /* Tránh cắt bảng */
            }

            .border-top {
                page-break-before: always; /* Đảm bảo phần thông tin xuống trang mới nếu cần */
            }

            .table tbody tr {
                page-break-inside: avoid; /* Tránh cắt hàng trong bảng */
            }

            .text-end, .text-center {
                text-align: right !important;
            }
            #btnExportPDF #btnSendEmail{
                visibility: hidden !important;
            }

        }



        /* Điều chỉnh margin tránh khoảng trắng dư */
        .mt-4 {
            margin-top: 20px !important;
        }

        .pt-4 {
            padding-top: 15px !important;
        }

        .pb-4 {
            padding-bottom: 15px !important;
        }

    </style>

    <body>
        <div class="container invoice-container">
            <h2 class="text-center">Chi tiết hóa đơn</h2>

            <div class="card p-4">
                <div class="modal-header border-bottom p-3">
                    <div class="col-lg-8 col-md-6">
                        <img src="assets/images/logo-light.png" height="22" alt="">
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="goBack()"></button>
                </div>

                <div class="pt-4 border-top">
                    <div class="row">
                        <div class="col-lg-6">
                            <h5 class="text-muted fw-bold">Hóa Đơn</h5>
                        </div>

                        <div class="col-lg-6">
                            <table class="table mt-3">
                                <tbody>
                                    <tr>
                                        <th width="45%">Ngày tạo:</th>
                                        <td><fmt:formatDate value="${invoices[0].appointment.date}" pattern="dd/MM/yyyy"/></td>
                                    </tr>
                                    <tr>
                                        <th>Khách hàng:</th>
                                        <td>${invoices[0].appointment.customer.name}</td>
                                    </tr>
                                    <tr>
                                        <th>Bác sĩ:</th>
                                        <td>${invoices[0].appointment.staff.name}</td>
                                    </tr>
                                    <tr>
                                        <th>Trạng thái:</th>
                                        <td>
                                            <c:choose>
                                                <c:when test="${invoices[0].appointment.status == 'paid'}">Đã thanh toán</c:when>
                                                <c:when test="${invoices[0].appointment.status == 'waitpay' || invoices[0].appointment.status == 'confirmed'}">Chưa thanh toán</c:when>
                                                <c:when test="${invoices[0].appointment.status == 'pending'}">Chờ xác nhận</c:when>
                                                <c:otherwise>Không xác định</c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Bảng hiển thị danh sách dịch vụ -->
                    <div class="invoice-table pb-4">
                        <div class="table-responsive shadow rounded">
                            <table class="table table-center invoice-tb mb-0">
                                <thead>
                                    <tr>
                                        <th class="text-start border-bottom p-3">Dịch vụ</th>
                                        <th class="text-center border-bottom p-3">Giá</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="invoice" items="${invoices}">
                                        <tr>
                                            <td class="text-start">${invoice.service.name}</td>
                                            <td class="text-center">
                                                <fmt:formatNumber value="${invoice.price}" type="currency" currencySymbol="VNĐ"/>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    <!-- Hàng tổng tiền -->
                                    <tr>
                                        <td class="text-start fw-bold">Tổng tiền:</td>
                                        <td class="text-center fw-bold">
                                            <c:set var="totalPrice" value="0" />
                                            <c:forEach var="invoice" items="${invoices}">
                                                <c:set var="totalPrice" value="${totalPrice + invoice.price}" />
                                            </c:forEach>
                                            <fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="VNĐ"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Nút Thanh toán -->
                        <c:if test="${customer != null and invoices[0].appointment.status != 'paid'}">
                            <div class="text-end mt-4 d-print-none">
                                <form action="vnpay_payment" method="post">
                                    <input type="hidden" name="amount" value="${totalPrice}">
                                    <input type="hidden" name="appointmentId" value="${invoices[0].appointment.appointmentId}">
                                    <button type="submit" class="btn btn-success">Thanh toán VNPay</button>
                                </form>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Chăm sóc khách hàng -->
                <div class="border-top pt-4">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="text-sm-start text-muted text-center">
                                <small class="mb-0">Dịch vụ chăm sóc khách hàng:
                                    <a href="tel:+152534-468-854" class="text-warning">(+12) 1546-456-856</a>
                                </small>
                            </div>
                        </div>

                    </div>
                </div>


                <!-- Nút xuất PDF -->
                <c:if test="${staff != null}">
                    <!-- Nút xuất PDF -->
                    <div class="text-end mt-4 d-print-none">
                        <button id="btnSendEmail" class="btn btn-primary">Gửi hóa đơn</button>
                        <button id="btnExportPDF" class="btn btn-soft-primary">
                            <i class="uil uil-file-download"></i> Xuất PDF
                        </button>
                    </div>
                </c:if>


            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
        <script>
                        document.getElementById("btnExportPDF").addEventListener("click", function () {
                            let invoiceContent = document.querySelector(".card"); // Chỉ lấy phần hóa đơn
                            let exportButton = document.getElementById("btnExportPDF"); // Nút xuất PDF
                            let sendmailButton = document.getElementById("btnSendEmail"); // Nút xuất PDF

                            let customerEmail = "${invoices[0].appointment.customer.email}";
                            let appointmentId = "${invoices[0].appointment.appointmentId}";
                            let fileName = appointmentId + "_" + customerEmail + ".pdf";

                            // Ẩn nút nhưng vẫn giữ không gian của nó
                            exportButton.style.visibility = "hidden";
                            sendmailButton.style.visibility = "hidden";
                            let invoiceHeight = invoiceContent.offsetHeight;
                            let marginTopBottom = invoiceHeight > 600 ? 10 : 30;

                            html2pdf()
                                    .from(invoiceContent)
                                    .set({
                                        margin: [marginTopBottom, 10, marginTopBottom, 10],
                                        filename: fileName,
                                        image: {type: 'jpeg', quality: 0.98},
                                        html2canvas: {scale: 2, useCORS: true},
                                        jsPDF: {orientation: 'portrait', unit: 'mm', format: 'a4', compressPDF: true},
                                        pagebreak: {mode: ['avoid-all', 'css', 'legacy']}
                                    })
                                    .save()
                                    .then(() => {
                                        // Hiện lại nút sau khi xuất PDF xong
                                        sendmailButton.style.visibility = "visible"
                                        exportButton.style.visibility = "visible";
                                    });
                        });

                        document.getElementById("btnSendEmail").addEventListener("click", function () {
                            let invoiceContent = document.querySelector(".card"); // Chỉ lấy phần hóa đơn
                            let exportButton = document.getElementById("btnExportPDF"); // Nút xuất PDF
                            let sendmailButton = document.getElementById("btnSendEmail"); // Nút gửi hóa đơn

                            let customerEmail = "${invoices[0].appointment.customer.email}";
                            let appointmentId = "${invoices[0].appointment.appointmentId}";
                            let fileName = appointmentId + "_" + customerEmail + ".pdf";

                            // Ẩn 2 nút bằng thuộc tính visibility (vẫn giữ nguyên không gian)
                            exportButton.style.visibility = "hidden";
                            sendmailButton.style.visibility = "hidden";

                            // Cập nhật giao diện nút gửi
                            sendmailButton.innerText = "Đang gửi...";
                            sendmailButton.disabled = true;

                            let invoiceHeight = invoiceContent.offsetHeight;
                            let marginTopBottom = invoiceHeight > 600 ? 10 : 30;

                            html2pdf()
                                    .from(invoiceContent)
                                    .set({
                                        margin: [marginTopBottom, 10, marginTopBottom, 10],
                                        filename: fileName,
                                        image: {type: 'jpeg', quality: 0.98},
                                        html2canvas: {scale: 2, useCORS: true},
                                        jsPDF: {orientation: 'portrait', unit: 'mm', format: 'a4', compressPDF: true},
                                        pagebreak: {mode: ['avoid-all', 'css', 'legacy']}
                                    })
                                    .outputPdf('blob') // Trả về file PDF dạng blob
                                    .then(pdfBlob => {
                                        let formData = new FormData();
                                        formData.append("email", customerEmail);
                                        formData.append("appid", appointmentId);
                                        formData.append("pdfFile", pdfBlob, fileName); // Đính kèm file PDF dạng blob

                                        return fetch("sendInvoice", {
                                            method: "POST",
                                            body: formData
                                        });
                                    })
                                    .then(response => response.text())
                                    .then(result => {
                                        alert("Hóa đơn đã được gửi thành công!");
                                        sendmailButton.innerText = "Gửi hóa đơn";
                                        sendmailButton.disabled = false;
                                        // Hiện lại các nút sau khi hoàn tất gửi
                                        exportButton.style.visibility = "visible";
                                        sendmailButton.style.visibility = "visible";
                                    })
                                    .catch(error => {
                                        alert("Gửi hóa đơn thất bại!");
                                        console.error("Lỗi:", error);
                                        sendmailButton.innerText = "Gửi hóa đơn";
                                        sendmailButton.disabled = false;
                                        // Hiện lại các nút khi xảy ra lỗi
                                        exportButton.style.visibility = "visible";
                                        sendmailButton.style.visibility = "visible";
                                    });
                        });


                        function goBack() {
                            window.history.back();
                        }
        </script>

    </body>
</html>
