package group03.bloomresin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import group03.bloomresin.domain.Cart;
import group03.bloomresin.domain.User;
import java.util.Optional;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {
    Cart findByUser(User user);
    Optional<Cart> findByUserId(Long userId);
    boolean existsByUserId(Long userId);
}
