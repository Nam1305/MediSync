package controller.customer;

import dal.DoctorDAO;
import dal.ScheduleDAO;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
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

        // Lấy danh sách ngày làm việc
        List<Schedule> fullSchedule = scheduleDao.getScheduleByStaffId(doctorId);

        // Kiểm tra bác sĩ có lịch làm việc hay không
        boolean hasSchedule = !fullSchedule.isEmpty();
        request.setAttribute("hasSchedule", hasSchedule);

        if (!hasSchedule) {
            request.getRequestDispatcher("customer/doctorDetail.jsp").forward(request, response);
            return;
        }
        
        //khởi tạo danh sách những ngày làm việc
        List<Date> workDays = new ArrayList<>();
        
        //thêm vào danh sách những ngày bác sĩ làm việc
        for (Schedule s : fullSchedule) {
            workDays.add(s.getDate());
        }

        // Chia danh sách ngày thành từng cụm 7 ngày
        List<List<Date>> groupedWeeks = new ArrayList<>();
        for (int i = 0; i < workDays.size(); i += 7) {
            List<Date> week = new ArrayList<>();
            for (int j = i; j < i + 7 && j < workDays.size(); j++) {
                week.add(workDays.get(j));
            }
            groupedWeeks.add(week);
        }

        // Xác định nhóm 7 ngày được chọn
        String weekStr = request.getParameter("week");
        List<Date> selectedWeek = groupedWeeks.get(0); // Mặc định là nhóm đầu tiên

        if (weekStr != null) {
            for (List<Date> week : groupedWeeks) {
                if (week.get(0).toString().equals(weekStr)) {
                    selectedWeek = week;
                    break;
                }
            }
        }

        // Xác định ngày được chọn
        String dateStr = request.getParameter("date");
        Date selectedDate = selectedWeek.get(0); // Mặc định là ngày đầu tiên

        if (dateStr != null) {
            try {
                Date requestedDate = Date.valueOf(dateStr);
                if (selectedWeek.contains(requestedDate)) {
                    selectedDate = requestedDate; // Chỉ đổi nếu ngày hợp lệ trong tuần
                }
            } catch (IllegalArgumentException e) {
                // Nếu date không hợp lệ, giữ nguyên ngày đầu tiên của tuần
            }
        }

        // Lấy danh sách slot trống của ngày đã chọn
        List<TimeSlot> availableSlots = scheduleDao.getAvailableTimeSlots(doctorId, selectedDate);

        request.setAttribute("availableSlot", availableSlots);
        request.setAttribute("selectedDate", selectedDate);
        request.setAttribute("schedule", selectedWeek);
        request.setAttribute("doctor", doctor);
        request.setAttribute("groupedWeeks", groupedWeeks);
        request.setAttribute("selectedWeek", selectedWeek);

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
        handleViewDoctorDetail(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet hiển thị thông tin bác sĩ chi tiết";
    }
}
