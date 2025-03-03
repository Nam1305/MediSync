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
        double[] feedbackStar = feedbackDao.getRatingStatistics(staff.getStaffId());
        List<Feedback> listFeedback = feedbackDao.getFeedbackByStaffId(staff.getStaffId());
        request.setAttribute("feedbackStar", feedbackStar);
        request.setAttribute("listFeedback", listFeedback);
        request.getRequestDispatcher("doctor/customerFeedback.jsp").forward(request, response);
    }

}
