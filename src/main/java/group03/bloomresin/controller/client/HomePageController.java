package group03.bloomresin.controller.client;

import group03.bloomresin.domain.*;
import group03.bloomresin.service.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.*;
import java.util.*;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final OrderService orderService;
    private final NewsService newsService;
    private final UserService userService;
    private final CustomOrderService customOrderService;

    public HomePageController(ProductService productService,
                              CategoryService categoryService,
                              OrderService orderService,
                              NewsService newsService,
                              UserService userService,
                              CustomOrderService customOrderService) {
        this.productService = productService;
        this.categoryService = categoryService;
        this.orderService = orderService;
        this.newsService = newsService;
        this.userService = userService;
        this.customOrderService = customOrderService;
    }

    @GetMapping("/")
    public String getHomePage(Model model) {
        model.addAttribute("products", productService.fetchProducts());
        model.addAttribute("categories", categoryService.getCategoryByStatus(true));
        model.addAttribute("newsList", newsService.getAllNews());
        return "customer/homepage/show";
    }

    @GetMapping("/news")
    public String showNewsPage(Model model) {
        model.addAttribute("newsList", newsService.getActiveNews());
        return "customer/news/list";
    }

    @GetMapping("/news/{id}")
    public String getNewsDetail(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id);
        model.addAttribute("news", news);
        return "customer/news/detail";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        Long userId = getSessionUserId(request);
        if (userId != null) {
            User currentUser = userService.findById(userId);
            if (currentUser != null) {
                List<Order> orders = orderService.getOrdersByUser(currentUser);
                List<CustomOrder> customOrders = customOrderService.findByUser(currentUser);

                Map<Long, Date> convertedDates = convertCustomOrderDates(customOrders);
                model.addAttribute("orders", orders);
                model.addAttribute("customOrders", customOrders);
                model.addAttribute("convertedDates", convertedDates);
            }
        }
        return "customer/order/history";
    }

    @GetMapping("/order-tracking")
    public String getOrderTracking(Model model, HttpServletRequest request) {
        Long userId = getSessionUserId(request);
        if (userId != null) {
            User currentUser = userService.findById(userId);
            if (currentUser != null) {
                List<Order> orders = orderService.getOrdersByUserAndStatusNotIn(currentUser, List.of("COMPLETE", "CANCEL"));
                List<CustomOrder> customOrders = customOrderService.findByUserAndStatusNotIn(currentUser, List.of("COMPLETED", "CANCELLED"));

                Map<Long, Date> convertedDates = convertCustomOrderDates(customOrders);
                model.addAttribute("orders", orders);
                model.addAttribute("customOrders", customOrders);
                model.addAttribute("convertedDates", convertedDates);
            }
        }
        return "customer/order/tracking";
    }

    @GetMapping("/customer/order/cancel/{id}")
    @Transactional
    public String cancelNormalOrder(@PathVariable("id") Long id,
                                    HttpServletRequest request,
                                    RedirectAttributes redirectAttributes) {

        Optional<Order> existingOrder = orderService.fetchOrderById(id);
        if (existingOrder.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy đơn hàng.");
            return "redirect:/order-tracking";
        }

        Order currentOrder = existingOrder.get();
        Long userId = getSessionUserId(request);
        if (userId == null || !Objects.equals(userId, currentOrder.getUser().getId())) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền hủy đơn hàng này.");
            return "redirect:/order-tracking";
        }

        if ("CANCEL".equals(currentOrder.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Đơn hàng đã bị hủy trước đó.");
            return "redirect:/order-tracking";
        }

        if (!"PENDING".equals(currentOrder.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "Đơn hàng không thể hủy ở giai đoạn này.");
            return "redirect:/order-tracking";
        }

        for (OrderDetail detail : currentOrder.getOrderDetails()) {
            Product product = detail.getProduct();
            if (product != null) {
                product.setQuantity(product.getQuantity() + detail.getQuantity());
                product.setSold(product.getSold() - detail.getQuantity());
                product.setUpdatedAt(LocalDateTime.now());
                productService.handleSaveProduct(product);
            }
        }

        currentOrder.setStatus("CANCEL");
        orderService.saveOrder(currentOrder);

        redirectAttributes.addFlashAttribute("message", "✅ Hủy đơn hàng thành công.");
        return "redirect:/order-tracking";
    }

    @GetMapping("/customer/custom-order/cancel/{id}")
    public String cancelCustomOrder(@PathVariable("id") Long id,
                                    HttpServletRequest request,
                                    RedirectAttributes redirectAttributes) {

        Long userId = getSessionUserId(request);
        if (userId == null) {
            return "redirect:/login";
        }

        Optional<CustomOrder> customOrder = customOrderService.findById(id);
        if (customOrder.isEmpty() || !Objects.equals(userId, customOrder.get().getUser().getId())) {
            redirectAttributes.addFlashAttribute("error", "Bạn không có quyền hủy đơn hàng này.");
            return "redirect:/order-tracking";
        }

        if ("CONFIRM".equals(customOrder.get().getStatus())) {
            customOrder.get().setStatus("CANCELLED");
            customOrderService.save(customOrder.orElse(null));
            redirectAttributes.addFlashAttribute("message", "✅ Đã hủy đơn hàng thành công.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Chỉ có thể hủy đơn hàng khi đang chờ xác nhận.");
        }

        return "redirect:/order-tracking";
    }

    /**
     * Trích xuất userId từ session, ép kiểu nếu cần.
     */
    private Long getSessionUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;

        Object rawId = session.getAttribute("id");
        if (rawId instanceof Long) return (Long) rawId;
        if (rawId instanceof Integer) return ((Integer) rawId).longValue();
        return null;
    }

    /**
     * Chuyển createdAt từ LocalDateTime sang java.util.Date để dùng trong JSTL fmt.
     */
    private Map<Long, Date> convertCustomOrderDates(List<CustomOrder> customOrders) {
        Map<Long, Date> result = new HashMap<>();
        for (CustomOrder co : customOrders) {
            if (co.getCreatedAt() != null) {
                Instant instant = co.getCreatedAt().atZone(ZoneId.systemDefault()).toInstant();
                result.put(co.getId(), Date.from(instant));
            }
        }
        return result;
    }
}
