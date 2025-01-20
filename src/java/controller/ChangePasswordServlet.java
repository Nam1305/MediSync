// Them boi Nguyen Dinh Chinh (12-1-25)
package controller;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import util.BCrypt;
import util.SendEmail;
import util.Validation;

public class ChangePasswordServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private StaffDAO staffDAO = new StaffDAO();
    Validation valid = new Validation();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession();
        Object loggedInAccount = session.getAttribute("account");

        if (loggedInAccount == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Forward to change password page
        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Get the logged-in user's information
        HttpSession session = request.getSession();
        Object loggedInAccount = session.getAttribute("account");

        if (loggedInAccount == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form parameters
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Verify current password
        if (loggedInAccount instanceof Customer) {
            Customer customer = (Customer) loggedInAccount;
            Customer dbCustomer = customerDAO.getCustomerByEmail(customer.getEmail());

            if (!BCrypt.checkpw(currentPassword, dbCustomer.getPassword())) {
                request.setAttribute("error", "Current password is incorrect!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            if (!valid.validatePassword(newPassword)) {
                request.setAttribute("error", "Mật khẩu phải ít nhất 6 kí tự, bao gồm chữ hoa, chữ thường, số và kí tự đặc biệt!");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
                return;
            }
            
            // Check if new password matches confirmation
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            // Hash and update the new password
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            customerDAO.updatePassword(dbCustomer.getEmail(), hashedPassword);

            // Send confirmation email
            SendEmail sendEmail = new SendEmail();
            sendEmail.sendPasswordChangeConfirmation(dbCustomer.getEmail());

        } else if (loggedInAccount instanceof Staff) {
            Staff staff = (Staff) loggedInAccount;
            Staff dbStaff = staffDAO.getStaffByEmail(staff.getEmail());

            if (!BCrypt.checkpw(currentPassword, dbStaff.getPassword())) {
                request.setAttribute("error", "Current password is incorrect!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            if (!valid.validatePassword(newPassword)) {
                request.setAttribute("error", "Mật khẩu phải ít nhất 6 kí tự, bao gồm chữ hoa, chữ thường, số và kí tự đặc biệt!");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
                return;
            }
            
            // Check if new password matches confirmation
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            // Hash and update the new password
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            staffDAO.updatePassword(dbStaff.getEmail(), hashedPassword);

            // Send confirmation email
            SendEmail sendEmail = new SendEmail();
            sendEmail.sendPasswordChangeConfirmation(dbStaff.getEmail());
        }

        // Set success message and redirect
        session.setAttribute("success", "Password changed successfully!");
        response.sendRedirect("profile"); // Assuming you have a profile page
    }
}
