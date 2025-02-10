package controller;

import dal.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import model.Customer;
import util.BCrypt;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)

@WebServlet(name = "AddCustomerServlet", urlPatterns = {"/addCustomer"})
public class AddCustomerServlet extends HttpServlet {

    CustomerDAO customerDao = new CustomerDAO();
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
    private static final String PHONE_REGEX = "^(09|03)\\d{8}$";
    private static final String PASSWORD_REGEX = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}$";
    private static final String IMAGE_REGEX = ".*\\.(png|jpg|jpeg)$";

    private void handleAddCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        // Lấy dữ liệu từ form
        String fullName = request.getParameter("full-name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("number");
        String dateOfBirthString = request.getParameter("date");
        String password = request.getParameter("password");
        Part imagePart = request.getPart("avatar");// Lấy file ảnh từ form
        String confirmPassWord = request.getParameter("confirmPassword");

        //Customer customer = new Customer(fullName,);
        // Kiểm tra dữ liệu nhập
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Vui lòng nhập đầy đủ họ tên!");
        }

        if (gender == null || gender.trim().isEmpty()) {
            errors.add("Vui lòng chọn giới tính!");
        }

        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            errors.add("Vui lòng điền Số điện thoại!");
        } else if (!phoneNumber.matches(PHONE_REGEX)) {
            errors.add("Số điện thoại phải bắt đầu bằng 09 hoặc 03 và có 10 số!");
        } else if (customerDao.isPhoneExists(phoneNumber)) {
            errors.add("Số điện thoại đã tồn tại!");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Vui lòng nhập mật khẩu!");
        } else if (!password.matches(PASSWORD_REGEX)) {
            errors.add("Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ cái in hoa, chữ cái thường, số và ký tự đặc biệt!");
        }

        if (confirmPassWord == null || confirmPassWord.trim().isEmpty()) {
            errors.add("Vui lòng nhập xác nhận mật khẩu!");
        } else if (!password.equals(confirmPassWord)) {
            errors.add("Xác nhận mật khẩu không trùng khớp với mật khẩu đã nhập!");
        }

        Date dateOfBirth = null;
        if (dateOfBirthString == null || dateOfBirthString.trim().isEmpty()) {
            errors.add("Vui lòng chọn ngày tháng năm sinh!");
        } else {
            dateOfBirth = Date.valueOf(dateOfBirthString);
            if (dateOfBirth.toLocalDate().isAfter(LocalDate.now())) {
                errors.add("Ngày sinh không hợp lệ!");
            }
        }

        String imageFilename = null;
        if (imagePart == null || imagePart.getSize() == 0) {
            errors.add("Vui lòng chọn ảnh đại diện!");
        } else {
            imageFilename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            if (!imageFilename.matches(IMAGE_REGEX)) {
                errors.add("Ảnh đại diện phải có định dạng .png, .jpg hoặc .jpeg!");
            }
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Vui lòng nhập email!");
        } else if (!Pattern.matches(EMAIL_REGEX, email)) {
            errors.add("Email không hợp lệ!");
        } else if (customerDao.isEmailExists(email)) {
            errors.add("Email đã tồn tại!");
        }

        // Nếu có lỗi, quay lại trang addCustomer.jsp với danh sách lỗi và dữ liệu đã nhập
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("fullName", fullName);
            request.setAttribute("gender", gender);
            request.setAttribute("email", email);
            request.setAttribute("phoneNumber", phoneNumber);
            request.setAttribute("dateOfBirth", dateOfBirthString);
            request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
            return;
        }

        //mã hóa password bằng hàm Bcrypt()
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        //lấy đường dẫn thư mục trên máy chủ (server)
        String uploadFolder = request.getServletContext().getRealPath("/uploads");
        Path uploadPath = Paths.get(uploadFolder);
        if (!Files.exists(uploadPath)) {
            Files.createDirectory(uploadPath);
        }

//         imageFilename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        if (!imageFilename.equals("")) {
            imagePart.write(Paths.get(uploadPath.toString(), imageFilename).toString());
        }

        Customer newCustomer = new Customer(fullName.trim(), email.trim(), hashedPassword, dateOfBirth, gender, phoneNumber.trim());
        //add Customer
        customerDao.addCustomer(newCustomer, "/uploads/" + imageFilename);
        request.setAttribute("success", "Thêm thành công!");
        request.setAttribute("fullName", fullName);
        request.setAttribute("gender", gender);
        request.setAttribute("email", email);
        request.setAttribute("phoneNumber", phoneNumber);
        request.setAttribute("dateOfBirth", dateOfBirthString);
        request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        handleAddCustomer(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
