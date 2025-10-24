package group03.bloomresin.repository;

import group03.bloomresin.domain.ProductReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FeedbackRepository extends JpaRepository<ProductReview, Long> {
    List<ProductReview> findByUserId(Long userId);
}
