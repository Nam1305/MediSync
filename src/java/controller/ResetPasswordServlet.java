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
import model.VerifyCode;
import util.BCrypt;
import util.SendEmail;
import util.Validation;

public class ResetPasswordServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private StaffDAO staffDAO = new StaffDAO();
    Validation valid = new Validation();

    // Xử lý GET request - Hiển thị form nhập email hoặc xác thực OTP
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String step = request.getParameter("step");

        // Nếu không có step, hiển thị form nhập email
        if (step == null) {
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        // Xử lý xác thực OTP
        if (step.equals("verify")) {
            HttpSession session = request.getSession();
            VerifyCode verifyCode = (VerifyCode) session.getAttribute("resetCode");
            String email = request.getParameter("email");
            String code = request.getParameter("code");

            request.setAttribute("email", email);

            if (verifyCode == null || verifyCode.isExpired() || !verifyCode.getAuthCode().equals(code)) {
                request.setAttribute("error", "The verification code is incorrect or expired!");
                request.getRequestDispatcher("reset-verify.jsp").forward(request, response);
            } else {
                // OTP hợp lệ, chuyển đến trang đổi mật khẩu mới
                session.removeAttribute("resetCode");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
            }
        }
    }

    // Xử lý POST request - Xử lý yêu cầu reset và cập nhật mật khẩu
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // Xử lý yêu cầu reset password
        if (action.equals("request")) {
            String email = request.getParameter("email");
            request.setAttribute("email", email);

            Customer customer = customerDAO.getCustomerByEmail(email);
            Staff staff = staffDAO.getStaffByEmail(email);

            if (customer == null && staff == null) {
                request.setAttribute("error", "Email does not exist!");
                request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                return;
            }

            // Gửi mã OTP qua email
            SendEmail sendEmail = new SendEmail();
            String code = sendEmail.getRandom();
            VerifyCode verifyCode = new VerifyCode(code);
            session.setAttribute("resetCode", verifyCode);
            sendEmail.sendMailResetPassword(email, code);

            request.getRequestDispatcher("reset-verify.jsp").forward(request, response);
        }

        // Xử lý cập nhật mật khẩu mới
        if (action.equals("reset")) {
            String email = request.getParameter("email");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            request.setAttribute("email", email);

            if (!valid.validatePassword(newPassword)) {
                request.setAttribute("error", "Mật khẩu phải ít nhất 6 kí tự, bao gồm chữ hoa, chữ thường, số và kí tự đặc biệt!");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Passwords do not match!");
                request.getRequestDispatcher("new-password.jsp").forward(request, response);
                return;
            }

            // Mã hóa và cập nhật mật khẩu mới
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            // Kiểm tra và cập nhật đúng tài khoản
            Customer customer = customerDAO.getCustomerByEmail(email);
            if (customer != null) {
                customerDAO.updatePassword(email, hashedPassword);
            } else {
                Staff staff = staffDAO.getStaffByEmail(email);
                if (staff != null) {
                    staffDAO.updatePassword(email, hashedPassword);
                }
            }

            // Chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
        }
    }
}
