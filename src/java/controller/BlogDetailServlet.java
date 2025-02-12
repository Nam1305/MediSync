/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Blog;
import dal.BlogDAO;
import jakarta.servlet.annotation.WebServlet;
import model.Comment;
import dal.CommentDAO;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name="ListBlogServlet", urlPatterns={"/blog-detail"})
public class BlogDetailServlet extends HttpServlet {
    
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BlogDetailServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogDetailServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String blogIdRaw = request.getParameter("blogId");
        
        if (blogIdRaw == null || blogIdRaw.isEmpty()) {
            response.sendRedirect("listBlog");
            return;
        }
        
        try {
            int blogId = Integer.parseInt(blogIdRaw);
            BlogDAO blogDAO = new BlogDAO();
            CommentDAO commentDAO = new CommentDAO();
            
            Blog blog = blogDAO.getBlogById(blogId);
            List<Comment> comments = commentDAO.getCommentsByBlogId(blogId);
            
            if (blog == null) {
                response.sendRedirect("listBlog");
                return;
            }
            
            request.setAttribute("blog", blog);
            request.setAttribute("comments", comments);
            request.getRequestDispatcher("blog-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("listBlog");
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
