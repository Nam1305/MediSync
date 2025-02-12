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
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

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

    private boolean sendEmail(String toEmail, String subject, String content) {
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
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setSubject(subject);
            message.setText(content);

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            return false;
        }
    }

    public boolean sendMailVerify(String toEmail, String code) {
        String subject = "Email Verification";
        String content = "Registered successfully. Please verify your account using this code: " + code;
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendMailResetPassword(String toEmail, String code) {
        String subject = "Password Reset Request";
        String content = "You have requested to reset your password. Use this code to reset your password: " + code
                + "\n\nIf you didn't request this, please ignore this email.";
        return sendEmail(toEmail, subject, content);
    }

    public boolean sendPasswordChangeConfirmation(String toEmail) {
        String subject = "Password Change Confirmation";
        String content = "Your password has been successfully changed.\n\n"
                + "If you did not make this change, please contact our support team immediately.";
        return sendEmail(toEmail, subject, content);
    }
        public boolean sendPasswordForStaff(String toEmail, String password) {
        String subject = "Password for account";
        String content = "You have requested register account. Use this password to login the system: " + password;
        return sendEmail(toEmail, subject, content);
    }
}
