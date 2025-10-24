package group03.bloomresin.repository;

import group03.bloomresin.domain.UserLoginLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface UserLoginLogRepository extends JpaRepository<UserLoginLog, Long> {

    // Thống kê lượt đăng nhập từng ngày trong khoảng start-end
    @Query("SELECT EXTRACT(DAY FROM l.loginTime), COUNT(l) " +
            "FROM UserLoginLog l " +
            "WHERE l.loginTime BETWEEN :startDate AND :endDate " +
            "GROUP BY EXTRACT(DAY FROM l.loginTime) " +
            "ORDER BY EXTRACT(DAY FROM l.loginTime)")
    List<Object[]> countLoginsBetweenDates(@Param("startDate") LocalDateTime startDate,
                                           @Param("endDate") LocalDateTime endDate);
}
