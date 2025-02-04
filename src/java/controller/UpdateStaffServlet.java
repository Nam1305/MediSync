/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DoctorDAO;
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
        StaffDAO staff1 = new StaffDAO();
        // lấy dữ liệu từ trang jsp về 
        int staffId = Integer.parseInt(request.getParameter("staffId"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        // Xử lý ảnh đại diện (avatar)
        Staff existingStaff = staff1.getStaffByEmail(email);
        if (existingStaff == null) {
            request.setAttribute("error", "Staff not found!");
            request.getRequestDispatcher("ListDoctor").forward(request, response);
            return;
        }        
        // Giữ nguyên ảnh cũ của nhân viên
        String avatarPath = existingStaff.getAvatar();
        
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        String position = request.getParameter("position");
        String gender = request.getParameter("gender");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        
        if (isEmpty(name) || isEmpty(email)
                || isEmpty(phone) || isEmpty(password)
                || isEmpty(gender) || isEmpty(dateOfBirthStr)) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("ListDoctor").forward(request, response);
            return;
        }
        
        java.sql.Date dateOfBirth = java.sql.Date.valueOf(dateOfBirthStr);
        // Mã hóa mật khẩu 
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        // tạo đối tượng department mới 
        Department department = new Department();
        department.setDepartmentId(departmentId);
        // tạo đối tượng role mới 
        Role role = new Role();
        role.setRoleId(roleId);
        // khởi tạo biến update staff mới 
        Staff updateStaff = new Staff(staffId, name, email, avatarPath, phone, password, dateOfBirth, position, gender, status,description , department, role);
        DoctorDAO staff = new DoctorDAO();
        boolean isUpdate = staff.updateStaff(updateStaff);
        if (isUpdate) {
            response.sendRedirect("ListDoctor");
        } else {
            request.setAttribute("error", "Failed to update staff");
            request.getRequestDispatcher("ListDoctor").forward(request, response);
        }
        
    }

    private boolean checkPhone(String phone) {
        return phone.matches("^(09|08|03)\\d{7}$");
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
