<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Lịch làm việc</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="assets/js/fullcalendar.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/feather.min.js"></script>
        <script src="assets/js/app.js"></script>
    </head>
    <body>
        <jsp:include page="top-navbar.jsp" />
        <section class="bg-dashboard">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xl-3 col-lg-3 col-md-4 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <jsp:include page="left-navbar.jsp" />
                        </div>
                    </div>
                    <div class="col-xl-9 col-lg-9 col-md-8 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <div id="calendar" style="max-width: 900px; margin: 40px auto;"></div>
                    </div>
                </div>
            </div>
        </section>

        <div class="modal fade" id="eventDetailModal" tabindex="-1" aria-labelledby="eventDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eventDetailModalLabel">Chi tiết ca làm việc</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <p><strong>Ngày:</strong> <span id="eventDate"></span></p>
                        <p><strong>Ca làm việc:</strong> <span id="eventTitle"></span></p>
                        <p><strong>Thời gian:</strong> <span id="eventTime"></span></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
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
                                            date: "${s.date}",
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
                                            eventClick: function(info) {
                                            $("#eventDate").text(info.event.extendedProps.date);
                                            $("#eventTitle").text(info.event.title);
                                            $("#eventTime").text(info.event.extendedProps.startTime + " - " + info.event.extendedProps.endTime);
                                            $("#eventDetailModal").modal("show");
                                            }

                                    });
                                    calendar.render();
                                    });
        </script>

        <jsp:include page="footer.jsp" />
    </body>
</html>
