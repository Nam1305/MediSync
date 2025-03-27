package controller.administrativeStaff;

import dal.ScheduleDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Schedule;
import model.ShiftRegistration;
import model.Staff;
import model.StaffSchedule;
import util.SendEmail;

@WebServlet(name = "ScheduleManagementServlet", urlPatterns = {"/schedule-management"})
public class ScheduleManagementServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        ScheduleDAO scheduleDAO = new ScheduleDAO();
        StaffDAO staffDAO = new StaffDAO();

        String action = request.getParameter("action");

        // Handle AJAX request for getting registration dates
        if ("getRegistrationDates".equals(action)) {
            handleGetRegistrationDates(request, response, scheduleDAO);
            return;
        }

        // Xử lý hành động tạo lịch làm việc nếu có
        if ("createSchedule".equals(action)) {
            handleCreateScheduleAction(request, scheduleDAO, staffDAO);
        }

        // Lấy danh sách nhân viên có đăng ký ca làm việc và đáp ứng điều kiện hiển thị
        List<Staff> eligibleStaffs = getEligibleStaffs(staffDAO, scheduleDAO);
        request.setAttribute("staffs", eligibleStaffs);

        // Lấy danh sách ca đăng ký của nhân viên được chọn nếu có
        handleSelectedStaff(request, scheduleDAO);

        // Lấy danh sách nhân viên có lịch từ hôm nay trở đi với phân trang và tìm kiếm
        String pageParam = request.getParameter("page");
        String searchName = request.getParameter("searchName") != null ? request.getParameter("searchName") : "";
        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        int pageSize = 10;
        Date today = new Date(System.currentTimeMillis());
        List<StaffSchedule> staffSchedules = scheduleDAO.getStaffsWithSchedule(today, searchName, page, pageSize);
        int totalRecords = scheduleDAO.countStaffsWithSchedule(today, searchName);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Chuyển dữ liệu đến JSP
        request.setAttribute("staffSchedules", staffSchedules);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchName", searchName);

        // Forward đến trang JSP
        request.getRequestDispatcher("AdministrativeStaff/scheduleManagement.jsp").forward(request, response);
    }

    /**
     * Handle AJAX request to get registration dates
     */
    private void handleGetRegistrationDates(HttpServletRequest request, HttpServletResponse response, ScheduleDAO scheduleDAO)
            throws IOException {
        response.setContentType("application/json");
        String registrationIdParam = request.getParameter("registrationId");

        if (registrationIdParam != null && !registrationIdParam.isEmpty()) {
            try {
                int registrationId = Integer.parseInt(registrationIdParam);
                ShiftRegistration registration = scheduleDAO.getShiftRegistrationById(registrationId);

                if (registration != null) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
                    String startDate = registration.getStartDate() != null
                            ? dateFormat.format(registration.getStartDate()) : "";
                    String endDate = registration.getEndDate() != null
                            ? dateFormat.format(registration.getEndDate()) : "";

                    // Tạo JSON response
                    String jsonResponse = "{\"startDate\":\"" + startDate + "\",\"endDate\":\"" + endDate + "\"}";
                    response.getWriter().write(jsonResponse);
                    return;
                }
            } catch (NumberFormatException e) {
                // Error parsing registration ID
            }
        }

        // Nếu có lỗi, trả về JSON rỗng
        response.getWriter().write("{}");
    }

    /**
     * Xử lý hành động tạo lịch làm việc từ form
     */
    private void handleCreateScheduleAction(HttpServletRequest request, ScheduleDAO scheduleDAO, StaffDAO staffDAO) {
        try {
            String staffIdParam = request.getParameter("staffId");
            String shiftRegistrationIdParam = request.getParameter("shiftRegistrationId");
            String startDateParam = request.getParameter("startDate");
            String endDateParam = request.getParameter("endDate");

            if (staffIdParam == null || staffIdParam.isEmpty()
                    || shiftRegistrationIdParam == null || shiftRegistrationIdParam.isEmpty()
                    || startDateParam == null || startDateParam.isEmpty()
                    || endDateParam == null || endDateParam.isEmpty()) {
                //request.setAttribute("error", "Thiếu thông tin cần thiết để tạo lịch làm việc");
                return;
            }

            try {
                int staffId = Integer.parseInt(staffIdParam);
                int shiftRegistrationId = Integer.parseInt(shiftRegistrationIdParam);

                // Chuyển đổi từ dd/MM/yyyy về yyyy-MM-dd
                SimpleDateFormat inputFormat = new SimpleDateFormat("dd/MM/yyyy");
                SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd");

                Date startDate = Date.valueOf(sqlFormat.format(inputFormat.parse(startDateParam)));
                Date endDate = Date.valueOf(sqlFormat.format(inputFormat.parse(endDateParam)));

                ShiftRegistration registration = scheduleDAO.getShiftRegistrationById(shiftRegistrationId);

                if (registration != null) {
                    createSchedulesForRegistration(request, scheduleDAO, staffId, registration, startDate, endDate);

                    Staff staff = staffDAO.getStaffById(staffId);
                    if (staff != null) {
                        sendScheduleNotification(staff, registration.getShift(), startDate, endDate);
                    }
                } else {
                    request.setAttribute("error", "Không tìm thấy thông tin đăng ký ca làm việc");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Định dạng dữ liệu không hợp lệ: " + e.getMessage());
            } catch (java.text.ParseException e) {
                request.setAttribute("error", "Định dạng ngày tháng không hợp lệ: " + e.getMessage());
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Ngày tháng không hợp lệ: " + e.getMessage());
            }
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi tạo lịch làm việc: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Gửi email thông báo lịch làm việc cho nhân viên
     */
    private void sendScheduleNotification(Staff staff, int shift, Date startDate, Date endDate) {
        try {
            // Định dạng ngày tháng
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            String formattedStartDate = dateFormat.format(startDate);
            String formattedEndDate = dateFormat.format(endDate);

            // Xác định tên ca làm việc
            String shiftName = getShiftName(shift);

            // Nội dung email
            String subject = "Thông báo lịch làm việc mới";
            String content = "Bạn đã được xếp lịch:\n\n"
                    + "Ca " + shiftName + " từ ngày " + formattedStartDate
                    + " đến ngày " + formattedEndDate;

            // Gửi email
            SendEmail emailSender = new SendEmail();
            boolean sent = emailSender.sendEmail(staff.getEmail(), subject, content);

            if (!sent) {
                System.out.println("Không thể gửi email thông báo lịch làm việc cho nhân viên: " + staff.getEmail());
            }
        } catch (Exception e) {
            System.out.println("Lỗi khi gửi email thông báo: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * Lấy tên ca làm việc dựa vào số ca
     */
    private String getShiftName(int shift) {
        switch (shift) {
            case 1:
                return "Sáng (8:00 - 12:00)";
            case 2:
                return "Chiều (13:00 - 17:00)";
            case 3:
                return "Tối (18:00 - 22:00)";
            default:
                return "Không xác định";
        }
    }

    /**
     * Tạo lịch làm việc cho một đăng ký ca
     */
    private void createSchedulesForRegistration(HttpServletRequest request, ScheduleDAO scheduleDAO,
            int staffId, ShiftRegistration registration, Date startDate, Date endDate) {

        List<Date> workDays = generateWorkDays(startDate, endDate);
        List<Schedule> createdSchedules = new ArrayList<>();

        // Xác định thời gian bắt đầu và kết thúc ca làm việc dựa vào shift
        Time startTime = getStartTimeByShift(registration.getShift());
        Time endTime = getEndTimeByShift(registration.getShift());

        for (Date workDate : workDays) {
            // Kiểm tra xem đã có lịch làm việc cho nhân viên vào ngày này chưa
            List<Schedule> existingSchedules = scheduleDAO.getSchedulesByDoctor(staffId, workDate);
            if (existingSchedules.isEmpty()) {
                // Tạo lịch làm việc mới
                Schedule schedule = new Schedule(0, startTime, endTime, registration.getShift(),
                        workDate, staffId);
                boolean insertSuccess = scheduleDAO.insertSchedule(schedule);
                if (insertSuccess) {
                    createdSchedules.add(schedule);
                }
            }
        }

        request.setAttribute("message", "Đã tạo " + createdSchedules.size() + " lịch làm việc mới");
    }

    /**
     * Xử lý việc hiển thị thông tin cho nhân viên được chọn
     */
    private void handleSelectedStaff(HttpServletRequest request, ScheduleDAO scheduleDAO) {
        String selectedStaffIdParam = request.getParameter("staffId");
        if (selectedStaffIdParam != null && !selectedStaffIdParam.isEmpty()) {
            try {
                int selectedStaffId = Integer.parseInt(selectedStaffIdParam);
                List<ShiftRegistration> pendingRegistrations = getPendingRegistrations(scheduleDAO, selectedStaffId);
                request.setAttribute("pendingRegistrations", pendingRegistrations);
                request.setAttribute("selectedStaffId", selectedStaffId);

                // Handle selected shift registration
                String selectedRegistrationIdParam = request.getParameter("shiftRegistrationId");
                if (selectedRegistrationIdParam != null && !selectedRegistrationIdParam.isEmpty()) {
                    try {
                        int selectedRegistrationId = Integer.parseInt(selectedRegistrationIdParam);
                        ShiftRegistration selectedRegistration = scheduleDAO.getShiftRegistrationById(selectedRegistrationId);
                        if (selectedRegistration != null) {
                            request.setAttribute("selectedRegistration", selectedRegistration);
                        }
                    } catch (NumberFormatException e) {
                        // Ignore parsing errors
                    }
                }
            } catch (NumberFormatException e) {
                // Không cần xử lý, nếu không parse được thì không hiển thị danh sách
            }
        }
    }

    /**
     * Generate list of workdays between start and end dates, excluding weekends
     */
    private List<Date> generateWorkDays(Date startDate, Date endDate) {
        List<Date> workDays = new ArrayList<>();

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);

        // Convert to Calendar instances for date manipulation
        Calendar endCal = Calendar.getInstance();
        endCal.setTime(endDate);

        // Iterate through each day in the range
        while (!calendar.after(endCal)) {
            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);

            // Skip Saturday (7) and Sunday (1)
            if (dayOfWeek != Calendar.SATURDAY && dayOfWeek != Calendar.SUNDAY) {
                workDays.add(new Date(calendar.getTimeInMillis()));
            }

            calendar.add(Calendar.DAY_OF_MONTH, 1);
        }

        return workDays;
    }

    /**
     * Determine start time based on shift number
     */
    private Time getStartTimeByShift(int shift) {
        switch (shift) {
            case 1:
                return Time.valueOf("08:00:00");
            case 2:
                return Time.valueOf("13:00:00");
            case 3:
                return Time.valueOf("18:00:00");
            default:
                return Time.valueOf("08:00:00"); // Default start time
        }
    }

    /**
     * Determine end time based on shift number
     */
    private Time getEndTimeByShift(int shift) {
        switch (shift) {
            case 1:
                return Time.valueOf("12:00:00");
            case 2:
                return Time.valueOf("17:00:00");
            case 3:
                return Time.valueOf("22:00:00");
            default:
                return Time.valueOf("12:00:00"); // Default end time
        }
    }

    /**
     * Get list of staffs who meet the eligibility criteria for scheduling
     */
    private List<Staff> getEligibleStaffs(StaffDAO staffDAO, ScheduleDAO scheduleDAO) {
        List<Staff> eligibleStaffs = new ArrayList<>();

        // Lấy tất cả nhân viên là bác sĩ hoặc y tá (role 2 và 3)
        List<Staff> medicalStaffs = staffDAO.getStaffsByNameAndRoles("", new int[]{2, 3});

        // Ngày hiện tại
        Date currentDate = new Date(System.currentTimeMillis());

        // Kiểm tra từng nhân viên
        for (Staff staff : medicalStaffs) {
            boolean isEligible = true;

            // Lấy danh sách đăng ký ca làm việc của nhân viên
            List<ShiftRegistration> registrations = scheduleDAO.ShiftRegistrationByStaffId(staff.getStaffId(), 1, 10);

            // Nếu nhân viên chưa đăng ký ca nào, cho phép hiển thị
            if (registrations.isEmpty()) {
                eligibleStaffs.add(staff);
                continue;
            }

            // Lấy lịch làm việc đã được xếp của nhân viên
            List<Schedule> schedules = scheduleDAO.getScheduleByStaffId(staff.getStaffId());

            // Nếu nhân viên chưa được xếp ca làm việc nào, cho phép hiển thị
            if (schedules.isEmpty()) {
                eligibleStaffs.add(staff);
                continue;
            }

            // Tìm ngày cuối cùng trong lịch làm việc hiện tại
            Date lastScheduledDate = null;
            for (Schedule schedule : schedules) {
                if (lastScheduledDate == null || schedule.getDate().after(lastScheduledDate)) {
                    lastScheduledDate = schedule.getDate();
                }
            }

            // Nếu ngày hiện tại sau ngày cuối cùng trong lịch, kiểm tra điều kiện về ngày đăng ký
            if (lastScheduledDate != null && currentDate.after(lastScheduledDate)) {
                // Tìm ngày đăng ký ca làm việc mới nhất
                Date latestRegistrationDate = null;
                for (ShiftRegistration registration : registrations) {
                    if (latestRegistrationDate == null || registration.getRegisDate().after(latestRegistrationDate)) {
                        latestRegistrationDate = registration.getRegisDate();
                    }
                }

                // Tìm ngày đầu tiên trong lịch làm việc hiện tại
                Date firstScheduledDate = null;
                for (Schedule schedule : schedules) {
                    if (firstScheduledDate == null || schedule.getDate().before(firstScheduledDate)) {
                        firstScheduledDate = schedule.getDate();
                    }
                }

                // Nếu ngày đăng ký ca mới nhất diễn ra trước ngày đầu tiên của lịch làm việc,
                // không hiển thị nhân viên
                if (latestRegistrationDate != null && firstScheduledDate != null
                        && latestRegistrationDate.before(firstScheduledDate)) {
                    isEligible = false;
                }
            } else if (lastScheduledDate != null && (currentDate.before(lastScheduledDate)
                    || currentDate.equals(lastScheduledDate))) {
                // Nếu ngày hiện tại đang trong lịch của ngày xếp ca trước, không hiển thị nhân viên
                isEligible = false;
            }

            if (isEligible) {
                eligibleStaffs.add(staff);
            }
        }

        return eligibleStaffs;
    }


    private List<ShiftRegistration> getPendingRegistrations(ScheduleDAO scheduleDAO, int staffId) {
        List<ShiftRegistration> allRegistrations = scheduleDAO.ShiftRegistrationByStaffId(staffId, 1, 100);
        List<ShiftRegistration> pendingRegistrations = new ArrayList<>();

        for (ShiftRegistration registration : allRegistrations) {
            if ("Approved".equals(registration.getStatus())) {
                pendingRegistrations.add(registration);
            }
        }

        return pendingRegistrations;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for managing staff scheduling";
    }
}
