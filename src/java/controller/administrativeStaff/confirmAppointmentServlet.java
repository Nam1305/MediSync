/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.administrativeStaff;

import dal.AppointmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.List;
import model.Appointment;

/**
 *
 * @author Admin
 */
@WebServlet(name = "confirmAppointmentServlet", urlPatterns = {"/confirmappointment"})
public class confirmAppointmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    AppointmentDAO appointmentDao = new AppointmentDAO();

    private String normalizeSearchQuery(String query) {
        return query.trim().replaceAll("\\s+", " "); // Loại bỏ khoảng trắng dư thừa
    }

    protected void handleConfirmAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        //lấy dữ liệu đưuọc gửi từ viewListAppointment.jsp về
        String appId = request.getParameter("appointmentId");
        String searchQuery = request.getParameter("search");
        String status = request.getParameter("status");
        String dateStr = request.getParameter("date");
        String newStatus = request.getParameter("newStatus");
        
        //cập nhật trạng thái
        if (appId != null && newStatus != null) {
            try {
                int appointmentId = Integer.parseInt(appId);
                // Cập nhật trạng thái của appointment
                appointmentDao.updateAppointmentStatus(appointmentId, newStatus);
            } catch (NumberFormatException e) {
            }
        }

        //normalized searchQuery
        if (searchQuery == null || searchQuery.trim().isEmpty()) {
            searchQuery = ""; // Gán chuỗi rỗng nếu `search` null
        }

        String nameNormalized = null;
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            nameNormalized = normalizeSearchQuery(searchQuery);
        }

        //ép kiểu dateStr
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

        //xử lý sort
        String sort = "desc";
        if (request.getParameter("sort") != null) {
            sort = request.getParameter("sort");
        }

        try {
            //lấy ra tất cả danh sách lịch hẹn
            List<Appointment> listA = appointmentDao.getAllAppointmentsByPage(nameNormalized, status, date, page, pageSize, sort);
            int totalAppointments = appointmentDao.countAllAppointmentsByFilter(nameNormalized, status, date);
            int totalPages = (int) Math.ceil((double) totalAppointments / pageSize);

            // Đẩy dữ liệu ra JSP
            request.setAttribute("listA", listA);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("totalAppointments", totalAppointments);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("search", nameNormalized);
            request.setAttribute("status", status);
            request.setAttribute("date", dateStr);
            request.setAttribute("sort", sort);
        } catch (Exception e) {
        }

        // Forward đến JSP hiển thị danh sách lịch hẹn
        request.getRequestDispatcher("AdministrativeStaff/viewListAppointment.jsp").forward(request, response);

    }

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
        handleConfirmAppointment(request, response);
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
