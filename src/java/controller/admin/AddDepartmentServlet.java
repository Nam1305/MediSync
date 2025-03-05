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
@WebServlet(name = "AddDepartmentServlet", urlPatterns = {"/AddDepartment"})
public class AddDepartmentServlet extends HttpServlet {

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
            
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddDepartmentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddDepartmentServlet at " + request.getContextPath() + "</h1>");
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
            request.getRequestDispatcher("admin/addDepartment.jsp").forward(request, response);
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
        String departmentName = request.getParameter("departmentname");
        if (departmentName == null || departmentName.trim().isEmpty()) {
            request.setAttribute("error", "Department không được rỗng!");
            request.getRequestDispatcher("admin/addDepartment.jsp").forward(request, response);
            return;
        }
        // Chuẩn hóa dữ liệu: Xóa khoảng trắng ở đầu và cuối, và chuyển thành chữ thường
        DepartmentDAO departmentDao = new DepartmentDAO();
        if (departmentDao.isDepartmentExists(departmentName.trim().toLowerCase().replaceAll("\\s+", " "))) {
            request.setAttribute("error", "Department đã tồn tại!");
            request.getRequestDispatcher("admin/addDepartment.jsp").forward(request, response);
            return;
        }
        Department department = new Department(0, departmentName, "Active");
        
        boolean isAdded = departmentDao.insertDepartment(department);
        // Redirect hoặc forward đến trang khác sau khi thêm thành công
        if(isAdded){
            request.setAttribute("success", "thêm Phòng Ban thành công");
            request.getRequestDispatcher("admin/addDepartment.jsp").forward(request, response);
        }

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
