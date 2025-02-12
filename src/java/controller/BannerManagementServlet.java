package controller;

import dal.BlogDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Blog;
import model.Staff;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "BannerManagementServlet", urlPatterns = {"/manage-banners"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class BannerManagementServlet extends HttpServlet {

    private final BlogDAO blogDAO;
    private final String UPLOAD_DIR = "assets/images/blog/";
    private final int ITEMS_PER_PAGE = 6;

    public BannerManagementServlet() {
        this.blogDAO = new BlogDAO();
    }

    private boolean validateSession(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        HttpSession session = request.getSession(false);
        
        // Check if session exists and user is logged in
        if (session == null || session.getAttribute("staff") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }

        // Check if logged-in user is an admin
        Staff staff = (Staff) session.getAttribute("staff");
        
        // Change the comparison to be case-insensitive
        if (staff.getPosition() == null || staff.getRole().getRoleId() != 1) {
            response.sendRedirect(request.getContextPath() + "/home");
            return false;
        }

        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Validate session before processing the request
        if (!validateSession(request, response)) {
            return;
        }

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException e) {
            // Keep default page 1
        }

        // Normalize search query
        String searchQuery = normalizeSearchText(request.getParameter("search"));

        String sortOrder = request.getParameter("sortOrder");
        if (sortOrder == null) {
            sortOrder = "desc"; // Default sort order
        }

        int totalItems = blogDAO.getTotalBannersCount(searchQuery);
        int totalPages = (int) Math.ceil((double) totalItems / ITEMS_PER_PAGE);

        List<Blog> allBlogs = blogDAO.getAllBlogsForBanner(
                page,
                ITEMS_PER_PAGE,
                searchQuery,
                sortOrder
        );

        request.setAttribute("blogs", allBlogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchQuery", request.getParameter("search")); // Giữ giá trị gốc cho form
        request.setAttribute("sortOrder", sortOrder);

        request.getRequestDispatcher("manage-banners.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!validateSession(request, response)) {
            return;
        }

        String action = request.getParameter("action");

        if ("updateBanner".equals(action)) {
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            boolean setAsBanner = Boolean.parseBoolean(request.getParameter("setAsBanner"));
            blogDAO.updateBannerStatus(blogId, setAsBanner);
        } else if ("uploadNew".equals(action)) {
            // Handle new banner upload
            Part filePart = request.getPart("bannerImage");
            String fileName = UUID.randomUUID().toString() + getFileExtension(filePart);
            String uploadPath = getServletContext().getRealPath("") + UPLOAD_DIR;

            // Create directory if it doesn't exist
            Files.createDirectories(Paths.get(uploadPath));

            // Save the file
            filePart.write(uploadPath + fileName);

            // Create new banner blog entry
            Blog newBanner = new Blog();
            newBanner.setBlogName(request.getParameter("bannerName"));
            newBanner.setContent(request.getParameter("bannerContent"));
            newBanner.setImage(UPLOAD_DIR + fileName);
            newBanner.setTypeId(1);
            newBanner.setSelectedBanner(1);

            blogDAO.addNewBanner(newBanner);
        }

        response.sendRedirect("manage-banners");
    }

    private String getFileExtension(Part part) {
        String submittedFileName = part.getSubmittedFileName();
        return submittedFileName.substring(submittedFileName.lastIndexOf("."));
    }

    private String normalizeSearchText(String text) {
        if (text == null) {
            return "";
        }

        // Trim và loại bỏ nhiều dấu cách liên tiếp
        String normalized = text.trim().replaceAll("\\s+", " ");

        // Chuyển về chữ thường
        normalized = normalized.toLowerCase();

        return normalized;
    }
}