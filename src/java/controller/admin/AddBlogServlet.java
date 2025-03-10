package controller.admin;

import dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 200, // 200MB
        maxRequestSize = 1024 * 1024 * 500 // 500MB
)
@WebServlet(name = "AddBlogServlet", urlPatterns = {"/addBlog"})
public class AddBlogServlet extends HttpServlet {

    long maxFileSize = 1024 * 1024 * 3;
    BlogDAO blogDAO = new BlogDAO();

    private void handleAddBlog(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        // Lấy dữ liệu từ form
        String blogName = request.getParameter("blogName");
        String content = request.getParameter("content");
        String author = request.getParameter("author");
        // Thay vì lấy ngày từ form, luôn sử dụng ngày hiện tại
        Date currentDate = Date.valueOf(LocalDate.now());
        Part imagePart = request.getPart("image");

        // Kiểm tra dữ liệu nhập
        if (blogName == null || blogName.trim().isEmpty()) {
            errors.add("Vui lòng nhập tiêu đề bài viết!");
        }
        if (content == null || content.trim().isEmpty()) {
            errors.add("Vui lòng nhập nội dung bài viết!");
        }
        if (author == null || author.trim().isEmpty()) {
            errors.add("Vui lòng nhập tên tác giả!");
        }

        String imageFilename = null;
        if (imagePart == null || imagePart.getSize() == 0) {
            errors.add("Vui lòng chọn ảnh!");
        } else {
            imageFilename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            // Thêm timestamp vào tên file để tránh trùng lặp
            String fileExtension = imageFilename.substring(imageFilename.lastIndexOf("."));
            String baseFileName = imageFilename.substring(0, imageFilename.lastIndexOf("."));
            imageFilename = baseFileName + "_" + System.currentTimeMillis() + fileExtension;
            
            if (!imageFilename.toLowerCase().matches(".*\\.(png|jpg|jpeg)$")) {
                errors.add("Ảnh phải có định dạng .png, .jpg hoặc .jpeg!");
            }
            if (imagePart.getSize() > maxFileSize) {
                errors.add("Dung lượng ảnh không được vượt quá 3MB!");
            }
        }

        // Nếu có lỗi, quay lại trang addBlog.jsp với danh sách lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("blogName", blogName);
            request.setAttribute("content", content);
            request.setAttribute("author", author);
            request.getRequestDispatcher("admin/addBlog.jsp").forward(request, response);
            return;
        }

        try {
            // Lưu ảnh vào thư mục uploads trên server
            String uploadFolder = request.getServletContext().getRealPath("/uploads");
            Path uploadPath = Paths.get(uploadFolder);
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Kiểm tra thư mục có tồn tại và có quyền ghi không
            if (!Files.isWritable(uploadPath)) {
                System.out.println("Không thể ghi vào thư mục: " + uploadPath);
                errors.add("Lỗi hệ thống: Không thể lưu file ảnh!");
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("admin/addBlog.jsp").forward(request, response);
                return;
            }

            String fullImagePath = Paths.get(uploadPath.toString(), imageFilename).toString();
            imagePart.write(fullImagePath);
            System.out.println("Đã lưu ảnh tại: " + fullImagePath);

            // Sửa lại đường dẫn ảnh để đảm bảo nó hoạt động trong JSP
            String imageDbPath = request.getContextPath() + "/uploads/" + imageFilename;
            
            // In ra đường dẫn để debug
            System.out.println("Đường dẫn ảnh được lưu vào DB: " + imageDbPath);
            
            Blog newBlog = new Blog();
            newBlog.setBlogName(blogName.trim());
            newBlog.setContent(content.trim());
            newBlog.setImage(imageDbPath);
            newBlog.setAuthor(author.trim());
            newBlog.setDate(currentDate);
            
            boolean success = blogDAO.addBlog(newBlog);
            
            if (success) {
                request.setAttribute("success", "Thêm bài viết thành công!");
            } else {
                errors.add("Không thể thêm bài viết!");
                request.setAttribute("errors", errors);
            }
            
            request.getRequestDispatcher("admin/addBlog.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Lỗi khi thêm blog: " + e.getMessage());
            e.printStackTrace();
            errors.add("Lỗi hệ thống: " + e.getMessage());
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("admin/addBlog.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("admin/addBlog.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        handleAddBlog(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}