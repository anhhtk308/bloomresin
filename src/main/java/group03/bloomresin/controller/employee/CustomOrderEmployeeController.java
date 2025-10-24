package group03.bloomresin.controller.employee;

import group03.bloomresin.domain.CustomOrder;
import group03.bloomresin.service.CustomOrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/employee/custom-order")
@RequiredArgsConstructor
public class CustomOrderEmployeeController {

    private final CustomOrderService service;

    // Redirect nếu vào /admin/custom-order
    @GetMapping
    public String redirectToList() {
        return "redirect:/employee/custom-order/list";
    }

    // Hiển thị danh sách
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("customOrders", service.findAll());
        return "employee/custom_order/custom_order_list";
    }

    // Hiển thị chi tiết đơn hàng
    @GetMapping("/detail/{id}")
    public String detail(@PathVariable Long id, Model model) {
        CustomOrder customOrder = service.findById(id).orElse(null);
        if (customOrder == null) return "redirect:/employee/custom-order/list";

        model.addAttribute("customOrder", customOrder);
        return "employee/custom_order/custom_order_detail";
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
        return "redirect:/employee/custom-order/detail/" + id;
    }
}
