package controller.customer;

import dal.AppointmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Appointment;
import model.Service;
import java.sql.*;
import model.Prescription;
import model.Staff;
import model.TreatmentPlan;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/appointmentDetail"})
public class ViewAppointmentDetail extends HttpServlet {

    AppointmentDAO appointmentDAO = new AppointmentDAO();

    protected void handleViewAppointmentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Lấy appointmentId từ request
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

        // Lấy chi tiết cuộc hẹn từ DAO
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);

        if (appointment != null) {
            // Truyền dữ liệu cuộc hẹn vào JSP
            request.setAttribute("appointment", appointment);
            // Lấy thông tin bác sĩ phụ trách
            Staff doctor = appointmentDAO.getDetailDoctor(appointment.getCustomer().getCustomerId(), appointmentId);
            //Lấy thông tin bệnh án
            TreatmentPlan treat = appointmentDAO.getTreatmentPlanDetail(appointment.getCustomer().getCustomerId(), appointmentId);
            //Lấy thông tin đơn thuốc
            List<Prescription> presription = appointmentDAO.getPrescriptionDetail(appointment.getCustomer().getCustomerId(), appointmentId);
            // Truyền thông tin thời gian và bác sĩ vào request
            request.setAttribute("doctor", doctor);
            request.setAttribute("treat", treat);
            request.setAttribute("prescription", presription);

            // Chuyển tiếp đến trang JSP để hiển thị
            request.getRequestDispatcher("customerAppointmentDetail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleViewAppointmentDetail(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
