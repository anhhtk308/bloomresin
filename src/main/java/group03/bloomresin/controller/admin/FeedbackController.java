package group03.bloomresin.controller.admin;

import group03.bloomresin.domain.ProductReview;
import group03.bloomresin.service.FeedbackService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin/customer")
public class FeedbackController {
    private final FeedbackService feedbackService;
    public FeedbackController(FeedbackService feedbackService) {
        this.feedbackService = feedbackService;
    }

    @GetMapping("/{userId}/feedback")
    public String getFeedback(@PathVariable Long userId, Model model) {
        List<ProductReview> feedbackList = feedbackService.getFeedbackByUserId(userId);
        model.addAttribute("feedbackList", feedbackList);
        model.addAttribute("userId", userId);
        model.addAttribute("feedback", new ProductReview());
        return "admin/customer/feedback";
    }

    @PostMapping("/feedback/{feedbackId}")
    public String updateFeedbackVisibility(@PathVariable Long feedbackId, @RequestParam String visible) {
        feedbackService.updateFeedbackVisibility(feedbackId, visible);
        Long userId = feedbackService.getFeedbackById(feedbackId).getUser().getId();
        return "redirect:/admin/customer/" + userId + "/feedback";
    }
}
