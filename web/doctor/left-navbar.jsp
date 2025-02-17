<%-- 
    Document   : left-navbar
    Created on : Feb 15, 2025, 4:03:56 PM
    Author     : DIEN MAY XANH
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div class="card border-0">
    <img src="assets/images/doctors/profile-bg.jpg" class="img-fluid" alt="">
</div>

<div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
    <img src="${staff.avatar}"
         class="avatar avatar-md-sm rounded-circle border shadow" alt="">

    <h5 class="mt-3 mb-1">${staff.name}</h5>
    <p class="text-muted mb-0">${staff.department.departmentName}</p>
</div>
<c:choose>
    <c:when test="${staff.role.roleId == 2 || staff.role.roleId == 3}">
        <ul class="list-unstyled sidebar-nav mb-0">
            <li class="navbar-item">
            <a href="doctorappointment" class="navbar-link">
                    <i class="ri-calendar-check-line align-middle navbar-icon"></i> Lịch hẹn
                </a>
            </li>
            <li class="navbar-item">
                <a href="schedule" class="navbar-link">
                    <i class="ri-timer-line align-middle navbar-icon"></i> Lịch làm việc
                </a>
            </li>
            <li class="navbar-item">
                <a href="doctor/invoices.jsp" class="navbar-link">
                    <i class="ri-pages-line align-middle navbar-icon"></i> Hóa đơn
                </a>
            </li>
            <li class="navbar-item">
                <a href="doctor/patient-list.jsp" class="navbar-link">
                    <i class="ri-empathize-line align-middle navbar-icon"></i> Bệnh nhân
                </a>
            </li>
            <li class="navbar-item">
                <a href="doctor/patient-review.jsp" class="navbar-link">
                    <i class="ri-chat-1-line align-middle navbar-icon"></i> Đánh giá của bệnh nhân
                </a>
            </li>
        </ul>
    </c:when>
    <c:otherwise>
        <div style="font-size: 20px; color: #333; background-color: #f8f9fa; padding: 15px; border-radius: 5px; border: 1px solid #ccc; margin-top: 20px; font-weight: bold; text-align: center;">
            Tôi là ${staff.role.role}
        </div>
    </c:otherwise>
</c:choose>



