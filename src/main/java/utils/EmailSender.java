package utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Date;

public class EmailSender {

    public static void sendVerificationEmail(String toEmail, String verificationCode) {
        //Email: GhienTruyenTranhTeam@gmail.com   
        //Pass: fpjg kskz wcvn hmar
        final String from = "GhienTruyenTranhTeam@gmail.com";
        final String pass = "fpjg kskz wcvn hmar";

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587"); // Hoặc 465 cho SSL
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, pass); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
            }
        };

        //tao phien lam viec
        Session session = Session.getInstance(props, auth);

        //Gui email
        MimeMessage msg = new MimeMessage(session);
        try {
            //Kieu noi dung
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            //Nguoi gui
            msg.setFrom(from);
            //Nguoi nhan
            msg.addRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
            //Tieu de email
            msg.setSubject("Mã xác thực", "UTF-8");
            //Quy dinh ngay gui
            msg.setSentDate(new Date());
            //Noi dung
            msg.setText("Mã xác thực của bạn là: "+verificationCode, "UTF-8");
            //Gui email di
            Transport.send(msg);
        } catch (Exception e) {
        }
    }
}