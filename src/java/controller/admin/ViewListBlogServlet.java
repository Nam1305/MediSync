package controller.admin;

import dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;
import model.Blog;

@WebServlet(name = "ViewListBlogServlet", urlPatterns = {"/blogs"})
public class ViewListBlogServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP GET and POST methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Code mẫu ban đầu
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods.">
    /**
     * Handles the HTTP GET method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();
        int currentPage = 1;
        int itemsPerPage = 6; // Default value

        String itemsPerPageParam = request.getParameter("itemsPerPage");
        if (itemsPerPageParam != null && !itemsPerPageParam.isEmpty()) {
            try {
                itemsPerPage = Integer.parseInt(itemsPerPageParam);
            } catch (NumberFormatException e) {
                itemsPerPage = 6;
            }
        }

        // Get page parameter
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;  // Default to page 1 if error
            }
        }

        // Get search and sort parameters
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        if (search != null) {
            search = search.trim().replaceAll("\\s+", " "); // Clean up search term
        }

        // Get total filtered blogs count for pagination
        int totalBlogs = blogDAO.getTotalBlogsCount(search);

        // Get blogs with pagination
        List<Blog> listBlog = blogDAO.getBlogs(search, sort, currentPage, itemsPerPage);

        // Calculate total pages based on the total blogs and items per page
        int totalPages = (int) Math.ceil((double) totalBlogs / itemsPerPage);

        // Set attributes for JSP
        request.setAttribute("listBlog", listBlog);
        request.setAttribute("search", search);
        request.setAttribute("sort", sort);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBlogs", totalBlogs);

        request.getRequestDispatcher("admin/blogs.jsp").forward(request, response);
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
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
