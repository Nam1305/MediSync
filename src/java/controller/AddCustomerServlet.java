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

    private static final String UPLOAD_DIR = "uploads"; // Thư mục lưu avatar trên server

    private void handleAddCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy dữ liệu từ form
        String fullName = request.getParameter("full-name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("number");
        String dateOfBirthString = request.getParameter("date");
        String password = request.getParameter("password");

        Part imagePart = request.getPart("avatar");// Lấy file ảnh từ form
        // Xử lý null
        if (fullName == null || fullName.trim().isEmpty()
                || gender == null || gender.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phoneNumber == null || phoneNumber.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || dateOfBirthString == null || dateOfBirthString.trim().isEmpty()
                || imagePart == null || imagePart.getSize() == 0) {
            request.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
            return;
        }
        //check email đã tồn tại và đang active
        if (customerDao.isEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại!");
            request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
            return;
        }

        //số ĐT bắt đầu bằng 03/09 và có 10 số
        if (!phoneNumber.matches("^(09|03)\\d{8}$")) {
            request.setAttribute("error", "Số điện thoại phải bắt đầu bằng 09 hoặc 03 và có 10 số!");
            request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
            return;
        }

        //ép kiểu cho dateOfBirth
        Date dateOfBirth = Date.valueOf(dateOfBirthString);
        //kiểm tra ngày sinh không lớn hơn ngày hiện tại
        // Kiểm tra ngày sinh không lớn hơn ngày hiện tại
        if (dateOfBirth.toLocalDate().isAfter(LocalDate.now())) {
            request.setAttribute("error", "Ngày sinh không hợp lệ!");
            request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
            return;
        }
        
        // Kiểm tra mật khẩu
        //^(?=.*[a-z]): Có ít nhất một chữ cái thường.
        //(?=.*[A-Z]): Có ít nhất một chữ cái in hoa.
        //(?=.*\\d): Có ít nhất một chữ số.
        //(?=.*[^a-zA-Z0-9]): Có ít nhất một ký tự đặc biệt.
        //.{8,}$: Mật khẩu phải có ít nhất 8 ký tự.
        String passwordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}$";
        if (!password.matches(passwordPattern)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ cái in hoa, chữ cái thường, số và ký tự đặc biệt!");
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

        String imageFilename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
        if (!imageFilename.equals("")) {
            imagePart.write(Paths.get(uploadPath.toString(), imageFilename).toString());
        }

        Customer newCustomer = new Customer(fullName, email, hashedPassword, dateOfBirth, gender, phoneNumber);
        //add Customer
        customerDao.addCustomer(newCustomer, "/uploads/" + imageFilename);
        request.setAttribute("success", "Thêm thành công!");
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
