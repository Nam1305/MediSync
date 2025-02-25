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

@WebServlet(name = "ServiceListingServlet", urlPatterns = {"/services"})
public class ServiceListingServlet extends HttpServlet {

    private static final int DEFAULT_PAGE_SIZE = 6;

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
            
            HttpSession session = request.getSession(false);

            // Check login status and set appropriate attributes
            if (isUserLoggedIn(session)) {
                Staff staff = (Staff) session.getAttribute("staff");
                Customer customer = (Customer) session.getAttribute("customer");

                // Set the logged-in user info for the view
                if (staff != null) {
                    request.setAttribute("staff", staff);
                } else {
                    request.setAttribute("customer", customer);
                }
            }
            
            String serviceType = request.getParameter("serviceType");
            String search = request.getParameter("search");
            
            
            if (search != null && !search.isEmpty()) {
                
                search = processSearchString(search);
            }
            
            String sortPrice = request.getParameter("sortPrice");
            
            
            Double minPrice = null;
            Double maxPrice = null;
            
            if (request.getParameter("minPrice") != null && !request.getParameter("minPrice").isEmpty()) {
                try {
                    minPrice = Double.parseDouble(request.getParameter("minPrice"));
                } catch (NumberFormatException e) {
                    
                }
            }
            
            if (request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isEmpty()) {
                try {
                    maxPrice = Double.parseDouble(request.getParameter("maxPrice"));
                } catch (NumberFormatException e) {
                    
                }
            }
            
            
            int page = 1;
            int pageSize = DEFAULT_PAGE_SIZE;
            
            if (request.getParameter("page") != null) {
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    
                }
            }
            
            if (request.getParameter("pageSize") != null) {
                try {
                    pageSize = Integer.parseInt(request.getParameter("pageSize"));
                    if (pageSize < 1) {
                        pageSize = DEFAULT_PAGE_SIZE;
                    }
                } catch (NumberFormatException e) {
                    // Invalid format, use default
                }
            }
            
            // Initialize DAO and get services
            ServiceDAO serviceDAO = new ServiceDAO();
            List<Service> services = serviceDAO.getServices(
                    serviceType, search, sortPrice, minPrice, maxPrice, page, pageSize);
            
            // Get total count for pagination
            int totalServices = serviceDAO.getTotalServicesCount(serviceType, search, minPrice, maxPrice);
            int totalPages = (int) Math.ceil((double) totalServices / pageSize);
            
            // Set request attributes
            request.setAttribute("services", services);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("serviceType", serviceType);
            request.setAttribute("search", search);
            request.setAttribute("sortPrice", sortPrice);
            request.setAttribute("minPrice", minPrice);
            request.setAttribute("maxPrice", maxPrice);
            request.setAttribute("pageSize", pageSize);
            
            // Forward to JSP
            request.getRequestDispatcher("/services.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Log error and show error page
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while retrieving services");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    private String processSearchString(String search) {
        if (search == null) return null;
        
        // Thay thế nhiều khoảng trắng liên tiếp bằng một khoảng trắng
        String result = search.replaceAll("\\s+", " ");
        
        // Loại bỏ khoảng trắng ở cuối chuỗi
        result = result.trim();
        
        return result;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle post requests (e.g., filters submission) by redirecting to doGet
        doGet(request, response);
    }
}