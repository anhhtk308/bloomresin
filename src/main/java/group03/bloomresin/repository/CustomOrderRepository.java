package group03.bloomresin.repository;

import group03.bloomresin.domain.CustomOrder;
import group03.bloomresin.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CustomOrderRepository extends JpaRepository<CustomOrder, Long> {
//    List<CustomOrder> findByUser(User user);
    List<CustomOrder> findByUser_Id(Long userId);
    List<CustomOrder> findByUserAndStatusNotIn(User user, List<String> statuses);
    Optional<CustomOrder> findById(Long id);
}
