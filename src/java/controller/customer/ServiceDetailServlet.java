package controller.customer;

import dal.ServiceDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Service;
import model.Staff;

@WebServlet(name = "ServiceDetailServlet", urlPatterns = {"/service-detail"})
public class ServiceDetailServlet extends HttpServlet {

    private boolean isUserLoggedIn(HttpSession session) {
        if (session == null) {
            return false;
        }
        Staff staff = (Staff) session.getAttribute("staff");
        Customer customer = (Customer) session.getAttribute("customer");
        return staff != null || customer != null;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String serviceIdParam = request.getParameter("id");
            if (serviceIdParam == null || serviceIdParam.isEmpty()) {
                response.sendRedirect("services");
                return;
            }
            
            int serviceId;
            try {
                serviceId = Integer.parseInt(serviceIdParam);
            } catch (NumberFormatException e) {
                response.sendRedirect("services");
                return;
            }
            
            // Get session and check login status
            HttpSession session = request.getSession(false);
            if (isUserLoggedIn(session)) {
                Staff staff = (Staff) session.getAttribute("staff");
                Customer customer = (Customer) session.getAttribute("customer");

                if (staff != null) {
                    request.setAttribute("staff", staff);
                } else {
                    request.setAttribute("customer", customer);
                }
            }
            
            ServiceDAO serviceDAO = new ServiceDAO();
            Service service = serviceDAO.getServiceById(serviceId);
            
            if (service == null || "Inactive".equals(service.getStatus())) {
                response.sendRedirect("services");
                return;
            }
            
            List<Service> relatedServices = serviceDAO.getAllActiveServices();
            relatedServices.removeIf(s -> s.getServiceId() == serviceId);
            
            if (relatedServices.size() > 3) {
                relatedServices = relatedServices.subList(0, 3);
            }
            
            request.setAttribute("service", service);
            request.setAttribute("relatedServices", relatedServices);

            request.getRequestDispatcher("/service-detail.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while retrieving service details");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}