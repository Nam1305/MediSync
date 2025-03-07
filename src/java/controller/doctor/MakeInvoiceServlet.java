/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.AppointmentDAO;
import dal.InvoiceDAO;
import dal.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Appointment;
import model.Invoice;
import model.Service;

/**
 *
 * @author DIEN MAY XANH
 */
public class MakeInvoiceServlet extends HttpServlet {

    ServiceDAO serviceDao = new ServiceDAO();
    AppointmentDAO ad = new AppointmentDAO();
    InvoiceDAO invoiceDao = new InvoiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
        List<Invoice> invoices = invoiceDao.getInvoiceByAppointment(appointmentId);
        List<Service> services = serviceDao.getAllActiveServices();

        request.setAttribute("invoices", invoices);
        request.setAttribute("services", services);

        request.setAttribute("app", app);
        request.getRequestDispatcher("doctor/makeInvoice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String appId = request.getParameter("appointmentId");
        int appointmentId = 0;
        try {
            appointmentId = Integer.parseInt(appId);
        } catch (NumberFormatException e) {
            appointmentId = 0;
        }

        String[] serviceIds = request.getParameterValues("serviceId[]");
        String[] prices = request.getParameterValues("price[]");

        boolean success = invoiceDao.saveInvoice(appointmentId, serviceIds, prices);
        response.sendRedirect("makeinvoice?appointmentId=" + appointmentId);
    }

}
