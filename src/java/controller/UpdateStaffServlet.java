/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DoctorDAO;
import dal.PositionDAO;
import dal.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import model.Department;
import model.Role;
import model.Staff;
import util.BCrypt;

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
                request.getRequestDispatcher("updateDish.jsp").forward(request, response); // Quay lại danh sách
            }
        }catch (NumberFormatException e) {
            // Xử lý lỗi nếu id không phải là số nguyên
            request.setAttribute("error", "Invalid ID format.");
            request.getRequestDispatcher("listDoctor").forward(request, response); // Quay lại danh sách
        } catch (Exception e) {
            // Xử lý các lỗi khác
            System.out.println(e);
            request.setAttribute("error", "An unexpected error occurred.");
            request.getRequestDispatcher("listDoctor").forward(request, response); // Quay lại danh sách
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
        // Lấy thông tin từ request
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String position = request.getParameter("position");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));

//        // Lấy staff hiện tại
//        StaffDAO staffDao = new StaffDAO();
//        Staff existingStaff = staffDao.getStaffByEmail(email);
//        if (existingStaff == null) {
//            request.setAttribute("error", "Staff not found!");
//            request.getRequestDispatcher("ListDoctor").forward(request, response);
//            return;
//        }
//        // Giữ nguyên avatar cũ
//        String avatarPath = existingStaff.getAvatar();
        // Lấy position hiện tại của nhân viên
        PositionDAO positionDao = new PositionDAO();
        String currentPosition = positionDao.getPositionByStaffId(staffId);

        // Kiểm tra điều kiện dữ liệu đầu vào
        if (isEmpty(name) || isEmpty(email) || isEmpty(phone) || isEmpty(password) || isEmpty(gender) || isEmpty(dateOfBirthStr)) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            return;
        }

        if (!checkPhone(phone)) {
            request.setAttribute("error", "Invalid phone number! It must start with 09, 08, or 03.");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            return;
        }

        if (!checkPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters and include uppercase, lowercase, special character.");
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
        //Mã hóa mật khẩu
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        // Tạo đối tượng Department và Role
        Department department = new Department();
        department.setDepartmentId(departmentId);

        Role role = new Role();
        role.setRoleId(roleId);
        DoctorDAO staff = new DoctorDAO();
        if (staff.checkPhoneExists(phone)) {
            request.setAttribute("error", "Phone number already exists!");
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
            request.setAttribute("error", "Failed to update staff");
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
        }
    }

    private boolean checkPhone(String phone) {
        return phone.matches("^(09|08|03)\\d{8}$");
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean checkPassword(String password) {
        // Kiểm tra ít nhất 8 ký tự, có chữ hoa, chữ thường, và ký tự đặc biệt (bất kỳ vị trí nào)
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8,}$";
        // ^                 : Bắt đầu chuỗi
        // (?=.*[a-z])       : Ít nhất một chữ cái thường (a-z)
        // (?=.*[A-Z])       : Ít nhất một chữ cái hoa (A-Z)
        // (?=.*[^a-zA-Z0-9]): Ít nhất một ký tự đặc biệt (không phải chữ hoặc số)
        // .{8,}             : Ít nhất 8 ký tự trở lên (bất kỳ ký tự nào)
        // $                 : Kết thúc chuỗi
        return password.matches(passwordPattern);
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
