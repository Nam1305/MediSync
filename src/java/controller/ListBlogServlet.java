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
import model.Blog;
import model.Customer;

@WebServlet(name = "ListBlogServlet", urlPatterns = {"/listBlog"})
public class ListBlogServlet extends HttpServlet {

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
     * Handles the HTTP GET method. Ở phiên bản này, người dùng có thể xem danh
     * sách blog mà không cần đăng nhập.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();
        int currentPage = 1; // Mặc định trang 1
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
     * Handles the HTTP POST method. Ở đây, nếu người dùng muốn thực hiện thao
     * tác POST (ví dụ: gửi bình luận), thì vẫn bắt buộc phải đăng nhập.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý POST vẫn giữ kiểm tra đăng nhập như cũ
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            session.setAttribute("redirectURL", request.getRequestURL().toString());
            response.sendRedirect("login");
            return;
        }
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "ListBlogServlet for Admin and Public view (GET does not require login)";
    }
    // </editor-fold>
}
