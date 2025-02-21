/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.DepartmentDAO;
import dal.DoctorDAO;
import dal.PositionDAO;
import dal.StaffDAO;
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
            request.setAttribute("listDepartment", listDepartment);
            
            int staffId = Integer.parseInt(staffIdStr);
            DoctorDAO staff = new DoctorDAO();
            Staff currentstaff = staff.getStaffById(staffId);
            if (currentstaff != null) {
                // Nếu tìm thấy nhân viên, gửi thông tin đến trang update.jsp
                request.setAttribute("staff", currentstaff); // Đặt đối tượng Dish vào attribute
                request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            } else {
                // Nếu không tìm thấy nhân viên , thông báo lỗi
                request.setAttribute("error", "Dish with ID " + staffId + " not found.");
                request.getRequestDispatcher("updateStaff.jsp").forward(request, response); // Quay lại danh sách
            }
        } catch (NumberFormatException e) {
            // Xử lý lỗi nếu id không phải là số nguyên
            request.setAttribute("error", "Invalid ID format.");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response); // Quay lại danh sách
        } catch (Exception e) {
            // Xử lý các lỗi khác
            System.out.println(e);
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response); // Quay lại danh sách
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
        List<String> error = new ArrayList<>();
        // Lấy thông tin từ request
        String staffIdStr = request.getParameter("staffId");
        if (staffIdStr == null || staffIdStr.trim().isEmpty()) {
            error.add("không có id ");
        }
        int staffId = Integer.parseInt(staffIdStr); // Chuyển đổi sang số nguyên
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

        PositionDAO positionDao = new PositionDAO();
        String currentPosition = positionDao.getPositionByStaffId(staffId);

        // Kiểm tra điều kiện dữ liệu đầu vào
        if (isEmpty(name)) {
            error.add("tên không thể rỗng!");
        }
        if (isEmpty(email)) {
            error.add("email không thể rỗng !");
        }
        if (isEmpty(phone)) {
            error.add("số điện thoại không thể rỗng!");
        }

        if (isEmpty(gender)) {
            error.add("giói tính không thể rỗng!");
        }
        if (isEmpty(dateOfBirthStr)) {
            error.add("ngày sinh không thể rỗng!");
        }
        if (isEmpty(position)) {
            error.add("vị trí là việc không thể rỗng!");
        }
        if (isEmpty(status)) {
            error.add("trạng thái hoạt động không thể rỗng!");
        }
        if (isEmpty(description)) {
            error.add("mô tả không thể rỗng!");
        }

        // Nếu có lỗi, gửi lại danh sách lỗi
        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            return;
        }

        if (!checkPhone(phone)) {
            request.setAttribute("error", "số điện thoại phải bắt đầu từ 08/09/03 và phải đủ 10 chữ số");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            return;
        }

        // ép kiểu cho dob
        java.sql.Date dateOfBirth = java.sql.Date.valueOf(dateOfBirthStr);
        if (dateOfBirth.toLocalDate().isAfter(LocalDate.now())) {
            request.setAttribute("error", "Ngày sinh không hợp lệ!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }

        // Tạo đối tượng Department và Role
        Department department = new Department();
        department.setDepartmentId(departmentId);

        Role role = new Role();
        role.setRoleId(roleId);
        DoctorDAO staff = new DoctorDAO();
        Staff currentstaff = staff.getStaffById(staffId);
//        String hashedPassword = BCrypt.hashpw(currentstaff.getPassword(), BCrypt.gensalt());
        String hashedPassword = currentstaff.getPassword();
        if (staff.checkPhoneExistsCurrentStaff(phone, staffId)) {
            request.setAttribute("error", "số điện thoại đã tồn tại !");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            return;
        }
        if (staff.checkEmailExistsCurrentStaff(email, staffId)) {
            request.setAttribute("error", "email đã tồn tại!");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            return;
        }
        // Cập nhật thông tin nhân viên
        Staff updateStaff = new Staff(staffId, name, email, "", phone, hashedPassword, dateOfBirth, position, gender, status, description, department, role);
        boolean isUpdate = staff.updateStaff(updateStaff);

        // Nếu cập nhật thành công và position thay đổi, lưu vào HistoryPosition
        if (isUpdate && !updateStaff.getPosition().equals(currentPosition)) {
            positionDao.insertPositionHistory(staffId, position);
        }

        if (isUpdate) {
            response.sendRedirect("ListDoctor");
        } else {
            request.setAttribute("error", "cập nhật thất bại");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
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
