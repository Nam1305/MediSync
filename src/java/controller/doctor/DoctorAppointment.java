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
import model.Staff;

/**
 *
 * @author DIEN MAY XANH
 */
public class DoctorAppointment extends HttpServlet {

    AppointmentDAO ad = new AppointmentDAO();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staff st = (Staff) session.getAttribute("staff");
        // Đặt charset cho request và response
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String appId = request.getParameter("appointmentId");
        String newStatus = request.getParameter("newStatus");
        if (appId != null && newStatus != null) {
            try {
                int appointmentId = Integer.parseInt(appId);
                // Cập nhật trạng thái của appointment
                ad.updateAppointmentStatus(appointmentId, newStatus);
            } catch (NumberFormatException e) {
            }
        }

        // Lấy các tham số filter từ request
        String search = request.getParameter("search");
        if (search != null) {
            search = search.trim().replaceAll("\\s+", " ");
        }
        String status = request.getParameter("status");
        String dateStr = request.getParameter("date");
        Date date = null;
        if (dateStr != null && !dateStr.trim().isEmpty()) {
            try {
                date = Date.valueOf(dateStr);
            } catch (Exception e) {
                date = null;
            }
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
        if(request.getParameter("sort") != null){
            sort = request.getParameter("sort");
        }

        try {
            // Lấy danh sách Appointment theo filter và phân trang
            List<Appointment> listA = ad.getAppointmentsByPage(st.getStaffId(), search, status, date, page, pageSize, sort);
            int totalAppointments = ad.countAppointmentsByFilter(st.getStaffId(), search, status, date);
            int totalPages = (int) Math.ceil((double) totalAppointments / pageSize);

            // Đẩy dữ liệu ra JSP
            request.setAttribute("listA", listA);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalAppointments", totalAppointments);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", search);
            request.setAttribute("status", status);
            request.setAttribute("date", dateStr);
            request.setAttribute("sort", sort);
        } catch (Exception e) {
        }

        // Forward đến JSP hiển thị danh sách lịch hẹn
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
