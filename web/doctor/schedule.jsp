<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Lịch làm việc</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="assets/css/remixicon.css" rel="stylesheet" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" />
        <link rel="shortcut icon" href="assets/images/logo-icon.png"><!-- comment -->       

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>

        <style>
            body {
                background-color: #e9ecef;
            }
            #calendar {
                width: 90%;
                max-width: 1200px;
                margin: auto;
                background: #fff;
                border: 1px solid #ced4da;
                padding: 10px;
                border-radius: 6px;
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                min-height: 500px;
            }

            .fc-toolbar {
                background: #c3e6cb;
                color: #155724;
                border-radius: 6px;
                padding: 8px;
            }
            .fc-toolbar h2 {
                color: #155724 !important;
            }
            .fc-toolbar .fc-button {
                background: #28a745;
                color: #fff;
                border: none;
                border-radius: 4px;
                padding: 6px 12px;
            }
            .fc-toolbar .fc-button:hover {
                background: #218838 !important;
            }
            .fc-toolbar .fc-button-active {
                background: #1e7e34 !important;
            }
            .fc-col-header-cell {
                background: #f1f3f5;
                color: #155724;
                font-weight: bold;
                border: 1px solid #ced4da;
            }
            .fc-event {
                background: #28a745;
                border-color: #218838;
                color: #fff;
                border-radius: 4px;
            }
            .fc-event:hover {
                background: #1e7e34 !important;
            }
            .fc-day-today {
                background: #d4edda !important;
            }

            @media (max-width: 768px) {
                #calendar {
                    width: 95vw;
                    min-height: 400px;
                }
                .fc-toolbar {
                    flex-direction: column;
                    text-align: center;
                }
            }
            @media (max-width: 480px) {
                #calendar {
                    width: 100%;
                    min-height: 350px;
                }
            }
            @media (min-width: 1024px) {
                #calendar {
                    width: 60vw; /* Giảm chiều rộng xuống 60% màn hình */
                    max-width: 900px; /* Giới hạn kích thước tối đa để bảng không quá dài */
                    max-height: 600px; /* Đảm bảo bảng không quá cao */
                }
            }


        </style>
    </head>
    <body>
        <div class="page-wrapper doctris-theme toggled">
            <jsp:include page="left-navbar.jsp" />
            <main class="page-content bg-light">
                <jsp:include page="top-navbar.jsp" />
                <div class="container-fluid">
                    <div class="layout-specing" style="margin-top: -1%;">
                        <div id="calendar"></div>
                    </div>
                </div>
                <jsp:include page="footer.jsp" />
            </main>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
            var calendarEl = document.getElementById("calendar");
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
                                            buttonText: { today: 'Hôm nay', month: 'Tháng', week: 'Tuần', day: 'Ngày' },
                                            events: events,
                                            eventContent: function(info) {
                                            var title = info.event.title;
                                            var startTime = info.event.extendedProps.startTime;
                                            var endTime = info.event.extendedProps.endTime;
                                            return { html: '<div style="font-size: 0.8em; text-align: center;">' + title + '<br>' + startTime + ' - ' + endTime + '</div>' };
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