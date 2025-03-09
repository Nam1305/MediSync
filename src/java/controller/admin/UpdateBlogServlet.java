package controller.admin;

import dal.BlogDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Blog;

@WebServlet(name = "UpdateBlogServlet", urlPatterns = {"/updateBlog"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateBlogServlet extends HttpServlet {

    private final BlogDAO blogDAO = new BlogDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String blogIdStr = request.getParameter("blogId");
        if (blogIdStr == null || blogIdStr.trim().isEmpty()) {
            response.sendRedirect("admin/blogs?error=missingId");
            return;
        }

        try {
            int blogId = Integer.parseInt(blogIdStr);
            Blog blog = blogDAO.getBlogById(blogId);
            if (blog == null) {
                response.sendRedirect("admin/blogs?error=notFound");
                return;
            }

            request.setAttribute("blog", blog);
            request.getRequestDispatcher("admin/updateBlog.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/blogs?error=invalidId");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String blogIdStr = request.getParameter("id");
        String blogName = request.getParameter("blogName");
        String content = request.getParameter("content");
        String author = request.getParameter("author");
        String dateStr = request.getParameter("date");

        List<String> errors = new ArrayList<>();
        int blogId = 0;

        try {
            blogId = Integer.parseInt(blogIdStr);
        } catch (NumberFormatException e) {
            errors.add("ID blog không hợp lệ!");
        }

        if (blogName == null || blogName.trim().isEmpty()) {
            errors.add("Vui lòng nhập Tên blog!");
        }
        if (content == null || content.trim().isEmpty()) {
            errors.add("Vui lòng nhập Nội dung blog!");
        }
        if (author == null || author.trim().isEmpty()) {
            errors.add("Vui lòng nhập Tác giả!");
        }

        Date date = null;
        try {
            date = Date.valueOf(dateStr);
            if (date.toLocalDate().isAfter(LocalDate.now())) {
                errors.add("Ngày đăng không hợp lệ!");
            }
        } catch (IllegalArgumentException e) {
            errors.add("Định dạng ngày không hợp lệ!");
        }

        // Xử lý ảnh upload
        Part imagePart = request.getPart("image");
        String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        String imagePath = "";

        if (!imageFileName.isEmpty()) {
            String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDirFile = new File(uploadDir);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdir();
            }

            imagePath = "uploads/" + imageFileName;
            imagePart.write(uploadDir + File.separator + imageFileName);
        } else {
            imagePath = blogDAO.getBlogById(blogId).getImage();
        }

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            Blog blog = new Blog(blogId, blogName, content, imagePath, author, date, 0, 0);
            request.setAttribute("blog", blog);
            request.getRequestDispatcher("admin/updateBlog.jsp").forward(request, response);
            return;
        }

        Blog updatedBlog = new Blog(blogId, blogName.trim(), content.trim(), imagePath, author.trim(), date, 0, 0);
        boolean success = blogDAO.updateBlog(updatedBlog);

        request.setAttribute("message", success ? "Cập nhật blog thành công!" : "Cập nhật thất bại!");
        request.setAttribute("blog", blogDAO.getBlogById(blogId));
        request.getRequestDispatcher("admin/updateBlog.jsp").forward(request, response);
    }
}
