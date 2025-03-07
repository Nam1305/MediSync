/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.ScheduleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.List;
import model.ShiftRegistration;
import model.Staff;

/**
 *
 * @author DIEN MAY XANH
 */
public class RegisterShift extends HttpServlet {

    private ScheduleDAO scheduleDao = new ScheduleDAO();

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

        if (request.getParameter("pageSize") != null) {
            size = Integer.parseInt(request.getParameter("pageSize"));
        }

        // Xử lý action: đăng ký hay xóa
        String action = request.getParameter("action");
        if (action != null) {
            if ("delete".equalsIgnoreCase(action)) {
                // Xử lý xóa đăng ký ca làm việc
                try {
                    int registrationId = Integer.parseInt(request.getParameter("registrationId"));
                    boolean deleted = scheduleDao.deleteShiftRegistration(registrationId);
                    if (deleted) {
                        request.setAttribute("success", "Xóa đăng ký ca làm việc thành công!");
                    } else {
                        request.setAttribute("error", "Xóa đăng ký ca làm việc thất bại!");
                    }
                } catch (NumberFormatException ex) {
                    request.setAttribute("error", "ID đăng ký không hợp lệ!");
                }
            } else if ("regis".equalsIgnoreCase(action)) {
                // Xử lý đăng ký ca làm việc
                String[] shifts = request.getParameterValues("shifts");
                if (shifts == null || shifts.length == 0) {
                    request.setAttribute("error", "Hãy chọn ít nhất 1 ca làm việc!");
                } else {
                    java.sql.Date workDate = new java.sql.Date(System.currentTimeMillis());
                    boolean allSuccess = true;
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
        }

        // Lấy tổng số bản ghi để tính số trang
        int totalRecords = scheduleDao.countShiftRegistrationByStaffId(staff.getStaffId());
        int totalPages = (int) Math.ceil((double) totalRecords / size);

        // Tải lại danh sách đăng ký ca làm việc
        List<ShiftRegistration> scheduleList = scheduleDao.ShiftRegistrationByStaffId(staff.getStaffId(), page, size);
        request.setAttribute("lists", scheduleList);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", size);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("doctor/scheduleRegister.jsp").forward(request, response);
    }

}
