package controller.doctor;

import dal.ScheduleDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Schedule;
import model.Staff;
import java.sql.*;
import model.ShiftRegistration;

public class ScheduleServlet extends HttpServlet {

    private ScheduleDAO scheduleDao = new ScheduleDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");
        List<Schedule> listSchedule = scheduleDao.getScheduleByStaffId(staff.getStaffId());
        request.setAttribute("list", listSchedule);

        request.getRequestDispatcher("doctor/schedule.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");

        int page = 1;
        int size = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        // Lấy tổng số bản ghi để tính số trang
        int totalRecords = scheduleDao.countShiftRegistrationByStaffId(staff.getStaffId());
        int totalPages = (int) Math.ceil((double) totalRecords / size);

        // Xử lý đăng ký ca làm việc nếu có action
        String action = request.getParameter("action");
        if (action != null) {
            String[] shifts = request.getParameterValues("shifts");

            if (shifts == null || shifts.length == 0) {
                request.setAttribute("error", "Hãy chọn ít nhất 1 ca làm việc!");
            } else {
                Date workDate = new Date(System.currentTimeMillis());
                boolean allSuccess = true;
                request.setAttribute("s", shifts.length);
                for (String shift : shifts) {
                    int shiftId = Integer.parseInt(shift);
                    boolean inserted = scheduleDao.insertShiftRegistration(staff.getStaffId(), shiftId, workDate);
                    
                    if (!inserted) {
                        allSuccess = false;
                    }
                }

                if (allSuccess) {
                    request.setAttribute("success", "Đăng ký ca làm việc thành công!");
                } else {
                    request.setAttribute("error", "Đăng ký thất bại! Vui lòng thử lại.");
                }
            }
        }

        // Tải lại danh sách sau khi đăng ký
        List<ShiftRegistration> scheduleList = scheduleDao.ShiftRegistrationByStaffId(staff.getStaffId(), page, size);
        request.setAttribute("lists", scheduleList);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("doctor/scheduleRegister.jsp").forward(request, response);
    }

}
