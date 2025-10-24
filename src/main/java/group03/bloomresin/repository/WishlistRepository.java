package group03.bloomresin.repository;

import group03.bloomresin.domain.User;
import group03.bloomresin.domain.Product;
import group03.bloomresin.domain.WishList;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface WishlistRepository extends JpaRepository<WishList, Long> {
    List<WishList> findByUser(User user);
    WishList findByUserAndProduct(User user, Product product);
}
