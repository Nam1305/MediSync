package controller.customer;

import dal.AppointmentDAO;
import dal.FeedbackDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Appointment;
import model.Customer;
import model.Feedback;
import model.Prescription;
import model.Staff;
import model.TreatmentPlan;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/appointmentDetail"})
public class ViewAppointmentDetail extends HttpServlet {
    
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    FeedbackDAO feedbackDAO = new FeedbackDAO();
    
    protected void handleViewAppointmentDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Lấy appointmentId từ request
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

        // Lấy chi tiết cuộc hẹn từ DAO
        Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
        System.out.println(appointment);
        
        if (appointment != null) {
            // Truyền dữ liệu cuộc hẹn vào JSP
            request.setAttribute("appointment", appointment);
            // Lấy thông tin bác sĩ phụ trách
            Staff doctor = appointmentDAO.getDetailDoctor(appointmentId);
            System.out.println(doctor);
            //Lấy thông tin bệnh án
            TreatmentPlan treat = appointmentDAO.getTreatmentPlanDetail(appointment.getCustomer().getCustomerId(), appointmentId);
            //Lấy thông tin đơn thuốc
            List<Prescription> presription = appointmentDAO.getPrescriptionDetail(appointment.getCustomer().getCustomerId(), appointmentId);
            // Truyền thông tin thời gian và bác sĩ vào request
            request.setAttribute("doctor", doctor);
            request.setAttribute("treat", treat);
            request.setAttribute("prescription", presription);

            // Chuyển tiếp đến trang JSP để hiển thị
            request.getRequestDispatcher("customer/customerAppointmentDetail.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Appointment not found");
        }
    }
    
    protected void handleFeedbackDoctors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        // Lấy appointmentId từ request
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        //lay thong tin cuoc hen
        Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
        //lấy ratings từ request
        String ratingsStr = request.getParameter("ratings");
        //lấy content từ request
        String content = request.getParameter("content");
        if (ratingsStr == null || ratingsStr.trim().isEmpty()) {
            System.out.println("Nguoi dung chua vote sao!");
            return;
        }
        
        if (content == null || content.trim().isEmpty()) {
            System.out.println("Nguoi dung chua viet danh gia!");
            return;
        }
        
        int ratings = Integer.parseInt(ratingsStr);
        Feedback feedback = new Feedback();
        feedback.setRatings(ratings);
        feedback.setContent(content);
        feedback.setDate(appointment.getDate());
        Staff doctor = appointmentDAO.getDetailDoctor(appointmentId);
        Customer customer = new Customer(appointment.getCustomer().getCustomerId());
        feedback.setStaff(doctor);
        feedback.setCustomer(customer);
        boolean success = feedbackDAO.insertNewFeedback(feedback);
        request.setAttribute("ratings", ratings);
        request.setAttribute("content", content);
        request.setAttribute("message", success ? "Cảm ơn bạn đã đánh giá!" : "Lỗi, vui lòng thử lại.");
        handleViewAppointmentDetail(request, response);
        request.getRequestDispatcher("customer/customerAppointmentDetail.jsp").forward(request, response);
        
        //response.sendRedirect("appointmentDetail?appointmentId=" + appointmentId);
        
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleViewAppointmentDetail(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleFeedbackDoctors(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
