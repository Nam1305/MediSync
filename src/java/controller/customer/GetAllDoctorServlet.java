/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.customer;

import dal.DepartmentDAO;
import dal.DoctorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.Department;
import model.Staff;

/**
 *
 * @author Phạm Hoàng Nam
 */
@WebServlet(name = "GetAllDoctorServlet", urlPatterns = {"/allDoctors"})
public class GetAllDoctorServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    DoctorDAO doctorDao = new DoctorDAO();
    DepartmentDAO departmentDao = new DepartmentDAO();

    private String normalizeSearchQuery(String query) {
        return query.trim().replaceAll("\\s+", " "); // Loại bỏ khoảng trắng dư thừa
    }

    protected void handleGetAllDotors(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        //Lấy dữ liệu từ form JSP về
        String name = request.getParameter("name");
        String departmentIdStr = request.getParameter("departmentId");
        String gender = request.getParameter("gender");
        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");

        int currentPage = 1;
        int pageSize = 4; // Số appointment mỗi trang mặc định
        //Normalize tên bác sĩ được search
        if (name == null || name.trim().isEmpty()) {
            name = ""; // Gán chuỗi rỗng nếu `search` null
        }

        String nameNormalized = null;
        if (name != null && !name.trim().isEmpty()) {
            nameNormalized = normalizeSearchQuery(name);
        }
        //ép kiểu
        int departmentId = (departmentIdStr != null && !departmentIdStr.isEmpty()) ? Integer.parseInt(departmentIdStr) : -1;

        try {
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                currentPage = Integer.parseInt(pageParam);
            }
            if (pageSizeParam != null && !pageSizeParam.trim().isEmpty()) {
                int parsedPageSize = Integer.parseInt(pageSizeParam);
                if (parsedPageSize >= 1) {
                    pageSize = parsedPageSize;
                }
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
            pageSize = 4;
        }

        try {
            // Tính tổng số bác sĩ (phục vụ phân trang)
            int totalDoctors = doctorDao.getTotalDoctorsByFilters(nameNormalized, departmentId, gender);
            int totalPages = (int) Math.ceil((double) totalDoctors / pageSize);

            // Lấy danh sách bác sĩ theo bộ lọc
            List<Staff> allDoctors = doctorDao.getDoctorsByFilters(nameNormalized, departmentId, gender, currentPage, pageSize);
            //Lấy danh sách tất cả department
            List<Department> allActiveDepartment = departmentDao.getActiveDepartmentForCustomer();
            // Kiểm tra danh sách có dữ liệu không
            if (allDoctors == null || allDoctors.isEmpty()) {
                System.out.println("Danh sách bác sĩ rỗng!");
            } else {
                System.out.println("Danh sách bác sĩ có dữ liệu: " + allDoctors.size());
            }

            // Gửi dữ liệu sang JSP
            request.setAttribute("doctors", allDoctors);
            request.setAttribute("departments", allActiveDepartment);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("name", name);
            request.setAttribute("departmentId", departmentIdStr); // Giữ nguyên dạng String để JSP sử dụng
            request.setAttribute("gender", gender);
            request.setAttribute("pageSize", pageSize);
            request.getRequestDispatcher("customer/allDoctor.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi lấy danh sách bác sĩ!");
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
        handleGetAllDotors(request, response);
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
