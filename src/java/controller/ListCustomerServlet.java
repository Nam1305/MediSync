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

@WebServlet(name = "ListCustomerServlet", urlPatterns = {"/listCustomer"})
public class ListCustomerServlet extends HttpServlet {

    private void handleListCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Tạo đối tượng CustomerDAO và gọi phương thức getAllCustomers để lấy dữ liệu
        CustomerDAO customerDao = new CustomerDAO();
        //lấy tham số từ url status và gender
        String status = request.getParameter("status");//trạng thái tài khoản
        String gender = request.getParameter("gender");//gioi tinh

        //paging
        int pageSize = 10;  // Số khách hàng mỗi trang
        int currentPage = 1;  // Trang mặc định là trang 1
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu lỗi, đặt mặc định là 1
            }
        }

        List<Customer> customers;

        // Kiểm tra xem có lọc theo trạng thái và giới tính không
        if (status != null && !status.isEmpty() && gender != null && !gender.isEmpty()) {
            // Nếu cả trạng thái và giới tính đều có, lọc theo cả hai
            customers = customerDao.getFilteredCustomers(status, gender, currentPage, pageSize);
        } else if (status != null && !status.isEmpty()) {
            // Nếu chỉ có trạng thái, lọc theo trạng thái
            customers = customerDao.getCustomersByStatus(status, currentPage, pageSize);
        } else if (gender != null && !gender.isEmpty()) {
            // Nếu chỉ có giới tính, lọc theo giới tính
            customers = customerDao.getCustomersByGender(gender, currentPage, pageSize);
        } else {
            // Nếu không có lọc, lấy tất cả khách hàng
            customers = customerDao.getCustomerByPage(currentPage, pageSize);
        }

        // Tính toán số lượng trang
        int totalCustomers = customerDao.getTotalCustomer();
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

        // Đặt danh sách khách hàng vào thuộc tính của request
        request.setAttribute("customers", customers);

        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCustomers", totalCustomers);
        // Đặt trạng thái và giới tính vào thuộc tính của request (để hiển thị trên giao diện nếu cần)
        request.setAttribute("status", status);
        request.setAttribute("gender", gender);

        request.getRequestDispatcher("listCustomer.jsp").forward(request, response);
    }

    private void handleSearchCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("s");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            CustomerDAO customerDao = new CustomerDAO();
            List<Customer> customers = customerDao.searchCustomers(searchQuery);
            // Đặt kết quả tìm kiếm vào thuộc tính của request
            request.setAttribute("customers", customers);
            request.getRequestDispatcher("listCustomer.jsp").forward(request, response);
        } else {
            // Nếu không có giá trị tìm kiếm, hiển thị tất cả khách hàng
            handleListCustomers(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleListCustomers(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra xem có phải yêu cầu tìm kiếm không
        String action = request.getParameter("action");
        if ("search".equalsIgnoreCase(action)) {
            handleSearchCustomers(request, response);  // Gọi phương thức tìm kiếm
        } else {
            handleListCustomers(request, response);  // Nếu không thì hiển thị tất cả
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
