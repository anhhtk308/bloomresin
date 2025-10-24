package group03.bloomresin.controller.client;

import group03.bloomresin.domain.OrderDetail;
import group03.bloomresin.domain.ProductReview;
import group03.bloomresin.domain.User;
import group03.bloomresin.service.OrderDetailService;
import group03.bloomresin.service.ProductReviewService;
import group03.bloomresin.service.ProductService;
import group03.bloomresin.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;

import java.util.Optional;

@Controller

public class ProductReviewController {

    private final ProductService productService;
    private final UserService userService;
    private final ProductReviewService productReviewService;
    private final OrderDetailService orderDetailService;

    public ProductReviewController(ProductService productService, UserService userService,
                                   ProductReviewService productReviewService, OrderDetailService orderDetailService) {
        this.productService = productService;
        this.userService = userService;
        this.productReviewService = productReviewService;
        this.orderDetailService = orderDetailService;
    }

    @GetMapping("/customer/product-review/{orderDetailId}")
    public String showReviewPage(@PathVariable long orderDetailId, Model model, HttpSession session) {
        OrderDetail orderDetail = orderDetailService.findById(orderDetailId).orElse(null);
        String email = (String) session.getAttribute("email");
        Optional<User> user = userService.getUserByEmail(email);

        if (orderDetail == null || user.isEmpty()) {
            return "error/404";
        }

        ProductReview existingReview = productReviewService.findByOrderDetail(orderDetail);

        model.addAttribute("product", orderDetail.getProduct());
        model.addAttribute("user", user);
        model.addAttribute("orderDetail", orderDetail);
        model.addAttribute("existingReview", existingReview);

        model.addAttribute("isReviewed", existingReview != null);
        return "customer/product/review";
    }

    @PostMapping("/customer/submit-review/{orderDetailId}")
    public String submitReview(@PathVariable long orderDetailId,
                               @RequestParam(value = "rating", required = false) Integer rating,
                               @RequestParam("reviewContent") String reviewContent,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {

        String email = (String) session.getAttribute("email");
        Optional<User> user = userService.getUserByEmail(email);
        OrderDetail orderDetail = orderDetailService.findById(orderDetailId).orElse(null);

        if (orderDetail == null) {
            return "error/404";
        }

        ProductReview review = productReviewService.findByOrderDetail(orderDetail);

        if (review == null) {
            review = new ProductReview();
            review.setOrderDetail(orderDetail);
            review.setUser(user.orElse(null));
            review.setProduct(orderDetail.getProduct());
            review.setRating(rating);
        } else {
            if (rating != null) {
                redirectAttributes.addFlashAttribute("error", "Bạn không thể cập nhật số sao đã đánh giá.");
                return "redirect:/customer/product-review/" + orderDetailId;
            }
        }

        review.setReviewContent(reviewContent);
        productReviewService.saveProductReview(review);

        redirectAttributes.addFlashAttribute("message", "Đánh giá của bạn đã được cập nhật!");
        return "redirect:/customer/product/review-success";
    }

    @GetMapping("/customer/product/review-success")
    public String reviewSuccess(Model model) {
        model.addAttribute("message", "Cảm ơn bạn đã đánh giá sản phẩm!");
        return "customer/product/review-success";
    }
}



