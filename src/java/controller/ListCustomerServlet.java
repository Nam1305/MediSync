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
        String pageSizeParam = request.getParameter("pageSize");//số lượng customer muốn lọc ra
        //tính tổng số customer
        int totalCustomers = customerDao.getTotalCustomer();
        //PAGING
        int pageSize = 10;  // Số khách hàng mỗi trang
        if (pageSizeParam != null && !pageSizeParam.trim().isEmpty()) {
            try {
                int parsedPageSize = Integer.parseInt(pageSizeParam);
                if (parsedPageSize >= 1 && parsedPageSize <= totalCustomers) { // Giới hạn hợp lệ từ 1 đến 100
                    pageSize = parsedPageSize;
                }
            } catch (NumberFormatException e) {
                pageSize = 10; // Nếu lỗi, đặt về mặc định
            }
        }
        int currentPage = 1;  // Trang mặc định là trang 1
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1; // Nếu lỗi, đặt mặc định là 1
            }
        }
        
        // Tính toán số lượng trang
        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

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

    private String normalizeSearchQuery(String query) {
        return query.trim().replaceAll("\\s+", " "); // Loại bỏ khoảng trắng dư thừa
    }

    private void handleSearchCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("s");
        String searchQueryNormalized = normalizeSearchQuery(searchQuery);
        if (searchQueryNormalized != null && !searchQueryNormalized.trim().isEmpty()) {
            CustomerDAO customerDao = new CustomerDAO();
            List<Customer> customers = customerDao.searchCustomers(searchQueryNormalized);
            // Đặt kết quả tìm kiếm vào thuộc tính của request
            request.setAttribute("customers", customers);
            request.setAttribute("searchQuery", searchQuery);
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
