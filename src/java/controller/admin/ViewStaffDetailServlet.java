package controller.admin;

import dal.DoctorDAO;
import dal.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Feedback;
import model.Staff;

/**
 *
 * @author Acer
 */
@WebServlet(name = "ViewStaffDetailServlet", urlPatterns = {"/ViewStaffDetail"})
public class ViewStaffDetailServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewStaffDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewStaffDetailServlet at " + request.getContextPath() + "</h1>");
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
        String staffIdStr = request.getParameter("id");
        try {
            int staffId = Integer.parseInt(staffIdStr);
            DoctorDAO doctorDAO = new DoctorDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            Staff currentstaff = doctorDAO.getStaffById(staffId);

            // Get feedback related data
            String starParam = request.getParameter("star");
            String sortParam = request.getParameter("sort");
            String pageParam = request.getParameter("page");

            int star = 0;
            String sortOrder = "desc"; // Default sort order
            int page = 1; // Default page
            int pageSize = 10; // Default page size

            if (starParam != null && !starParam.isEmpty()) {
                star = Integer.parseInt(starParam);
            }

            if (sortParam != null && !sortParam.isEmpty()) {
                sortOrder = sortParam;
            }

            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            // Get feedback data from DAO
            List<Feedback> feedbacks = feedbackDAO.getFeedbackByStaff(staffId, page, pageSize, star, sortOrder);

            // Get total feedbacks for pagination
            int totalFeedbacks = feedbackDAO.getTotalFeedbackCountByStaffId(staffId, star);
            int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);
            double ratting = doctorDAO.getAverageRating(staffId);
            // Get rating statistics
            double[] ratingStats = feedbackDAO.getRatingStatistics(staffId);
            int commentCount = feedbackDAO.countFeedbacksWithComment(staffId);
            double avgRating = ratingStats[0]; // Use the first element which is the average rating

            if (currentstaff != null) {
                request.setAttribute("staff", currentstaff);
                request.setAttribute("rating", ratting);
                // Set feedback attributes
                request.setAttribute("feedbacks", feedbacks);
                request.setAttribute("ratingStats", ratingStats);
                request.setAttribute("commentCount", commentCount);
                request.setAttribute("avgRating", avgRating);
                request.setAttribute("staffId", staffId);
                request.setAttribute("star", star);
                request.setAttribute("sortOrder", sortOrder);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);

                request.getRequestDispatcher("admin/staffDetail.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy nhân viên , thông báo lỗi
                request.setAttribute("error", "Staff with ID " + staffId + " not found.");
                request.getRequestDispatcher("admin/staffDetail").forward(request, response); // Quay lại danh sách
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi nếu id không phải là số nguyên
            request.setAttribute("error", "Invalid ID format.");
            request.getRequestDispatcher("listDoctor").forward(request, response); // Quay lại danh sách
        } catch (Exception e) {
            // Xử lý các lỗi khác
            System.out.println(e);
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("listDoctor").forward(request, response); // Quay lại danh sách
        }
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
