/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Customer;

/**
 *
 * @author Admin
 */
@WebServlet(name="ListCustomerServlet", urlPatterns={"/listCustomer"})
public class ListCustomerServlet extends HttpServlet {

    private void handleListCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Tạo đối tượng CustomerDAO và gọi phương thức getAllCustomers để lấy dữ liệu
        
        CustomerDAO customerDao = new CustomerDAO();
        List<Customer> customers = customerDao.getAllCustomer();

        // Đặt danh sách khách hàng vào thuộc tính của request
        request.setAttribute("customers", customers);
        //
         // Lấy tham số "status" từ URL
        String status = request.getParameter("status");
        if (status != null && !status.isEmpty()) {
            request.setAttribute("status", status);
        }
        // Chuyển hướng đến trang listCustomers.jsp để hiển thị dữ liệu
        request.getRequestDispatcher("listCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        handleListCustomers(request, response);
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
