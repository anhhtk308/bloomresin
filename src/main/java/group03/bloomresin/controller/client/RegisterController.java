package group03.bloomresin.controller.client;

import java.util.Properties;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import group03.bloomresin.domain.OTPForm;
import group03.bloomresin.domain.User;
import group03.bloomresin.domain.dto.RegisterDTO;
import group03.bloomresin.service.UserService;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class RegisterController {
    private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final ObjectMapper objectMapper;

    public RegisterController(UserService userService, PasswordEncoder passwordEncoder, ObjectMapper objectMapper) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.objectMapper = objectMapper;
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        logger.info("Truy cập trang đăng ký");
        model.addAttribute("registerUser", new RegisterDTO());
        return "authentication/register";
    }

    @PostMapping("/register")
    public String registerUser(Model model, @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
                               BindingResult bindingResult, HttpServletRequest request) {
        logger.info("Xử lý đăng ký cho email: {}", registerDTO.getEmail());
        logger.debug("Mật khẩu: [{}]", registerDTO.getPassword());
        logger.debug("Xác nhận mật khẩu: [{}]", registerDTO.getConfirmPassword());
        logger.debug("Mật khẩu khớp: {}", registerDTO.isPasswordMatching());

        if (bindingResult.hasErrors()) {
            logger.error("Lỗi validate:");
            bindingResult.getAllErrors().forEach(error ->
                    logger.error("Lỗi: {}", error.getDefaultMessage()));
            return "authentication/register";
        }

        if (userService.checkEmailExist(registerDTO.getEmail())) {
            logger.warn("Email {} đã được đăng ký", registerDTO.getEmail());
            request.setAttribute("message", "Email đã được đăng ký. Vui lòng đăng nhập.");
            return "redirect:/register?exist";
        }

        HttpSession mySession = request.getSession();
        int otpValue = new Random().nextInt(999999);
        String email = registerDTO.getEmail();

        try {
            String registerDTOJson = objectMapper.writeValueAsString(registerDTO);
            mySession.setAttribute("registerDTO", registerDTOJson);
            logger.info("Đã lưu RegisterDTO vào session cho email: {}", email);
        } catch (JsonProcessingException e) {
            logger.error("Lỗi khi chuyển đổi RegisterDTO thành JSON cho email: {}", email, e);
            request.setAttribute("message", "Lỗi khi xử lý đăng ký. Vui lòng thử lại.");
            return "authentication/register";
        }

        mySession.setAttribute("otp", otpValue);
        mySession.setAttribute("email", email);
        logger.debug("Đã tạo OTP: {} cho email: {}", otpValue, email);

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
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress("bloomresin.system@gmail.com"));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Cửa hàng ✿ Hoa hòe hoa hoẹt ✿ - Mã OTP Xác Minh");
            message.setText("Khách hàng thân mến,\n\nMã OTP của bạn để đăng ký tài khoản là: " + otpValue +
                    "\n\nVui lòng nhập mã này để hoàn tất đăng ký. Không chia sẻ mã này với bất kỳ ai.\n\n" +
                    "Cảm ơn bạn đã chọn cửa hàng!\n\n" +
                    "Trân trọng,\nNhóm 3 - Cửa hàng ✿ Hoa hòe hoa hoẹt ✿");

            Transport.send(message);
            logger.info("Đã gửi email chứa OTP tới: {}", email);

        } catch (MessagingException e) {
            logger.error("Không thể gửi email OTP đến: {}", email, e);
            request.setAttribute("message", "Không gửi được mã OTP. Vui lòng thử lại.");
            return "authentication/register";
        }

        return "redirect:/authentication/enterRegisterOTP";
    }

    @GetMapping("/authentication/enterRegisterOTP")
    public String getOTPPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String registerDTOJson = (String) session.getAttribute("registerDTO");

        if (registerDTOJson == null) {
            logger.warn("Phiên đã hết hạn hoặc không tìm thấy RegisterDTO");
            request.setAttribute("message", "Phiên làm việc hết hạn. Vui lòng đăng ký lại.");
            return "redirect:/register";
        }

        logger.info("Accessing OTP entry page");
        model.addAttribute("newOtpForm", new OTPForm());
        return "authentication/enterRegisterOTP";
    }

    @PostMapping("/authentication/enterRegisterOTP")
    public String validateOtp(HttpServletRequest request, @RequestParam("otp") int otp, Model model) {
        HttpSession session = request.getSession();
        Integer generatedOtp = (Integer) session.getAttribute("otp");
        String registerDTOJson = (String) session.getAttribute("registerDTO");
        String email = (String) session.getAttribute("email");

        logger.info("Xác minh OTP cho email: {}, OTP nhập: {}", email, otp);
        logger.debug("OTP trong phiên bản: {}", generatedOtp);

        if (registerDTOJson == null) {
            logger.error("Không tìm thấy RegisterDTO trong phiên bản cho email: {}", email);
            model.addAttribute("message", "Lỗi phiên làm việc. Vui lòng thử lại.");
            return "authentication/register";
        }

        RegisterDTO registerDTO = null;
        try {
            registerDTO = objectMapper.readValue(registerDTOJson, RegisterDTO.class);
            logger.debug("Đã chuyển RegisterDTO từ JSON: {}", registerDTO);
        } catch (JsonProcessingException e) {
            logger.error("Không thể chuyển JSON về RegisterDTO cho email: {}", email, e);
            model.addAttribute("message", "Lỗi phiên làm việc. Vui lòng thử lại.");
            return "authentication/register";
        }

        if (generatedOtp != null && generatedOtp.equals(otp) && registerDTO != null) {
            logger.info("OTP xác minh thành công cho email: {}", email);
            try {
                User user = this.userService.registerDTOtoUser(registerDTO);
                String hashPassword = this.passwordEncoder.encode(registerDTO.getPassword());
                user.setPassword(hashPassword);
                user.setRole(this.userService.getRoleByName("CUSTOMER"));
                user.setStatus(true);

                logger.debug("Người dùng sẽ được lưu: {}", user);
                this.userService.handleSaveUser(user);
                logger.info("Lưu người dùng thành công cho email: {}", email);

                session.invalidate();
                return "redirect:/login?registersuccess";
            } catch (Exception e) {
                logger.error("Lỗi khi lưu người dùng cho email: {}", email, e);
                model.addAttribute("message", "Lỗi khi tạo tài khoản. Vui lòng thử lại.");
                return "authentication/enterRegisterOTP";
            }
        } else {
            logger.warn("OTP không hợp lệ cho email: {}. Nhập: {}, Mong đợi: {}", email, otp, generatedOtp);
            model.addAttribute("message", "Mã OTP không đúng. Vui lòng thử lại.");
            return "authentication/enterRegisterOTP";
        }
    }
}