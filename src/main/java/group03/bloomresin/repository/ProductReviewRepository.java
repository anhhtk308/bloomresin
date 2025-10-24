package group03.bloomresin.repository;

import group03.bloomresin.domain.ProductReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

import group03.bloomresin.domain.OrderDetail;
import group03.bloomresin.domain.Product;
import group03.bloomresin.domain.User;

import java.util.Optional;

@Repository
public interface ProductReviewRepository extends JpaRepository<ProductReview, Long> {
    Optional<ProductReview> findByUserAndProduct(User user, Product product);
    ProductReview findByOrderDetail(OrderDetail orderDetail);
    List<ProductReview> findByProductId(long productId);
}
