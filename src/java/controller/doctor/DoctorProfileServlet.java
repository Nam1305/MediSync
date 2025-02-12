/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

import dal.CustomerDAO;
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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import model.Department;
import model.Staff;
import java.sql.*;
import util.Validation;

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

    Validation valid = new Validation();
    DepartmentDAO depart = new DepartmentDAO();
    StaffDAO std = new StaffDAO();
    CustomerDAO ctm = new CustomerDAO();

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
        List<Department> listd = depart.getAllDepartment();
        switch (action) {
            case "updateprofile":
                if (std.checkExitEMail(request.getParameter("email").trim(), st.getStaffId()) != null
                        || ctm.getCustomerByEmail(request.getParameter("email").trim()) != null) {
                    request.setAttribute("error", "Email này đã được tài khoản khác sử dụng!");
                    session.setAttribute("staff", st);
                    request.setAttribute("listd", listd);

                    request.getRequestDispatcher("doctorProfile.jsp").forward(request, response);
                    return;

                }
                if (std.checkExitPhone(request.getParameter("phone").trim(), st.getStaffId()) != null
                        || ctm.getCustomerByPhone(request.getParameter("phone").trim()) != null) {
                    request.setAttribute("error", "Số điện thoại này đã được tài khoản khác sử dụng!");
                    session.setAttribute("staff", st);
                    request.setAttribute("listd", listd);

                    request.getRequestDispatcher("doctorProfile.jsp").forward(request, response);
                    return;
                }
                st.setName(valid.normalizeFullName(request.getParameter("name")));
                st.setEmail(request.getParameter("email").trim());
                st.setPhone(request.getParameter("phone").trim());
                st.setDateOfBirth(Date.valueOf(request.getParameter("dob")));
                st.setGender(request.getParameter("gender"));
                st.setDescription(request.getParameter("des").trim());
                int depid = Integer.parseInt(request.getParameter("depart"));
                st.setDepartment(depart.getDepartmentById(depid));
                std.updateProfile(st);
                request.setAttribute("listd", listd);

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
                    String fileExtension = "";
                    int dotIndex = imageFilename.lastIndexOf('.');
                    if (dotIndex > 0 && dotIndex < imageFilename.length() - 1) {
                        fileExtension = imageFilename.substring(dotIndex + 1).toLowerCase();
                    }
                    if (fileExtension.equals("jpg") || fileExtension.equals("jpeg") || fileExtension.equals("png")) {
                        imagePart.write(Paths.get(uploadPath.toString(), imageFilename).toString());
                        String avt = request.getContextPath() + "/uploads/" + imageFilename;
                        std.updateAvatar(st.getStaffId(), avt);
                        st.setAvatar(avt);
                        request.setAttribute("listd", listd);
                    } else {
                        request.setAttribute("erroravatar", "Định dạng tệp không hợp lệ. Vui lòng chọn tệp .jpg, .jpeg hoặc .png.");
                        session.setAttribute("staff", st);
                        request.setAttribute("listd", listd);
                        request.getRequestDispatcher("doctorProfile.jsp").forward(request, response);

                        return;
                    }
                    imagePart.write(Paths.get(uploadPath.toString(), imageFilename).toString());
                }

                break;
        }
        session.setAttribute("staff", st);
        request.getRequestDispatcher("doctorProfile.jsp").forward(request, response);
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
