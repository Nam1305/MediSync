package controller;

import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;

@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/editCustomer"})
public class EditCustomerServlet extends HttpServlet {

    private void handleEditCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //lấy tất cả thông tin về
        String customerIdStr = request.getParameter("customerId");        
        String firstName = request.getParameter("first-name");
        String lastName = request.getParameter("last-name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("number");
        //kiểm tra null
        if (customerIdStr == null || customerIdStr.trim().isEmpty() ||
                firstName == null || firstName.trim().isEmpty()
                || lastName == null || lastName.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || phoneNumber == null || phoneNumber.trim().isEmpty()) {
            response.sendRedirect("listCustomer?status=fail");
            return;
        }
        
        //ep kieu cho customerId
        int customerId = Integer.parseInt(customerIdStr);
        
        //ghép fullName
        String fullName = lastName + " " + firstName;
        //lấy customer dựa vào email, tạo customer
        CustomerDAO customerDao = new CustomerDAO();
        Customer updatedCustomer = new Customer(customerId, fullName, email, phoneNumber);
        //dùng CustomerDAO để cập nhật thông tin khách hàng trong cơ sở dữ liệu
        boolean isUpdated = customerDao.updateCustomer(updatedCustomer);
        //bắn status lên url để bên listCustomerServlet lấy và hiển thị ra 
        if (isUpdated) {
            response.sendRedirect("listCustomer?status=success");
        } else {
            response.sendRedirect("listCustomer?status=fail");
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
