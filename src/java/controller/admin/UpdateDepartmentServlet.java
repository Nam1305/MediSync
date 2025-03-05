/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.DepartmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Department;

/**
 *
 * @author Acer
 */
@WebServlet(name = "UpdateDepartmentServlet", urlPatterns = {"/UpdateDepartment"})
public class UpdateDepartmentServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateDepartmentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateDepartmentServlet at " + request.getContextPath() + "</h1>");
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
        String departmentIdStr = request.getParameter("id");
        try {
            int departmentId = Integer.parseInt(departmentIdStr);
            DepartmentDAO department = new DepartmentDAO();
            Department currentDepartment = department.getDepartmentById(departmentId);
            if (currentDepartment != null) {
                request.setAttribute("department", currentDepartment);
                request.getRequestDispatcher("admin/updateDepartment.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không thấy phòng ban này");
                request.getRequestDispatcher("admin/updateDepartment.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Id Phòng ban này phải là số  ");
            request.getRequestDispatcher("admin/updateDepartment.jsp").forward(request, response); // Quay lại danh sách
        }
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
        DepartmentDAO departmentDao = new DepartmentDAO();
        List<String> error = new ArrayList<>();

        String departmentIdStr = request.getParameter("departmentId");
        String status = request.getParameter("status");
        String departmentName = request.getParameter("name");

        // Kiểm tra ID hợp lệ
        int departmentId = Integer.parseInt(departmentIdStr);
        Department department = departmentDao.getDepartmentById(departmentId);
        

        // Kiểm tra tên phòng ban không được để trống
        if (isEmpty(departmentName)) {
            error.add("Tên Phòng ban không được để trống!");
        } 

        // Kiểm tra trạng thái không được để trống
        if (isEmpty(status)) {
            error.add("Trạng thái không được để trống!");
        }

        // Kiểm tra phòng ban có tồn tại không
        if (departmentDao.isDepartmentExistsNotCurrentDepartment(departmentName.trim().toLowerCase().replaceAll("\\s+", " "), departmentId)) {
            error.add("Phòng ban này đã tồn tại!");
        }

        // Nếu có lỗi, hiển thị lại trang với thông báo lỗi
        if (!error.isEmpty()) {
            request.setAttribute("department", department);
            request.setAttribute("error", error);
            request.getRequestDispatcher("admin/updateDepartment.jsp").forward(request, response);
            return;
        }

        // Cập nhật phòng ban
        Department updateDepartment = new Department(departmentId, departmentName, status);
        departmentDao.updateDepartment(updateDepartment);

        request.setAttribute("success", "Cập nhật thành công!");
        request.getRequestDispatcher("admin/updateDepartment.jsp").forward(request, response);
    }
    // Hàm kiểm tra chuỗi rỗng

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
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
