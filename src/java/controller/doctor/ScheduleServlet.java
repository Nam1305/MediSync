/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.ScheduleDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Schedule;
import model.Staff;
import java.sql.*;

/**
 *
 * @author DIEN MAY XANH
 */
public class ScheduleServlet extends HttpServlet {

    ScheduleDAO scheduleDao = new ScheduleDAO();

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
        Staff s = (Staff) session.getAttribute("staff");

        int page = 1;
        int pageSize = 3;
        if (request.getParameter("size") != null) {
            pageSize = Integer.parseInt(request.getParameter("size"));
        }
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy giá trị ngày từ request
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        Date startDate = null, endDate = null;

        if (startDateStr != null && !startDateStr.isEmpty()) {
            startDate = Date.valueOf(startDateStr);
        }
        if (endDateStr != null && !endDateStr.isEmpty()) {
            endDate = Date.valueOf(endDateStr);
        }

        // Nếu startDate lớn hơn endDate, hoán đổi lại
        if (startDate != null && endDate != null && startDate.after(endDate)) {
            Date temp = startDate;
            startDate = endDate;
            endDate = temp;
        }

        // Lấy danh sách lịch theo điều kiện lọc
        List<Schedule> listSchedule = scheduleDao.getScheduleByPage(s.getStaffId(), startDate, endDate, page, pageSize);

        // Lấy tổng số bản ghi để tính số trang
        int totalSchedules = scheduleDao.countScheduleByFilter(s.getStaffId(), startDate, endDate, page, pageSize);

        int totalPages = (int) Math.ceil((double) totalSchedules / pageSize);

        // Gửi dữ liệu đến JSP
        request.setAttribute("listSchedule", listSchedule);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalSchedules", totalSchedules);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startDate", startDateStr);
        request.setAttribute("endDate", endDateStr);

        request.getRequestDispatcher("doctor/schedule.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");
        switch (action) {
            case "adddate":
                String dateworkStr = request.getParameter("datework");
                String startTimeStr = request.getParameter("startTime");
                String endTimeStr = request.getParameter("endTime");
                Date datework = Date.valueOf(dateworkStr);
                Time startTime = Time.valueOf(startTimeStr + ":00");
                Time endTime = Time.valueOf(endTimeStr + ":00");
                Schedule schedule = new Schedule(0, startTime, endTime, 30, datework, staff.getStaffId());
                scheduleDao.insertSchedule(schedule);
                response.sendRedirect("schedule");
                break;
            case "filterbyday":
                break;

        }
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
