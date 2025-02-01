package controller;

import dal.DoctorDAO;
import dal.BlogDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Staff;
import model.Customer;
import model.Blog;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {
    
    private final DoctorDAO doctorDAO;
    private final BlogDAO blogDAO;
    
    public HomeServlet() {
        this.doctorDAO = new DoctorDAO();
        this.blogDAO = new BlogDAO();
    }
    
    private boolean isUserLoggedIn(HttpSession session) {
        if (session == null) return false;
        Staff staff = (Staff) session.getAttribute("staff");
        Customer customer = (Customer) session.getAttribute("customer");
        return staff != null || customer != null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get session without creating a new one if it doesn't exist
            HttpSession session = request.getSession(false);
            
            // Check login status and set appropriate attributes
            if (isUserLoggedIn(session)) {
                Staff staff = (Staff) session.getAttribute("staff");
                Customer customer = (Customer) session.getAttribute("customer");
                
                // Set the logged-in user info for the view
                if (staff != null) {
                    request.setAttribute("account", staff);
                } else {
                    request.setAttribute("account", customer);
                }
            }

            // Get top rated doctors
            List<Staff> topDoctors = doctorDAO.getTopRatedDoctors();
            request.setAttribute("topDoctors", topDoctors);

            // Get random blogs
            List<Blog> randomBlogs = blogDAO.getRandomBlogs();
            request.setAttribute("blogs", randomBlogs);

            // Forward to the home page
            request.getRequestDispatcher("home.jsp").forward(request, response);
            
        } catch (ServletException | IOException e) {
            // Log the error and handle it appropriately
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}