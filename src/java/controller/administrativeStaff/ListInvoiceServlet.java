package controller.administrativeStaff;

import dal.AppointmentDAO;
import java.io.IOException;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.List;
import java.util.function.IntPredicate;
import model.Appointment;

public class ListInvoiceServlet extends HttpServlet {

    AppointmentDAO appointmentDao = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String appointmentIdStr = request.getParameter("invoiceId");
        String statusUpdate = request.getParameter("statusUpdate");

        if (appointmentIdStr != null && !appointmentIdStr.isEmpty()
                && statusUpdate != null && !statusUpdate.isEmpty()) {
            try {
                int appointmentId = Integer.parseInt(appointmentIdStr);
                appointmentDao.updateInvoiceStatus(appointmentId, statusUpdate);
            } catch (NumberFormatException ignored) {
            }
        }

        // Lấy các tham số lọc
        String name = request.getParameter("name");
        String status = request.getParameter("status");
        String dateFromStr = request.getParameter("dateFrom");
        String dateToStr = request.getParameter("dateTo");
        String totalFromStr = request.getParameter("totalFrom");
        String totalToStr = request.getParameter("totalTo");
        String sortDate = request.getParameter("sortDate");
        String sortPrice = request.getParameter("sortPrice");

        if (name != null) {
            name = name.trim().replaceAll("\\s+", " ");
        }

        int page = 1, pageSize = 5;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {
        }
        try {
            pageSize = Integer.parseInt(request.getParameter("pageSize"));
        } catch (NumberFormatException ignored) {
        }

        // Chuyển đổi dữ liệu
        Integer appointmentIdFilter = null;
        Double totalFrom = null, totalTo = null;
        Date dateFrom = null;
        Date dateTo = null;
        
        try {
            if (appointmentIdStr != null && !appointmentIdStr.isEmpty()) {
                appointmentIdFilter = Integer.valueOf(appointmentIdStr);
            }
            // Chỉ ép sang Date nếu dateFromStr không null và không rỗng
            if (dateFromStr != null && !dateFromStr.isEmpty()) {
                dateFrom = Date.valueOf(dateFromStr);
            }
            // Chỉ ép sang Date nếu dateToStr không null và không rỗng
            if (dateToStr != null && !dateToStr.isEmpty()) {
                dateTo = Date.valueOf(dateToStr);
            }
            if (totalFromStr != null && !totalFromStr.isEmpty()) {
                totalFrom = Double.valueOf(totalFromStr);
            }
            if (totalToStr != null && !totalToStr.isEmpty()) {
                totalTo = Double.valueOf(totalToStr);
            }
        } catch (Exception e) {
        }

        // Lấy danh sách hóa đơn
        List<Appointment> listInvoice = appointmentDao.getInvoiceByPage(
                appointmentIdFilter, name, status, dateFrom, dateTo, totalFrom, totalTo,
                page, pageSize, sortDate, sortPrice
        );

        // Tính tổng số trang
        int totalRecords = appointmentDao.countInvoiceByPage(
                appointmentIdFilter, name, status, dateFrom, dateTo, totalFrom, totalTo
        );
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Gửi dữ liệu sang JSP - Kiểm tra null trước khi gọi toString()
        request.setAttribute("listInvoice", listInvoice);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("invoiceIdFilter", appointmentIdFilter);
        request.setAttribute("name", name);
        request.setAttribute("status", status);
        request.setAttribute("dateFrom", dateFrom != null ? dateFrom.toString() : "");
        request.setAttribute("dateTo", dateTo != null ? dateTo.toString() : "");
        request.setAttribute("totalFrom", totalFromStr);
        request.setAttribute("totalTo", totalToStr);
        request.setAttribute("sortDate", sortDate);
        request.setAttribute("sortPrice", sortPrice);

        request.getRequestDispatcher("AdministrativeStaff/listInvoice.jsp").forward(request, response);
    }
}
