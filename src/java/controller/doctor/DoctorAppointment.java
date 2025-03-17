/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.AppointmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Appointment;
import java.sql.*;
import java.time.LocalDate;
import model.Staff;

/**
 *
 * @author DIEN MAY XANH
 */
public class DoctorAppointment extends HttpServlet {

    AppointmentDAO ad = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staff st = (Staff) session.getAttribute("staff");

        // Đặt charset cho request và response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Xử lý cập nhật trạng thái nếu có
        String appId = request.getParameter("appointmentId");
        String newStatus = request.getParameter("newStatus");
        if (appId != null && newStatus != null) {
            try {
                int appointmentId = Integer.parseInt(appId);
                ad.updateAppointmentStatus(appointmentId, newStatus);
            } catch (NumberFormatException e) {
                // Log lỗi nếu cần
            }
        }

        // Lấy các tham số filter từ request
        String search = request.getParameter("search");
        if (search != null) {
            search = search.trim().replaceAll("\\s+", " ");
        }
        String status = request.getParameter("status"); // filter status: "confirmed", "waitpay", "absent"

        // Lấy giá trị từDate và toDate từ request
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        Date fromDate = null, toDate = null;

        // Tách riêng xử lý fromDate và toDate
        if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
            try {
                fromDate = Date.valueOf(fromDateStr);
            } catch (Exception e) {
                fromDate = null;
            }
        }
        if (toDateStr != null && !toDateStr.trim().isEmpty()) {
            try {
                toDate = Date.valueOf(toDateStr);
            } catch (Exception e) {
                toDate = null;
            }
        }
        // Nếu cả 2 đều null, mặc định lấy ngày hôm nay
        if (fromDateStr == null) {
            LocalDate today = LocalDate.now();
            fromDate = Date.valueOf(today);
            fromDateStr = fromDate.toString();
        }
        if (toDateStr == null) {
            LocalDate today = LocalDate.now();
            toDate = Date.valueOf(today);
            toDateStr = toDate.toString();
        }

        // Xử lý phân trang: mặc định page = 1, pageSize = 10
        int page = 1;
        int pageSize = 10;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        if (request.getParameter("pageSize") != null) {
            try {
                pageSize = Integer.parseInt(request.getParameter("pageSize"));
            } catch (NumberFormatException e) {
                pageSize = 10;
            }
        }

        String sort = "asc";
        if (request.getParameter("sort") != null) {
            sort = request.getParameter("sort");
        }

        try {
            // Lấy danh sách Appointment theo filter và phân trang
            List<Appointment> listA = ad.getAppointmentsByPage(st.getStaffId(), search, status, fromDate, toDate, page, pageSize, sort);
            int statis[] = ad.countAppointmentStatsByFilter(st.getStaffId(), search, status, fromDate, toDate);
            int totalPages = (int) Math.ceil((double) statis[0] / pageSize);

            request.setAttribute("listA", listA);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("statis", statis);
            request.setAttribute("totalPages", totalPages);     // "Vắng mặt"
            request.setAttribute("search", search);
            request.setAttribute("status", status);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);
            request.setAttribute("sort", sort);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("doctor/doctorAppointment.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
