package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import util.SendEmail;

@WebServlet("/sendInvoice")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // Giới hạn file tối đa 10MB
public class SendInvoiceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy thông tin từ request
            String customerEmail = request.getParameter("email");
            String appointmentId = request.getParameter("appid");
            Part filePart = request.getPart("pdfFile");

            // Kiểm tra dữ liệu hợp lệ
            if (customerEmail == null || appointmentId == null || filePart == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("❌ Dữ liệu không hợp lệ!");
                return;
            }

            // Đọc file PDF thành mảng byte
            InputStream fileContent = filePart.getInputStream();
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                byteArrayOutputStream.write(buffer, 0, bytesRead);
            }
            byte[] pdfData = byteArrayOutputStream.toByteArray();

            // Tiêu đề & nội dung email
            String subject = "Hóa đơn khám bệnh - ID: " + appointmentId;
            String htmlContent = "<p>Chào quý khách,</p>"
                    + "<p>Vui lòng tìm hóa đơn của bạn trong file đính kèm.</p>"
                    + "<p>Trân trọng!</p>";

            // Gửi email
            SendEmail emailSender = new SendEmail();
            boolean isSent = emailSender.sendEmailWithAttachment(customerEmail, subject, htmlContent, pdfData, appointmentId + "_invoice.pdf");

            // Kiểm tra trạng thái gửi email
            if (isSent) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("Hóa đơn đã được gửi thành công!");
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("Gửi hóa đơn thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("Gửi hóa đơn thất bại! Lỗi: " + e.getMessage());
        }
    }
}
