package util;

import java.util.Properties;
import java.util.Random;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.mail.util.ByteArrayDataSource;

/**
 *
 * @author DIEN MAY XANH
 */
public class SendEmail {

    private static final String FROM_EMAIL = "duchvhe181827@gmail.com";
    private static final String PASSWORD = "herd tbfg gejc maau";
    private static final String ADMIN_EMAIL = "trungnmhe186069@gmail.com";

    public String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public boolean sendEmail(String toEmail, String subject, String content) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
                }
            });

            Message message = new MimeMessage(session);
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setFrom(new InternetAddress(FROM_EMAIL, MimeUtility.encodeText("Hệ thống quản lý đặt lịch hẹn bác sĩ!", "UTF-8", "B")));
            message.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));

            // Thiết lập nội dung email với UTF-8
            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(content, "text/html; charset=UTF-8"); // Hỗ trợ tiếng Việt và HTML

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);

            Transport.send(message);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean sendMailVerify(String toEmail, String code) {
        String subject = "Xác minh địa chỉ email";
        String content = "Bạn đã đăng ký thành công. Vui lòng xác minh tài khoản của bạn bằng mã sau: " + code;
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendMailResetPassword(String toEmail, String code) {
        String subject = "Yêu cầu đặt lại mật khẩu";
        String content = "Bạn đã yêu cầu đặt lại mật khẩu. Vui lòng sử dụng mã sau để đặt lại mật khẩu: " + code
                + "\n\nNếu bạn không yêu cầu, vui lòng bỏ qua email này.";
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendPasswordChangeConfirmation(String toEmail) {
        String subject = "Xác nhận thay đổi mật khẩu";
        String content = "Mật khẩu của bạn đã được thay đổi thành công.\n\n"
                + "Nếu bạn không thực hiện thay đổi này, vui lòng liên hệ ngay với bộ phận hỗ trợ.";
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendPasswordForStaff(String toEmail, String password) {
        String subject = "Mật khẩu tài khoản nhân viên";
        String content = "Bạn đã yêu cầu đăng ký tài khoản. Vui lòng sử dụng mật khẩu sau để đăng nhập vào hệ thống: " + password;
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendPasswordForCustomer(String toEmail, String password) {
        String subject = "Tài khoản của bạn đã được tạo!";
        String content = "Vui lòng sử dụng mật khẩu: " + password + " để đăng nhập!";
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendScheduleNotification(String toEmail, String shiftInfo, String startDate, String endDate) {
        String subject = "Thông báo lịch làm việc mới";
        String content = "Bạn đã được xếp lịch:\n\n"
                + "Ca " + shiftInfo + " từ ngày " + startDate
                + " đến ngày " + endDate;
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendEmailContact(String name, String email, String subject, String message) {
        String emailSubject = subject.isEmpty() ? "Liên hệ mới từ website" : subject;

        String content = "<html><body>"
                + "<h2>Thông tin liên hệ mới</h2>"
                + "<p><strong>Họ tên:</strong> " + name + "</p>"
                + "<p><strong>Email:</strong> " + email + "</p>"
                + "<p><strong>Tiêu đề:</strong> " + emailSubject + "</p>"
                + "<p><strong>Nội dung:</strong></p>"
                + "<p>" + message.replace("\n", "<br>") + "</p>"
                + "</body></html>";

        return sendEmail(ADMIN_EMAIL, emailSubject, content);
    }

    public boolean sendEmailWithAttachment(String toEmail, String subject, String htmlContent, byte[] pdfData, String fileName) {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Hệ thống quản lý đặt lịch hẹn bác sĩ!", "UTF-8"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(subject, "UTF-8");

            Multipart multipart = new MimeMultipart();

            // Nội dung email (HTML)
            BodyPart htmlBodyPart = new MimeBodyPart();
            htmlBodyPart.setContent(htmlContent, "text/html; charset=UTF-8");
            multipart.addBodyPart(htmlBodyPart);

            // Đính kèm file PDF
            if (pdfData != null && pdfData.length > 0) {
                BodyPart attachmentBodyPart = new MimeBodyPart();
                DataSource source = new ByteArrayDataSource(pdfData, "application/pdf");
                attachmentBodyPart.setDataHandler(new DataHandler(source));
                attachmentBodyPart.setFileName(MimeUtility.encodeText(fileName, "UTF-8", "B"));
                multipart.addBodyPart(attachmentBodyPart);
            }

            message.setContent(multipart);
            Transport.send(message);

            System.out.println("Email đã gửi thành công đến: " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("Gửi email thất bại: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
