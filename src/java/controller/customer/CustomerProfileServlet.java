package controller.customer;

import dal.CustomerDAO;
import model.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.UUID;
import java.util.regex.Pattern;

@WebServlet(name = "CustomerProfileServlet", urlPatterns = {"/customer-profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 5, // 5MB buffer trước khi ghi vào đĩa
        maxFileSize = -1, // Không giới hạn kích thước file
        maxRequestSize = -1 // Không giới hạn kích thước request
)
public class CustomerProfileServlet extends HttpServlet {

    private final String AVATAR_UPLOAD_DIR = "assets/images/avatars/";

    private static final String EMAIL_REGEX
            = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";

    // Phone number validation regex pattern (10 digits)
    private static final String PHONE_REGEX = "^[0-9]{10}$";

    // Method to validate email format
    private boolean isValidEmail(String email) {
        return email != null && Pattern.matches(EMAIL_REGEX, email);
    }

    // Method to validate phone number (10 digits)
    private boolean isValidPhoneNumber(String phone) {
        return phone != null && Pattern.matches(PHONE_REGEX, phone);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check login session
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            // If not logged in, redirect to login page
            response.sendRedirect("login");
            return;
        }

        // Get the latest customer data from database
        CustomerDAO customerDAO = new CustomerDAO();
        Customer currentCustomer = customerDAO.getCustomerByEmail(customer.getEmail());

        if (currentCustomer == null) {
            // Customer not found in database
            session.invalidate(); // Invalidate session
            response.sendRedirect("login");
            return;
        }

        // Check if there's an avatar remove action
        String action = request.getParameter("action");
        if ("removeAvatar".equals(action)) {
            // Remove avatar file if it exists
            if (currentCustomer.getAvatar() != null && !currentCustomer.getAvatar().isEmpty()) {
                try {
                    String fullPath = getServletContext().getRealPath("") + currentCustomer.getAvatar();
                    File avatarFile = new File(fullPath);
                    if (avatarFile.exists()) {
                        avatarFile.delete();
                    }

                    // Update database
                    currentCustomer.setAvatar(null);
                    customerDAO.updateCustomer(currentCustomer);

                    // Update session
                    session.setAttribute("customer", currentCustomer);
                    request.setAttribute("successMessage", "Đã xóa ảnh đại diện");
                } catch (Exception e) {
                    request.setAttribute("errorMessage", "Xóa ảnh đại diện thất bại: " + e.getMessage());
                }
            }
        }

        // Set customer data to request attribute
        request.setAttribute("customer", currentCustomer);

        // Forward to profile JSP
        request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check login session
        HttpSession session = request.getSession();
        Customer sessionCustomer = (Customer) session.getAttribute("customer");

        if (sessionCustomer == null) {
            // If not logged in, redirect to login page
            response.sendRedirect("login");
            return;
        }

        // Get customer data from database to ensure we're updating the correct record
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByEmail(sessionCustomer.getEmail());

        if (customer == null) {
            // Customer not found in database
            session.invalidate(); // Invalidate session
            response.sendRedirect("login");
            return;
        }

        // Check if this is an avatar upload-only request
        String action = request.getParameter("action");
        if ("uploadAvatar".equals(action)) {
            handleAvatarUpload(request, response, customer, customerDAO);
            return;
        }

        // Regular profile update
        try {
            // Get form parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String bloodType = request.getParameter("bloodType"); // Add this line to get bloodType

            // Validate required fields
            if (name == null || name.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Hãy điền các trường tên, email và số điện thoại");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
                return;
            }

            // Validate email format
            if (!isValidEmail(email)) {
                request.setAttribute("errorMessage", "Lỗi format email");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
                return;
            }

            // Validate phone number (10 digits)
            if (!isValidPhoneNumber(phone)) {
                request.setAttribute("errorMessage", "Số điện thoại phải có 10 chữ số");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
                return;
            }

            // Check if email is changed and already exists
            if (!email.equals(customer.getEmail()) && customerDAO.isEmailExists(email)) {
                request.setAttribute("errorMessage", "Email đã được sử dụng bởi 1 tài khoản khác");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
                return;
            }

            // Check if phone is changed and already exists
            if (!phone.equals(customer.getPhone()) && customerDAO.isPhoneExists(phone)) {
                request.setAttribute("errorMessage", "Số điện thoại đã được sử dụng bởi 1 tài khoản khác");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
                return;
            }

            // Convert date string to SQL Date if provided
            Date dateOfBirth = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                try {
                    // Parse from dd/MM/yyyy to java.sql.Date (stored as yyyy-MM-dd)
                    SimpleDateFormat inputFormat = new SimpleDateFormat("dd/MM/yyyy");
                    java.util.Date parsed = inputFormat.parse(dateOfBirthStr);
                    dateOfBirth = new Date(parsed.getTime());
                } catch (ParseException e) {
                    try {
                        // Fallback for yyyy-MM-dd format (for existing data)
                        SimpleDateFormat fallbackFormat = new SimpleDateFormat("yyyy-MM-dd");
                        java.util.Date parsed = fallbackFormat.parse(dateOfBirthStr);
                        dateOfBirth = new Date(parsed.getTime());
                    } catch (ParseException ex) {
                        request.setAttribute("errorMessage", "Format ngày không hợp lệ. Xin hãy dùng dd/MM/yyyy");
                        request.setAttribute("customer", customer);
                        request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
                        return;
                    }
                }
            }

            // Update customer object with new data
            customer.setName(name);
            customer.setEmail(email);
            customer.setAddress(address);
            if (dateOfBirth != null) {
                customer.setDateOfBirth(dateOfBirth);
            }
            customer.setGender(gender);
            customer.setPhone(phone);
            customer.setBloodType(bloodType);

            // Update customer in database
            boolean updated = customerDAO.updateCustomer(customer);

            if (updated) {
                // Update session with new data
                session.setAttribute("customer", customer);
                request.setAttribute("successMessage", "Cập nhật hồ sơ thành công");
            } else {
                request.setAttribute("errorMessage", "Cập nhật hồ sơ thất bại");
            }

            // Set updated customer data and forward back to profile page
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any unexpected errors
            request.setAttribute("errorMessage", "Lỗi: " + e.getMessage());
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
        }
    }

    private void handleAvatarUpload(HttpServletRequest request, HttpServletResponse response,
            Customer customer, CustomerDAO customerDAO) throws ServletException, IOException {
        try {
            Part avatarPart = request.getPart("profileImage");
            if (avatarPart == null || avatarPart.getSize() <= 0) {
                request.setAttribute("errorMessage", "Không có file ảnh nào được chọn");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
                return;
            }

            // Generate unique filename based on content type
            String contentType = avatarPart.getContentType();
            String extension = contentType.contains("png") ? ".png" : ".jpg";
            String fileName = "avatar_" + customer.getCustomerId() + "_" + UUID.randomUUID().toString() + extension;

            // Get the real path for the upload directory
            String uploadPath = getServletContext().getRealPath("") + AVATAR_UPLOAD_DIR;

            // Create directory structure if it doesn't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean created = uploadDir.mkdirs();
                if (!created) {
                    throw new IOException("Failed to create directory: " + uploadPath);
                }
            }

            // Store the path of the old avatar to delete it later if update succeeds
            String oldAvatarPath = null;
            if (customer.getAvatar() != null && !customer.getAvatar().isEmpty()) {
                oldAvatarPath = getServletContext().getRealPath("") + customer.getAvatar();
            }

            // Ensure the file path ends with a separator if needed
            if (!uploadPath.endsWith(File.separator)) {
                uploadPath = uploadPath + File.separator;
            }

            // Save the new file
            avatarPart.write(uploadPath + fileName);

            // Update customer avatar path in object
            String avatarPath = AVATAR_UPLOAD_DIR + fileName;
            customer.setAvatar(avatarPath);

            // Update in database
            boolean updated = customerDAO.updateCustomer(customer);

            if (updated) {
                // Update succeeded, now safe to delete the old avatar
                if (oldAvatarPath != null) {
                    File oldAvatar = new File(oldAvatarPath);
                    if (oldAvatar.exists()) {
                        oldAvatar.delete();
                    }
                }

                // Update session
                request.getSession().setAttribute("customer", customer);
                request.setAttribute("successMessage", "Cập nhật ảnh đại diện thành công");
            } else {
                // Update failed, delete the newly uploaded file and revert avatar path
                File newAvatar = new File(uploadPath + fileName);
                if (newAvatar.exists()) {
                    newAvatar.delete();
                }

                // Restore old avatar path in customer object
                customer = customerDAO.getCustomerByEmail(customer.getEmail()); // Reload from DB to get original avatar

                request.setAttribute("errorMessage", "Cập nhật ảnh đại diện thất bại");
            }

            // Set updated customer data and forward back to profile page
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);

        } catch (Exception e) {
            // In case of error, reload customer from DB to ensure avatar path is still original
            customer = customerDAO.getCustomerByEmail(customer.getEmail());

            request.setAttribute("errorMessage", "Lỗi tải ảnh đại diện: " + e.getMessage());
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("customer/customer-profile.jsp").forward(request, response);
        }
        //System.out.println("Full avatar path: " + getServletContext().getRealPath("") + AVATAR_UPLOAD_DIR);
    }
}
