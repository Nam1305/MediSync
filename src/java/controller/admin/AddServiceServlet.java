/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Service;

/**
 *
 * @author Acer
 */
@WebServlet(name = "AddServiceServlet", urlPatterns = {"/AddService"})
public class AddServiceServlet extends HttpServlet {

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
            out.println("<title>Servlet AddServiceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddServiceServlet at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("addService.jsp").forward(request, response);
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
        List<String> error = new ArrayList<>();

        String serviceName = request.getParameter("serviceName");
        String content = request.getParameter("content");
        String priceStr = request.getParameter("price");

        // Kiểm tra các trường không được để trống
        if (isEmpty(serviceName)) {
            error.add("Tên dịch vụ không được để trống!");
        }
        if (isEmpty(content)) {
            error.add("Nội dung dịch vụ không được để trống!");
        }
        if (isEmpty(priceStr)) {
            error.add("Giá dịch vụ không được để trống!");
        }

        // Nếu có lỗi, hiển thị lại form với thông báo lỗi
        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("addService.jsp").forward(request, response);
            return;
        }

        double price = Double.parseDouble(priceStr);
        ServiceDAO serviceDao = new ServiceDAO();

        if (serviceDao.isServiceExists(serviceName.trim().toLowerCase().replaceAll("\\s+", " "))) {
            error.add("Service đã tồn tại!");
        }
        if (serviceDao.isContentExists(content.trim().toLowerCase().replaceAll("\\s+", " "))) {
            error.add("Content không thể trùng nhau!");
        }

        if (!error.isEmpty()) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("addService.jsp").forward(request, response);
            return;
        }

        Service newService = new Service(0, content, price, serviceName, "Active");
        boolean isAdded = serviceDao.insertService(newService);

        if (isAdded) {
            request.setAttribute("success", "Thêm Service thành công");
        } else {
            error.add("Có lỗi xảy ra, vui lòng thử lại!");
            request.setAttribute("error", error);
        }
        request.getRequestDispatcher("addService.jsp").forward(request, response);
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
