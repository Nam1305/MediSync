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
import java.util.Date;
import model.Department;
import model.Role;
import model.Staff;
import util.BCrypt;

/**
 *
 * @author Acer
 */
@WebServlet(name = "AddStaffServlet", urlPatterns = {"/AddStaffServlet"})
public class AddStaffServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */


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
//        processRequest(request, response);
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
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String position = request.getParameter("position");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        if (isEmpty(name) || isEmpty(email) 
            || isEmpty(phone) || isEmpty(password) 
            || isEmpty(gender) || isEmpty(dateOfBirthStr)){
        request.setAttribute("error", "All fields are required!");
        request.getRequestDispatcher("addStaff.jsp").forward(request, response);
        return;
    }   
        //ép kiểu cho dateOfBirth
        java.sql.Date dateOfBirth = java.sql.Date.valueOf(dateOfBirthStr);
        //mã hóa password bằng hàm Bcrypt()
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        DoctorDAO staff = new DoctorDAO();
        // // Khởi tạo đối tượng Department
        Department department = new Department();
        department.setDepartmentId(departmentId);
        Role role = new Role();
        role.setRoleId(roleId);
        Staff newStaff = new Staff(0, name, email, gender, phone, password, dateOfBirth, position, gender, "Active", position, department, role);
      
        boolean isAdded = staff.addStaff(newStaff);

        if (isAdded) {
            
            response.sendRedirect("ListDoctor");
        } else {
            request.setAttribute("error", "Failed to add staff. Please try again.");
            request.getRequestDispatcher("addStaff.jsp").forward(request, response);
        }
    }

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
