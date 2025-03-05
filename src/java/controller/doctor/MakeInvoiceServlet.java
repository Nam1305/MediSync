/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.AppointmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Appointment;
import model.Staff;

/**
 *
 * @author DIEN MAY XANH
 */
public class MakeInvoiceServlet extends HttpServlet {

    AppointmentDAO ad = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String appId = request.getParameter("appointmentId");
        int appointmentId = 0;
        try {
            appointmentId = Integer.parseInt(appId);
        } catch (NumberFormatException e) {
            appointmentId = 0;
        }
        Appointment app = ad.getAppointmentsById(appointmentId);
        request.setAttribute("app", app);
        request.getRequestDispatcher("doctor/makeInvoice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
