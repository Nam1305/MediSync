package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Blog;
import model.Comment;
import model.Customer;
import dal.BlogDAO;
import dal.CommentDAO;
import model.Staff;

@WebServlet(name = "BlogDetailServlet", urlPatterns = {"/blogDetail"})
public class BlogDetailServlet extends HttpServlet {

    private boolean validateSession(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);

        // Kiểm tra session có tồn tại và user đã đăng nhập chưa
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }
        return true;

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogIdRaw = request.getParameter("blogId");
        String pageRaw = request.getParameter("page");
        int page = 1;
        if (pageRaw != null && !pageRaw.isEmpty()) {
            try {
                page = Integer.parseInt(pageRaw);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        if (blogIdRaw == null || blogIdRaw.isEmpty()) {
            response.sendRedirect("listBlog");
            return;
        }

        try {
            int blogId = Integer.parseInt(blogIdRaw);
            BlogDAO blogDAO = new BlogDAO();
            CommentDAO commentDAO = new CommentDAO();
            int limit = 5;
            int offset = (page - 1) * limit;
            Blog blog = blogDAO.getBlogById(blogId);
            List<Comment> comments = commentDAO.getCommentsByBlogId(blogId, offset, limit);
            int totalComments = commentDAO.getCommentsCountByBlogId(blogId);
            int totalPages = (int) Math.ceil((double) totalComments / limit);
            if (blog == null) {
                response.sendRedirect("listBlog");
                return;
            }

            request.setAttribute("blog", blog);
            request.setAttribute("comments", comments);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.getRequestDispatcher("blogDetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("listBlog");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        Staff staff = (Staff) session.getAttribute("staff");

        // Nếu không có khách hàng hoặc nhân viên trong session, chuyển hướng về trang login
        if (customer == null && staff == null) {
            session.setAttribute("redirectURL", request.getRequestURL().toString()); // Lưu URL hiện tại vào session để chuyển hướng lại sau khi đăng nhập
            response.sendRedirect("login"); // Chuyển hướng tới trang login
            return;
        }

        // Lấy thông tin người dùng từ session
        Customer user = (Customer) customer;

        // Lấy dữ liệu từ form
        String blogIdRaw = request.getParameter("blogId");
        String content = request.getParameter("content");

        // Kiểm tra dữ liệu đầu vào
        if (blogIdRaw == null || content == null || content.trim().isEmpty()) {
            response.sendRedirect("blogDetail?blogId=" + blogIdRaw);
            return;
        }

        try {
            int blogId = Integer.parseInt(blogIdRaw);
            CommentDAO commentDAO = new CommentDAO();

            // Tạo và thêm bình luận
            Comment comment = new Comment(0, content.trim(), new java.sql.Date(System.currentTimeMillis()), blogId,
                    user.getCustomerId(), user.getName(), user.getAvatar());
            commentDAO.addComment(comment, blogId);

            // Chuyển hướng về trang chi tiết blog
            response.sendRedirect("blogDetail?blogId=" + blogId);
        } catch (NumberFormatException e) {
            response.sendRedirect("listBlog");
        }
    }

}
