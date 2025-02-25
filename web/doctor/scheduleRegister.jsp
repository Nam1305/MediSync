<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Đăng ký ca làm việc</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/app.js"></script>

        <style>
            .shift-container {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
                justify-content: center;
            }
            .shift-box {
                display: flex;
                align-items: center;
                justify-content: center;
                width: 150px;
                height: 40px;
                border: 2px solid #ddd;
                border-radius: 10px;
                cursor: pointer;
                transition: all 0.3s ease-in-out;
                font-size: 12px;
                font-weight: bold;
                text-align: center;
                background-color: #f8f9fa;
            }
            .shift-box:hover {
                border-color: #007bff;
                background-color: #e9f5ff;
            }
            .shift-box input {
                display: none;
            }
            .shift-box.active {
                border-color: #28a745;
                background-color: #d4edda;
                color: #155724;
            }
        </style>
    </head>
    <body>
        <jsp:include page="top-navbar.jsp" />
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-3 col-md-4">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <jsp:include page="left-navbar.jsp" />
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-9 col-md-8 mt-4 pt-2">
                        <!-- Form đăng ký ca làm việc -->
                        <div class="card shadow p-4 mb-4">
                            <h4 class="mb-3 text-center">Đăng ký ca làm việc</h4>
                            <form id="registerShiftForm" action="schedule" method="GET">
                                <input type="hidden" name="action" value="regis">
                                <div class="mb-3">
                                    <div class="shift-container">
                                        <label class="shift-box">
                                            <input type="checkbox" name="shifts" value="1"> Ca 1 <br> (08:00 - 12:00)
                                        </label>
                                        <label class="shift-box">
                                            <input type="checkbox" name="shifts" value="2"> Ca 2 <br> (13:00 - 17:00)
                                        </label>
                                        <label class="shift-box">
                                            <input type="checkbox" name="shifts" value="3"> Ca 3 <br> (18:00 - 22:00)
                                        </label>
                                    </div>
                                </div>

                                <!-- Hiển thị thông báo ngay trên nút đăng ký -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center">${error}</div>
                                </c:if>
                                <c:if test="${not empty success}">
                                    <div class="alert alert-success text-center">${success}</div>
                                </c:if>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-success px-4">Đăng ký</button>
                                </div>                           
                            </form>
                        </div>

                        <!-- Danh sách bản đăng ký ca làm việc -->
                        <div class="card shadow p-4">
                            <h4 class="mb-3 text-center">Danh sách đăng ký ca làm việc</h4>
                            <table class="table table-bordered">
                                <thead class="table-success">
                                    <tr>
                                        <th>ID</th>
                                        <th>Thời gian đăng kí</th>
                                        <th>Ca</th>
                                        <th>Thời gian</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="schedule" items="${lists}">
                                        <tr>
                                            <td>${schedule.registrationId}</td>
                                            <td><fmt:formatDate value="${schedule.regisDate}" pattern="dd/MM/yyyy" /></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${schedule.shift == 1}">Ca 1</c:when>
                                                    <c:when test="${schedule.shift == 2}">Ca 2</c:when>
                                                    <c:otherwise>Ca 3</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${schedule.shift == 1}">08:00 - 12:00</c:when>
                                                    <c:when test="${schedule.shift == 2}">13:00 - 17:00</c:when>
                                                    <c:otherwise>18:00 - 22:00</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${schedule.status eq 'Approved'}">
                                                        <span class="badge bg-success">Đã duyệt</span>
                                                    </c:when>
                                                    <c:when test="${schedule.status eq 'Pending'}">
                                                        <span class="badge bg-warning">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-danger">Từ chối</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="col-12" style="margin-top: 1%;">
                                <div class="d-md-flex align-items-center justify-content-end">
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <!-- Nút 'Trước' -->
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage - 1}&pageSize=${pageSize}">Trước</a>
                                            </li>
                                        </c:if>

                                        <!-- Hiển thị số trang -->
                                        <c:forEach begin="1" end="${totalPages}" var="p">
                                            <li class="page-item ${p == currentPage ? 'active' : ''}">
                                                <a class="page-link" href="?page=${p}&pageSize=${pageSize}">${p}</a>
                                            </li>
                                        </c:forEach>

                                        <!-- Nút 'Sau' -->
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item">
                                                <a class="page-link" href="?page=${currentPage + 1}&pageSize=${pageSize}">Sau</a>
                                            </li>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>

        </section>

        <script>
//            document.getElementById("registerShiftForm").addEventListener("submit", function (event) {
//                let checkboxes = document.querySelectorAll('input[name="shifts"]:checked');
//                if (checkboxes.length === 0) {
//                    event.preventDefault();
//                    alert("Vui lòng chọn ít nhất một ca làm việc!");
//                }
//            });

            document.querySelectorAll(".shift-box").forEach(box => {
                box.addEventListener("click", function () {
                    let checkbox = this.querySelector("input");
                    checkbox.checked = !checkbox.checked;
                    this.classList.toggle("active", checkbox.checked);
                });
            });
        </script>

        <jsp:include page="footer.jsp" />
    </body>
</html>
