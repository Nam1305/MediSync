/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DoctorDAO;
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
import java.util.Date;
import model.Department;
import model.Role;
import model.Staff;
import util.BCrypt;

/**
 *
 * @author Acer
 */
@WebServlet(name = "AddStaffServlet", urlPatterns = {"/AddStaffServlet"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddStaffServlet extends HttpServlet {

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
//        processRequest(request, response);
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
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Tạo thư mục nếu chưa tồn tại
        }

        Part filePart = request.getPart("avatar");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            request.setAttribute("error", "Only image files are allowed.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        // Nếu không có file được chọn, đặt ảnh mặc định
        if (fileName == null || fileName.trim().isEmpty()) {
            fileName = "default-avatar.png";
        } else {
            // Tránh trùng tên file bằng cách thêm timestamp
            fileName = System.currentTimeMillis() + "_" + fileName;
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath); // Lưu file vào thư mục
        }

        // Đường dẫn ảnh lưu vào database
        String avatarPath = request.getContextPath() + "/uploads/" + fileName;
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String position = request.getParameter("position");
        String description = request.getParameter("description");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));

        if (isEmpty(name) || isEmpty(email)
                || isEmpty(phone) || isEmpty(password)
                || isEmpty(gender) || isEmpty(dateOfBirthStr)) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }

        if (!checkPhone(phone)) {
            request.setAttribute("error", "Invalid phone number! It must start with 09, 08, or 03.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        if (!checkPassword(password)) {
            request.setAttribute("error", "Password must be at least 8 characters and include uppercase, lowercase, special character.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        //ép kiểu cho dateOfBirth
        java.sql.Date dateOfBirth = java.sql.Date.valueOf(dateOfBirthStr);
        if (dateOfBirth.toLocalDate().isAfter(LocalDate.now())) {
            request.setAttribute("error", "Ngày sinh không hợp lệ!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        //mã hóa password bằng hàm Bcrypt()
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        DoctorDAO staff = new DoctorDAO();
        if (staff.checkPhoneExists(phone)) {
            request.setAttribute("error", "Phone number already exists!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        // // Khởi tạo đối tượng Department
        Department department = new Department();
        department.setDepartmentId(departmentId);
        Role role = new Role();
        role.setRoleId(roleId);
        if (staff.checkEmail(email)) {
            request.setAttribute("error", "Email exists!");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        Staff newStaff = new Staff(0, name, email, avatarPath, phone, hashedPassword, dateOfBirth, position, gender, "Active", description, department, role);

        boolean isAdded = staff.addStaff(newStaff);

        if (isAdded) {
            response.sendRedirect("ListDoctor");
        } else {
            request.setAttribute("error", " Please try again.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean checkPhone(String phone) {
        return phone.matches("^(09|08|03)\\d{8}$");
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
