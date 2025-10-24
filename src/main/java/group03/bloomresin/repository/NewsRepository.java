package group03.bloomresin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import group03.bloomresin.domain.News;

@Repository
public interface NewsRepository extends JpaRepository<News, Long> {
    java.util.List<News> findByStatusTrue();
}
