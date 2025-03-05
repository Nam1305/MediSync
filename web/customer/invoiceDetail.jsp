<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Invoice Detail - Doctris</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="assets/images/favicon.ico.png">
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
</head>

<body>
    <div class="container mt-5">
        <h2 class="text-center">Thông tin chi tiết hóa đơn</h2>
        <div class="card mt-4 p-4">
            <div class="row mb-4">
                <div class="col-lg-8 col-md-6">
                    <img src="assets/images/logo-dark.png" height="22" alt="">
<!--                    <h6 class="mt-4 pt-2">Address :</h6>
                    <small class="text-muted mb-0">1419 Riverwood Drive, <br>Redding, CA 96001</small>-->
                </div><!--end col-->

                <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                    <ul class="list-unstyled">
                        <li class="d-flex">
                            <small class="mb-0 text-muted">Invoice no. : </small>
                            <small class="mb-0 text-dark">&nbsp;&nbsp;${invoice.invoiceNo}</small>
                        </li>
                        <li class="d-flex mt-2">
                            <small class="mb-0 text-muted">Email : </small>
                            <small class="mb-0">&nbsp;&nbsp;<a href="mailto:contact@example.com" class="text-dark">info@doctris.com</a></small>
                        </li>
                        <li class="d-flex mt-2">
                            <small class="mb-0 text-muted">Phone : </small>
                            <small class="mb-0">&nbsp;&nbsp;<a href="tel:+152534-468-854" class="text-dark">(+12) 1546-456-856</a></small>
                        </li>
                        <li class="d-flex mt-2">
                            <small class="mb-0 text-muted">Website : </small>
                            <small class="mb-0">&nbsp;&nbsp;<a href="#" class="text-dark">www.doctris.com</a></small>
                        </li>
                        <li class="d-flex mt-2">
                            <small class="mb-0 text-muted">Patient Name : </small>
                            <small class="mb-0">&nbsp;&nbsp;${patient.name}</small>
                        </li>
                    </ul>
                </div><!--end col-->
            </div><!--end row-->

            <div class="pt-4 border-top">
                <div class="row">
                    <div class="col-lg-8 col-md-6">
                        <h5 class="text-muted fw-bold">Hóa Đơn <span class="badge badge-pill badge-soft-success fw-normal ms-2">Paid</span></h5>
                        <h6>Ngày tạo: </h6>
                    </div><!--end col-->

                    <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <ul class="list-unstyled">
                            <li class="d-flex mt-2">
                                <small class="mb-0 text-muted">Issue Dt. : </small>
                                <small class="mb-0 text-dark">&nbsp;&nbsp;${invoice.issueDate}</small>
                            </li>

                            <li class="d-flex mt-2">
                                <small class="mb-0 text-muted">Due Dt. : </small>
                                <small class="mb-0 text-dark">&nbsp;&nbsp;${invoice.dueDate}</small>
                            </li>

                            <li class="d-flex mt-2">
                                <small class="mb-0 text-muted">Dr. Name : </small>
                                <small class="mb-0 text-dark">&nbsp;&nbsp;${doctor.name}</small>
                            </li>
                        </ul>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="invoice-table pb-4">
                    <div class="table-responsive shadow rounded mt-4">
                        <table class="table table-center invoice-tb mb-0">
                            <thead>
                                <tr>
                                    <th scope="col" class="text-start border-bottom p-3" style="min-width: 60px;">Số thứ tự</th>
                                    <th scope="col" class="text-start border-bottom p-3" style="min-width: 220px;">Dịch vụ</th>
                                    <th scope="col" class="text-center border-bottom p-3" style="min-width: 60px;">Giá</th>
                                    <th scope="col" class="border-bottom p-3" style="min-width: 130px;">Rate</th>
                                    <th scope="col" class="border-bottom p-3" style="min-width: 130px;">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${invoice.items}">
                                    <tr>
                                        <th scope="row" class="text-start p-3">${item.number}</th>
                                        <td class="text-start p-3">${item.name}</td>
                                        <td class="text-center p-3">${item.quantity}</td>
                                        <td class="p-3">${item.rate}</td>
                                        <td class="p-3">${item.total}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="row">
                        <div class="col-lg-4 col-md-5 ms-auto">
                            <ul class="list-unstyled h6 fw-normal mt-4 mb-0 ms-md-5 ms-lg-4">
                                <li class="text-muted d-flex justify-content-between pe-3">Subtotal :<span>${invoice.subtotal}</span></li>
                                <li class="text-muted d-flex justify-content-between pe-3">Taxes :<span>${invoice.tax}</span></li>
                                <li class="d-flex justify-content-between pe-3">Total :<span>${invoice.total}</span></li>
                            </ul>
                        </div><!--end col-->
                    </div><!--end row-->
                </div>

                <div class="border-top pt-4">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="text-sm-start text-muted text-center">
                                <small class="mb-0">Customer Services : <a href="tel:+152534-468-854" class="text-warning">(+12) 1546-456-856</a></small>
                            </div>
                        </div><!--end col-->

                        <div class="col-sm-6">
                            <div class="text-sm-end text-muted text-center">
                                <small class="mb-0"><a href="#" class="text-primary">Terms & Conditions</a></small>
                            </div>
                        </div><!--end col-->
                    </div><!--end row-->
                </div>
            </div>

            <div class="text-end mt-4 pt-2">
                <a href="javascript:window.print()" class="btn btn-soft-primary d-print-none"><i class="uil uil-print"></i> Print</a>
            </div>
        </div>
    </div>
</body>

</html>
