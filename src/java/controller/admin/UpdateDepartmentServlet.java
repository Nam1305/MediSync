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
                request.getRequestDispatcher("updateDepartment.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không thấy phòng ban này");
                request.getRequestDispatcher("updateDepartment.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Id Phòng ban này phải là số  ");
            request.getRequestDispatcher("updateDepartment.jsp").forward(request, response); // Quay lại danh sách
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
        String departmentIdStr = request.getParameter("departmentId");
        String status = request.getParameter("status");
        String departmentName = request.getParameter("name");
        
        int departmentId = Integer.parseInt(departmentIdStr);
        if (departmentName == null || departmentName.trim().isEmpty()) {
            request.setAttribute("error", "Tên Phòng ban không được để trống");
            request.getRequestDispatcher("updateDepartment.jsp").forward(request, response);
            return;
        }
        departmentName = departmentName.trim().toLowerCase().replaceAll("\\s+", " ");
        if (status == null || status.isEmpty()) {
            request.setAttribute("error", "status không được để trống");
            request.getRequestDispatcher("updateDepartment.jsp").forward(request, response);
            return;
        }
        DepartmentDAO departmentDao = new DepartmentDAO();
        
        if (departmentDao.isDepartmentExistsNotCurrentDepartment(departmentName, departmentId)) {
            request.setAttribute("error", "Phòng ban này đã tồn tại ");
            request.getRequestDispatcher("updateDepartment.jsp").forward(request, response);
            return;
        }
        
            Department updateDepartment = new Department(departmentId, departmentName, status);
            departmentDao.updateDepartment(updateDepartment);
            request.setAttribute("success", "cập nhật thành công ");
            request.getRequestDispatcher("updateDepartment.jsp").forward(request, response);
        
        
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
