package group03.bloomresin.controller.client;

import group03.bloomresin.domain.CustomOrder;
import group03.bloomresin.domain.User;
import group03.bloomresin.service.CustomOrderService;
import group03.bloomresin.service.UploadService;
import group03.bloomresin.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.Optional;

@Controller
@RequestMapping("/custom-order")
public class CustomOrderController {

    private final CustomOrderService customOrderService;
    private final UploadService uploadService;
    private final UserService userService;

    public CustomOrderController(CustomOrderService customOrderService,
                                 UploadService uploadService,
                                 UserService userService) {
        this.customOrderService = customOrderService;
        this.uploadService = uploadService;
        this.userService = userService;
    }

    @GetMapping("/form")
    public String showForm(Model model) {
        model.addAttribute("customOrder", new CustomOrder());
        return "customer/custom_order/custom_order_form";
    }

    @PostMapping("/submit")
    public String submitOrder(@Valid @ModelAttribute("customOrder") CustomOrder order,
                              BindingResult result,
                              @RequestParam("imageFile") MultipartFile imageFile,
                              Principal principal,
                              Model model) {

        if (!order.getPhone().isBlank() && !order.getPhone().matches("^\\d{9,11}$")) {
            result.rejectValue("phone", null, "Số điện thoại không hợp lệ");
        }

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Vui lòng kiểm tra lại thông tin.");
            return "customer/custom_order/custom_order_form";
        }

        if (!imageFile.isEmpty()) {
            String savedFileName = uploadService.handleSaveUploadFile(imageFile, "custom-order");
            order.setImage(savedFileName);
        } else {
            order.setImage("default_custom.png");
        }

        User user = userService.findByUsername(principal.getName());
        order.setUser(user);
        order.setCreatedAt(LocalDateTime.now());
        order.setStatus("CONFIRM");
        order.setProcessed(false);

        customOrderService.save(order);

        // ✅ Trả lại trang form và hiển thị thông báo thành công
        model.addAttribute("customOrder", new CustomOrder()); // reset form
        model.addAttribute("successMessage", "✅ Yêu cầu của bạn đã được gửi thành công!");
        return "customer/custom_order/custom_order_form";
    }

    @GetMapping("/edit/{id}")
    public String editCustomOrder(@PathVariable Long id, Model model, Principal principal) {
        Optional<CustomOrder> optionalOrder = customOrderService.findById(id);
        if (optionalOrder.isEmpty()) return "redirect:/order-history";

        CustomOrder order = optionalOrder.get();
        User user = userService.findByUsername(principal.getName());
        if (!Objects.equals(order.getUser().getId(), user.getId())) {
            return "redirect:/access-denied";
        }

        model.addAttribute("customOrder", order);
        return "customer/custom_order/custom_order_edit";
    }

    @PostMapping("/update")
    public String updateCustomOrder(@Valid @ModelAttribute("customOrder") CustomOrder customOrder,
                                    BindingResult result,
                                    @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                                    Principal principal,
                                    Model model,
                                    RedirectAttributes redirectAttributes) {

        Optional<CustomOrder> optional = customOrderService.findById(customOrder.getId());
        if (optional.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn hàng.");
            return "redirect:/order-history";
        }

        CustomOrder existing = optional.get();
        User user = userService.findByUsername(principal.getName());
        if (!Objects.equals(existing.getUser().getId(), user.getId())) {
            return "redirect:/access-denied";
        }

        if (!customOrder.getPhone().isBlank() && !customOrder.getPhone().matches("^\\d{9,11}$")) {
            result.rejectValue("phone", null, "Số điện thoại không hợp lệ");
        }

        if (result.hasErrors()) {
            model.addAttribute("errorMessage", "Vui lòng kiểm tra lại thông tin.");
            return "customer/custom_order/custom_order_edit";
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            String savedFileName = uploadService.handleSaveUploadFile(imageFile, "custom-order");
            customOrder.setImage(savedFileName);
        } else {
            customOrder.setImage(existing.getImage());
        }

        customOrder.setUser(existing.getUser());
        customOrder.setCreatedAt(existing.getCreatedAt());
        customOrder.setStatus(existing.getStatus());
        customOrder.setProcessed(existing.isProcessed());

        customOrderService.save(customOrder);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật đơn hàng thành công!");
        return "redirect:/order-history";
    }

    @GetMapping("/cancel/{id}")
    public String cancelCustomOrder(@PathVariable("id") Long id,
                                    HttpServletRequest request,
                                    RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("id") == null) {
            return "redirect:/login";
        }

        Long userId = (Long) session.getAttribute("id");
        Optional<CustomOrder> optional = customOrderService.findById(id);

        if (optional.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy đơn hàng.");
            return "redirect:/customer/order-tracking";
        }

        CustomOrder customOrder = optional.get();
        if (customOrder.getUser() == null || !Objects.equals(customOrder.getUser().getId(), userId)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Bạn không có quyền hủy đơn này.");
            return "redirect:/customer/order-tracking";
        }

        if ("CONFIRM".equals(customOrder.getStatus())) {
            customOrder.setStatus("CANCELLED");
            customOrderService.save(customOrder);
            redirectAttributes.addFlashAttribute("successMessage", "Đã hủy đơn hàng thành công.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Chỉ có thể hủy đơn hàng khi đang chờ xác nhận.");
        }

        return "redirect:/customer/order-tracking";
    }
}

