/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.DoctorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.Staff;

/**
 *
 * @author Acer
 */
@WebServlet(name = "ListPatientServlet", urlPatterns = {"/ListPatient"})
public class ListPatientServlet extends HttpServlet {

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
            out.println("<title>Servlet ListPatientServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListPatientServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");

        if (staff != null) {
            DoctorDAO staffDao = new DoctorDAO();
            int page = 1;
            int pageSize = 6;
            // Lấy pageSize từ request, giữ nguyên nếu đã có giá trị
            String pageSizeParam = request.getParameter("pageSize");
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeParam);
                    if (pageSize <= 0) {
                        pageSize = 6; // Tránh pageSize không hợp lệ
                    }
                } catch (NumberFormatException e) {
                    pageSize = 6;
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
            String sort = request.getParameter("sort");
            String bloodType = request.getParameter("bloodType");
            if (bloodType != null) {
    bloodType = bloodType.replace(" ", "+");  // Chuyển khoảng trắng thành +
}
            String searchQuery = request.getParameter("search");
            String searchQueryNormalized = "";
            if (searchQuery != null) {
                searchQueryNormalized = normalizationSearchQuery(searchQuery);
            }

            List<Customer> patientList = staffDao.getPatientsByDoctor(staff.getStaffId(), searchQueryNormalized, page, pageSize, sort,bloodType);
            int totalPatient = staffDao.getTotalPatientsByDoctor(staff.getStaffId(), searchQuery, bloodType);
            int totalPages = (int) Math.ceil((double) totalPatient / pageSize);
            request.setAttribute("patientList", patientList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("search", searchQueryNormalized);
            request.setAttribute("sort", sort);
            request.setAttribute("bloodType", bloodType);
            request.getRequestDispatcher("doctor/listPatient.jsp").forward(request, response);

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
        processRequest(request, response);
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
