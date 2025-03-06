/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.doctor;

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
        HttpSession session = request.getSession();
        Staff staff = (Staff) session.getAttribute("staff");
        String invoiceIdStr = request.getParameter("invoiceId"); // 🔹 Đổi từ invoiceId → appointmentId
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        String dateStr = request.getParameter("date");
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
        // 🟢 Chuyển đổi dữ liệu
        Integer invoiceIdFilter = null;
        Date date = null;
        Double totalFrom = null, totalTo = null;

        try {
            if (invoiceIdStr != null && !invoiceIdStr.isEmpty()) {
                invoiceIdFilter = Integer.valueOf(invoiceIdStr);
            }
            if (dateStr != null && !dateStr.isEmpty()) {
                date = Date.valueOf(dateStr);
            }
            if (totalFromStr != null && !totalFromStr.isEmpty()) {
                totalFrom = Double.valueOf(totalFromStr);
            }
            if (totalToStr != null && !totalToStr.isEmpty()) {
                totalTo = Double.valueOf(totalToStr);
            }
        } catch (NumberFormatException e) {
        }

        // 🟢 Lấy danh sách hóa đơn với bộ lọc
        List<Appointment> listInvoice = appointmentDao.getInvoiceByPage(
                staff.getStaffId(), invoiceIdFilter, name, status, date, totalFrom, totalTo,
                page, pageSize, sortDate, sortPrice
        );

        // 🟢 Tính tổng số trang
        int totalRecords = appointmentDao.countInvoiceByPage(
                staff.getStaffId(), invoiceIdFilter, name, status, date, totalFrom, totalTo
        );
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // 🟢 Gửi dữ liệu sang JSP
        request.setAttribute("listInvoice", listInvoice);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("invoiceIdFilter", invoiceIdFilter);
        request.setAttribute("name", name);
        request.setAttribute("status", status);
        request.setAttribute("date", dateStr);
        request.setAttribute("totalFrom", totalFromStr);
        request.setAttribute("totalTo", totalToStr);
        request.setAttribute("sortDate", sortDate);
        request.setAttribute("sortPrice", sortPrice);

        request.getRequestDispatcher("doctor/listInvoice.jsp").forward(request, response);
    }

}
