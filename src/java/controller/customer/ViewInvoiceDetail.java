package controller.customer;

import dal.InvoiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Invoice;

/**
 *
 * @author Admin
 */
@WebServlet(urlPatterns = {"/invoiceDetail"})
public class ViewInvoiceDetail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    InvoiceDAO invoiceDao = new InvoiceDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //lấy ra id của appointment
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        List<Invoice> invoices = invoiceDao.getInvoiceByAppointment(appointmentId);
        // Gán vào request để truyền sang JSP
        request.setAttribute("invoices", invoices);
        request.getRequestDispatcher("customer/invoiceDetail.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
