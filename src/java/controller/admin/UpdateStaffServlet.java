/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.DepartmentDAO;
import dal.DoctorDAO;
import dal.PositionDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Department;
import model.Role;
import model.Staff;

/**
 *
 * @author Acer
 */
@WebServlet(name = "UpdateStaffServlet", urlPatterns = {"/UpdateStaffServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
public class UpdateStaffServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String staffIdStr = request.getParameter("id");
        try {
            DepartmentDAO department = new DepartmentDAO();
            List<Department> listDepartment = department.getActiveDepartment();

            int staffId = Integer.parseInt(staffIdStr);
            DoctorDAO staff = new DoctorDAO();
            Staff currentstaff = staff.getStaffById(staffId);
            if (currentstaff != null) {
                request.setAttribute("listDepartment", listDepartment);
                // Nếu tìm thấy nhân viên, gửi thông tin đến trang update.jsp
                request.setAttribute("staff", currentstaff); // Đặt đối tượng Staff vào attribute
                request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy nhân viên , thông báo lỗi
                request.setAttribute("error", "Staff with ID " + staffId + " not found.");
                request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response); // Quay lại danh sách
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi nếu id không phải là số nguyên
            request.setAttribute("error", "Invalid ID format.");
            request.getRequestDispatcher("dmin/updateStaff.jsp").forward(request, response); // Quay lại danh sách
        } catch (Exception e) {
            // Xử lý các lỗi khác
            System.out.println(e);
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response); // Quay lại danh sách
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       DepartmentDAO departmentDao = new DepartmentDAO();
        DoctorDAO staffDao = new DoctorDAO();
        PositionDAO positionDao = new PositionDAO();
        List<String> errors = new ArrayList<>();

        // Lấy thông tin từ request
        String staffIdStr = request.getParameter("staffId");
        if (staffIdStr == null || staffIdStr.trim().isEmpty()) {
            errors.add("Không có ID nhân viên.");
        }
        int staffId = -1;
        try {
            staffId = Integer.parseInt(staffIdStr);
        } catch (NumberFormatException e) {
            errors.add("ID nhân viên không hợp lệ.");
        }

        Staff currentStaff = staffDao.getStaffById(staffId);
        if (currentStaff == null) {
            errors.add("Nhân viên không tồn tại.");
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String position = request.getParameter("position");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        
        // Kiểm tra điều kiện dữ liệu đầu vào
        if (isEmpty(name)) errors.add("Tên không thể rỗng!");
        if (isEmpty(email)) errors.add("Email không thể rỗng!");
        if (isEmpty(phone)) errors.add("Số điện thoại không thể rỗng!");
        if (isEmpty(gender)) errors.add("Giới tính không thể rỗng!");
        if (isEmpty(dateOfBirthStr)) errors.add("Ngày sinh không thể rỗng!");
        if (isEmpty(position)) errors.add("Vị trí làm việc không thể rỗng!");
        if (isEmpty(status)) errors.add("Trạng thái hoạt động không thể rỗng!");
        if (isEmpty(description)) errors.add("Mô tả không thể rỗng!");

        if (!checkPhone(phone)) {
            errors.add("Số điện thoại phải bắt đầu từ 08, 09 hoặc 03 và đủ 10 chữ số.");
        }

        java.sql.Date dateOfBirth = null;
        try {
            dateOfBirth = java.sql.Date.valueOf(dateOfBirthStr);
            if (dateOfBirth.toLocalDate().isAfter(LocalDate.now())) {
                errors.add("Ngày sinh không hợp lệ!");
            }
        } catch (Exception e) {
            errors.add("Định dạng ngày sinh không hợp lệ!");
        }

        if (staffDao.checkPhoneExistsCurrentStaff(phone, staffId)) {
            errors.add("Số điện thoại đã tồn tại!");
        }
        if (staffDao.checkEmailExistsCurrentStaff(email, staffId)) {
            errors.add("Email đã tồn tại!");
        }
        
        if (!errors.isEmpty()) {
            request.setAttribute("staff", currentStaff);
            request.setAttribute("listDepartment", departmentDao.getActiveDepartment());
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
            return;
        }
        
        Department department = new Department();
        department.setDepartmentId(departmentId);
        Role role = new Role();
        role.setRoleId(roleId);
        
        String hashedPassword = currentStaff.getPassword();
        Staff updatedStaff = new Staff(staffId, name, email, "", phone, hashedPassword, dateOfBirth, position, gender, status, description, department, role);
        boolean isUpdated = staffDao.updateStaff(updatedStaff);
        
        String currentPosition = positionDao.getPositionByStaffId(staffId);
        if (isUpdated && !updatedStaff.getPosition().equals(currentPosition)) {
            positionDao.insertPositionHistory(staffId, position);
        }
        
        if (isUpdated) {
            request.setAttribute("success", "cập nhật thành công");
            request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
        } else {
            errors.add("Cập nhật thất bại.");
            request.setAttribute("staff", currentStaff);
            request.setAttribute("listDepartment", departmentDao.getActiveDepartment());
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
        }
    }

    private boolean checkPhone(String phone) {
        return phone.matches("^(09|08|03)\\d{8}$");
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
