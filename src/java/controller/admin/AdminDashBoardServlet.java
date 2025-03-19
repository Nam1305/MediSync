/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.AppointmentDAO;
import dal.CustomerDAO;
import dal.DepartmentDAO;
import dal.DoctorDAO;
import dal.InvoiceDAO;
import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import model.Staff;

/**
 *
 * @author Acer
 */
@WebServlet(name = "AdminDashBoardServlet", urlPatterns = {"/AdminDashBoard"})
public class AdminDashBoardServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminDashBoardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashBoardServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DoctorDAO staffDao = new DoctorDAO();
        CustomerDAO customerDao = new CustomerDAO();
        InvoiceDAO invoiceDao = new InvoiceDAO();
        DepartmentDAO departmentDao = new DepartmentDAO();
        AppointmentDAO appointmentDao = new AppointmentDAO();
        ServiceDAO serviceDao = new ServiceDAO();

        // Thống kê tổng hợp
        Map<String, Integer> staffByRole = departmentDao.countStaffByRole();
        double totalRevenue = invoiceDao.calculateTotalRevenue();
        int customerCount = customerDao.countCustomers();
        int totalAppointments = appointmentDao.getTotalAppointments();
        int totalService = serviceDao.getTotalServices();
        List<String> topServices = serviceDao.getTop4MostUsedServices();
        Map<Staff, Double> topStaffList = staffDao.getTop3HighestRatedStaff();

        // Lấy tham số từ request
        String selectedYear = request.getParameter("year");
        String selectedMonth = request.getParameter("month");
        String selectedDay = request.getParameter("day");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        int year = 0, month = 0, day = 0;
        List<String> errors = new ArrayList<>();

        // Kiểm tra năm hợp lệ
        if (selectedYear != null && !selectedYear.trim().isEmpty()) {
            try {
                year = Integer.parseInt(selectedYear);
                if (year <= 0) {
                    errors.add("❌ Năm phải là số nguyên dương.");
                }
            } catch (NumberFormatException e) {
                errors.add("❌ Năm không hợp lệ.");
            }
        }

        // Kiểm tra tháng hợp lệ
        if (selectedMonth != null && !selectedMonth.trim().isEmpty()) {
            try {
                month = Integer.parseInt(selectedMonth);
                if (month < 1 || month > 12) {
                    errors.add("❌ Tháng phải từ 1 đến 12.");
                }
            } catch (NumberFormatException e) {
                errors.add("❌ Tháng không hợp lệ.");
            }
        }

        // Kiểm tra ngày hợp lệ
        if (selectedDay != null && !selectedDay.trim().isEmpty()) {
            try {
                day = Integer.parseInt(selectedDay);
                if (day < 1 || day > 31) {
                    errors.add("❌ Ngày không hợp lệ.");
                } else if (year > 0 && month > 0) {
                    // Kiểm tra số ngày hợp lệ trong tháng
                    int maxDays = 31;
                    if (Arrays.asList(4, 6, 9, 11).contains(month)) {
                        maxDays = 30;
                    } else if (month == 2) {
                        boolean isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
                        maxDays = isLeapYear ? 29 : 28;
                    }

                    if (day > maxDays) {
                        errors.add("❌ Ngày không hợp lệ cho tháng đã chọn.");
                    }
                }
            } catch (NumberFormatException e) {
                errors.add("❌ Ngày không hợp lệ.");
            }
        }

        // Kiểm tra ngày bắt đầu và ngày kết thúc
        if (startDate != null && endDate != null && !startDate.isEmpty() && !endDate.isEmpty()) {
            if (startDate.compareTo(endDate) > 0) {
                errors.add("❌ Ngày bắt đầu không được lớn hơn ngày kết thúc.");
            }
        }

        // Nếu có lỗi, chuyển về trang JSP và hiển thị lỗi
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
             request.getRequestDispatcher("admin/adminDashBoard.jsp").forward(request, response);
            return;
        }

        // Kiểm tra khoảng ngày
        if (startDate != null && !startDate.isEmpty() && (endDate == null || endDate.isEmpty())) {
            endDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")); // Không thêm điều kiện endDate nếu chỉ chọn startDate
        }


        // Thống kê khách hàng & doanh thu theo khoảng thời gian hoặc theo ngày/tháng/năm
        Map<String, Integer> customerStats = customerDao.getCustomerStats(year, month, day, startDate, endDate);
        Map<String, Double> revenueStats = invoiceDao.getRevenueStats(year, month, day, startDate, endDate);

        // Chuyển đổi dữ liệu cho biểu đồ
        List<String> labels = new ArrayList<>(customerStats.keySet());
        List<Integer> customerCounts = new ArrayList<>(customerStats.values());
        List<Double> revenueCounts = new ArrayList<>();

        for (String key : labels) {
            revenueCounts.add(revenueStats.getOrDefault(key, 0.0));
        }

        // Đặt dữ liệu vào request
        request.setAttribute("labels", labels);
        request.setAttribute("customerCounts", customerCounts);
        request.setAttribute("revenueCounts", revenueCounts);
        request.setAttribute("topStaffList", topStaffList);
        request.setAttribute("topServices", topServices);
        request.setAttribute("totalService", totalService);
        request.setAttribute("totalAppointments", totalAppointments);
        request.setAttribute("staffByRole", staffByRole);
        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("customerCount", customerCount);

        // Gửi kết quả về view
        request.getRequestDispatcher("admin/adminDashBoard.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
