/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.ScheduleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import java.sql.*;
import java.text.SimpleDateFormat;

/**
 *
 * @author Phạm Hoàng Nam
 */
@WebServlet(name = "BookAppointmentServlet", urlPatterns = {"/bookAppointment"})

public class BookAppointmentServlet extends HttpServlet {

    protected void handleBookAppointment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ScheduleDAO scheduleDAO = new ScheduleDAO();
        //lấy doctorId
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        //lấy customerId
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        int customerId = customer.getCustomerId();
        //lấy startTime
        Time startTime = Time.valueOf(request.getParameter("startTime"));
        //lấy endTime
        Time endTime = Time.valueOf(request.getParameter("endTime"));
        //lấy date
        String dateStr = request.getParameter("date");
        Date date= Date.valueOf(dateStr);//ép kiểu
        boolean success = scheduleDAO.bookAppointment(doctorId, customerId, startTime, endTime, date);
        if (success) {
            response.sendRedirect("doctorDetail?doctorId=" + doctorId + "&date=" + date + "&message=success");
        } else {
            response.sendRedirect("doctorDetail?doctorId=" + doctorId + "&date=" + date + "&message=error");
        }

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
        handleBookAppointment(request, response);
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
