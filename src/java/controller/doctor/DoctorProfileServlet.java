/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.DepartmentDAO;
import dal.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import model.Department;
import model.Staff;
import java.sql.*;

/**
 *
 * @author DIEN MAY XANH
 */
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024, // 2MB
        maxFileSize = 10 * 1024 * 1024, // 10MB
        maxRequestSize = 50 * 1024 * 1024 // 50MB
)
public class DoctorProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
    DepartmentDAO depart = new DepartmentDAO();
    StaffDAO std = new StaffDAO();

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
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        List<Department> listd = depart.getAllDepartment();
        request.setAttribute("listd", listd);
        Staff staff = (Staff) session.getAttribute("staff");
        request.setAttribute("staff", staff);
        request.getRequestDispatcher("doctorProfile.jsp").forward(request, response);

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
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action") == null
                ? ""
                : request.getParameter("action");
        HttpSession session = request.getSession();
        Staff st = (Staff) session.getAttribute("staff");
        switch (action) {
            case "updateprofile":
                st.setName(request.getParameter("name"));
                st.setEmail(request.getParameter("email"));
                st.setPhone(request.getParameter("phone"));
                st.setDateOfBirth(Date.valueOf(request.getParameter("dob")));
                st.setGender(request.getParameter("gender"));
                st.setDescription(request.getParameter("des"));
                int depid = Integer.parseInt(request.getParameter("depart"));
                st.setDepartment(depart.getDepartmentById(depid));
                std.updateProfile(st);
                break;
            case "updateavatar":
                String uploadFolder = request.getServletContext().getRealPath("/uploads");
                Path uploadPath = Paths.get(uploadFolder);
                if (!Files.exists(uploadPath)) {
                    Files.createDirectory(uploadPath);
                }
                Part imagePart = request.getPart("avatar");
                String imageFilename = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                if (!imageFilename.equals("")) {
                    imagePart.write(Paths.get(uploadPath.toString(), imageFilename).toString());
                }
                std.updateAvatar(st.getStaffId(), "/uploads/" + imageFilename);
                st.setAvatar("/uploads/" + imageFilename);

                break;
        }
        session.setAttribute("staff", st);
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
