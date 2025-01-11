/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import util.BCrypt;

/**
 *
 * @author DIEN MAY XANH
 */
public class LoginServlet extends HttpServlet {

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
        Account account = accountDAO.getAccountByEmail(email);
        if (account != null) {
            if (BCrypt.checkpw(password, account.getPassWord())) {
                if (account.getStatus() == 0) {
                    request.setAttribute("error", "This account is not active.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    session.setAttribute("account", account);
                    if (account.getStatus() == 3) {
                        response.sendRedirect("home.jsp");
                    } else {
                        request.getRequestDispatcher("home.jsp").forward(request, response);
                    }
                }
            } else {
                request.setAttribute("error", "Password is incorrect!");
                request.getRequestDispatcher("login.jsp").forward(request, response);

            }
        } else {
            request.setAttribute("error", "Email is incorrect!");
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
