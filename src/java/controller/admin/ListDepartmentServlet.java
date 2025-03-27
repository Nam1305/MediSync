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
@WebServlet(name = "ListDepartmentServlet", urlPatterns = {"/ListDepartment"})
public class ListDepartmentServlet extends HttpServlet {

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
            out.println("<title>Servlet ListDepartmentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListDepartmentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    private String normalizationSearchQuery(String searchQuery) {
        return searchQuery.trim().replaceAll("\\s+", " ");
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
        int page = 1;
        int pageSize = 3;
        String status = request.getParameter("status");
        // Lấy pageSize từ request, giữ nguyên nếu đã có giá trị
        String pageSizeParam = request.getParameter("pageSize");
        if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeParam);
                if (pageSize <= 0) {
                    pageSize = 3; // Tránh pageSize không hợp lệ
                }
            } catch (NumberFormatException e) {
                pageSize = 3;
            }
        }

        // Lấy số trang từ request
        String pageParam = request.getParameter("page");
        String sort = request.getParameter("sort");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1; // Tránh lỗi về trang âm
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        String searchQuery = request.getParameter("search");
        String searchQueryNormalized = "";
        if(searchQuery!= null){
            searchQueryNormalized = normalizationSearchQuery(searchQuery);
        }
        DepartmentDAO department = new DepartmentDAO();
        List<Department> listDepartment = department.getAllDepartments(searchQueryNormalized,page,pageSize,status,sort);
        int totalDoctors = department.getTotalDepartments(searchQueryNormalized, status);
        int totalPages = (int) Math.ceil((double) totalDoctors / pageSize);
        request.setAttribute("listDepartment", listDepartment);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("status", status);
        request.setAttribute("sort", sort);
        request.setAttribute("search", searchQueryNormalized);
        request.getRequestDispatcher("admin/listDepartment.jsp").forward(request, response);
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
            doGet(request, response);
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
