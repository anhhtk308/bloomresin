package group03.bloomresin.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import group03.bloomresin.domain.News;
import group03.bloomresin.repository.NewsRepository;

@Service
public class NewsService {
    private static final Logger logger = LoggerFactory.getLogger(NewsService.class);
    private final NewsRepository newsRepository;

    @Autowired
    public NewsService(NewsRepository newsRepository) {
        this.newsRepository = newsRepository;
    }

    public List<News> getAllNews() {
        logger.info("Đang lấy tất cả tin tức...");
        return newsRepository.findAll();
    }

    public List<News> getActiveNews() {
        logger.info("Đang lấy tin tức đang hoạt động với trạng thái = true...");
        return newsRepository.findByStatusTrue();
    }

    public News getNewsById(Long id) {
        return newsRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy tin tức với ID: " + id));
    }


    public News saveNews(News news) {
        logger.info("Đang lưu tin tức: {}", news.getTitle());
        if (news.getTitle() == null || news.getTitle().trim().isEmpty()) {
            throw new IllegalArgumentException("Tiêu đề tin tức không được để trống");
        }
        if (news.getContent() == null || news.getContent().trim().isEmpty()) {
            throw new IllegalArgumentException("Nội dung tin tức không được để trống");
        }
        return newsRepository.save(news);
    }

    public void deleteNews(Long id) {
        logger.info("Đang xóa tin tức với ID: {}", id);
        if (!newsRepository.existsById(id)) {
            throw new RuntimeException("Không thể xóa: Tin tức với ID " + id + " không tìm thấy");
        }
        newsRepository.deleteById(id);
    }
}