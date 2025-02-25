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
        request.getRequestDispatcher("addStaff.jsp").forward(request, response);

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
        GeneratePassword generatePassword = new GeneratePassword();
        // lấy dữ liệu từ request 
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Tạo thư mục nếu chưa tồn tại
        }

        Part filePart = request.getPart("avatar");
        long fileSize = filePart.getSize();
        if (fileSize > 3 * 1024 * 1024) { // 3MB = 3 * 1024 * 1024 bytes
            request.setAttribute("error", "File size must be less than 3MB.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String contentType = filePart.getContentType();
        // Danh sách đuôi file hợp lệ
        List<String> allowedExtensions = Arrays.asList("png", "jpg", "jpeg");

        if (contentType == null || !contentType.startsWith("image/")) {
            request.setAttribute("error", "Only image files are allowed.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
            return;
        }
        // Kiểm tra đuôi file (đảm bảo không bị giả mạo MIME type)
        String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        if (!allowedExtensions.contains(fileExtension)) {
            request.setAttribute("error", "Invalid file format. Only PNG, JPG, and JPEG are allowed.");
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
        String password = generatePassword.generateRandomPassword(8);
        String gender = request.getParameter("gender");
        String position = request.getParameter("position");
        String description = request.getParameter("description");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));

        // Kiểm tra điều kiện dữ liệu đầu vào
        if (isEmpty(name)) {
            error.add("Name must not null!");
        }
        if (isEmpty(email)) {
            error.add("Email must not null !");
        }
        if (isEmpty(phone)) {
            error.add("Phone must not null!");
        }

        if (isEmpty(gender)) {
            error.add("Gender must not null!");
        }
        if (isEmpty(dateOfBirthStr)) {
            error.add("Date of birth must not null!");
        }
        if (isEmpty(position)) {
            error.add("position must not null!");
        }

        if (isEmpty(description)) {
            error.add("description must not null!");
        }

        // Nếu có lỗi, gửi lại danh sách lỗi
        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
            return;
        }

        if (!checkPhone(phone)) {
            request.setAttribute("error", "Invalid phone number! It must start with 09, 08, or 03.");
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

        int staffId = staff.addStaff(newStaff);
        PositionDAO positiondao = new PositionDAO();
        if (staffId > 0) {
            positiondao.insertPositionHistory(staffId, position);
            response.sendRedirect("ListDoctor");
            SendEmail sendPassword = new SendEmail();
            sendPassword.sendPasswordForStaff(email, password);
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
