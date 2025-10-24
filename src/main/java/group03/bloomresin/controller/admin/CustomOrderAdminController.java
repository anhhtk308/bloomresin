package group03.bloomresin.controller.admin;

import group03.bloomresin.domain.CustomOrder;
import group03.bloomresin.service.CustomOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/custom-order")
@RequiredArgsConstructor
public class CustomOrderAdminController {

    private final CustomOrderService service;

    // Redirect nếu vào /admin/custom-order
    @GetMapping
    public String redirectToList() {
        return "redirect:/admin/custom-order/list";
    }

    // Hiển thị danh sách
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("customOrders", service.findAll());
        return "admin/custom_order/custom_order_list";
    }

    // Hiển thị chi tiết đơn hàng
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        CustomOrder customOrder = service.findById(id).orElse(null);
        if (customOrder == null) return "redirect:/admin/custom-order/list";

        model.addAttribute("customOrder", customOrder);
        return "admin/custom_order/custom_order_detail";
    }

    // Cập nhật trạng thái đơn
    @PostMapping("/update-status/{id}")
    public String updateStatus(@PathVariable Long id,
                               @RequestParam("status") String status) {
        CustomOrder order = service.findById(id).orElse(null);
        if (order != null) {
            order.setStatus(status);
            service.save(order);
        }
        return "redirect:/admin/custom-order/detail/" + id;
    }
}
