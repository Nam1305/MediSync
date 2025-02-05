package controller;

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
import model.Customer;

@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/editCustomer"})
public class EditCustomerServlet extends HttpServlet {

    CustomerDAO customerDao = new CustomerDAO();

    private void handleEditCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //lấy tất cả thông tin về
        String customerIdStr = request.getParameter("customerId");
        String fullName = request.getParameter("full-name");
        String gender = request.getParameter("gender");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("number");
        String address = request.getParameter("address");
        String dateOfBirthString = request.getParameter("dob");
        
        // Kiểm tra null hoặc chuỗi rỗng
        if (customerIdStr == null || customerIdStr.trim().isEmpty()
                || fullName == null || fullName.trim().isEmpty()
                || gender == null || gender.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phoneNumber == null || phoneNumber.trim().isEmpty()
                || address == null || address.trim().isEmpty()
                || dateOfBirthString == null || dateOfBirthString.trim().isEmpty()) {
            response.sendRedirect("listCustomer?noti=fail");
            return;
        }
        
        //ep kieu cho customerId
        int customerId = Integer.parseInt(customerIdStr);     
        
        //ép kiểu cho dateOfBirth
        Date dateOfBirth = Date.valueOf(dateOfBirthString);
        //lấy customer dựa vào email, tạo customer
        Customer updatedCustomer = new Customer(customerId, fullName, email, address, dateOfBirth, gender, phoneNumber);
        //dùng CustomerDAO để cập nhật thông tin khách hàng trong cơ sở dữ liệu
        boolean isUpdated = customerDao.updateCustomer(updatedCustomer);
        //bắn status lên url để bên listCustomerServlet lấy và hiển thị ra 
        if (isUpdated) {
            response.sendRedirect("listCustomer?noti=success");
        } else {
            response.sendRedirect("listCustomer?noti=fail");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleEditCustomer(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
