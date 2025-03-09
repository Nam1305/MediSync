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
        int itemsPerPage = 6;//
        int totalBlogs = blogDAO.getTotalBlogs();

        String itemsPerPageParam = request.getParameter("itemsPerPage");
        if (itemsPerPageParam != null && !itemsPerPageParam.isEmpty()) {
            try {
                itemsPerPage = Integer.parseInt(itemsPerPageParam);
            } catch (NumberFormatException e) {
                itemsPerPage = 6;
            }
        }

        // Lấy tham số page từ URL, nếu có thì parse sang số nguyên
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;  // Nếu lỗi, mặc định là trang 1
            }
        }

        // Lấy tham số tìm kiếm và sắp xếp từ URL
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        if (search != null) {
            search = search.trim().replaceAll("\\s+", " "); // Loại bỏ khoảng trắng thừa
        }

        // Gọi BlogDAO để lấy danh sách blog theo tìm kiếm, sắp xếp và phân trang
        List<Blog> listBlog = blogDAO.getBlogs(search, sort, currentPage, itemsPerPage);
        int totalPages = (int) Math.ceil((double) totalBlogs / itemsPerPage);

        request.setAttribute("listBlog", listBlog);
        request.setAttribute("search", search);
        request.setAttribute("sort", sort);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("itemsPerPage", itemsPerPage);
        request.setAttribute("totalPages", totalPages);
        
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
