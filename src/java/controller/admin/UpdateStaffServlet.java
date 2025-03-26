/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.CustomerDAO;
import dal.DepartmentDAO;
import dal.DoctorDAO;
import dal.PositionDAO;
import dal.RoleDAO;
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
        RoleDAO roleDao = new RoleDAO();
        List<Role> listRoles = roleDao.getAllRoles();
        String staffIdStr = request.getParameter("id");
        try {
            DepartmentDAO department = new DepartmentDAO();
            List<Department> listDepartment = department.getActiveDepartment();

            int staffId = Integer.parseInt(staffIdStr);
            DoctorDAO staff = new DoctorDAO();
            Staff currentstaff = staff.getStaffById(staffId);
            if (currentstaff != null) {
                request.setAttribute("listRoles", listRoles);
                request.setAttribute("listDepartment", listDepartment);
                // Nếu tìm thấy nhân viên, gửi thông tin đến trang update.jsp
                request.setAttribute("staff", currentstaff); // Đặt đối tượng Staff vào attribute
                request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
            } else {
                request.setAttribute("listRoles", listRoles);
                request.setAttribute("listDepartment", listDepartment);
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
        CustomerDAO customerDao = new CustomerDAO();
        DepartmentDAO departmentDao = new DepartmentDAO();
        List<Department> listDepartment = departmentDao.getActiveDepartment();
        DoctorDAO staffDao = new DoctorDAO();
        PositionDAO positionDao = new PositionDAO();
        RoleDAO roleDao = new RoleDAO();
        List<String> errors = new ArrayList<>();
        List<Role> listRoles = roleDao.getAllRoles(); // Lấy danh sách Role
        // Lấy thông tin từ request
        String staffIdStr = request.getParameter("staffId");
        int staffId = 0;
        if (staffIdStr != null && !staffIdStr.trim().isEmpty()) {
            staffId = Integer.parseInt(staffIdStr);
        } else {
            errors.add("Không có ID nhân viên.");
        }

        Staff currentStaff = staffDao.getStaffById(staffId);
        if (currentStaff == null) {
            errors.add("Nhân viên không tồn tại.");
        }
        String certificate = request.getParameter("certificate");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String position = request.getParameter("position");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        String roleIdStr = request.getParameter("roleId");

        int roleId = 0;
        if (roleIdStr != null && !roleIdStr.trim().isEmpty()) {
            roleId = Integer.parseInt(roleIdStr);
        } else {
            errors.add("Role không thể để trống!");
        }
        if (position == null || position.trim().isEmpty()) {
            errors.add("Vị trí làm việc không thể để trống!");
        }
        // Kiểm tra điều kiện dữ liệu đầu vào
        if (isEmpty(name)) {
            errors.add("Tên không thể rỗng!");
        }
        if (isEmpty(email)) {
            errors.add("Email không thể rỗng!");
        }
        if (isEmpty(phone)) {
            errors.add("Số điện thoại không thể rỗng!");
        }
        if (isEmpty(gender)) {
            errors.add("Giới tính không thể rỗng!");
        }
        if (isEmpty(dateOfBirthStr)) {
            errors.add("Ngày sinh không thể rỗng!");
        }
        if (isEmpty(position)) {
            errors.add("Vị trí làm việc không thể rỗng!");
        }
        if (isEmpty(status)) {
            errors.add("Trạng thái hoạt động không thể rỗng!");
        }
        if (isEmpty(description)) {
            errors.add("Mô tả không thể rỗng!");
        }

        if (!checkPhone(phone)) {
            errors.add("Số điện thoại phải bắt đầu từ 0 và đủ 10 chữ số.");
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
        if (customerDao.isPhoneExists(phone)) {
            errors.add("Số điện thoại đã tồn tại!");
        }
        if (staffDao.checkEmailExistsCurrentStaff(email, staffId)) {
            errors.add("Email đã tồn tại!");
        }
        if (customerDao.isEmailExists(email)) {
            errors.add("Email đã tồn tại!");
        }

        if (!errors.isEmpty()) {
            request.setAttribute("listRoles", listRoles);
            request.setAttribute("staff", currentStaff);
            request.setAttribute("listDepartment", listDepartment);
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
            return;
        }

        Department department = new Department();
        department.setDepartmentId(departmentId);
        Role role = new Role();
        role.setRoleId(roleId);

        String hashedPassword = currentStaff.getPassword();
        Staff updatedStaff = new Staff(staffId, name, email, "", phone, hashedPassword, dateOfBirth, position, gender, status, description, department, role, certificate);
        boolean isUpdated = staffDao.updateStaff(updatedStaff);

        String currentPosition = positionDao.getPositionByStaffId(staffId);
        if (isUpdated && !updatedStaff.getPosition().equals(currentPosition)) {
            positionDao.insertPositionHistory(staffId, position);
        }

        if (isUpdated) {
            request.setAttribute("staff", updatedStaff);
            request.setAttribute("listDepartment", listDepartment);
            request.setAttribute("listRoles", listRoles);
            request.setAttribute("success", "cập nhật thành công");
            request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
        } else {
            request.setAttribute("staff", updatedStaff);
            errors.add("Cập nhật thất bại.");
            request.setAttribute("listRoles", listRoles);

            request.setAttribute("listDepartment", listDepartment);
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("admin/updateStaff.jsp").forward(request, response);
        }
    }

    private boolean checkPhone(String phone) {
        if (phone == null) {
            return false; // Kiểm tra null trước
        }
        phone = phone.trim(); // Loại bỏ khoảng trắng đầu/cuối chuỗi
        return phone.matches("^0\\d{9}$"); // Kiểm tra định dạng
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
