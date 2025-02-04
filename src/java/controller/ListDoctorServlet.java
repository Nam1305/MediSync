/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

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
@WebServlet(name="ListDoctorServlet", urlPatterns={"/ListDoctor"})
public class ListDoctorServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<h1>Servlet ListDoctorServlet at  " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // tạo đối tượng doctors và gọi phương thức getAllDOctor để lấy dữ liệu 
        DoctorDAO doctors = new DoctorDAO();
        String roleIdParam = request.getParameter("roleId"); // Lấy roleId từ request
        Integer roleId = null;

        if (roleIdParam != null && !roleIdParam.isEmpty()) {
            roleId = Integer.parseInt(roleIdParam); // Chuyển về Integer nếu có roleId
        }
        List<Staff> listDoctor = doctors.getAllDoctor(roleId);
        // đóng gói listDoctor và request và truyền sang trang jsp để hiện thị dữ liệu 
        request.setAttribute("listDoctor", listDoctor);
        request.getRequestDispatcher("listDoctor.jsp").forward(request, response);
        response.setContentType("text/html;charset=UTF-8");
       
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
