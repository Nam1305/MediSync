package controller.customer;

import dal.AppointmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dal.CustomerDAO;
import java.util.List;
import model.Appointment;
import model.Customer;

@WebServlet(name = "ListAppointmentServlet", urlPatterns = {"/listAppointments"})

public class ListAppointmentServlet extends HttpServlet {

    private String normalizeSearchQuery(String query) {
        return query.trim().replaceAll("\\s+", " "); // Loại bỏ khoảng trắng dư thừa
    }

    AppointmentDAO appointmentDao = new AppointmentDAO();
//    CustomerDAO customerDao = new CustomerDAO();

    private void handleListAppointment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = customer.getCustomerId();

        // Lấy giá trị từ request
        String search = request.getParameter("search");
        if (search == null || search.trim().isEmpty()) {
            search = ""; // Gán chuỗi rỗng nếu `search` null
        }

        String searchQueryNormalized = null;
        if (search != null && !search.trim().isEmpty()) {
            searchQueryNormalized = normalizeSearchQuery(search);
        }

        String sort = request.getParameter("sort");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");

        // Mặc định nếu không có giá trị
        int currentPage = 1;
        int pageSize = 2; // Số appointment mỗi trang mặc định

        try {
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
            if (pageSizeParam != null && !pageSizeParam.trim().isEmpty()) {
                int parsedPageSize = Integer.parseInt(pageSizeParam);
                if (parsedPageSize >= 1) {
                    pageSize = parsedPageSize;
                }
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
            pageSize = 2;
        }

        // Tính tổng số lịch hẹn để phân trang
        int totalAppointment = appointmentDao.countAllAppointmentsByFilterForPatient(customerId, search, gender, status);
        int totalPages = (int) Math.ceil((double) totalAppointment / pageSize);

        // Lấy danh sách lịch hẹn
        List<Appointment> appointments = appointmentDao.getFilteredAppointments(customerId, searchQueryNormalized, sort, gender, status, currentPage, pageSize);

        // Gửi dữ liệu về JSP
        request.setAttribute("appointments", appointments);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalAppointment", totalAppointment);
        request.setAttribute("pageSize", pageSize);

        // Gửi các giá trị filter về lại JSP để giữ trạng thái
        request.setAttribute("search", searchQueryNormalized);
        request.setAttribute("sort", sort);
        request.setAttribute("gender", gender);
        request.setAttribute("status", status);

        request.getRequestDispatcher("customer/patientsProfile.jsp").forward(request, response);
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
