<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">

    <head>
        <meta charset="utf-8" />
        <title>Schedule</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/assets/images/favicon.ico.png">
        <link href="<%= request.getContextPath() %>/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="<%= request.getContextPath() %>/assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="<%= request.getContextPath() %>/assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet">
        <link href="<%= request.getContextPath() %>/assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <style>
            .schedule-container {
                background: white;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 100%;
            }

            h2 {
                font-size: 24px;
            }

            table {
                font-size: 16px;
                width: 100%;
            }

            button {
                font-size: 16px;
                padding: 10px;
            }
            th, tr{
                text-align: center;
            }
        </style>
    </head>

    <body>
        <jsp:include page="top-navbar.jsp" />
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <!-- Left Navbar chiếm 1/4 -->
                    <div class="col-xl-3 col-lg-3 col-md-4 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <jsp:include page="left-navbar.jsp" />
                        </div>
                    </div>

                    <!-- Schedule chiếm 3/4 -->
                    <div class="col-xl-9 col-lg-9 col-md-8 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div class="schedule-container">
                            <form action="schedule?action=adddate" method="post">
                                <!-- Chọn ngày -->
                                <label class="form-label">Chọn ngày: </label>
                                <input type="date" id="selectedDate" class="form-control mb-3" name="datework" required>

                                <!-- Chọn ca làm việc -->
                                <label class="form-label">Chọn ca làm việc:</label>
                                <select id="shiftSelect" class="form-select mb-3" required onchange="updateTime()">
                                    <option value="" disabled selected>Chọn ca</option>
                                    <option value="08:00-12:00">Ca 1: 08:00 - 12:00</option> 
                                    <option value="13:00-17:00">Ca 2: 13:00 - 17:00</option> 
                                    <option value="18:00-22:00">Ca 3: 18:00 - 22:00</option> 
                                </select>

                                <input type="hidden" id="startTime" name="startTime">
                                <input type="hidden" id="endTime" name="endTime">
                                <button type="submit" class="btn btn-success w-100">Đăng ký</button>
                            </form>

                            <h4 class="mt-4 text-center">Lịch làm việc đã đăng ký</h4>

                            <form action="schedule" method="get" class="d-inline">
                                <label for="startDate" class="form-label">Từ ngày:</label>
                                <input type="date" id="startDate" name="startDate" class="form-control form-control-sm d-inline w-auto"
                                       value="${startDate}"">

                                <label for="endDate" class="form-label">Đến ngày:</label>
                                <input type="date" id="endDate" name="endDate" class="form-control form-control-sm d-inline w-auto"
                                       value="${endDate}"">

                                <label for="pageSize" class="form-label">Số bản ghi:</label>
                                <input type="number" id="pageSize" name="size" class="form-control form-control-sm d-inline w-auto" 
                                       value="${pageSize}">

                                <button type="submit" class="btn btn-success btn-sm">Áp dụng</button>
                            </form>

                            <p></p>
                            <!-- Bảng dữ liệu -->
                            <div class="table-responsive">
                                <table id="scheduleTable" class="table table-bordered table-hover">
                                    <thead class="table-success">
                                        <tr>
                                            <th>STT</th> <!-- Cột số thứ tự -->
                                            <th>Ngày làm việc</th>
                                            <th>Ca làm việc</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${listSchedule}" var="o" varStatus="status">
                                            <tr>
                                                <td> <fmt:formatDate value="${o.date}" pattern="dd/MM/yyyy"/></td>
                                                <td>${o.startTime} - ${o.endTime}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>


                        </div>
                        <div class="row text-center mt-4">
                            <div class="col-12">
                                <div class="d-md-flex align-items-center justify-content-center">


                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0 justify-content-end">
                                        <!-- Nút Trước -->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="schedule?startDate=${requestScope.startDate}&endDate=${requestScope.endDate}&size=${pageSize}&page=${currentPage - 1}">Trước</a>
                                            </li>
                                        </c:if>

                                        <!-- Các số trang -->
                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="schedule?startDate=${requestScope.startDate}&endDate=${requestScope.endDate}&size=${pageSize}&page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Nút Sau -->
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="schedule?startDate=${requestScope.startDate}&endDate=${requestScope.endDate}&size=${pageSize}&page=${currentPage + 1}">Sau</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div><!-- End Schedule Section -->
                </div><!-- End Row -->
            </div><!-- End Container -->
        </section>

        <jsp:include page="footer.jsp" />

        <script>


            $(document).ready(function () {
                // Khởi tạo DataTable với chỉ sắp xếp, tắt tìm kiếm, phân trang và hiển thị thông tin
                var table = $("#scheduleTable").DataTable({
                    "order": [[0, "asc"]], // Sắp xếp mặc định theo cột ngày làm việc
                    "paging": false, // Tắt phân trang
                    "info": false, // Tắt thông tin số lượng mục hiển thị
                    "searching": false, // Tắt ô tìm kiếm
                });
            });



            function updateTime() {
                let shift = document.getElementById("shiftSelect").value;
                let [start, end] = shift.split("-"); // Tách giờ bắt đầu và kết thúc

                document.getElementById("startTime").value = start;
                document.getElementById("endTime").value = end;

                document.getElementById("displayStartTime").innerText = start;
                document.getElementById("displayEndTime").innerText = end;
            }


            document.addEventListener("DOMContentLoaded", function () {
                let rows = document.querySelectorAll("#scheduleTable tbody tr");
                rows.forEach((row, index) => {
                    let firstCell = document.createElement("td");
                    firstCell.textContent = index + 1; // Đánh số từ 1
                    row.insertBefore(firstCell, row.firstChild);
                });
            });

        </script>

        <script src="<%= request.getContextPath() %>/assets/js/bootstrap.bundle.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/feather.min.js"></script>
        <script src="<%= request.getContextPath() %>/assets/js/app.js"></script>
    </body>
</html>