
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


@WebServlet(name="ViewCustomerDetalServlet", urlPatterns={"/viewCustomerDetail"})
public class ViewCustomerDetailServlet extends HttpServlet {
    CustomerDAO customerDao = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String customerIdStr = request.getParameter("id");
        if(customerIdStr == null || customerIdStr.trim().isEmpty()){
            request.setAttribute("error", "Missing id of customer!");
        }
        int customerId = Integer.parseInt(customerIdStr);
        Customer customer = customerDao.getCustomerById(customerId);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("admin/customerDetail.jsp").forward(request, response);
            
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
