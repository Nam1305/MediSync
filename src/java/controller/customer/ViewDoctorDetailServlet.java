package controller.customer;

import dal.DoctorDAO;
import dal.ScheduleDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Schedule;
import model.Staff;
import model.TimeSlot;

/**
 * Servlet hiển thị thông tin chi tiết của bác sĩ
 */
@WebServlet(name = "ViewDoctorDetailServlet", urlPatterns = {"/doctorDetail"})
public class ViewDoctorDetailServlet extends HttpServlet {

    protected void handleViewDoctorDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        DoctorDAO doctorDao = new DoctorDAO();
        ScheduleDAO scheduleDao = new ScheduleDAO();

        // Lấy doctorId từ request
        String doctorIdStr = request.getParameter("doctorId");
        if (doctorIdStr == null || doctorIdStr.trim().isEmpty()) {
            request.setAttribute("error", "Không tìm thấy thông tin bác sĩ.");
            request.getRequestDispatcher("customer/doctorDetail.jsp").forward(request, response);
            return;
        }

        int doctorId;
        try {
            doctorId = Integer.parseInt(doctorIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Mã bác sĩ không hợp lệ.");
            request.getRequestDispatcher("customer/doctorDetail.jsp").forward(request, response);
            return;
        }

        // Lấy thông tin bác sĩ
        Staff doctor = doctorDao.getStaffById(doctorId);
        if (doctor == null) {
            request.setAttribute("error", "Không tìm thấy bác sĩ.");
            request.getRequestDispatcher("customer/doctorDetail.jsp").forward(request, response);
            return;
        }

        // Lấy danh sách lịch làm việc của bác sĩ
        List<Schedule> schedule = scheduleDao.getScheduleByStaffId(doctorId);
        boolean hasSchedule = !schedule.isEmpty(); // Kiểm tra có lịch hay không

        Date selectedDate = null;
        List<TimeSlot> availableSlots = null;

        if (hasSchedule) {
            // Lấy ngày được chọn từ request hoặc mặc định là ngày đầu tiên có lịch
            String dateStr = request.getParameter("date");
            try {
                if (dateStr != null) {
                    selectedDate = Date.valueOf(dateStr);
                } else {
                    selectedDate = schedule.get(0).getDate();
                }

                // Lấy danh sách slot khám trống của ngày đó
                availableSlots = scheduleDao.getAvailableTimeSlots(doctorId, selectedDate);
            } catch (IllegalArgumentException e) {
                hasSchedule = false; // Nếu ngày không hợp lệ, ẩn lịch khám
            }
        }

        // Gửi dữ liệu đến JSP
        request.setAttribute("availableSlot", availableSlots);
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("schedule", schedule);
        request.setAttribute("doctor", doctor);
        request.setAttribute("hasSchedule", hasSchedule); // Gửi trạng thái lịch làm việc

        // Nếu có message (ví dụ: đặt lịch thành công), gửi đến JSP
        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("message", message);
        }

        request.getRequestDispatcher("customer/doctorDetail.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleViewDoctorDetail(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiện tại không xử lý POST, có thể mở rộng sau này
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị thông tin bác sĩ chi tiết";
    }
}
