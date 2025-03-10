package controller.administrativeStaff;

import dal.ScheduleDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ShiftRegistration;
import model.Staff;

@WebServlet(name = "ShiftApprovalServlet", urlPatterns = {"/shift-approval"})
public class ShiftApprovalServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        ScheduleDAO scheduleDAO = new ScheduleDAO();
        StaffDAO staffDAO = new StaffDAO();
        
        String action = request.getParameter("action");
        
        // Xử lý hành động phê duyệt/từ chối đăng ký ca
        if ("approve".equals(action) || "reject".equals(action)) {
            int registrationId = Integer.parseInt(request.getParameter("registrationId"));
            String status = "approve".equals(action) ? "Approved" : "Rejected";
            
            // Lấy thông tin đăng ký ca làm việc hiện tại
            ShiftRegistration registration = scheduleDAO.getShiftRegistrationById(registrationId);
            
            // Kiểm tra trạng thái hiện tại, chỉ cho phép cập nhật nếu đang ở trạng thái Pending
            if (registration != null && "Pending".equals(registration.getStatus())) {
                registration.setStatus(status);
                boolean updateSuccess = scheduleDAO.updateShiftRegistration(registration);
                
                if (updateSuccess) {
                    request.setAttribute("message", "Cập nhật trạng thái thành công");
                } else {
                    request.setAttribute("error", "Cập nhật trạng thái thất bại");
                }
            } else {
                request.setAttribute("error", "Không thể cập nhật đăng ký đã được xử lý");
            }
        }
        
        // Phân trang và lọc dữ liệu
        int page = 1;
        int pageSize = 10;
        Integer staffId = null;
        Date fromDate = null;
        Date toDate = null;
        String staffName = "";
        
        // Lấy tham số từ request
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        if (request.getParameter("pageSize") != null) {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        }
        
        if (request.getParameter("staffName") != null && !request.getParameter("staffName").trim().isEmpty()) {
            staffName = request.getParameter("staffName").trim();
            // Không cần set staffId ở đây vì sẽ tìm theo tên
        }
        
        // Xử lý lọc theo ngày
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        if (request.getParameter("fromDate") != null && !request.getParameter("fromDate").isEmpty()) {
            try {
                java.util.Date parsedDate = sdf.parse(request.getParameter("fromDate"));
                fromDate = new Date(parsedDate.getTime());
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        
        if (request.getParameter("toDate") != null && !request.getParameter("toDate").isEmpty()) {
            try {
                java.util.Date parsedDate = sdf.parse(request.getParameter("toDate"));
                toDate = new Date(parsedDate.getTime());
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        
        // Lấy danh sách các đăng ký ca làm việc
        List<ShiftRegistration> registrations;
        int totalRegistrations;
        
        if (!staffName.isEmpty()) {
            // Tìm kiếm staffId từ tên
            List<Staff> staffs = getDoctorsByName(staffDAO, staffName);
            
            // Lưu danh sách bác sĩ/y tá để hiển thị trên dropdown
            request.setAttribute("staffs", staffs);
            
            if (!staffs.isEmpty()) {
                // Gán registrations vào list rỗng trước
                registrations = scheduleDAO.getShiftRegistrations(null, fromDate, toDate, page, pageSize);
                totalRegistrations = scheduleDAO.countShiftRegistrations(null, fromDate, toDate);
                
                // Filter lại theo tên nhân viên (vì không có method search trực tiếp bằng tên)
                registrations = filterRegistrationsByStaffs(registrations, staffs);
                totalRegistrations = registrations.size(); // Đếm lại sau khi lọc
            } else {
                registrations = scheduleDAO.getShiftRegistrations(null, fromDate, toDate, page, pageSize);
                totalRegistrations = scheduleDAO.countShiftRegistrations(null, fromDate, toDate);
            }
        } else {
            registrations = scheduleDAO.getShiftRegistrations(staffId, fromDate, toDate, page, pageSize);
            totalRegistrations = scheduleDAO.countShiftRegistrations(staffId, fromDate, toDate);
        }
        
        // Lấy thông tin nhân viên cho mỗi đăng ký
        for (ShiftRegistration registration : registrations) {
            Staff staff = staffDAO.getStaffById(registration.getStaffId());
            if (staff != null) {
                // Lưu tên nhân viên vào attribute của registration để hiển thị trên JSP
                request.setAttribute("staffName_" + registration.getRegistrationId(), staff.getName());
            }
        }
        
        // Tính toán thông tin phân trang
        int totalPages = (int) Math.ceil((double) totalRegistrations / pageSize);
        
        // Set các thuộc tính để hiển thị trên JSP
        request.setAttribute("registrations", registrations);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRegistrations", totalRegistrations);
        request.setAttribute("staffName", staffName);
        request.setAttribute("fromDate", fromDate != null ? sdf.format(fromDate) : "");
        request.setAttribute("toDate", toDate != null ? sdf.format(toDate) : "");
        
        // Forward đến trang JSP
        request.getRequestDispatcher("AdministrativeStaff/shiftApproval.jsp").forward(request, response);
    }
    
    // Lọc danh sách đăng ký theo danh sách nhân viên
    private List<ShiftRegistration> filterRegistrationsByStaffs(List<ShiftRegistration> registrations, List<Staff> staffs) {
        registrations.removeIf(registration -> {
            boolean shouldKeep = false;
            for (Staff staff : staffs) {
                if (registration.getStaffId() == staff.getStaffId()) {
                    shouldKeep = true;
                    break;
                }
            }
            return !shouldKeep;
        });
        return registrations;
    }
    
    // Tìm kiếm bác sĩ/y tá theo tên (role 2 hoặc 3)
    private List<Staff> getDoctorsByName(StaffDAO staffDAO, String name) {
        return staffDAO.getStaffsByNameAndRoles(name, new int[]{2, 3});
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
        return "Servlet for managing shift registration approvals";
    }
}