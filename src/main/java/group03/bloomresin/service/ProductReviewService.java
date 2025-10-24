package group03.bloomresin.service;

import group03.bloomresin.domain.Product;
import group03.bloomresin.domain.ProductReview;
import group03.bloomresin.domain.User;
import group03.bloomresin.repository.ProductReviewRepository;
import org.springframework.stereotype.Service;
import group03.bloomresin.domain.OrderDetail;
import java.util.List;
import java.util.Optional;

@Service
public class ProductReviewService {
    private final ProductReviewRepository productReviewRepository;

    public ProductReviewService(ProductReviewRepository productReviewRepository) {
        this.productReviewRepository = productReviewRepository;
    }

    public Optional<ProductReview> findById(long id) {
        return productReviewRepository.findById(id);
    }

    public ProductReview findByOrderDetail(OrderDetail orderDetail) {
        return productReviewRepository.findByOrderDetail(orderDetail);
    }

    public void saveProductReview(ProductReview review) {
        productReviewRepository.save(review);
    }

    public List<ProductReview> findReviewsByProductId(long productId) {
        return productReviewRepository.findByProductId(productId);
    }

    public Optional<ProductReview> findByUserAndProduct(User user, Product product) {
        return productReviewRepository.findByUserAndProduct(user, product);
    }
}
