package group03.bloomresin.controller.client;

import group03.bloomresin.domain.*;
import group03.bloomresin.service.OrderService;
import group03.bloomresin.service.ProductService;
import group03.bloomresin.repository.CartRepository;
import group03.bloomresin.repository.CartDetailRepository;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

@Controller
public class PaymentController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private ProductService productService;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private CartDetailRepository cartDetailRepository;

    @GetMapping("/createOrder")
    public String createOrder(
            @RequestParam("amount") double amount,
            @RequestParam("orderInfo") String orderInfo,
            @RequestParam("receiverAddress") String address,
            @RequestParam("receiverName") String name,
            @RequestParam("phone") String phone,
            @RequestParam("paymentMethod") String paymentMethod,
            Model model,
            HttpSession session
    ) {
        if (amount <= 0) {
            model.addAttribute("error", "Số tiền phải lớn hơn 0");
            return "customer/payment/createOrder";
        }

        // Lưu thông tin khác vào session
        session.setAttribute("amount", amount);
        session.setAttribute("orderInfo", orderInfo);
        session.setAttribute("receiverAddress", address);
        session.setAttribute("receiverName", name);
        session.setAttribute("receiverPhone", phone);
        // Không cần lưu paymentMethod vào session nữa

        model.addAttribute("totalAmount", amount);
        model.addAttribute("orderDetails", orderInfo);
        model.addAttribute("receiverAddress", address);
        model.addAttribute("receiverName", name);
        model.addAttribute("receiverPhone", phone);
        model.addAttribute("paymentMethod", paymentMethod); // render lại UI nếu cần

        return "customer/payment/createOrder";
    }

    @GetMapping("/submitOrder")
    public String submitOrder(
            @RequestParam("paymentMethod") String paymentMethod,
            HttpSession session,
            Model model
    ) {
        Double amount = (Double) session.getAttribute("amount");
        String orderInfo = (String) session.getAttribute("orderInfo");
        String receiverAddress = (String) session.getAttribute("receiverAddress");
        String receiverName = (String) session.getAttribute("receiverName");
        String receiverPhone = (String) session.getAttribute("receiverPhone");

        if (amount == null || amount <= 0) {
            model.addAttribute("error", "Không thể xử lý đơn hàng. Số tiền không hợp lệ.");
            return "customer/payment/orderfail";
        }

        Long userId = (Long) session.getAttribute("id");
        User user = new User();
        user.setId(userId);

        Cart cart = productService.fetchByUser(user);
        if (cart == null || cart.getCartDetails().isEmpty()) {
            model.addAttribute("error", "Giỏ hàng trống.");
            return "customer/payment/orderfail";
        }

        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setReceiverAddress(receiverAddress);
        order.setNote(orderInfo);
        order.setStatus("PENDING");
        order.setTotalPrice(amount);
        order.setOrderDate(LocalDateTime.now());
        order.setPaymentMethod("cod".equalsIgnoreCase(paymentMethod) ? "COD" : "BANKING");

        List<OrderDetail> orderDetails = new ArrayList<>();
        for (CartDetail cd : cart.getCartDetails()) {
            Product product = cd.getProduct();

            if (product.getQuantity() < cd.getQuantity()) {
                model.addAttribute("error", "Sản phẩm " + product.getName() + " không đủ hàng.");
                return "customer/payment/orderfail";
            }

            OrderDetail od = new OrderDetail();
            od.setProduct(product);
            od.setQuantity((int) cd.getQuantity());
            od.setPrice(cd.getPrice());
            od.setOrder(order);
            orderDetails.add(od);

            product.setQuantity(product.getQuantity() - cd.getQuantity());
            product.setSold(product.getSold() + cd.getQuantity());
            product.setUpdatedAt(LocalDateTime.now());
            productService.handleSaveProduct(product);
        }

        order.setOrderDetails(orderDetails);
        orderService.saveOrder(order);

        for (CartDetail cd : cart.getCartDetails()) {
            cartDetailRepository.delete(cd);
        }
        cartRepository.delete(cart);
        session.setAttribute("sum", 0);

        model.addAttribute("order", order);

        if ("cod".equalsIgnoreCase(paymentMethod)) {
            return "redirect:/cod-confirmation";
        } else {
            return "customer/payment/pendingBankTransfer";
        }
    }

    @GetMapping("/cod-confirmation")
    public String showCodConfirmation(HttpSession session, Model model) {
        String orderInfo = (String) session.getAttribute("orderInfo");
        Double amount = (Double) session.getAttribute("amount");

        model.addAttribute("message", "Đơn hàng của bạn đã được tạo thành công!");
        model.addAttribute("paymentType", "COD");
        model.addAttribute("orderInfo", orderInfo);
        model.addAttribute("amount", amount);

        return "customer/payment/codConfirmation";
    }

    @GetMapping("/payment-complete")
    public String markOrderComplete(@RequestParam("orderId") Long orderId, Model model) {
        Optional<Order> optOrder = orderService.getOrderById(orderId);
        if (optOrder.isPresent()) {
            Order order = optOrder.get();
            order.setStatus("COMPLETE");
            orderService.saveOrder(order);

            model.addAttribute("orderInfo", order.getNote());
            model.addAttribute("amount", order.getTotalPrice());
            model.addAttribute("paymentTime", order.getOrderDate());
            model.addAttribute("transactionId", "BankTransfer-" + order.getId());

            return "customer/payment/ordersuccess";
        }

        model.addAttribute("error", "Không tìm thấy đơn hàng.");
        return "customer/payment/orderfail";
    }

    @GetMapping("/order-success")
    public String viewOrderSuccess(@RequestParam("orderId") Long orderId, Model model) {
        Optional<Order> order = orderService.getOrderById(orderId);
        if (order.isEmpty()) {
            model.addAttribute("error", "Không tìm thấy đơn hàng");
            return "customer/payment/orderfail";
        }

        model.addAttribute("order", order.get());
        model.addAttribute("orderInfo", order.get().getNote());
        model.addAttribute("amount", order.get().getTotalPrice());
        model.addAttribute("paymentTime", order.get().getConvertedOrderDate());
        model.addAttribute("transactionId", "BankTransfer-" + order.get().getId());

        return "customer/payment/ordersuccess";
    }

    @GetMapping("/payment-fail")
    public String showFailPage() {
        return "customer/payment/orderfail";
    }

    @GetMapping("/thank")
    public String thankYouPage(HttpSession session) {
        session.removeAttribute("cart");
        session.removeAttribute("paymentInfo");
        return "thank";
    }
}
