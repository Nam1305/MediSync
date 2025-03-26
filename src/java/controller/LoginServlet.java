package controller;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import model.Role;
import util.BCrypt;

public class LoginServlet extends HttpServlet {

    StaffDAO staffDao = new StaffDAO();
    CustomerDAO customerDao = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();

        String email = request.getParameter("email") != null ? request.getParameter("email") : "";
        String password = request.getParameter("password") != null ? request.getParameter("password") : "";
        String remember = request.getParameter("remember") != null ? request.getParameter("remember") : "";

        String encodedEmail = URLEncoder.encode(email, StandardCharsets.UTF_8.toString());
        String encodedPassword = URLEncoder.encode(password, StandardCharsets.UTF_8.toString());
        String encodedRemember = URLEncoder.encode(remember, StandardCharsets.UTF_8.toString());

        Cookie cEmail = new Cookie("cEmail", encodedEmail);
        Cookie cPassword = new Cookie("cPassword", encodedPassword);
        Cookie cRemember = new Cookie("cRemember", encodedRemember);

        if (remember != null && !remember.isEmpty()) {
            cEmail.setMaxAge(60 * 60 * 24); // 1 ngày
            cPassword.setMaxAge(60 * 60 * 24);
            cRemember.setMaxAge(60 * 60 * 24);
        } else {
            cEmail.setMaxAge(0); // Xóa cookie
            cPassword.setMaxAge(0);
            cRemember.setMaxAge(0);
        }

        response.addCookie(cEmail);
        response.addCookie(cPassword);
        response.addCookie(cRemember);

        Customer customer = customerDao.getCustomerByEmail(email);
        Staff staff = staffDao.getStaffByEmail(email);

        if (customer != null) {
            if (BCrypt.checkpw(password, customer.getPassword())) {
                if (!customer.getStatus().equals("Active")) {
                    request.setAttribute("error", "Tài khoản này đã bị vô hiệu hóa!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    session.setAttribute("customer", customer);
                    request.getRequestDispatcher("home").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Mật khẩu không đúng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if (staff != null) {
            if (BCrypt.checkpw(password, staff.getPassword())) {
                if (!staff.getStatus().equals("Active")) {
                    request.setAttribute("error", "Tài khoản này đã bị vô hiệu hóa!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    session.setAttribute("staff", staff);
                    
                    // Lưu thông tin role vào session từ đối tượng Staff
                    Role role = staff.getRole();
                    if (role != null) {
                        session.setAttribute("roleId", role.getRoleId());
                        session.setAttribute("roleName", role.getRole());
                    }
                    
                    // Điều hướng theo vai trò
                    if (role != null && role.getRoleId() == 1) {
                        request.getRequestDispatcher("AdminDashBoard").forward(request, response);
                    } else {
                        request.getRequestDispatcher("home").forward(request, response);
                    }
                }
            } else {
                request.setAttribute("error", "Mật khẩu không đúng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Tài khoản không tồn tại!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}