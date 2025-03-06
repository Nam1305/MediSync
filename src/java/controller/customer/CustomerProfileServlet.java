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
                    request.setAttribute("successMessage", "Profile picture removed successfully");
                } catch (Exception e) {
                    request.setAttribute("errorMessage", "Failed to remove profile picture: " + e.getMessage());
                }
            }
        }

        // Set customer data to request attribute
        request.setAttribute("customer", currentCustomer);

        // Forward to profile JSP
        request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
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

            // Validate required fields
            if (name == null || name.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Name, email and phone are required fields");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
                return;
            }

            // Validate email format
            if (!isValidEmail(email)) {
                request.setAttribute("errorMessage", "Invalid email format");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
                return;
            }

            // Validate phone number (10 digits)
            if (!isValidPhoneNumber(phone)) {
                request.setAttribute("errorMessage", "Phone number must be 10 digits");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
                return;
            }

            // Check if email is changed and already exists
            if (!email.equals(customer.getEmail()) && customerDAO.isEmailExists(email)) {
                request.setAttribute("errorMessage", "Email address is already used by another account");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
                return;
            }

            // Check if phone is changed and already exists
            if (!phone.equals(customer.getPhone()) && customerDAO.isPhoneExists(phone)) {
                request.setAttribute("errorMessage", "Phone number is already used by another account");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
                return;
            }

            // Convert date string to SQL Date if provided
            Date dateOfBirth = null;
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                try {
                    // Parse from yyyy-MM-dd to java.sql.Date
                    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
                    java.util.Date parsed = inputFormat.parse(dateOfBirthStr);
                    dateOfBirth = new Date(parsed.getTime());
                } catch (ParseException e) {
                    request.setAttribute("errorMessage", "Invalid date format. Please use yyyy-MM-dd");
                    request.setAttribute("customer", customer);
                    request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
                    return;
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

            // Update customer in database
            boolean updated = customerDAO.updateCustomer(customer);

            if (updated) {
                // Update session with new data
                session.setAttribute("customer", customer);
                request.setAttribute("successMessage", "Profile updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile");
            }

            // Set updated customer data and forward back to profile page
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);

        } catch (Exception e) {
            // Handle any unexpected errors
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
        }
    }

    private void handleAvatarUpload(HttpServletRequest request, HttpServletResponse response,
            Customer customer, CustomerDAO customerDAO) throws ServletException, IOException {
        try {
            Part avatarPart = request.getPart("profileImage");
            if (avatarPart == null || avatarPart.getSize() <= 0) {
                request.setAttribute("errorMessage", "No image file selected");
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
                return;
            }

            // Remove old avatar if exists
            if (customer.getAvatar() != null && !customer.getAvatar().isEmpty()) {
                String fullPath = getServletContext().getRealPath("") + customer.getAvatar();
                File oldAvatar = new File(fullPath);
                if (oldAvatar.exists()) {
                    oldAvatar.delete();
                }
            }

            // Generate unique filename based on content type
            String contentType = avatarPart.getContentType();
            String extension = contentType.contains("png") ? ".png" : ".jpg";
            String fileName = "avatar_" + customer.getCustomerId() + "_" + UUID.randomUUID().toString() + extension;
            String uploadPath = getServletContext().getRealPath("") + AVATAR_UPLOAD_DIR;

            // Create directory if it doesn't exist
            Files.createDirectories(Paths.get(uploadPath));

            // Save the file
            avatarPart.write(uploadPath + fileName);

            // Update customer avatar path
            String avatarPath = AVATAR_UPLOAD_DIR + fileName;
            customer.setAvatar(avatarPath);

            // Update in database
            boolean updated = customerDAO.updateCustomer(customer);

            if (updated) {
                // Update session
                request.getSession().setAttribute("customer", customer);
                request.setAttribute("successMessage", "Profile picture updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile picture");
            }

            // Set updated customer data and forward back to profile page
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error uploading profile picture: " + e.getMessage());
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("patientsProfile.jsp").forward(request, response);
        }
    }
}
