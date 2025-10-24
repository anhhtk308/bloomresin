package group03.bloomresin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import group03.bloomresin.domain.OrderDetail;

import java.time.LocalDateTime;
import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    List<OrderDetail> findByProductId(long productId);
    List<OrderDetail> findByOrderId(long orderId);

    // Top sản phẩm bán chạy theo month/year
    @Query("SELECT od.product.name, SUM(od.quantity) " +
            "FROM OrderDetail od " +
            "WHERE MONTH(od.order.orderDate) = :month AND YEAR(od.order.orderDate) = :year " +
            "GROUP BY od.product.name " +
            "ORDER BY SUM(od.quantity) DESC")
    List<Object[]> getTopProductsInMonthByMonthYear(@Param("month") int month,
                                                    @Param("year") int year);

    // Top sản phẩm bán chạy trong khoảng thời gian start-end
    @Query("SELECT od.product.name, SUM(od.quantity) " +
            "FROM OrderDetail od " +
            "WHERE od.order.orderDate BETWEEN :startDate AND :endDate " +
            "GROUP BY od.product.name " +
            "ORDER BY SUM(od.quantity) DESC")
    List<Object[]> getTopProductsBetweenDates(@Param("startDate") LocalDateTime startDate,
                                              @Param("endDate") LocalDateTime endDate);
}
