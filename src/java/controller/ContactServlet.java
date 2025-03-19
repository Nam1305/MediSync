package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import util.SendEmail;

@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Validate form data
        if (name == null || email == null || message == null
                || name.trim().isEmpty() || email.trim().isEmpty() || message.trim().isEmpty()) {
            request.setAttribute("message", "Vui lòng điền đầy đủ thông tin bắt buộc.");
            request.setAttribute("status", "danger");
            request.getRequestDispatcher("contact.jsp").forward(request, response);
            return;
        }

        // If subject is null, set it to empty string
        if (subject == null) {
            subject = "";
        }

        // Send email
        SendEmail sender = new SendEmail();
        boolean result = sender.sendEmailContact(name, email, subject, message);

        if (result) {
            request.setAttribute("message", "Cảm ơn bạn đã liên hệ. Chúng tôi sẽ phản hồi sớm nhất có thể.");
            request.setAttribute("status", "success");
        } else {
            request.setAttribute("message", "Có lỗi xảy ra khi gửi tin nhắn. Vui lòng thử lại sau.");
            request.setAttribute("status", "danger");
        }

        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}