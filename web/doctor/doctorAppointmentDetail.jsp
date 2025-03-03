<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết lịch hẹn</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.tiny.cloud/1/vnufc6yakojjcovpkijlauot8hfpbxd3uscxatfq2m4yijay/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>        
        <script src="assets/js/tinymce-init.js"></script>



        <style>
            body {
                background-color: #f8f9fa;
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
                background-color: #28a745;
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
                        <a onclick="goBack()" class="btn btn-success mb-3">Quay lại</a>
                        <h3 class="text-center text-success mb-4">Chi tiết lịch hẹn</h3>

                        <!-- Thông tin khách hàng -->
                        <div class="card">
                            <div class="card-header">Thông tin khách hàng</div>
                            <div class="card-body d-flex flex-column flex-md-row align-items-start">
                                <img src="${app.customer.avatar}" alt="Avatar" class="customer-image"/>
                                <div class="ms-3">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p><span class="info-label">Tên:</span> ${app.customer.name}</p>
                                            <p><span class="info-label">Email:</span> ${app.customer.email}</p>
                                            <p><span class="info-label">Địa chỉ:</span> ${app.customer.address}</p>
                                            <p><span class="info-label">Ngày sinh:</span> ${app.customer.dateOfBirth}</p>
                                        </div>
                                        <div class="col-md-6">
                                            <p><span class="info-label">Số điện thoại:</span> ${app.customer.phone}</p>
                                            <p><span class="info-label">Giới tính:</span> 
                                                <c:choose>
                                                    <c:when test="${app.customer.gender == 'M'}">Nam</c:when>
                                                    <c:otherwise>Nữ</c:otherwise>
                                                </c:choose>
                                            </p>
                                            <p><span class="info-label">Nhóm máu:</span> ${app.customer.getBloodType()}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bệnh án -->
                        <div class="card">
                            <div class="card-header">Bệnh án</div>
                            <div class="card-body">
                                <form action="doctorappdetail?action=treat" method="POST">
                                    <input type="hidden" name="appointmentId" value="${app.appointmentId}" />
                                    <div class="mb-2">
                                        <label for="symptoms">Triệu chứng:</label>
                                        <textarea id="symptoms" class="form-control" name="symptoms" >${treatment.symptoms}</textarea>
                                    </div>
                                    <div class="mb-2">
                                        <label for="diagnosis">Chẩn đoán:</label>
                                        <textarea id="diagnosis" class="form-control" name="diagnosis" >${treatment.diagnosis}</textarea>
                                    </div>
                                    <div class="mb-2">
                                        <label for="testResults">Kết quả xét nghiệm:</label>
                                        <!-- TinyMCE sẽ chuyển textarea này thành rich text editor -->
                                        <textarea id="testResults" class="form-control" name="testResult">${treatment.testResult}</textarea>
                                    </div>
                                    <div class="mb-2">
                                        <label for="treatmentPlan">Kế hoạch điều trị:</label>
                                        <textarea id="treatmentPlan" class="form-control" name="plan" >${treatment.plan}</textarea>
                                    </div>
                                    <div class="mb-2">
                                        <label for="followUp">Theo dõi:</label>
                                        <textarea id="followUp" class="form-control" name="followUp">${treatment.followUp}</textarea>
                                    </div>
                                    <button type="submit" class="btn btn-success">Lưu</button>
                                </form>
                            </div>
                        </div>

                        <!-- Đơn thuốc -->
                        <div class="card">
                            <div class="card-header">Đơn thuốc</div>
                            <div class="card-body">
                                <form action="doctorappdetail?action=pres" method="POST">
                                    <input type="hidden" name="appointmentId" value="${app.appointmentId}" />
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
                                            <c:forEach var="pres" items="${listPre}">
                                                <tr>
                                                    <td><input type="text" name="medicineName[]" class="form-control" value="${pres.medicineName}" required></td>
                                                    <td><input type="text" name="totalQuantity[]" class="form-control" value="${pres.totalQuantity}" required></td>
                                                    <td><input type="text" name="dosage[]" class="form-control" value="${pres.dosage}" required></td>
                                                    <td><input type="text" name="note[]" class="form-control" value="${pres.note}"></td>
                                                    <td><button type="button" class="btn btn-danger remove-medicine">Xóa</button></td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty appointment.prescriptions}">
                                                <tr>
                                                    <td><input type="text" name="medicineName[]" class="form-control" required></td>
                                                    <td><input type="text" name="totalQuantity[]" class="form-control" required></td>
                                                    <td><input type="text" name="dosage[]" class="form-control" required></td>
                                                    <td><input type="text" name="note[]" class="form-control"></td>
                                                    <td><button type="button" class="btn btn-danger remove-medicine">Xóa</button></td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                    <button type="button" class="btn btn-success" id="addMedicine">Thêm thuốc</button>
                                    <button type="submit" class="btn btn-success">Lưu</button>
                                </form>
                            </div>
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

                $("#addMedicine").hover(
                        function () {
                            $(this).addClass("btn-light");
                        },
                        function () {
                            $(this).removeClass("btn-light");
                        }
                );
            });


            function goBack() {
                if (document.referrer) {
                    window.history.back(); // Quay lại trang trước đó
                }
            }
        </script>









        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>


</html>



