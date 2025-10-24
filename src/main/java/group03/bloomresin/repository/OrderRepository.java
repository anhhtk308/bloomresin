package group03.bloomresin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import group03.bloomresin.domain.Order;
import group03.bloomresin.domain.User;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    List<Order> findByStatus(String status);
    List<Order> findByUserAndStatus(User user, String status);
    List<Order> findByUser(User user);
    List<Order> findByUserAndStatusNotIn(User user, List<String> statuses);
    List<Order> findByUser_Id(long userId);
    List<Order> findByUserAndStatusNot(User user, String status);
    boolean existsByUserId(Long userId);
    long countByStatus(String status);

    // Doanh thu theo ngày trong khoảng start-end
    @Query("SELECT EXTRACT(DAY FROM o.orderDate), SUM(o.totalPrice) " +
            "FROM Order o " +
            "WHERE o.orderDate BETWEEN :startDate AND :endDate " +
            "GROUP BY EXTRACT(DAY FROM o.orderDate) " +
            "ORDER BY EXTRACT(DAY FROM o.orderDate)")
    List<Object[]> getRevenueByDayBetween(@Param("startDate") LocalDateTime startDate,
                                          @Param("endDate") LocalDateTime endDate);

    // Tổng đơn hàng trong khoảng start-end
    @Query("SELECT COUNT(o) FROM Order o " +
            "WHERE o.orderDate BETWEEN :startDate AND :endDate")
    long countOrdersInMonthBetween(@Param("startDate") LocalDateTime startDate,
                                   @Param("endDate") LocalDateTime endDate);

    // Lấy danh sách năm có dữ liệu (PostgreSQL: EXTRACT YEAR)
    @Query("SELECT DISTINCT CAST(EXTRACT(YEAR FROM o.orderDate) AS integer) " +
            "FROM Order o " +
            "ORDER BY CAST(EXTRACT(YEAR FROM o.orderDate) AS integer) DESC")
    List<Integer> findYearsWithData();
}
