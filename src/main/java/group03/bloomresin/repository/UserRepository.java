package group03.bloomresin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import group03.bloomresin.domain.User;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    void deleteById(long id);
    List<User> findByRoleId(Long roleId);
    List<User> findAllByRole_Id(long roleId);
    List<User> findAllByRole_IdAndStatus(long roleId, boolean status);
    Optional<User> findById(Long id);
    boolean existsByEmail(String email);
    Optional<User> findByEmail(String email);
    boolean existsById(Long id);
    void deleteById(Long id);
    @Query("SELECT u.email FROM User u WHERE u.role = :role")
    List<String> findEmailsByRole(String role);
    @Query("SELECT COUNT(u) FROM User u WHERE u.role.id = :roleId")
    long countByRoleId(@Param("roleId") Long roleId);

}
