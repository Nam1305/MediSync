package controller;

import dal.BlogDAO;
import dal.CommentDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Blog;
import model.Comment;
import model.Customer;
import model.Staff;

@WebServlet(name = "BlogDetailServlet", urlPatterns = {"/blogDetail"})
public class BlogDetailServlet extends HttpServlet {

    // Phần GET: Cho phép xem chi tiết blog và bình luận mà không cần đăng nhập.
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

            List<Blog> nearestBlogs = blogDAO.getNearestBlogs();
            request.setAttribute("topBlog", nearestBlogs);
            request.setAttribute("blog", blog);
            request.setAttribute("comments", comments);

            request.getRequestDispatcher("blogDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("listBlog");
        }
    }

    // Phần POST: Xử lý bình luận - yêu cầu đăng nhập
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        Staff staff = (Staff) session.getAttribute("staff");

        // Nếu user chưa đăng nhập, chuyển hướng đến trang login
        if (customer == null && staff == null) {
            // Lưu URL hiện tại để chuyển hướng lại sau khi đăng nhập
            session.setAttribute("redirectURL", request.getRequestURL() + "?" + request.getQueryString());
            response.sendRedirect("login");
            return;
        }

        // Lấy dữ liệu bình luận từ form
        String blogIdRaw = request.getParameter("blogId");
        String content = request.getParameter("content");

        if (blogIdRaw == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("blogDetail?blogId=" + blogIdRaw);
            return;
        }

        try {
            int blogId = Integer.parseInt(blogIdRaw);
            CommentDAO commentDAO = new CommentDAO();
            // Tạo bình luận mới
            Comment comment = new Comment(0, content.trim(), new java.sql.Date(System.currentTimeMillis()), blogId,
                    customer.getCustomerId(), customer.getName(), customer.getAvatar());
            commentDAO.addComment(comment, blogId);

            response.sendRedirect("blogDetail?blogId=" + blogId);
        } catch (NumberFormatException e) {
            response.sendRedirect("listBlog");
        }
    }
}
