/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import model.VerifyCode;
import util.BCrypt;
import util.SendEmail;

/**
 *
 * @author DIEN MAY XANH
 */
public class RegisterServlet extends HttpServlet {

    AccountDAO accountDAO = new AccountDAO();

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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        VerifyCode verifyCode = (VerifyCode) session.getAttribute("verifyCode");
        String email = request.getParameter("email");
        request.setAttribute("email", email);
        String code = request.getParameter("code");
        String password = request.getParameter("password");
        request.setAttribute("password",password);
        if (verifyCode == null || verifyCode.isExpired() || !verifyCode.getAuthCode().equals(code)) {
            request.setAttribute("error", "The verification code is incorrect or expired!");
            request.getRequestDispatcher("verify.jsp").forward(request, response);
        } else {
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            accountDAO.insertAccount(new Account(0, email, hashedPassword , 0, 1));
            session.removeAttribute("verifyCode");
            response.sendRedirect("home.jsp");

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
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        request.setAttribute("email", email);
        String password = request.getParameter("password");
        request.setAttribute("password", password);
        String confirm = request.getParameter("confirm");

        Account account = accountDAO.getAccountByEmail(email);
        if (account != null) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Password and confirm password do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        SendEmail sendEmail = new SendEmail();
        String code = sendEmail.getRandom();
        VerifyCode verifyCode = new VerifyCode(code);
        session.setAttribute("verifyCode", verifyCode);
        sendEmail.sendMailVerify(email, code);
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
