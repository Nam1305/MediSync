/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.stream.Collectors;
import model.Blog;
import model.Customer;
import model.Staff;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ListBlogServlet", urlPatterns = {"/listBlog"})
public class ListBlogServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListBlogServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListBlogServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
        // Kiểm tra xem người dùng đã đăng nhập chưa
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        Staff staff = (Staff) session.getAttribute("staff");

        // Nếu không có khách hàng hoặc nhân viên trong session, chuyển hướng về trang login
        if (customer == null && staff == null) {
            session.setAttribute("redirectURL", request.getRequestURL().toString()); // Lưu URL hiện tại vào session để chuyển hướng lại sau khi đăng nhập
            response.sendRedirect("login"); // Chuyển hướng tới trang login
            return;
        }
        BlogDAO blogDAO = new BlogDAO();
        int currentPage = 1; // Mặc định vào trang 1
        int itemsPerPage = 6; // Mỗi trang có 6 blog
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");

        if (search != null) {
            search = search.trim().replaceAll("\\s+", " "); // Xóa khoảng trắng thừa
        }
        // Lấy danh sách blog theo tìm kiếm và sắp xếp
        List<Blog> listBlog = blogDAO.getBlogs(search, sort, currentPage, itemsPerPage);
        int totalBlogs = blogDAO.getTotalBlogsCount(search);
        int totalPages = (int) Math.ceil((double) totalBlogs / itemsPerPage);

        request.setAttribute("listBlog", listBlog);
        request.setAttribute("search", search);
        request.setAttribute("sort", sort);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("listBlog.jsp").forward(request, response);
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
        processRequest(request, response);
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
