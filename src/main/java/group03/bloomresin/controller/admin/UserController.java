package group03.bloomresin.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group03.bloomresin.domain.User;
import group03.bloomresin.service.UploadService;
import group03.bloomresin.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String getDashboard(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("users", users);
        return "admin/user/show";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(Model model, @ModelAttribute("newUser") @Valid User user,
            BindingResult newUserBindingResult,
            @RequestParam("hoidanitFile") MultipartFile file) {
        if (newUserBindingResult.hasErrors()) {
            return "admin/user/create";
        }
        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setAvatar(avatar);
        user.setPassword(hashPassword);
        user.setStatus(true);
        user.setRole(this.userService.getRoleByName(user.getRole().getName()));
        this.userService.handleSaveUser(user);
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUser(Model model, @ModelAttribute("newUser") User eric) {
        this.userService.deleteAUser(eric.getId());
        return "redirect:/admin/user";
    }

    @PostMapping("/admin/customer/ban/{userId}")
    public String banOrUnbanCustomer(@PathVariable Long userId, @RequestParam boolean status,
            RedirectAttributes redirectAttributes) {
        try {
            if (!status) {
                userService.banCustomerAccount(userId);
                redirectAttributes.addFlashAttribute("message", "Tài khoản này đã khóa");
            } else {
                userService.unbanCustomerAccount(userId);
                redirectAttributes.addFlashAttribute("message", "Đã mở kháo tài khoản thành công");
            }
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (EntityNotFoundException e) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy tài khoản!");
        }
        return "redirect:/admin/customer";
    }

    @GetMapping("/admin/customer")
    public String getAllCustomer(Model model) {
        List<User> customers = this.userService.getUsersRoleId(3);
        model.addAttribute("customers", customers);
        return "admin/customer/show";
    }

    @GetMapping("/admin/customer/create")
    public String getCreateCustomerPage(Model model) {
        model.addAttribute("newCustomer", new User());
        return "admin/customer/create";
    }

    @PostMapping(value = "admin/customer/create")
    public String createCustomerPage(Model model, @ModelAttribute("newCustomer") @Valid User customer,
            BindingResult newUserBindingResult,
            @RequestParam(value = "imagesFile", required = false) MultipartFile imageFile,
            @RequestParam(value = "excelFile", required = false) MultipartFile excelFile) {
        if (excelFile == null || excelFile.isEmpty()) {
            if (newUserBindingResult.hasErrors()) {
                return "admin/customer/create";
            }
            String avatar = imageFile != null && !imageFile.isEmpty()
                    ? this.uploadService.handleSaveUploadFile(imageFile, "avatar")
                    : null;
            String hashPassword = this.passwordEncoder.encode(customer.getPassword());
            customer.setAvatar(avatar);
            customer.setPassword(hashPassword);
            customer.setStatus(true);
            customer.setRole(this.userService.getRoleByName("CUSTOMER"));
            this.userService.handleSaveUser(customer);
        }
        else {
            try {
                List<User> customers = this.userService.importFromExcel(excelFile);
                if (customers.isEmpty()) {
                    model.addAttribute("errorMessage", "Không tìm thấy khách hàng hợp lệ trong tệp Excel");
                    return "admin/customer/create";
                }
                for (User user : customers) {
                    if (this.userService.checkEmailExist(user.getEmail())) {
                        continue;
                    }
                    user.setPassword(this.passwordEncoder.encode(user.getPassword()));
                    this.userService.handleSaveUser(user);
                }
            } catch (Exception e) {
                model.addAttribute("errorMessage", "Lỗi khi nhập tệp Excel: " + e.getMessage());
                return "admin/customer/create";
            }
        }
        return "redirect:/admin/customer";
    }

    @PostMapping("/admin/customer/import")
    public String importCustomersFromExcel(@RequestParam("excelFile") MultipartFile excelFile,
            RedirectAttributes redirectAttributes) {
        try {
            if (excelFile.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Vui lòng nhập tệp Excel.");
                return "redirect:/admin/customer";
            }
            List<User> customers = this.userService.importFromExcel(excelFile);
            if (customers.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Không tìm thấy khách hàng hợp lệ trong tệp Excel.");
                return "redirect:/admin/customer";
            }
            int successCount = 0;
            int errorCount = 0;
            StringBuilder errorDetails = new StringBuilder();
            for (User user : customers) {
                if (this.userService.checkEmailExist(user.getEmail())) {
                    errorDetails.append("Email ").append(user.getEmail()).append(" đã tồn tại; ");
                    errorCount++;
                    continue;
                }
                try {
                    user.setPassword(this.passwordEncoder.encode(user.getPassword()));
                    this.userService.handleSaveUser(user);
                    successCount++;
                } catch (Exception e) {
                    errorCount++;
                    errorDetails.append("User with email ").append(user.getEmail()).append(": ").append(e.getMessage())
                            .append("; ");
                }
            }
            if (successCount > 0) {
                redirectAttributes.addFlashAttribute("message",
                        "Nhập " + successCount + " khách hàng thành công.");
            }
            if (errorCount > 0) {
                redirectAttributes.addFlashAttribute("error",
                        "Không thể nhập " + errorCount + " khách hàng: " + errorDetails.toString());
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi nhập tệp Excel: " + e.getMessage());
        }
        return "redirect:/admin/customer";
    }

    @RequestMapping("/admin/customer/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        Optional<User> customerOptional = this.userService.getUserById(id);
        User currentCustomer = customerOptional.orElse(null);
        if (currentCustomer == null || !currentCustomer.isStatus()) {
            return "redirect:/admin/customer";
        }
        model.addAttribute("newCustomer", currentCustomer);
        return "admin/customer/update";
    }

    @PostMapping("/admin/customer/update")
    public String postUpdateUser(Model model, @ModelAttribute("newCustomer") @Valid User customer,
            BindingResult newProductBindingResult,
            @RequestParam("imagesFile") MultipartFile file) {
        Optional<User> customerOptional = this.userService.getUserById(customer.getId());
        User currentCustomer = customerOptional.orElse(null);
        if (currentCustomer != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentCustomer.setAvatar(img);
            }
            currentCustomer.setAddress(customer.getAddress());
            currentCustomer.setFullName(customer.getFullName());
            currentCustomer.setPhone(customer.getPhone());
            this.userService.handleSaveUser(currentCustomer);
        }
        return "redirect:/admin/customer";
    }

    @GetMapping("/admin/customer/{id}")
    public String getCustomerDetailPage(Model model, @PathVariable long id) {
        Optional<User> customerOptional = this.userService.getUserById(id);
        User newCustomer = customerOptional.orElse(null);
        model.addAttribute("newCustomer", newCustomer);
        model.addAttribute("id", id);
        return "admin/customer/detail";
    }

    @GetMapping("/admin/employee")
    public String getAllEmployee(Model model) {
        List<User> employees = this.userService.getUsersByRoleId(2L);
        model.addAttribute("employees", employees);
        return "admin/employee/show";
    }

    @GetMapping("/admin/employee/create")
    public String getCreateEmployeePage(Model model) {
        model.addAttribute("newEmployee", new User());
        return "admin/employee/create";
    }

    @PostMapping(value = "/admin/employee/create")
    public String createEmployeePage(Model model,
            @ModelAttribute("newEmployee") @Valid User employee,
            BindingResult newUserBindingResult,
            HttpServletRequest request,
            @RequestParam("imagesFile") MultipartFile file) {
        if (newUserBindingResult.hasErrors()) {
            return "admin/employee/create";
        }

        try {
            String avatar = file != null && !file.isEmpty() ? this.uploadService.handleSaveUploadFile(file, "avatar")
                    : null;
            employee.setAvatar(avatar);
            String rawPassword = employee.getPassword();
            String hashPassword = this.passwordEncoder.encode(rawPassword);
            employee.setPassword(hashPassword);
            employee.setStatus(true);
            employee.setRole(this.userService.getRoleByName("EMPLOYEE"));
            this.userService.saveEmployeeWithEmail(employee, rawPassword);
            return "redirect:/admin/employee";
        } catch (Exception e) {
            model.addAttribute("message", "Lỗi khi tạo nhân viên: " + e.getMessage());
            return "admin/employee/create";
        }
    }

    @GetMapping("/admin/employee/resend-email/{id}")
    public String resendEmployeeEmail(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            userService.resendEmployeeEmail(id);
            redirectAttributes.addFlashAttribute("message", "Đã gửi lại email thành công.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "Lỗi khi gửi lại email: " + e.getMessage());
        }
        return "redirect:/admin/employee";
    }

    @RequestMapping("/admin/employee/update/{id}")
    public String getUpdateEmployeePage(Model model, @PathVariable long id) {
        Optional<User> employeeOptional = this.userService.getUserById(id);
        User currentEmployee = employeeOptional.orElse(null);
        if (currentEmployee == null || !currentEmployee.isStatus()) {
            return "redirect:/admin/employee";
        }
        model.addAttribute("newEmployee", currentEmployee);
        return "admin/employee/update";
    }

    @PostMapping("/admin/employee/update")
    public String postUpdateEmployee(Model model, @ModelAttribute("newEmployee") @Valid User employee,
            BindingResult newProductBindingResult,
            @RequestParam("imagesFile") MultipartFile file) {
        Optional<User> employeeOptional = this.userService.getUserById(employee.getId());
        User currentEmployee = employeeOptional.orElse(null);
        if (currentEmployee != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentEmployee.setAvatar(img);
            }
            currentEmployee.setAddress(employee.getAddress());
            currentEmployee.setFullName(employee.getFullName());
            currentEmployee.setPhone(employee.getPhone());
            this.userService.handleSaveUser(currentEmployee);
        }
        return "redirect:/admin/employee";
    }

    @GetMapping("/admin/employee/{id}")
    public String getEmployeeDetailPage(Model model, @PathVariable long id) {
        Optional<User> employeeOptional = this.userService.getUserById(id);
        User newEmployee = employeeOptional.orElse(null);
        model.addAttribute("newEmployee", newEmployee);
        model.addAttribute("id", id);
        return "admin/employee/detail";
    }

    @PostMapping("/admin/employee/ban/{userId}")
    public String banOrUnbanEmployee(@PathVariable Long userId, @RequestParam boolean status,
            RedirectAttributes redirectAttributes) {
        try {
            if (!status) {
                userService.banEmployeeAccount(userId);
                redirectAttributes.addFlashAttribute("message", "Tài khoản nhân viên đã bị khóa.");
            } else {
                userService.unbanEmployeeAccount(userId);
                redirectAttributes.addFlashAttribute("message", "Tài khoản nhân viên đã được mở khóa.");
            }
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        } catch (EntityNotFoundException e) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy tài khoản nhân viên!");
        }
        return "redirect:/admin/employee";
    }

}