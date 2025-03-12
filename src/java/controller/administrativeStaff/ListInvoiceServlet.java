/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.administrativeStaff;

import dal.AppointmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Appointment;
import model.Staff;
import java.sql.Date;

/**
 *
 * @author DIEN MAY XANH
 */
public class ListInvoiceServlet extends HttpServlet {

    AppointmentDAO appointmentDao = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy các tham số từ form
        String invoiceIdStr = request.getParameter("invoiceId"); // Sử dụng appointmentId
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        // Thay vì 1 ngày, bây giờ có 2 tham số: từ ngày và đến ngày
        String dateFromStr = request.getParameter("dateFrom");
        String dateToStr = request.getParameter("dateTo");
        String totalFromStr = request.getParameter("totalFrom");
        String totalToStr = request.getParameter("totalTo");
        String sortDate = request.getParameter("sortDate");
        String sortPrice = request.getParameter("sortPrice");

        if (name != null) {
            name = name.trim().replaceAll("\\s+", " ");
        }

        int page;
        int pageSize;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {
            page = 1;
        }
        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (NumberFormatException ignored) {
            pageSize = 5;
        }

        // Chuyển đổi dữ liệu từ String sang các kiểu dữ liệu tương ứng
        Integer appointmentIdFilter = null;
        Date dateFrom = null;
        Date dateTo = null;
        Double totalFrom = null, totalTo = null;

        try {
            if (invoiceIdStr != null && !invoiceIdStr.isEmpty()) {
                appointmentIdFilter = Integer.valueOf(invoiceIdStr);
            }
            if (dateFromStr != null && !dateFromStr.isEmpty()) {
                dateFrom = Date.valueOf(dateFromStr);
            }
            if (dateToStr != null && !dateToStr.isEmpty()) {
                dateTo = Date.valueOf(dateToStr);
            }
            if (totalFromStr != null && !totalFromStr.isEmpty()) {
                totalFrom = Double.valueOf(totalFromStr);
            }
            if (totalToStr != null && !totalToStr.isEmpty()) {
                totalTo = Double.valueOf(totalToStr);
            }
        } catch (NumberFormatException e) {
            // Ghi log hoặc xử lý lỗi nếu cần
        }

        // Lấy danh sách hóa đơn theo bộ lọc (appointment)
        List<Appointment> listInvoice = appointmentDao.getInvoiceByPage(
                appointmentIdFilter, name, status, dateFrom, dateTo, totalFrom, totalTo,
                page, pageSize, sortDate, sortPrice
        );

        // Tính tổng số trang
        int totalRecords = appointmentDao.countInvoiceByPage(
                appointmentIdFilter, name, status, dateFrom, dateTo, totalFrom, totalTo
        );
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Gửi dữ liệu sang JSP
        request.setAttribute("listInvoice", listInvoice);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("invoiceIdFilter", appointmentIdFilter);
        request.setAttribute("name", name);
        request.setAttribute("status", status);
        request.setAttribute("dateFrom", dateFromStr);
        request.setAttribute("dateTo", dateToStr);
        request.setAttribute("totalFrom", totalFromStr);
        request.setAttribute("totalTo", totalToStr);
        request.setAttribute("sortDate", sortDate);
        request.setAttribute("sortPrice", sortPrice);

        request.getRequestDispatcher("AdministrativeStaff/listInvoice.jsp").forward(request, response);
    }

}
