package controller.doctor;

import dal.ScheduleDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Schedule;
import model.Staff;

public class ScheduleServlet extends HttpServlet {

    private ScheduleDAO scheduleDao = new ScheduleDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");

        // Lấy thông tin phân trang
        int page = 1;
        int pageSize = 3;
        if (request.getParameter("size") != null) {
            pageSize = Integer.parseInt(request.getParameter("size"));
        }
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy thông tin lọc ngày
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        Date startDate = null, endDate = null;
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");

        try {
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = Date.valueOf(startDateStr);
            }
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = Date.valueOf(endDateStr);
            }
            // Nếu startDate lớn hơn endDate, hoán đổi lại
            if (startDate != null && endDate != null && startDate.after(endDate)) {
                Date temp = startDate;
                startDate = endDate;
                endDate = temp;
            }
        } catch (Exception e) {
            startDate = null;
            endDate = null;
        }

        // Xử lý nếu người dùng gửi yêu cầu thêm lịch làm việc
        String action = request.getParameter("action");
        if ("adddate".equals(action)) {
            try {
                String dateworkStr = request.getParameter("datework");
                String startTimeStr = request.getParameter("startTime");
                String endTimeStr = request.getParameter("endTime");

                if (dateworkStr == null || startTimeStr == null || endTimeStr == null) {
                    throw new IllegalArgumentException("Vui lòng nhập đầy đủ thông tin.");
                }

                Date datework = Date.valueOf(dateworkStr);
                Time startTime = Time.valueOf(startTimeStr + ":00");
                Time endTime = Time.valueOf(endTimeStr + ":00");

                Schedule schedule = new Schedule(0, startTime, endTime, 30, datework, staff.getStaffId());

                // Kiểm tra lịch đã tồn tại chưa
                if (scheduleDao.checkExistSchedule(schedule) != null) {
                    request.setAttribute("errorMessage", "Lịch đã tồn tại! Vui lòng chọn thời gian khác.");
                } else {
                    scheduleDao.insertSchedule(schedule);
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("errorMessage", "Lỗi khi thêm lịch: " + e.getMessage());
            }
        }

        // Lấy danh sách lịch sau khi xử lý
        List<Schedule> listSchedule = scheduleDao.getScheduleByPage(staff.getStaffId(), startDate, endDate, page, pageSize);

        // Lấy tổng số bản ghi để tính số trang
        int totalSchedules = scheduleDao.countScheduleByFilter(staff.getStaffId(), startDate, endDate, page, pageSize);
        int totalPages = (int) Math.ceil((double) totalSchedules / pageSize);

        // Gửi dữ liệu đến JSP
        request.setAttribute("listSchedule", listSchedule);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalSchedules", totalSchedules);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("startDate", startDateStr);
        request.setAttribute("endDate", endDateStr);

        request.getRequestDispatcher("doctor/schedule.jsp").forward(request, response);
    }
}
