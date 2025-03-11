package controller.admin;

import dal.BlogDAO;
import dal.CommentDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Blog;
import model.Comment;

@WebServlet(name = "ViewBlogDetailServlet", urlPatterns = {"/blogs-detail"})
public class ViewBlogDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogIdRaw = request.getParameter("blogId");

        if (blogIdRaw == null || blogIdRaw.isEmpty()) {
            response.sendRedirect("admin/blogs");
            return;
        }

        try {
            int blogId = Integer.parseInt(blogIdRaw);
            BlogDAO blogDAO = new BlogDAO();
            CommentDAO commentDAO = new CommentDAO();

            Blog blog = blogDAO.getBlogById(blogId);
            if (blog == null) {
                response.sendRedirect("admin/blogs");
                return;
            }

            // Lấy tất cả comments không phân trang
            List<Comment> comments = commentDAO.getCommentsByBlogId(blogId);
            
            List<Blog> nearestBlogs = blogDAO.getNearestBlogs();

            request.setAttribute("topBlog", nearestBlogs);
            request.setAttribute("blog", blog);
            request.setAttribute("comments", comments);
            
            // Bỏ các thuộc tính phân trang
            // request.setAttribute("currentPage", page);
            // request.setAttribute("totalPages", totalPages);

            request.getRequestDispatcher("admin/blogs-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/blogs");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}