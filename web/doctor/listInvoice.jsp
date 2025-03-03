<%-- 
    Document   : listInvoice
    Created on : Mar 3, 2025, 6:32:21 PM
    Author     : DIEN MAY XANH
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Danh sách hóa đơn</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />



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
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <div class="col-12 mt-4 pt-2">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3">ID</th>
                                                <th class="border-bottom p-3" style="min-width: 220px;">Tên</th>
                                                <th class="text-center border-bottom p-3" style="min-width: 180px;">Số điện thoại</th>
                                                <th class="text-center border-bottom p-3">Tổng tiền</th>
                                                <th class="text-center border-bottom p-3" style="min-width: 140px;">Ngày tạo</th>
                                                <th class="text-center border-bottom p-3">Trạng thái</th>
                                                <th class="text-end border-bottom p-3" style="min-width: 200px;"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d01</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/01.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Howard Tanner</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$253</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-danger rounded px-3 py-1">
                                                        Unpaid
                                                    </div>
                                                </td>
                                                <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d02</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/02.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Wendy Filson</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$482</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-success rounded px-3 py-1">
                                                        Paid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d03</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/03.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Faye Bridger</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$546</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-danger rounded px-3 py-1">
                                                        Unpaid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d04</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/04.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Ronald Curtis</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$154</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-danger rounded px-3 py-1">
                                                        Unpaid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d05</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/05.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Melissa Hibner</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$458</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-success rounded px-3 py-1">
                                                        Paid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d06</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/06.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Randall Case</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$548</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-success rounded px-3 py-1">
                                                        Paid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d07</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/07.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Jerry Morena</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$658</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-danger rounded px-3 py-1">
                                                        Unpaid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d08</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/08.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Lester McNally</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$457</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-danger rounded px-3 py-1">
                                                        Unpaid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d09</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/09.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Christopher Burrell</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$586</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-success rounded px-3 py-1">
                                                        Paid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->


                                            <!-- Start -->
                                            <tr>
                                                <th class="p-3">#d10</th>
                                                <td class="p-3">
                                                    <a href="#" class="text-primary">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/client/10.jpg" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                            <span class="ms-2">Mary Skeens</span>
                                                        </div>
                                                    </a>
                                                </td>
                                                <td class="text-center p-3">(+12)85-4521-7568</td>
                                                <td class="text-center p-3">$325</td>
                                                <td class="text-center p-3">23th Dec 2020</td>
                                                <td class="text-center p-3">
                                                    <div class="badge bg-soft-danger rounded px-3 py-1">
                                                        Unpaid
                                                    </div>
                                                </td>
                                                 <td class="text-center p-3">
                                                    <a href="#" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#view-invoice">Xem</a>
 
                                                </td>
                                            </tr>
                                            <!-- End -->
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div><!--end row-->


                        <div class="row text-center">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-end">
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Previous">Trước</a></li>
                                        <li class="page-item active"><a class="page-link" href="javascript:void(0)">1</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Next">Sau</a></li>
                                    </ul>
                                </div>
                            </div><!--end col-->
                            <!-- PAGINATION END -->

                        </div>
                    </div><!--end container-->
                    <!-- Footer Start -->
                    <jsp:include page="footer.jsp" />

                    <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- View Invoice Start -->
        <div class="modal fade" id="view-invoice" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header border-bottom p-3">
                        <h5 class="modal-title" id="exampleModalLabel">Patient Invoice</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-3 pt-4">
                        <div class="row mb-4">
                            <div class="col-lg-8 col-md-6">
                                <img src="../assets/images/logo-dark.png" height="22" alt="">
                                <h6 class="mt-4 pt-2">Address :</h6>
                                <small class="text-muted mb-0">1419 Riverwood Drive, <br>Redding, CA 96001</small>
                            </div><!--end col-->

                            <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <ul class="list-unstyled">
                                    <li class="d-flex">
                                        <small class="mb-0 text-muted">Invoice no. : </small>
                                        <small class="mb-0 text-dark">&nbsp;&nbsp;#54638990jnn</small>
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
                                        <small class="mb-0">&nbsp;&nbsp;Mary Skeens</small>
                                    </li>
                                </ul>
                            </div><!--end col-->
                        </div><!--end row-->

                        <div class="pt-4 border-top">
                            <div class="row">
                                <div class="col-lg-8 col-md-6">
                                    <h5 class="text-muted fw-bold">Invoice <span class="badge badge-pill badge-soft-success fw-normal ms-2">Paid</span></h5>
                                    <h6>Surgery (Gynecology)</h6>
                                </div><!--end col-->

                                <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                    <ul class="list-unstyled">
                                        <li class="d-flex mt-2">
                                            <small class="mb-0 text-muted">Issue Dt. : </small>
                                            <small class="mb-0 text-dark">&nbsp;&nbsp;25th Sep. 2020</small>
                                        </li>

                                        <li class="d-flex mt-2">
                                            <small class="mb-0 text-muted">Due Dt. : </small>
                                            <small class="mb-0 text-dark">&nbsp;&nbsp;11th Oct. 2020</small>
                                        </li>

                                        <li class="d-flex mt-2">
                                            <small class="mb-0 text-muted">Dr. Name : </small>
                                            <small class="mb-0 text-dark">&nbsp;&nbsp;Dr. Calvin Carlo</small>
                                        </li>
                                    </ul>
                                </div><!--end col-->
                            </div><!--end row-->

                            <div class="invoice-table pb-4">
                                <div class="table-responsive shadow rounded mt-4">
                                    <table class="table table-center invoice-tb mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col" class="text-start border-bottom p-3" style="min-width: 60px;">No.</th>
                                                <th scope="col" class="text-start border-bottom p-3" style="min-width: 220px;">Item</th>
                                                <th scope="col" class="text-center border-bottom p-3" style="min-width: 60px;">Qty</th>
                                                <th scope="col" class="border-bottom p-3" style="min-width: 130px;">Rate</th>
                                                <th scope="col" class="border-bottom p-3" style="min-width: 130px;">Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th scope="row" class="text-start p-3">1</th>
                                                <td class="text-start p-3">Hospital Charges</td>
                                                <td class="text-center p-3">1</td>
                                                <td class="p-3">$ 125</td>
                                                <td class="p-3">$ 125</td>
                                            </tr>
                                            <tr>
                                                <th scope="row" class="text-start p-3">2</th>
                                                <td class="text-start p-3">Medicine</td>
                                                <td class="text-center p-3">1</td>
                                                <td class="p-3">$ 245</td>
                                                <td class="p-3">$ 245</td>
                                            </tr>
                                            <tr>
                                                <th scope="row" class="text-start p-3">3</th>
                                                <td class="text-start p-3">Special Visit Fee(Doctor)</td>
                                                <td class="text-center p-3">1</td>
                                                <td class="p-3">$ 150</td>
                                                <td class="p-3">$ 150</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="row">
                                    <div class="col-lg-4 col-md-5 ms-auto">
                                        <ul class="list-unstyled h6 fw-normal mt-4 mb-0 ms-md-5 ms-lg-4">
                                            <li class="text-muted d-flex justify-content-between pe-3">Subtotal :<span>$ 520</span></li>
                                            <li class="text-muted d-flex justify-content-between pe-3">Taxes :<span> 0</span></li>
                                            <li class="d-flex justify-content-between pe-3">Total :<span>$ 520</span></li>
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
            </div>
        </div>
        <!-- View Invoice End -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>


</html>




