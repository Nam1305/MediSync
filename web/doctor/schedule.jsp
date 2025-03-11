<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Lịch làm việc</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- CSS Bootstrap, Icons, FullCalendar -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

        <style>
            /* Page background */
            body {
                background-color: #e9ecef; /* Light gray */
            }
            /* Calendar container */
            #calendar {
                background-color: #ffffff; /* White */
                border: 1px solid #ced4da;
                padding: 10px;
                border-radius: 6px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                max-width: 900px;
                margin: 40px auto;
            }
            /* Toolbar */
            .fc-toolbar {
                color: #000000; /* Dark text */
                border-radius: 4px;
                padding: 5px;
            }
            .fc-toolbar button {
                background-color: #ffffff;
                color: #000000;
                border: none;
                border-radius: 4px;
                margin: 2px;
            }
            .fc-toolbar button:hover {
                background-color: #b8daff; /* Slightly darker blue */
            }
            /* Header cells */
            .fc-col-header-cell {
                background-color: #f1f3f5;
                border: 1px solid #ced4da;
                font-weight: bold;
            }
            /* Event styling */
            .fc-event {
                background-color: #28a745 !important; /* Green */
                border-color: #28a745 !important;
                color: #ffffff !important;
                border-radius: 4px;
                padding: 2px 4px;
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
        <!-- END Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="left-navbar.jsp" />
            <!-- sidebar-wrapper -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing" style="margin-top: -4%;">
                        <div id="calendar"></div>
                    </div>
                </div>
                <!--end container-->
                <jsp:include page="footer.jsp" />
            </main>
            <!-- End Page Content -->
        </div>
        <!-- END page-wrapper -->

        <!-- Loại bỏ modal vì không cần popup nữa -->

        <script>
            document.addEventListener("DOMContentLoaded", function () {
            var calendarEl = document.getElementById("calendar");
            // Hàm xác định tên ca dựa trên startTime (có thể dùng nếu cần hiển thị trong event)
            function getShiftTitle(startTime) {
            switch (startTime) {
            case "08:00:00": return "Ca 1";
            case "13:00:00": return "Ca 2";
            case "18:00:00": return "Ca 3";
            default: return "Ca khác";
            }
            }

            var events = [
            <c:if test="${not empty list}">
                <c:forEach var="s" items="${list}" varStatus="status">
            {
            title: getShiftTitle("${s.startTime}"),
                    start: "${s.date}T<fmt:formatDate value='${s.startTime}' type='time' pattern='HH:mm'/>",
                                end: "${s.date}T<fmt:formatDate value='${s.endTime}' type='time' pattern='HH:mm'/>",
                                            backgroundColor: "#007bff",
                                            borderColor: "#007bff",
                                            extendedProps: {
                                            date: "<fmt:formatDate value='${s.date}' type='date' pattern='dd/MM/yyyy'/>",
                                                    startTime: "<fmt:formatDate value='${s.startTime}' type='time' pattern='HH:mm'/>",
                                                    endTime: "<fmt:formatDate value='${s.endTime}' type='time' pattern='HH:mm'/>"
                                            }
                                    }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            </c:if>
                                    ];
                                    var calendar = new FullCalendar.Calendar(calendarEl, {
                                    initialView: "dayGridMonth",
                                            locale: "vi",
                                            headerToolbar: {
                                            left: "prev,next today",
                                                    center: "title",
                                                    right: "dayGridMonth,timeGridWeek,timeGridDay"
                                            },
                                            buttonText: {
                                            today: 'Hôm nay',
                                                    month: 'Tháng',
                                                    week: 'Tuần',
                                                    day: 'Ngày'
                                            },
                                            events: events,
                                            // Hiển thị chi tiết event trực tiếp trong ngày (inline)
                                            eventContent: function(info) {
                                            var title = info.event.title;
                                            var startTime = info.event.extendedProps.startTime;
                                            var endTime = info.event.extendedProps.endTime;
                                            var html = '<div style="font-size: 0.8em; text-align: center;">'
                                                    + title + '<br>'
                                                    + startTime + ' - ' + endTime
                                                    + '</div>';
                                            return { html: html };
                                            }
                                    });
                                    calendar.render();
                                    });
        </script>

        <script src="assets/js/fullcalendar.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </body>
</html>
