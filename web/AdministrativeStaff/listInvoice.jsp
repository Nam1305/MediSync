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
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->       
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <style>
            .filter-form .form-control, .filter-form .form-select {
                height: 2rem;
                font-size: 0.9rem;
            }
            .filter-form label {
                font-size: 0.85rem;
                font-weight: 500;
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
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="card shadow p-3 mb-4">
                            <form class="filter-form" method="GET" action="listinvoice">
                                <!-- Row 1: ID, Tên, Từ ngày, Đến ngày, Trạng thái, Số bản ghi -->
                                <div class="row g-2 align-items-end">
                                    <div class="col-md-2">
                                        <label for="invoiceId" class="form-label">ID</label>
                                        <input type="number" class="form-control" id="invoiceId" name="invoiceId"
                                               value="${invoiceIdFilter != null ? invoiceIdFilter : ''}">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="name" class="form-label">Tên</label>
                                        <input type="text" class="form-control" id="name" name="name"
                                               value="${name != null ? name : ''}">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="dateFrom" class="form-label">Từ ngày</label>
                                        <input type="date" class="form-control" id="dateFrom" name="dateFrom"
                                               value="${dateFrom != null ? dateFrom : ''}">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="dateTo" class="form-label">Đến ngày</label>
                                        <input type="date" class="form-control" id="dateTo" name="dateTo"
                                               value="${dateTo != null ? dateTo : ''}">
                                    </div>
                                    <div class="col-md-2">
                                        <label for="status" class="form-label">Trạng thái</label>
                                        <select class="form-select" id="status" name="status">
                                            <option value="">Tất cả</option>
                                            <option value="paid" ${status == 'paid' ? 'selected' : ''}>Đã thanh toán</option>
                                            <option value="unpaid" ${status == 'unpaid' ? 'selected' : ''}>Chưa thanh toán</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <label for="pageSize" class="form-label">Số bản ghi</label>
                                        <input type="number" class="form-control" id="pageSize" name="pageSize" min="1"
                                               value="${empty param.pageSize ? 5 : param.pageSize}">
                                    </div>
                                </div>

                                <!-- Row 2: Tổng tiền, Sắp xếp, Nút Lọc & Reset -->
                                <div class="row g-2 mt-2 align-items-end">
                                    <!-- Tổng tiền từ -->
                                    <div class="col-md-2">
                                        <label for="totalFrom" class="form-label">Tổng tiền từ</label>
                                        <input type="number" step="0.01" class="form-control form-control-sm" id="totalFrom" name="totalFrom"
                                               value="${totalFrom != null ? totalFrom : ''}">
                                    </div>
                                    <!-- Tổng tiền đến -->
                                    <div class="col-md-2">
                                        <label for="totalTo" class="form-label">Đến</label>
                                        <input type="number" step="0.01" class="form-control form-control-sm" id="totalTo" name="totalTo"
                                               value="${totalTo != null ? totalTo : ''}">
                                    </div>
                                    <!-- Sắp xếp theo Ngày tạo -->
                                    <div class="col-md-2">
                                        <label for="sortDate" class="form-label" style="font-size: 0.8rem;">Ngày tạo</label>
                                        <select class="form-select form-select-sm" id="sortDate" name="sortDate">
                                            <option value="" ${empty sortDate ? 'selected' : ''}>Không</option>
                                            <option value="ASC" ${sortDate == 'ASC' ? 'selected' : ''}>Tăng</option>
                                            <option value="DESC" ${sortDate == 'DESC' ? 'selected' : ''}>Giảm</option>
                                        </select>
                                    </div>
                                    <!-- Sắp xếp theo Giá -->
                                    <div class="col-md-2">
                                        <label for="sortPrice" class="form-label" style="font-size: 0.8rem;">Giá</label>
                                        <select class="form-select form-select-sm" id="sortPrice" name="sortPrice">
                                            <option value="" ${empty sortPrice ? 'selected' : ''}>Không</option>
                                            <option value="ASC" ${sortPrice == 'ASC' ? 'selected' : ''}>Tăng</option>
                                            <option value="DESC" ${sortPrice == 'DESC' ? 'selected' : ''}>Giảm</option>
                                        </select>
                                    </div>
                                    <!-- Nút Lọc -->
                                    <div class="col-md-2 text-center">
                                        <button type="submit" class="btn btn-primary btn-sm">Lọc</button>
                                    </div>
                                    <!-- Nút Reset -->
                                    <div class="col-md-2 text-center">
                                        <button type="button" class="btn btn-secondary btn-sm" id="btnReset">Làm mới</button>
                                    </div>
                                </div>
                            </form>





                        </div>
                        <!-- Invoice Table -->
                        <div class="row" style="margin-top: -3%;">
                            <div class="col-12 mt-4 pt-2">
                                <div class="table-responsive shadow rounded">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>
                                                <th class="border-bottom p-3">ID</th>
                                                <th class="border-bottom p-3" style="min-width: 220px;">Tên</th>
                                                <th class="text-center border-bottom p-3" style="min-width: 180px;">Số điện thoại</th>
                                                <th class="text-center border-bottom p-3" style="min-width: 140px;">Ngày tạo</th>
                                                <th class="text-center border-bottom p-3">Tổng tiền</th>
                                                <th class="text-center border-bottom p-3">Trạng thái</th>
                                                <th class="text-center border-bottom p-3">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listInvoice}" var="o">
                                                <tr>
                                                    <th class="p-3">${o.appointmentId}</th>
                                                    <td class="p-3">
                                                        <a href="#" class="text-primary">
                                                            <div class="d-flex align-items-center">
                                                                <img src="${o.customer.avatar}" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                                <span class="ms-2">${o.customer.name}</span>
                                                            </div>
                                                        </a>
                                                    </td>
                                                    <td class="text-center p-3">${o.customer.phone}</td>
                                                    <td class="text-center p-3">
                                                        <fmt:formatDate value="${o.date}" pattern="dd/MM/yyyy" />
                                                    </td>
                                                    <td class="text-center p-3">
                                                        <fmt:formatNumber value="${o.total}" type="currency" currencySymbol="VNĐ"/>
                                                    </td>
                                                    <td class="text-center p-3">
                                                        <div class="badge ${o.status == 'paid' ? 'bg-soft-success' : 'bg-soft-danger'} rounded px-3 py-1">
                                                            ${o.status == 'paid' ? 'Đã thanh toán' : 'Chưa thanh toán'}
                                                        </div>
                                                    </td>
                                                    <td class="text-center p-3">
                                                        <!-- Icon con mắt để xem chi tiết hóa đơn -->
                                                        <a href="invoiceDetail?appointmentId=${o.appointmentId}" class="btn btn-sm btn-primary">
                                                            <i class="fas fa-eye"></i> 
                                                        </a>

                                                        <a href="listinvoice?invoiceId=${o.appointmentId}&name=${param.name}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&totalFrom=${param.totalFrom}&totalTo=${param.totalTo}&status=${param.status}&statusUpdate=paid&pageSize=${param.pageSize}&sortDate=${param.sortDate}&sortPrice=${param.sortPrice}&page=${currentPage}" 
                                                           class="btn btn-sm btn-success" 
                                                           onclick="return confirm('Bạn có chắc chắn muốn đánh dấu hóa đơn này là đã thanh toán?');">
                                                            <i class="fas fa-check"></i>
                                                        </a>


                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div><!--end row-->

                        <!-- Phân trang -->
                        <div class="col-12" style="margin-top: 1%;">
                            <div class="d-md-flex align-items-center justify-content-end">
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <!-- Nút "Trước" -->
                                    <c:if test="${currentPage > 1}">
                                        <li class="page-item">
                                            <a class="page-link" href="listinvoice?invoiceId=${param.invoiceId}&name=${param.name}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&totalFrom=${param.totalFrom}&totalTo=${param.totalTo}&status=${param.status}&pageSize=${param.pageSize}&sortDate=${param.sortDate}&sortPrice=${param.sortPrice}&page=${currentPage - 1}">Trước</a>
                                        </li>
                                    </c:if>

                                    <!-- Hiển thị số trang -->
                                    <c:forEach begin="1" end="${totalPages}" var="p">
                                        <li class="page-item ${p == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="listinvoice?invoiceId=${param.invoiceId}&name=${param.name}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&totalFrom=${param.totalFrom}&totalTo=${param.totalTo}&status=${param.status}&pageSize=${param.pageSize}&sortDate=${param.sortDate}&sortPrice=${param.sortPrice}&page=${p}">${p}</a>
                                        </li>
                                    </c:forEach>

                                    <!-- Nút "Sau" -->
                                    <c:if test="${currentPage < totalPages}">
                                        <li class="page-item">
                                            <a class="page-link" href="listinvoice?invoiceId=${param.invoiceId}&name=${param.name}&dateFrom=${param.dateFrom}&dateTo=${param.dateTo}&totalFrom=${param.totalFrom}&totalTo=${param.totalTo}&status=${param.status}&pageSize=${param.pageSize}&sortDate=${param.sortDate}&sortPrice=${param.sortPrice}&page=${currentPage + 1}">Sau</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>
                        </div>


                    </div><!--end container-->
                    <!-- Footer Start -->
                    <jsp:include page="footer.jsp" />
                    <!-- End -->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->
        <script>
            document.getElementById("btnReset").addEventListener("click", function () {
                let form = document.querySelector(".filter-form");

                form.querySelectorAll("input").forEach(input => {
                    if (input.type === "date") {
                        input.value = "";
                    } else if (input.name === "pageSize") {
                        input.value = 10;
                    } else {
                        input.value = ""; //
                    }
                });

                form.querySelectorAll("select").forEach(select => {
                    select.selectedIndex = 0;
                });
            });
        </script>

    </script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/feather.min.js"></script>
    <script src="assets/js/app.js"></script>
</body>
</html>
