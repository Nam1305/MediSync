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
        int page = 1; // Trang mặc định
        int pageSize = 10; // Số bản ghi mỗi trang
        String searchName = request.getParameter("searchName");
        Date today = new Date(System.currentTimeMillis());

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        List<StaffSchedule> staffSchedules = scheduleDAO.getStaffsWithSchedule(today, searchName, page, pageSize);
        int totalRecords = scheduleDAO.countStaffsWithSchedule(today, searchName);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        request.setAttribute("staffSchedules", staffSchedules);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);

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
                return;
            }

            int staffId = Integer.parseInt(staffIdParam);
            int shiftRegistrationId = Integer.parseInt(shiftRegistrationIdParam);

            SimpleDateFormat inputFormat = new SimpleDateFormat("dd/MM/yyyy");
            SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy-MM-dd");

            Date startDate = Date.valueOf(sqlFormat.format(inputFormat.parse(startDateParam)));
            Date endDate = Date.valueOf(sqlFormat.format(inputFormat.parse(endDateParam)));

            ShiftRegistration registration = scheduleDAO.getShiftRegistrationById(shiftRegistrationId);

            if (registration != null) {
                createSchedulesForRegistration(request, scheduleDAO, staffId, registration, startDate, endDate);

                // Cập nhật trạng thái ca đăng ký sang "Scheduled"
                registration.setStatus("Scheduled");
                scheduleDAO.updateShiftRegistration(registration);

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
        List<Date> conflictDates = new ArrayList<>(); // Danh sách các ngày bị xung đột

        // Xác định thời gian bắt đầu và kết thúc ca làm việc dựa vào shift
        Time startTime = getStartTimeByShift(registration.getShift());
        Time endTime = getEndTimeByShift(registration.getShift());
        int shift = registration.getShift(); // Lấy ca làm việc từ registration

        for (Date workDate : workDays) {
            // Lấy danh sách lịch làm việc hiện có cho nhân viên vào ngày này
            List<Schedule> existingSchedules = scheduleDAO.getSchedulesByDoctor(staffId, workDate);

            // Kiểm tra trùng lặp ca
            boolean hasConflict = existingSchedules.stream()
                    .anyMatch(existing -> existing.getShift() == shift);

            if (hasConflict) {
                conflictDates.add(workDate); // Ghi nhận ngày bị trùng ca
            } else {
                // Kiểm tra trùng lặp thời gian nếu không trùng ca
                boolean hasOverlap = false;
                for (Schedule existing : existingSchedules) {
                    Time existingStart = existing.getStartTime();
                    Time existingEnd = existing.getEndTime();
                    if (startTime.before(existingEnd) && endTime.after(existingStart)) {
                        hasOverlap = true;
                        break;
                    }
                }

                // Nếu không có trùng lặp thời gian, tạo lịch làm việc mới
                if (!hasOverlap) {
                    Schedule schedule = new Schedule(0, startTime, endTime, shift, workDate, staffId);
                    boolean insertSuccess = scheduleDAO.insertSchedule(schedule);
                    if (insertSuccess) {
                        createdSchedules.add(schedule);
                    }
                } else {
                    conflictDates.add(workDate); // Ghi nhận ngày bị trùng thời gian
                }
            }
        }

        // Xử lý thông báo kết quả
        if (!conflictDates.isEmpty()) {
            // Nếu có ngày bị xung đột, gửi thông báo lỗi
            String errorMessage = "Không thể tạo lịch do trùng lặp ca hoặc thời gian trong các ngày: ";
            SimpleDateFormat displayFormat = new SimpleDateFormat("dd/MM/yyyy");
            for (Date conflictDate : conflictDates) {
                errorMessage += displayFormat.format(conflictDate) + ", ";
            }
            errorMessage = errorMessage.substring(0, errorMessage.length() - 2); // Xóa dấu phẩy và khoảng trắng cuối
            request.setAttribute("error", errorMessage);
        } else {
            request.setAttribute("message", "Đã tạo " + createdSchedules.size() + " lịch làm việc mới");
        }
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

    private List<Staff> getEligibleStaffs(StaffDAO staffDAO, ScheduleDAO scheduleDAO) {
        List<Staff> eligibleStaffs = new ArrayList<>();

        // Get all medical staff (doctors and nurses)
        List<Staff> medicalStaffs = staffDAO.getStaffsByNameAndRoles("", new int[]{2, 3});

        // Current date
        Date currentDate = new Date(System.currentTimeMillis());

        // Check each staff member
        for (Staff staff : medicalStaffs) {
            List<ShiftRegistration> registrations = scheduleDAO.ShiftRegistrationByStaffId(staff.getStaffId(), 1, 10);
            List<Schedule> existingSchedules = scheduleDAO.getScheduleByStaffId(staff.getStaffId());

            if (!registrations.isEmpty()) {
                boolean hasSchedulablePeriod = checkSchedulablePeriods(registrations, existingSchedules);

                if (hasSchedulablePeriod) {
                    eligibleStaffs.add(staff);
                }
            } else {
                eligibleStaffs.add(staff);
            }
        }

        return eligibleStaffs;
    }

    private boolean checkSchedulablePeriods(List<ShiftRegistration> registrations, List<Schedule> existingSchedules) {
        for (ShiftRegistration registration : registrations) {
            if (!"Approved".equals(registration.getStatus())) {
                continue;
            }

            if (isRegistrationSchedulable(registration, existingSchedules)) {
                return true;
            }
        }
        return false;
    }

    private boolean isRegistrationSchedulable(ShiftRegistration registration, List<Schedule> existingSchedules) {
        Date startDate = registration.getStartDate();
        Date endDate = registration.getEndDate();

        // If no start or end date, consider not schedulable
        if (startDate == null || endDate == null) {
            return false;
        }

        // Iterate through date range to check for conflicts
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(startDate);
        Calendar endCalendar = Calendar.getInstance();
        endCalendar.setTime(endDate);

        while (!calendar.after(endCalendar)) {
            Date currentDate = new Date(calendar.getTimeInMillis());

            // Skip weekends
            if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY
                    || calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                calendar.add(Calendar.DAY_OF_MONTH, 1);
                continue;
            }

            // Check if this date conflicts with any existing schedule
            boolean hasConflict = existingSchedules.stream()
                    .anyMatch(schedule
                            -> schedule.getDate().equals(currentDate)
                    && schedule.getShift() == registration.getShift());

            // If no conflict found, this registration is schedulable
            if (!hasConflict) {
                return true;
            }

            calendar.add(Calendar.DAY_OF_MONTH, 1);
        }

        return false;
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
