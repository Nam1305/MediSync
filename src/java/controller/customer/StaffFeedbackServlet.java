/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.FeedbackDAO;
import dal.StaffDAO;
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
 * @author Admin
 */
@WebServlet(name = "StaffFeedbackServlet", urlPatterns = {"/staffFeedback"})
public class StaffFeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        int staffId = Integer.parseInt(request.getParameter("staffId"));
        int star = 0;
        int page = 1;
        int pageSize = 10;
        boolean hasComment = false;
        String sortOrder = "desc"; // Mặc định hiển thị mới nhất trước

        if (request.getParameter("star") != null) {
            star = Integer.parseInt(request.getParameter("star"));
        }

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        if (request.getParameter("hasComment") != null) {
            hasComment = true;
        }

        if (request.getParameter("sort") != null) {
            sortOrder = request.getParameter("sort");
        }

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        StaffDAO staffDAO = new StaffDAO();

        // Lấy thông tin nhân viên
        Staff staff = staffDAO.getStaffById(staffId);

        // Lấy thống kê đánh giá
        double[] ratingStats = feedbackDAO.getRatingStatistics(staffId);

        // Lấy danh sách feedback với phân trang và filter
        List<Feedback> feedbacks = feedbackDAO.getFeedbackByStaff(staffId, page, pageSize, star, sortOrder);

        // Tính tổng số trang
        int totalFeedbacks = feedbackDAO.getTotalFeedbackCountByStaffId(staffId, star);
        int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

        // Đếm số lượng có bình luận
        int commentCount = feedbackDAO.countFeedbacksWithComment(staffId);

        request.setAttribute("staff", staff);
        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("ratingStats", ratingStats);
        request.setAttribute("avgRating", ratingStats[0]);
        request.setAttribute("commentCount", commentCount);
        request.setAttribute("staffId", staffId);
        request.setAttribute("star", star);
        request.setAttribute("hasComment", hasComment);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("staffFeedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị thông tin bác sĩ chi tiết";
    }
}
