/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DeleteBlogServlet", urlPatterns = {"/deleteBlog"})
public class DeleteBlogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        BlogDAO blogDAO = new BlogDAO();
        String blogIdStr = request.getParameter("blogId");
        if (blogIdStr != null) {
            try {
                int blogId = Integer.parseInt(blogIdStr);
                boolean success = blogDAO.deleteBlog(blogId);

                if (success) {
                    request.getSession().setAttribute("noti", "successDelete");
                } else {
                    request.getSession().setAttribute("noti", "failDelete");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("noti", "failDelete");
            }
        } else {
            request.getSession().setAttribute("noti", "failDelete");
        }

        response.sendRedirect("blogs");
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
