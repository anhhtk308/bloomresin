package group03.bloomresin.service;

import group03.bloomresin.domain.ProductReview;
import group03.bloomresin.repository.FeedbackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class FeedbackService {
    @Autowired
    private FeedbackRepository feedbackRepository;

    public List<ProductReview> getFeedbackByUserId(Long userId) {
        return feedbackRepository.findByUserId(userId);
    }

    public ProductReview getFeedbackById(Long feedbackId) {
        return feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> new IllegalArgumentException("Feedback không tồn tại."));
    }

    @Transactional
    public void updateFeedbackVisibility(Long feedbackId, String visible) {
        ProductReview feedback = getFeedbackById(feedbackId);
        feedback.setVisible(visible);
        feedbackRepository.save(feedback);
    }
}
