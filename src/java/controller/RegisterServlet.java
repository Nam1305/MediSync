/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import util.*;

/**
 *
 * @author DIEN MAY XANH
 */
public class RegisterServlet extends HttpServlet {

    StaffDAO staffDao = new StaffDAO();
    CustomerDAO customerDao = new CustomerDAO();
    Validation valid = new Validation();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        VerifyCode verifyCode = (VerifyCode) session.getAttribute("verifyCode");
        String name = request.getParameter("name");
        request.setAttribute("name", name);
        String phone = request.getParameter("phone");
        request.setAttribute("phone", phone);
        String address = request.getParameter("address");
        request.setAttribute("address", address);
        String email = request.getParameter("email");
        request.setAttribute("email", email);
        String password = request.getParameter("password");
        request.setAttribute("password", password);
        String code = request.getParameter("code");
        if (verifyCode == null || verifyCode.isExpired() || !verifyCode.getAuthCode().equals(code)) {
            request.setAttribute("error", "Mã xác thực không đúng hoặc đã hết hạn!");
            request.getRequestDispatcher("verify.jsp").forward(request, response);
        } else {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            Customer customer = new Customer();
            customer.setName(name);
            customer.setAddress(address);
            customer.setPhone(phone);
            customer.setPassword(hashedPassword);
            customer.setEmail(email);
            customer.setAvatar("https://thumbs.dreamstime.com/z/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg");            
            customer.setStatus("Active");
            customerDao.insertCustomer(customer);
            System.out.println(customer.toString());
            session.removeAttribute("verifyCode");
            response.sendRedirect("login.jsp");

        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        HttpSession session = request.getSession();
        String name = request.getParameter("name");
        request.setAttribute("name", name);
        String phone = request.getParameter("phone");
        request.setAttribute("phone", phone);
        String address = request.getParameter("address");
        request.setAttribute("address", address);
        String email = request.getParameter("email");
        request.setAttribute("email", email);
        String password = request.getParameter("password");
        request.setAttribute("password", password);
        String confirm = request.getParameter("confirm");
        Staff staff = staffDao.getStaffByEmail(email);
        Customer customer = customerDao.getCustomerByEmail(email);
        if (staff != null || customer != null) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!valid.validatePassword(password)) {
            request.setAttribute("error", "Mật khẩu phải ít nhất 6 kí tự, bao gồm chữ hoa, chữ thường, số và kí tự đặc biệt!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        SendEmail sendEmail = new SendEmail();
        String code = sendEmail.getRandom();
        VerifyCode verifyCode = new VerifyCode(code);
        session.setAttribute("verifyCode", verifyCode);
        boolean x = sendEmail.sendMailVerify(email, code);
        request.getRequestDispatcher("verify.jsp").forward(request, response);

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
