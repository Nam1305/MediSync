/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.DoctorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Staff;

/**
 *
 * @author Acer
 */
@WebServlet(name = "ListDoctorServlet", urlPatterns = {"/ListDoctor"})
public class ListDoctorServlet extends HttpServlet {

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
            out.println("<title>Servlet ListDoctorServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListDoctorServlet at  " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private String normalizationSearchQuery(String searchQuery) {
        return searchQuery.trim().replaceAll("\\s+", " ");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DoctorDAO doctors = new DoctorDAO();
        int page = 1;
        int pageSize = 5;
        // Lấy pageSize từ request, giữ nguyên nếu đã có giá trị
        String pageSizeParam = request.getParameter("pageSize");
        if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeParam);
                if (pageSize <= 0) {
                    pageSize = 5; // Tránh pageSize không hợp lệ
                }
            } catch (NumberFormatException e) {
                pageSize = 5;
            }
        }

        // Lấy số trang từ request
        String pageParam = request.getParameter("page");
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

        String searchQueryNormalized = "";
        String searchQuery = request.getParameter("s");
        if (searchQuery != null) {
            searchQueryNormalized = normalizationSearchQuery(searchQuery);
        }

        String roleIdParam = request.getParameter("roleId1"); // Lấy roleId từ request
        Integer roleId1 = null;
        String status = request.getParameter("status");
        String sort = request.getParameter("sort");
        if (roleIdParam != null && !roleIdParam.isEmpty()) {
            roleId1 = Integer.parseInt(roleIdParam); // Chuyển về Integer nếu có roleId
        }
        List<Staff> listDoctor = doctors.getAllStaff(roleId1, status, searchQueryNormalized, page, pageSize,sort);
        // đóng gói listDoctor và request và truyền sang trang jsp để hiện thị dữ liệu 
        int totalDoctors = doctors.getTotalStaffCount(roleId1, status, searchQueryNormalized);
        int totalPages = (int) Math.ceil((double) totalDoctors / pageSize);
        request.setAttribute("listDoctor", listDoctor);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("status", status);
        request.setAttribute("roleId1", roleId1);
        request.setAttribute("sort", sort);
        request.setAttribute("s", searchQueryNormalized);
        request.getRequestDispatcher("admin/listDoctor.jsp").forward(request, response);
        response.setContentType("text/html;charset=UTF-8");

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
