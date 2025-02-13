package controller.admin;

import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;


@WebServlet(name="DeleteCustomerServlet", urlPatterns={"/deleteCustomer"})
public class DeleteCustomerServlet extends HttpServlet {

    private void handleDeleteCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerIdStr = request.getParameter("id");
        if(customerIdStr == null || customerIdStr.trim().isEmpty()){
            response.sendRedirect("listCustomer?noti=failDelete");
            return;
        }
        int customerId = Integer.parseInt(customerIdStr);
        Customer deletedCustomer = new Customer(customerId);
        CustomerDAO customerDao = new CustomerDAO();
        boolean isDeleted = customerDao.deleteCustomer(deletedCustomer);
        if(isDeleted == true){
            response.sendRedirect("listCustomer?noti=successDelete");
        } else{
            response.sendRedirect("listCustomer?noti=failDelete");
        }     
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        handleDeleteCustomer(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    

}
