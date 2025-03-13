/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

/**
 *
 * @author DIEN MAY XANH
 */
public class SendEmail {

    private static final String FROM_EMAIL = "duchvhe181827@gmail.com";
    private static final String PASSWORD = "herd tbfg gejc maau";

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
        String content = "Bạn đã đăng ký thành công. Vui lòng xác minh tài khoản của bạn bằng mã sau: "
                + code
                + ".\nLưu ý: Mã này sẽ hết hạn sau 5 phút.";
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
}
