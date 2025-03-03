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
@WebServlet(name = "UpdateServiceServlet", urlPatterns = {"/UpdateService"})
public class UpdateServiceServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateServiceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateServiceServlet at " + request.getContextPath() + "</h1>");
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
        String serviceIdStr = request.getParameter("id");
        try {
            int serviceId = Integer.parseInt(serviceIdStr);
            ServiceDAO serviceDao = new ServiceDAO();
            Service currentService = serviceDao.getServiceById(serviceId);
            if (currentService != null) {
                request.setAttribute("service", currentService);
                request.getRequestDispatcher("updateService.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Không thấy service này");
                request.getRequestDispatcher("updateService.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Id Service này phải là số  ");
            request.getRequestDispatcher("updateService.jsp").forward(request, response); // Quay lại danh sách
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
        ServiceDAO serviceDao = new ServiceDAO();
        List<String> error = new ArrayList<>();
        String serviceIdStr = request.getParameter("serviceId");
        String serviceName = request.getParameter("name");
        String serviceContent = request.getParameter("content");
        String servicePrice = request.getParameter("price");
        String status = request.getParameter("status");

        int serviceId = Integer.parseInt(serviceIdStr);
        double price = Double.parseDouble(servicePrice);

        if (isEmpty(serviceName)) {
            error.add("Tên Dịch Vụ không được để trống!");
        }
        // Kiểm tra trạng thái không được để trống
        if (isEmpty(status)) {
            error.add("Trạng thái không được để trống!");
        }
        if (isEmpty(serviceContent)) {
            error.add("Mô tả không được để trống!");
        }
        if (isEmpty(servicePrice)) {
            error.add("Giá không được để trống!");
        }
        Service currentService = serviceDao.getServiceById(serviceId);
        // Nếu có lỗi, hiển thị lại trang với thông báo lỗi
        if (serviceDao.isServiceNotCurrentExists(serviceName.trim().toLowerCase().replaceAll("\\s+", " "), serviceId)) {
            error.add("Tên Dịch Vụ đã tồn tại");
        }
        if (serviceDao.isContentNotCurrentExists(serviceContent.trim().toLowerCase().replaceAll("\\s+", " "), serviceId)) {
            error.add("Mô tả đã tồn tại");
        }
        if (!error.isEmpty()) {
            request.setAttribute("service", currentService);
            request.setAttribute("error", error);
            request.getRequestDispatcher("updateService.jsp").forward(request, response);
            return;
        }
        Service updateService = new Service(serviceId, serviceContent, price, serviceName, status);
        boolean isAdded = serviceDao.updateService(updateService);
        if (isAdded) {
            request.setAttribute("success", "Cập nhật thành công!");
            request.getRequestDispatcher("updateService.jsp").forward(request, response);
        } else {
            error.add("Cập nhật thất bại");
            request.setAttribute("error", error);
            request.getRequestDispatcher("updateService.jsp").forward(request, response);
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
