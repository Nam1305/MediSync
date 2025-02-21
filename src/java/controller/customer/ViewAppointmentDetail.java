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

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/appointmentDetail"})
public class ViewAppointmentDetail extends HttpServlet {

    AppointmentDAO appointmentDAO = new AppointmentDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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

            // Lấy danh sách dịch vụ của khách hàng liên quan
            List<Service> services = appointmentDAO.getListService(appointment.getCustomer().getCustomerId(), appointmentId);
            request.setAttribute("services", services);

            // Lấy thông tin thời gian và bác sĩ
            Time startTime = appointmentDAO.getDetailStartTime(appointment.getCustomer().getCustomerId(), appointmentId);
            Time endTime = appointmentDAO.getDetailEndTime(appointment.getCustomer().getCustomerId(), appointmentId);
            String doctorName = appointmentDAO.getDetailDoctorName(appointment.getCustomer().getCustomerId(), appointmentId);
            String status = appointmentDAO.getDetailStatus(appointment.getCustomer().getCustomerId(), appointmentId);
            // Truyền thông tin thời gian và bác sĩ vào request
            request.setAttribute("startTime", startTime);
            request.setAttribute("endTime", endTime);
            request.setAttribute("doctorName", doctorName);
            request.setAttribute("status", status);

            // Chuyển tiếp đến trang JSP để hiển thị
            request.getRequestDispatcher("AppointmentDetail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
