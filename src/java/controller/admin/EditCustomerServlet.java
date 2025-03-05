package controller.admin;

import com.google.gson.JsonObject;
import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import model.Customer;

@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/editCustomer"})
public class EditCustomerServlet extends HttpServlet {

    CustomerDAO customerDao = new CustomerDAO();

    // Regex kiểm tra email hợp lệ
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";

    // Regex kiểm tra số điện thoại hợp lệ (bắt đầu bằng 03 hoặc 09 và có 10 chữ số)
    private static final String PHONE_REGEX = "^(03|09)\\d{8}$";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ID từ request
        String customerIdStr = request.getParameter("id");
        if (customerIdStr == null || customerIdStr.trim().isEmpty()) {
            response.sendRedirect("listCustomer?error=missingId");
            return;
        }

        try {
            int customerId = Integer.parseInt(customerIdStr);
            Customer customer = customerDao.getCustomerById(customerId);
            if (customer == null) {
                response.sendRedirect("listCustomer?error=notFound");
                return;
            }

            // Gửi dữ liệu khách hàng sang editCustomer.jsp
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("admin/editCustomer.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("listCustomer?error=invalidId");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Xử lý cập nhật thông tin khách hàng
        
        String customerIdStr = request.getParameter("id");
        String fullName = request.getParameter("full-name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phone = request.getParameter("number");
        String address = request.getParameter("address");
        String dobStr = request.getParameter("dob");
        String avatar = request.getParameter("avatar");

        int customerId = Integer.parseInt(customerIdStr);
        List<String> errors = new ArrayList<>(); // Danh sách lưu lỗi

        // Kiểm tra lỗi
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Vui lòng nhập Họ và Tên!");
        }
        if (gender == null || gender.trim().isEmpty()) {
            errors.add("Vui lòng chọn Giới tính!");
        }
        if (email == null || email.trim().isEmpty()) {
            errors.add("Vui lòng nhập Email!");
        } else if (!Pattern.matches(EMAIL_REGEX, email)) {
            errors.add("Email không hợp lệ!");
        }
        if (phone == null || phone.trim().isEmpty()) {
            errors.add("Vui lòng nhập Số điện thoại!");
        } else if (!Pattern.matches(PHONE_REGEX, phone.trim())) {
            errors.add("Số điện thoại không hợp lệ! (Phải bắt đầu bằng 03 hoặc 09 và có 10 chữ số)");
        }
        if (address == null || address.trim().isEmpty()) {
            errors.add("Vui lòng nhập Địa chỉ!");
        }
        if (dobStr == null || dobStr.trim().isEmpty()) {
            errors.add("Vui lòng nhập Ngày sinh!");
        }
        if (customerDao.checkEmailOtherCustomer(email, customerId)) {
            errors.add("Email đã tồn tại!");
        }
        if (customerDao.checkPhoneOtherCustomer(phone, customerId)) {
            errors.add("Số điện thoại đã tồn tại!");
        }
        Date dob = null;
        try {
             dob = Date.valueOf(dobStr);
            LocalDate today = LocalDate.now();
            if (dob.toLocalDate().isAfter(today)) {
                errors.add("Ngày sinh không hợp lệ! (Không thể lớn hơn ngày hiện tại)");
            }
        } catch (IllegalArgumentException e) {
            errors.add("Định dạng ngày không hợp lệ!");
        }

        // Nếu có lỗi, gửi lại danh sách lỗi về JSP
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);

            Customer customer = new Customer(customerId, fullName, avatar, email, address, dob, gender, phone);
            request.setAttribute("customer", customer);

            request.getRequestDispatcher("admin/editCustomer.jsp").forward(request, response);
            return;
        }

        // Nếu không có lỗi, thực hiện cập nhật
        Customer updatedCustomer = new Customer(customerId, fullName.trim(), avatar, email.trim(), address.trim(), dob, gender, phone.trim());
        boolean success = customerDao.updateCustomer(updatedCustomer);

        if (success) {
            request.setAttribute("message", "Cập nhật thành công!");
        } else {
            request.setAttribute("message", "Cập nhật thất bại, vui lòng thử lại!");
        }

        updatedCustomer = customerDao.getCustomerById(customerId);
        request.setAttribute("customer", updatedCustomer);
        request.getRequestDispatcher("admin/editCustomer.jsp").forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
