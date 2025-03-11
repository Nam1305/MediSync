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
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.Department;
import model.Role;
import model.Staff;
import util.BCrypt;
import util.GeneratePassword;
import util.SendEmail;

/**
 *
 * @author Acer
 */
@WebServlet(name = "AddStaffServlet", urlPatterns = {"/AddStaffServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 30, // 30MB
        maxRequestSize = 1024 * 1024 * 100 // 100MB
)

public class AddStaffServlet extends HttpServlet {

    private static final String IMAGE_REGEX = ".*\\.(png|jpg|jpeg)$";

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
        DepartmentDAO department = new DepartmentDAO();
        List<Department> listDepartment = department.getActiveDepartment();
        request.setAttribute("listDepartment", listDepartment);
        request.getRequestDispatcher("admin/addStaff.jsp").forward(request, response);

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
        List<Department> listDepartment = departmentDao.getActiveDepartment();
        List<String> error = new ArrayList<>();
        GeneratePassword generatePassword = new GeneratePassword();
        String certificate = request.getParameter("certificate");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String position = request.getParameter("position");
        String description = request.getParameter("description");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        if(isEmpty(certificate)){
            error.add("Bằng cấp không được để trống!");
        }
        if (isEmpty(name)) {
            error.add("Tên không được để trống!");
        }
        if (isEmpty(email)) {
            error.add("Email không được để trống!");
        }
        if (isEmpty(phone)) {
            error.add("Số điện thoại không được để trống!");
        }
        if (isEmpty(gender)) {
            error.add("Giới tính không được để trống!");
        }
        if (isEmpty(dateOfBirthStr)) {
            error.add("Ngày sinh không được để trống!");
        }
        if (isEmpty(position)) {
            error.add("Vị trí làm việc không được để trống!");
        }
        if (isEmpty(description)) {
            error.add("Mô tả không được để trống!");
        }

        DoctorDAO staffDao = new DoctorDAO();
        if (staffDao.checkPhoneExists(phone)) {
            error.add("Số điện thoại đã tồn tại!");
        }
        if (staffDao.checkEmail(email)) {
            error.add("Email đã tồn tại!");
        }
        if (!checkPhone(phone)) {
            error.add("Số điện thoại không hợp lệ (bắt đầu bằng 09, 08, hoặc 03 và có 10 chữ số)!");
        }

        java.sql.Date dateOfBirth = java.sql.Date.valueOf(dateOfBirthStr);
        if (dateOfBirth.toLocalDate().isAfter(LocalDate.now())) {
            error.add("Ngày sinh không hợp lệ!");
        }

        Part filePart = request.getPart("avatar");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!fileName.isEmpty()) {
            if (filePart.getSize() > 3 * 1024 * 1024) {
                error.add("Ảnh phải nhỏ hơn 3MB!");
            }
            String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
            List<String> allowedExtensions = Arrays.asList("png", "jpg", "jpeg");
            if (!allowedExtensions.contains(fileExtension)) {
                error.add("Chỉ được chọn file có đuôi png, jpg, jpeg!");
            }
        } else {
            fileName = "default-avatar.png";
        }

        if (!error.isEmpty()) {
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("description", description);
            request.setAttribute("listDepartment", listDepartment);
            request.setAttribute("error", error);
            request.getRequestDispatcher("admin/addStaff.jsp").forward(request, response);
            return;
        }

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        fileName = System.currentTimeMillis() + "_" + fileName;
        filePart.write(uploadPath + File.separator + fileName);
        String avatarPath = request.getContextPath() + "/uploads/" + fileName;

        String password = generatePassword.generateRandomPassword(8);
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Department department = new Department();
        department.setDepartmentId(departmentId);
        Role role = new Role();
        role.setRoleId(roleId);

        Staff newStaff = new Staff(0, name, email, avatarPath, phone, hashedPassword, dateOfBirth, position, gender, "Active", description, department, role,certificate);
        int staffId = staffDao.addStaff(newStaff);
        PositionDAO positionDao = new PositionDAO();

        if (staffId > 0) {
            positionDao.insertPositionHistory(staffId, position);
            request.setAttribute("success", "Thêm nhân viên thành công");
            request.getRequestDispatcher("admin/addStaff.jsp").forward(request, response);
            new SendEmail().sendPasswordForStaff(email, password);
        } else {
            request.setAttribute("listDepartment", listDepartment);
            error.add("Có lỗi xảy ra, vui lòng thử lại!");
            request.setAttribute("error", error);
            request.getRequestDispatcher("admin/addStaff.jsp").forward(request, response);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean checkPhone(String phone) {
        return phone.matches("^(09|08|03)\\d{8}$");
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
