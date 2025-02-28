package controller.admin;

import dal.BlogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Blog;
import model.Staff;
import java.io.IOException;

@WebServlet(name = "FooterManagementServlet", urlPatterns = {"/manage-footer"})
public class FooterManagementServlet extends HttpServlet {

    private final BlogDAO blogDAO;

    public FooterManagementServlet() {
        this.blogDAO = new BlogDAO();
    }

    private boolean validateSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);

        // Check if session exists and user is logged in
        if (session == null || session.getAttribute("staff") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Check if logged-in user is an admin
        Staff staff = (Staff) session.getAttribute("staff");

        if (staff.getRole().getRoleId() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return false;
        }

        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Validate session before processing the request
        if (!validateSession(request, response)) {
            return;
        }

        // Get footer content
        Blog addressContent = blogDAO.getContactInfoByName("Địa chỉ");
        Blog emailContent = blogDAO.getContactInfoByName("Email");
        Blog phoneContent = blogDAO.getContactInfoByName("Số điện thoại");

        // Check if any content exists
        boolean footerContentExists = addressContent != null || emailContent != null || phoneContent != null;

        // Set attributes for JSP
        request.setAttribute("addressContent", addressContent);
        request.setAttribute("emailContent", emailContent);
        request.setAttribute("phoneContent", phoneContent);
        request.setAttribute("footerContentExists", footerContentExists);

        request.getRequestDispatcher("manage-footer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!validateSession(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        if ("saveFooterContent".equals(action)) {
            String addressContent = request.getParameter("addressContent");
            String emailContent = request.getParameter("emailContent");
            String phoneContent = request.getParameter("phoneContent");

            // Validate inputs on server side
            boolean isValid = true;
            StringBuilder errorMessage = new StringBuilder("Validation errors: ");

            if (addressContent == null || addressContent.trim().isEmpty()) {
                errorMessage.append("Address cannot be empty. ");
                isValid = false;
            }

            // Email validation
            if (emailContent == null || emailContent.trim().isEmpty()) {
                errorMessage.append("Email cannot be empty. ");
                isValid = false;
            } else if (!emailContent.matches(".*[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}.*")) {
                errorMessage.append("Invalid email format. ");
                isValid = false;
            }

            // Phone validation
            if (phoneContent == null || phoneContent.trim().isEmpty()) {
                errorMessage.append("Phone number cannot be empty. ");
                isValid = false;
            } else if (!phoneContent.matches(".*\\b\\d{10}\\b.*")) {
                errorMessage.append("Phone number must contain exactly 10 digits. ");
                isValid = false;
            }

            if (!isValid) {
                request.getSession().setAttribute("errorMessage", errorMessage.toString());
                response.sendRedirect("manage-footer");
                return;
            }

            // Get the admin user information
            Staff admin = (Staff) request.getSession().getAttribute("staff");
            String author = admin.getName();

            boolean isUpdate = Boolean.parseBoolean(request.getParameter("isUpdate"));

            int result;
            if (isUpdate) {
                // Sử dụng phương thức cập nhật mới
                result = blogDAO.updateAllContactInfo(addressContent, emailContent, phoneContent, author);

                if (result == 3) {
                    request.getSession().setAttribute("successMessage", "Footer content updated successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Error updating footer content. Only " + result + " out of 3 items were updated.");
                }
            } else {
                // Process as new content
                result = blogDAO.addBasicContactInfo(addressContent, emailContent, phoneContent, author);

                if (result == 3) {
                    request.getSession().setAttribute("successMessage", "Footer content added successfully!");
                } else {
                    request.getSession().setAttribute("errorMessage", "Error adding footer content. Only " + result + " out of 3 items were added.");
                }
            }

            response.sendRedirect("manage-footer");
        }
    }
}
