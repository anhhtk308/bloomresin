package group03.bloomresin.service;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;

import java.util.Properties;

@Service
public class EmailService {

    public void sendRegistrationEmail(String to, String username, String email, String password)
            throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("bloomresin.system@gmail.com", "oxiu oyla rasd cqzm"); // Thay bằng App
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress("bloomresin.system@gmail.com"));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Cửa hàng ✿ Hoa hòe hoa hoẹt ✿ - Thông tin tài khoản nhân viên của bạn");

        message.setText("Xin chào " + username + ",\n\n" +
                "Tài khoản nhân viên của bạn đã được tạo thành công. Dưới đây là thông tin đăng nhập:\n\n" +
                "Tên người dùng: " + username + "\n" +
                "Email: " + email + "\n" +
                "Mật khẩu: " + password + "\n\n" +
                "Vui lòng giữ bí mật thông tin này và không chia sẻ cho người khác.\n\n" +
                "Cảm ơn bạn đã gia nhập cửa hàng!\n\n" +
                "Trân trọng,\nNhóm 3 - Cửa hàng ✿ Hoa hòe hoa hoẹt ✿");
        Transport.send(message);
    }
}