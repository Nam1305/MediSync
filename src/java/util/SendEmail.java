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

    public String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public boolean sendMailVerify(String toEmail, String code) {

        boolean test = false;
        String fromEmail = "duchvhe181827@gmail.com";
        String password = "herd tbfg gejc maau";

        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP HOST
            props.put("mail.smtp.port", "587"); // TLS 587 SSL 465
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            // create Authenticator
            Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication(){
                return new PasswordAuthentication(fromEmail, password);
            }
            });
            Message mess = new MimeMessage(session);
            
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            mess.setFrom(new InternetAddress(fromEmail));
            
            mess.setSubject("Email Verification");
            
            mess.setText("Registered successfully. Please verify your account using this code: " + code);

            Transport.send(mess);
            
            test = true;
        } catch (MessagingException e) {
        }
        return true;
    }
    
    //Them boi Nguyen Dinh Chinh (11-1-25)
    public boolean sendMailResetPassword(String toEmail, String code) {
        boolean test = false;
        String fromEmail = "duchvhe181827@gmail.com";
        String password = "herd tbfg gejc maau";

        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message mess = new MimeMessage(session);
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            mess.setFrom(new InternetAddress(fromEmail));
            mess.setSubject("Password Reset Request");
            mess.setText("You have requested to reset your password. Use this code to reset your password: " + code
                    + "\n\nIf you didn't request this, please ignore this email.");

            Transport.send(mess);
            test = true;
        } catch (MessagingException e) {
            // Xử lý exception
        }
        return test;
    }

    //Them boi Nguyen Dinh Chinh 12-1-25
    public boolean sendPasswordChangeConfirmation(String toEmail) {
        boolean test = false;
        String fromEmail = "duchvhe181827@gmail.com";
        String password = "herd tbfg gejc maau";

        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message mess = new MimeMessage(session);
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            mess.setFrom(new InternetAddress(fromEmail));
            mess.setSubject("Password Change Confirmation");
            mess.setText("Your password has been successfully changed.\n\n"
                    + "If you did not make this change, please contact our support team immediately.");

            Transport.send(mess);
            test = true;
        } catch (MessagingException e) {
            // Handle exception
        }
        return test;

    }
}
