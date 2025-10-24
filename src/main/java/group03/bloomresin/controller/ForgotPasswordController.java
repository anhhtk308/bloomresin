package group03.bloomresin.controller;

import java.util.Properties;
import java.util.Random;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import group03.bloomresin.domain.OTPForm;
import group03.bloomresin.domain.ResetPasswordForm;
import group03.bloomresin.domain.User;
import group03.bloomresin.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Controller
public class ForgotPasswordController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public ForgotPasswordController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/forgotpassword")
    public String getForgotPassword(Model model) {
        model.addAttribute("newUser", new User());
        return "authentication/forgotpassword";
    }

    @PostMapping("/authentication/forgotpassword")
    public String recoverPassword(Model model, @ModelAttribute("newUser") User user, HttpServletRequest request) {
        boolean checkEmail = this.userService.checkEmailExist(user.getEmail());
        if (checkEmail) {
            HttpSession mySession = request.getSession();
            int otpvalue = new Random().nextInt(999999);
            String email = user.getEmail();

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("bloomresin.system@gmail.com", "oxiu oyla rasd cqzm");
                }
            });

            try {
                // Compose the message
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("bloomresin.system@gmail.com"));
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                message.setSubject("Khôi phục mật khẩu - Mã OTP");
                message.setText("Khách hàng thân mến,\n\nMã OTP của bạn để đăng ký tài khoản là: " + otpvalue +
                        "\n\nVui lòng nhập mã này để hoàn tất đăng ký. Không chia sẻ mã này với bất kỳ ai.\n\n" +
                        "Cảm ơn bạn đã chọn cửa hàng!\n\n" +
                        "Trân trọng,\nNhóm 3 - Cửa hàng ✿ Hoa hòe hoa hoẹt ✿");
                Transport.send(message);
                System.out.println("Tin nhắn đã được gửi thành công");

            } catch (MessagingException e) {
                e.printStackTrace();
                throw new RuntimeException(e);
            }

            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("email", email);
            request.setAttribute("message", "Mã OTP đã được gửi tới email của bạn.");
            return "redirect:/authentication/enterOTP";
        } else {
            request.setAttribute("message", "Địa chỉ email không hợp lệ!");
            return "redirect:/forgotpassword?invalidemail";
        }
    }

    @GetMapping("/authentication/enterOTP")
    public String getOTP(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Integer generatedOtp = (Integer) session.getAttribute("otp");

        // Check if the email and OTP are present in the session
        if (email == null || generatedOtp == null) {
            request.setAttribute("message",
                    "Phiên làm việc đã hết hạn hoặc truy cập không hợp lệ. Vui lòng thực hiện lại quy trình.");
            return "redirect:/forgotpassword";
        }
        model.addAttribute("newOtpForm", new OTPForm());
        return "authentication/enterOTP";
    }

    @PostMapping("/authentication/enterOTP")
    public String validateOtp(HttpServletRequest request, @RequestParam("otp") int otp, Model model,
            @ModelAttribute("newOtpForm") OTPForm newOtpForm) {
        HttpSession session = request.getSession();
        Integer generatedOtp = (Integer) session.getAttribute("otp");
        Integer currentOTP = newOtpForm.getOtp();

        if (generatedOtp != null && currentOTP != null && currentOTP.equals(generatedOtp)) {
            return "redirect:/authentication/resetPassword";
        } else {
            request.setAttribute("message", "Mã OTP không đúng. Vui lòng thử lại.");
            return "redirect:/authentication/enterOTP?error";
        }
    }

    @GetMapping("/authentication/resetPassword")
    public String getResetPassword(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        Integer generatedOtp = (Integer) session.getAttribute("otp");
        if (email == null || generatedOtp == null) {
            request.setAttribute("message",
                    "Phiên làm việc đã hết hạn hoặc truy cập không hợp lệ. Vui lòng thực hiện lại quy trình.");
            return "redirect:/forgotpassword";
        }
        model.addAttribute("resetPasswordForm", new ResetPasswordForm());
        return "authentication/resetPassword";
    }

    @PostMapping("/authentication/resetPassword")
    public String resetPassword(HttpServletRequest request, @RequestParam("password") String password,
            @RequestParam("confPassword") String confPassword, Model model) {
        if (password.equals(confPassword)) {
            HttpSession session = request.getSession();
            String email = (String) session.getAttribute("email");
            String newPassword = this.passwordEncoder.encode(password);
            if (email != null) {
                this.userService.updatePassword(email, newPassword);
                session.invalidate();
                request.setAttribute("message", "Đặt lại mật khẩu thành công!");
                return "redirect:/login?resetsuccess";
            } else {
                request.setAttribute("message", "Phiên làm việc đã hết hạn. Vui lòng thử lại.");
                return "authentication/forgotPassword";
            }
        } else {
            return "redirect:/authentication/resetPassword?invalidpassword";
        }
    }
}
