package group03.bloomresin.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import group03.bloomresin.domain.Cart;
import group03.bloomresin.domain.CartDetail;
import group03.bloomresin.domain.Product;

@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product product);
    CartDetail findByCartAndProduct(Cart cart, Product product);
    List<CartDetail> findByProduct(Product product);
}
