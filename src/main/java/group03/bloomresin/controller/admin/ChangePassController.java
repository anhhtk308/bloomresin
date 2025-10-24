package group03.bloomresin.controller.admin;

import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import group03.bloomresin.domain.PasswordChangeForm;
import group03.bloomresin.domain.User;
import group03.bloomresin.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ChangePassController {

    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    public ChangePassController(UserService userService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/changepass")
    public String showChangePassForm(Model model) {
        model.addAttribute("passwordChangeForm", new PasswordChangeForm());
        return "admin/changepass/pass";
    }

    @PostMapping("/admin/changepass")
    public String changePassword(
            @Valid PasswordChangeForm passwordChangeForm,
            BindingResult bindingResult,
            Model model,
            HttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errorMessage", "Vui lòng sửa các lỗi bên dưới.");
            return "admin/changepass/pass";
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || email.isEmpty()) {
            model.addAttribute("errorMessage", "Phiên làm việc hết hạn hoặc chưa đăng nhập.");
            return "admin/changepass/pass";
        }

        Optional<User> user = userService.getUserByEmail(email);
        if (user.isEmpty()) {
            model.addAttribute("errorMessage", "Không tìm thấy người dùng.");
            return "admin/changepass/pass";
        }

        if (!passwordEncoder.matches(passwordChangeForm.getCurrentPassword(), user.get().getPassword())) {
            bindingResult.rejectValue("currentPassword", "error.passwordChangeForm", "Mật khẩu hiện tại không đúng.");
            return "admin/changepass/pass";
        }

        if (!passwordChangeForm.getNewPassword().equals(passwordChangeForm.getConfirmPassword())) {
            bindingResult.rejectValue("confirmPassword", "error.passwordChangeForm",
                    "Mật khẩu mới và mật khẩu xác nhận không trùng khớp.");
            return "admin/changepass/pass";
        }
        if (passwordChangeForm.getNewPassword().length() < 6) {
            model.addAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            return "admin/changepass/pass";
        }

        if (passwordChangeForm.getConfirmPassword().length() < 6) {
            model.addAttribute("errorMessage", "Mật khẩu xác nhận phải có ít nhất 6 ký tự.");
            return "admin/changepass/pass";
        }
        String hashedNewPassword = passwordEncoder.encode(passwordChangeForm.getNewPassword());
        userService.updatePassword(user.get().getEmail(), hashedNewPassword);

        model.addAttribute("successMessage", "Mật khẩu đã được thay đổi thành công.");
        return "admin/changepass/pass";
    }

    @GetMapping("/employee/changepass")
    public String showChangePassFormEmployee(Model model) {
        model.addAttribute("passwordChangeForm", new PasswordChangeForm());
        return "employee/changepass/pass";
    }

    @PostMapping("/employee/changepass")
    public String changePasswordEmployee(
            @Valid PasswordChangeForm passwordChangeForm,
            BindingResult bindingResult,
            Model model,
            HttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errorMessage", "Vui lòng sửa các lỗi bên dưới.");
            return "employee/changepass/pass";
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || email.isEmpty()) {
            model.addAttribute("errorMessage", "Phiên làm việc hết hạn hoặc chưa đăng nhập.");
            return "employee/changepass/pass";
        }

        Optional<User> user = userService.getUserByEmail(email);
        if (user.isEmpty()) {
            model.addAttribute("errorMessage", "Không tìm thấy người dùng.");
            return "employee/changepass/pass";
        }

        if (!passwordEncoder.matches(passwordChangeForm.getCurrentPassword(), user.get().getPassword())) {
            model.addAttribute("errorMessage", "Mật khẩu hiện tại không đúng.");
            return "employee/changepass/pass";
        }

        if (!passwordChangeForm.getNewPassword().equals(passwordChangeForm.getConfirmPassword())) {
            model.addAttribute("errorMessage", "Mật khẩu mới và mật khẩu xác nhận không trùng khớp.");
            return "employee/changepass/pass";
        }
        if (passwordChangeForm.getNewPassword().length() < 6) {
            model.addAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            return "employee/changepass/pass";
        }

        if (passwordChangeForm.getConfirmPassword().length() < 6) {
            model.addAttribute("errorMessage", "Mật khẩu xác nhận phải có ít nhất 6 ký tự.");
            return "employee/changepass/pass";
        }

        String hashedNewPassword = passwordEncoder.encode(passwordChangeForm.getNewPassword());
        userService.updatePassword(user.get().getEmail(), hashedNewPassword);

        model.addAttribute("successMessage", "Mật khẩu đã được thay đổi thành công.");
        return "employee/changepass/pass";
    }

    @GetMapping("/customer/changepass")
    public String showChangePassFormCustomer(Model model) {
        model.addAttribute("passwordChangeForm", new PasswordChangeForm());
        return "customer/changepass/pass";
    }

    @PostMapping("/customer/changepass")
    public String changePasswordCustomer(
            @Valid PasswordChangeForm passwordChangeForm,
            BindingResult bindingResult,
            Model model,
            HttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("errorMessage", "Vui lòng sửa các lỗi bên dưới.");
            return "customer/changepass/pass";
        }

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || email.isEmpty()) {
            model.addAttribute("errorMessage", "Phiên làm việc hết hạn hoặc chưa đăng nhập.");
            return "customer/changepass/pass";
        }

        Optional<User> user = userService.getUserByEmail(email);
        if (user.isEmpty()) {
            model.addAttribute("errorMessage", "Không tìm thấy người dùng.");
            return "customer/changepass/pass";
        }

        if (!passwordEncoder.matches(passwordChangeForm.getCurrentPassword(), user.get().getPassword())) {
            model.addAttribute("errorMessage", "Mật khẩu hiện tại không đúng.");
            return "customer/changepass/pass";
        }

        if (!passwordChangeForm.getNewPassword().equals(passwordChangeForm.getConfirmPassword())) {
            model.addAttribute("errorMessage", "Mật khẩu mới và mật khẩu xác nhận không trùng khớp.");
            return "customer/changepass/pass";
        }

        if (passwordChangeForm.getNewPassword().length() < 6) {
            model.addAttribute("errorMessage", "Mật khẩu mới phải có ít nhất 6 ký tự.");
            return "customer/changepass/pass";
        }

        if (passwordChangeForm.getConfirmPassword().length() < 6) {
            model.addAttribute("errorMessage", "Mật khẩu xác nhận phải có ít nhất 6 ký tự.");
            return "customer/changepass/pass";
        }
        String hashedNewPassword = passwordEncoder.encode(passwordChangeForm.getNewPassword());
        userService.updatePassword(user.get().getEmail(), hashedNewPassword);

        model.addAttribute("successMessage", "Mật khẩu đã được thay đổi thành công.");
        return "customer/changepass/pass";
    }
}