<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <title>Chi tiết hóa đơn - Doctris</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->       
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" />
    </head>

    <body>
        <div class="container mt-5">
            <h2 class="text-center">Chi tiết hóa đơn</h2>

            <div class="card mt-4 p-4">
                <div class="modal-header border-bottom p-3">
                    <div class="col-lg-8 col-md-6">
                        <img src="assets/images/logo-light.png" height="22" alt="">
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="goBack()"></button>
                </div>

                <div class="pt-4 border-top">
                    <div class="row">
                        <div class="col-lg-8 col-md-6">
                            <h5 class="text-muted fw-bold">Hóa Đơn <span class="badge badge-pill badge-soft-success fw-normal ms-2"></span></h5>
                        </div>

                        <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <ul class="list-unstyled">
                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Ngày tạo:</small>
                                    <small class="mb-0">&nbsp;&nbsp;<fmt:formatDate value="${invoices[0].appointment.date}" pattern="dd/MM/yyyy"/></small>
                                </li>
                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Tên khách hàng:</small>
                                    <small class="mb-0">&nbsp;&nbsp;${invoices[0].appointment.customer.name}</small>
                                </li>
                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Tên bác sĩ:</small>
                                    <small class="mb-0 text-dark">&nbsp;&nbsp;${invoices[0].appointment.staff.name}</small>
                                </li>

                                <li class="d-flex mt-2">
                                    <small class="mb-0 text-muted">Trạng thái:</small>
                                    <small class="mb-0 text-dark">
                                        &nbsp;&nbsp;
                                        <c:choose>
                                            <c:when test="${invoices[0].appointment.status == 'paid'}">Đã thanh toán</c:when>
                                            <c:when test="${invoices[0].appointment.status == 'waitpay'}">Chưa thanh toán</c:when>
                                            <c:when test="${invoices[0].appointment.status == 'confirmed'}">Chưa thanh toán</c:when>
                                             <c:when test="${invoices[0].appointment.status == 'pending'}">Chờ xác nhận</c:when>
                                            <c:otherwise>Không xác định</c:otherwise>
                                        </c:choose>
                                    </small>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Bảng hiển thị danh sách dịch vụ trong hóa đơn -->
                    <div class="invoice-table pb-4">
                        <div class="table-responsive shadow rounded mt-4">
                            <table class="table table-center invoice-tb mb-0">
                                <thead>
                                    <tr>
                                        <th scope="col" class="text-start border-bottom p-3">Dịch vụ</th>
                                        <th scope="col" class="text-center border-bottom p-3">Giá</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="invoice" items="${invoices}">
                                        <tr>
                                            <td class="text-start">
                                                ${invoice.service.name}
                                                <input type="hidden" name="serviceId[]" value="${invoice.service.serviceId}">
                                            </td>
                                            <td class="text-center price" data-price="${invoice.price}">
                                                <fmt:formatNumber value="${invoice.price}" type="currency" currencySymbol="VNĐ"/>
                                                <input type="hidden" name="price[]" value="${invoice.price}">
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <!-- Tính tổng tiền -->
                        <div class="row">
                            <div class="col-lg-4 col-md-5 ms-auto">
                                <ul class="list-unstyled h6 fw-normal mt-4 mb-0 ms-md-5 ms-lg-4">
                                    <li class="d-flex justify-content-between pe-3">Tổng tiền: 
                                        <span>
                                            <c:set var="totalPrice" value="0" />
                                            <c:forEach var="invoice" items="${invoices}">
                                                <c:set var="totalPrice" value="${totalPrice + invoice.price}" />
                                            </c:forEach>
                                            <fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="VNĐ"/>
                                        </span>
                                    </li>
                                </ul>
                                <c:if test="${customer != null and invoices[0].appointment.status != 'paid'}">
                                    <div class="text-end mt-4 pt-2">
                                        <form action="vnpay_payment" method="post">
                                            <input type="hidden" name="amount" value="${totalPrice}">
                                            <input type="hidden" name="appointmentId" value="${invoices[0].appointment.appointmentId}">
                                            <button type="submit" class="btn btn-success">Thanh toán VNPay</button>
                                        </form>
                                    </div>
                                </c:if>


                            </div>
                        </div>
                    </div>

                    <div class="border-top pt-4">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="text-sm-start text-muted text-center">
                                    <small class="mb-0">Dịch vụ chăm sóc khách hàng: 
                                        <a href="tel:+152534-468-854" class="text-warning">(+12) 1546-456-856</a>
                                    </small>
                                </div>
                            </div>
                            <li class="d-flex mt-2">
                                <small class="mb-0 text-muted">Email:</small>
                                <small class="mb-0">&nbsp;&nbsp;<a href="mailto:contact@example.com" class="text-dark">info@medisync.com</a></small>
                            </li>
                            <li class="d-flex mt-2">
                                <small class="mb-0 text-muted">Website:</small>
                                <small class="mb-0">&nbsp;&nbsp;<a href="#" class="text-dark">www.medisync.com</a></small>
                            </li>
                        </div>
                    </div>
                </div>

                <div class="text-end mt-4 pt-2">
                    <a href="javascript:window.print()" class="btn btn-soft-primary d-print-none"><i class="uil uil-print"></i> In </a>
                </div>
            </div>
        </div>

        <script>
            function goBack() {
                window.history.back();
            }

            // Xóa dịch vụ khỏi danh sách (chỉ frontend, không ảnh hưởng đến database)
            document.querySelectorAll('.btnRemoveService').forEach(button => {
                button.addEventListener('click', function () {
                    this.closest('tr').remove();
                });
            });
        </script>
    </body>

</html>
