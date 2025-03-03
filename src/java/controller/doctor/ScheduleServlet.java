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
        List<Schedule> listSchedule = scheduleDao.getScheduleByStaffId(staff.getStaffId());
        request.setAttribute("list", listSchedule);

        request.getRequestDispatcher("doctor/schedule.jsp").forward(request, response);
    }

}
