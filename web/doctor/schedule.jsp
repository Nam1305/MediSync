<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>Schedule</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css" rel="stylesheet" />
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <link href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css" rel="stylesheet" />
        <!-- Calendar CSS -->
        <link href="assets/css/fullcalendar.min.css" rel="stylesheet" type="text/css" />
        <!-- jQuery và các plugin JS khác -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <!-- FullCalendar JS -->
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
                    <!-- Left Navbar chiếm 1/4 -->
                    <div class="col-xl-3 col-lg-3 col-md-4 col-12">
                        <div class="rounded shadow overflow-hidden sticky-bar">
                            <jsp:include page="left-navbar.jsp" />
                        </div>
                    </div>

                    <!-- Schedule chiếm 3/4 -->
                    <div class="col-xl-9 col-lg-9 col-md-8 mt-4 pt-2 mt-sm-0 pt-sm-0">
                        <!-- FullCalendar sẽ được hiển thị ở đây -->
                        <div id="calendar" style="max-width: 900px; margin: 40px auto;"></div>
                    </div>
                    <!--end col-->
                </div>
                <!--end row-->
            </div>
            <!--end container-->
        </section>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
            var calendarEl = document.getElementById("calendar");
            var events = [
            <c:if test="${not empty list}">
                <c:forEach var="s" items="${list}" varStatus="status">
            {
            title: "${s.startTime} - ${s.endTime}",
                        start: "${s.date}T${s.startTime}",
                                    end: "${s.date}T${s.endTime}",
                                                backgroundColor: "#007bff",
                                                borderColor: "#007bff"
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
                                                events: events
                                        });
                                        calendar.render();
                                        });
        </script>

        <!--end section-->
        <jsp:include page="footer.jsp" />
    </body>
</html>
