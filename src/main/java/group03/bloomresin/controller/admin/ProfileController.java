package group03.bloomresin.controller.admin;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group03.bloomresin.domain.User;
import group03.bloomresin.service.UploadService;
import group03.bloomresin.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.Optional;

@Controller
public class ProfileController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public ProfileController(UserService userService, UploadService uploadService,
                             PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/profile/{id}")
    public String getAdminProfile(@PathVariable Long id, Model model, HttpServletRequest request) {
        return getProfile(id, model, request, "admin");
    }

    @PostMapping("/admin/profile/update")
    public String updateAdminProfile(@ModelAttribute("newUser") User user,
                                     @RequestParam("imagesFile") MultipartFile file,
                                     HttpServletRequest request,
                                     RedirectAttributes redirectAttributes) {
        return updateProfile(user, file, request, redirectAttributes, "admin");
    }

    @GetMapping("/employee/profile/{id}")
    public String getEmployeeProfile(@PathVariable Long id, Model model, HttpServletRequest request) {
        return getProfile(id, model, request, "employee");
    }

    @PostMapping("/employee/profile/update")
    public String updateEmployeeProfile(@ModelAttribute("newUser") User user,
                                        @RequestParam("imagesFile") MultipartFile file,
                                        HttpServletRequest request,
                                        RedirectAttributes redirectAttributes) {
        return updateProfile(user, file, request, redirectAttributes, "employee");
    }

    @GetMapping("/customer/profile/{id}")
    public String getCustomerProfile(@PathVariable Long id, Model model, HttpServletRequest request) {
        return getProfile(id, model, request, "customer");
    }

    @PostMapping("/customer/profile/update")
    public String updateCustomerProfile(@ModelAttribute("newUser") User user,
                                        @RequestParam("imagesFile") MultipartFile file,
                                        HttpServletRequest request,
                                        RedirectAttributes redirectAttributes) {
        return updateProfile(user, file, request, redirectAttributes, "customer");
    }

    private String getProfile(Long id, Model model, HttpServletRequest request, String role) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            return "redirect:/login";
        }
        String email = (String) session.getAttribute("username");
        Optional<User> optionalUser = userService.getUserByEmail(email);
        if (optionalUser.isEmpty() || optionalUser.get().getId() != id) {
            return "redirect:/login";
        }
        User userFromDb = optionalUser.get();
        model.addAttribute("newUser", userFromDb);
        return role + "/profile/profile";
    }

    private String updateProfile(User user, MultipartFile file,
                                 HttpServletRequest request,
                                 RedirectAttributes redirectAttributes,
                                 String role) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            redirectAttributes.addFlashAttribute("error", "Người dùng chưa đăng nhập.");
            return "redirect:/login";
        }

        String email = (String) session.getAttribute("username");
        Optional<User> sessionUserOptional = userService.getUserByEmail(email);
        if (sessionUserOptional.isEmpty() || sessionUserOptional.get().getId() != user.getId()) {
            redirectAttributes.addFlashAttribute("error", "Hành động không được phep.");
            return "redirect:/" + role + "/profile/" + user.getId();
        }

        Optional<User> optionalUser = userService.getUserById(user.getId());
        if (optionalUser.isPresent()) {
            User currentUser = optionalUser.get();

            if (!file.isEmpty()) {
                String img = uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(img);
            }

            currentUser.setAddress(user.getAddress());
            currentUser.setFullName(user.getFullName());
            currentUser.setPhone(user.getPhone());

            try {
                userService.handleSaveUser(currentUser);
                redirectAttributes.addFlashAttribute("message", "Cập nhật hồ sơ thành công.");
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("error", "Lỗi khi cập nhật hồ sơ: " + e.getMessage());
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy người dùng.");
        }

        return "redirect:/" + role + "/profile/" + user.getId();
    }
}
