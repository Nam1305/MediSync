/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Feedback;
import model.Staff;

/**
 *
 * @author DIEN MAY XANH
 */
public class MyFeedbackServlet extends HttpServlet {

    FeedbackDAO feedbackDao = new FeedbackDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");
        String sortOrder = request.getParameter("sortOrder") == null ? "desc" : "asc";
        int page = 1;
        int pageSize = 5;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        if (request.getParameter("pageSize") != null) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }

        int starFilter = 0;

        if (request.getParameter("starFilter") != null) {
            try {
                starFilter = Integer.parseInt(request.getParameter("starFilter"));
            } catch (NumberFormatException e) {
                starFilter = 0;
            }
        }

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Feedback> feedbackList = feedbackDAO.getFeedbackByStaffId(staff.getStaffId(), page, pageSize, starFilter, sortOrder);
        int totalRecords = feedbackDAO.getTotalFeedbackCountByStaffId(staff.getStaffId(), starFilter);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        double[] feedbackStar = feedbackDao.getRatingStatistics(staff.getStaffId());
        request.setAttribute("feedbackStar", feedbackStar);
        request.setAttribute("feedbackList", feedbackList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("starFilter", starFilter);
        request.getRequestDispatcher("doctor/customerFeedback.jsp").forward(request, response);
    }

}
