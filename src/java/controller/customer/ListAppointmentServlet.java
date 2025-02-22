package controller.customer;

import dal.AppointmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dal.CustomerDAO;
import jakarta.servlet.http.Cookie;
import java.sql.Time;
import java.util.List;
import model.Appointment;
import model.Customer;
import model.Service;

@WebServlet(name = "ListAppointmentServlet", urlPatterns = {"/listAppointments"})

public class ListAppointmentServlet extends HttpServlet {

    AppointmentDAO appointmentDao = new AppointmentDAO();
    CustomerDAO customerDao = new CustomerDAO();

    private void handleListAppointment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        // Lấy email từ session
        String email = customer.getEmail();
        // Truy vấn customerId
        int customerId = customer.getCustomerId();
        
        // Lấy danh sách lịch hẹn từ database
        List<Appointment> appointments = appointmentDao.getListAppointmentsByCustomerId(customerId);
        request.setAttribute("appointments", appointments);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleListAppointment(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
