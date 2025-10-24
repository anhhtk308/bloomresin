package group03.bloomresin.controller.admin;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import group03.bloomresin.service.UserService;
import group03.bloomresin.domain.User;
import group03.bloomresin.domain.Order;
import group03.bloomresin.service.OrderService;

@Controller
public class OrderController {
    private final OrderService orderService;
    private final UserService userService;

    public OrderController(OrderService orderService, UserService userService) {
        this.orderService = orderService;
        this.userService = userService;
    }

    @GetMapping("/admin/order")
    public String getDashboard(Model model) {
        List<Order> orders = this.orderService.fetchAllOrders();
        model.addAttribute("orders", orders);
        long newOrderCount = orderService.countNewOrders();
        model.addAttribute("newOrderCount", newOrderCount);
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id) {
        Order order = this.orderService.fetchOrderById(id).get();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
        String formattedDate = order.getOrderDate().format(formatter);

        model.addAttribute("order", order);
        model.addAttribute("id", id);
        model.addAttribute("orderDetails", order.getOrderDetails());
        model.addAttribute("formattedOrderDate", formattedDate);

        return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        model.addAttribute("newOrder", currentOrder.get());
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String handleUpdateOrder(@ModelAttribute("newOrder") Order order) {
        this.orderService.updateOrder(order);
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/customer/{customerId}/purchase-history")
    public String getPurchaseHistory(@PathVariable long customerId, Model model) {
        Optional<User> customer = userService.findUserById(customerId);
        if (customer.isPresent()) {
            List<Order> orders = orderService.fetchOrdersByCustomerId(customerId);
            model.addAttribute("customer", customer);
            model.addAttribute("orders", orders);
        } else {
            model.addAttribute("error", "Không tìm thấy khách hàng");
        }
        return "admin/customer/purchaseHistory";
    }

    @GetMapping("/admin/order/update-to-complete/{id}")
    public String updateOrderToComplete(@PathVariable long id) {
        Optional<Order> optionalOrder = orderService.fetchOrderById(id);
        if (optionalOrder.isPresent()) {
            Order order = optionalOrder.get();
            order.setStatus("COMPLETE");
            orderService.updateOrder(order);
        }
        return "redirect:/admin/order";
    }

}