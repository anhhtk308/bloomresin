package group03.bloomresin.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Properties;

@Service
public class OrderNotificationService {
    private final String fromEmail = "bloomresin.system@gmail.com";
    private final String password = "oxiu oyla rasd cqzm";

    private Session createEmailSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });
    }

    public void sendOrderNotification(List<String> recipientEmails, String orderInfo) {
        try {
            Session session = createEmailSession();
            for (String toEmail : recipientEmails) {
                Message message = new MimeMessage(session);
                message.setFrom(new InternetAddress(fromEmail));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
                message.setSubject("Thông báo: Có đơn hàng mới");
                message.setText("Thông tin đơn hàng mới:\n\n" + orderInfo + "\n\nVui lòng kiểm tra hệ thống để xử lý đơn hàng.");
                Transport.send(message);
            }
        } catch (MessagingException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi gửi email");
        }
    }
}
