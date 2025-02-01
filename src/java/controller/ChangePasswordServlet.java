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

    private final CustomerDAO customerDAO;
    private final StaffDAO staffDAO;
    private final Validation valid;
    private final SendEmail sendEmail;

    public ChangePasswordServlet() {
        this.customerDAO = new CustomerDAO();
        this.staffDAO = new StaffDAO();
        this.valid = new Validation();
        this.sendEmail = new SendEmail();
    }

    private boolean isUserLoggedIn(HttpSession session) {
        Staff staff = (Staff) session.getAttribute("staff");
        Customer customer = (Customer) session.getAttribute("customer");
        return staff != null || customer != null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);  // Don't create new session if none exists
        
        // Check if session exists and user is logged in
        if (session == null || !isUserLoggedIn(session)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");  // Handle UTF-8 encoding

        HttpSession session = request.getSession(false);
        
        // Check if session exists and user is logged in
        if (session == null || !isUserLoggedIn(session)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get logged in user
        Staff staff = (Staff) session.getAttribute("staff");
        Customer customer = (Customer) session.getAttribute("customer");

        try {
            String currentPassword = request.getParameter("currentPassword").trim();
            String newPassword = request.getParameter("newPassword").trim();
            String confirmPassword = request.getParameter("confirmPassword").trim();

            if (currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            if (!valid.validatePassword(newPassword)) {
                request.setAttribute("error", "Mật khẩu phải ít nhất 6 kí tự, bao gồm chữ hoa, chữ thường, số và kí tự đặc biệt!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu mới không khớp với mật khẩu xác nhận!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            if (currentPassword.equals(newPassword)) {
                request.setAttribute("error", "Mật khẩu mới phải khác mật khẩu hiện tại!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
                return;
            }

            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            boolean passwordChanged = false;

            if (staff != null) {
                Staff dbStaff = staffDAO.getStaffByEmail(staff.getEmail());
                if (dbStaff == null || !BCrypt.checkpw(currentPassword, dbStaff.getPassword())) {
                    request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                    request.getRequestDispatcher("change-password.jsp").forward(request, response);
                    return;
                }
                staffDAO.updatePassword(dbStaff.getEmail(), hashedPassword);
                sendEmail.sendPasswordChangeConfirmation(dbStaff.getEmail());
                passwordChanged = true;
            } else {
                Customer dbCustomer = customerDAO.getCustomerByEmail(customer.getEmail());
                if (dbCustomer == null || !BCrypt.checkpw(currentPassword, dbCustomer.getPassword())) {
                    request.setAttribute("error", "Mật khẩu hiện tại không đúng!");
                    request.getRequestDispatcher("change-password.jsp").forward(request, response);
                    return;
                }
                customerDAO.updatePassword(dbCustomer.getEmail(), hashedPassword);
                sendEmail.sendPasswordChangeConfirmation(dbCustomer.getEmail());
                passwordChanged = true;
            }

            if (passwordChanged) {
                session.setAttribute("success", "Đổi mật khẩu thành công!");
                response.sendRedirect(request.getContextPath() + "/profile");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra khi đổi mật khẩu. Vui lòng thử lại!");
                request.getRequestDispatcher("change-password.jsp").forward(request, response);
            }

        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra. Vui lòng thử lại sau!");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
        }
    }
}