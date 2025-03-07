/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CustomerDAO;
import dal.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Customer;
import model.Staff;
import util.BCrypt;

/**
 *
 * @author DIEN MAY XANH
 */
public class LoginServlet extends HttpServlet {

    StaffDAO staffDao = new StaffDAO();
    CustomerDAO customerDao = new CustomerDAO();

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
        request.getRequestDispatcher("login.jsp").forward(request, response);

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
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        Cookie cEmail = new Cookie("cEmail", email);
        Cookie cPassword = new Cookie("cPassword", password);
        Cookie cRemember = new Cookie("cRemember", remember);

        if (remember != null) {
            cEmail.setMaxAge(60 * 60 * 24);
            cPassword.setMaxAge(60 * 60 * 24);
            cRemember.setMaxAge(60 * 60 * 24);
        } else {
            cEmail.setMaxAge(0);
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
                    if (staff.getRole().getRoleId() == 1) {
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
