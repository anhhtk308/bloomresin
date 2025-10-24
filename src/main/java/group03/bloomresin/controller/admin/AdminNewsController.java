package group03.bloomresin.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group03.bloomresin.domain.News;
import group03.bloomresin.service.NewsService;
import group03.bloomresin.service.UploadNewsService;

@Controller
@RequestMapping("/admin/news")
public class AdminNewsController {

    private final NewsService newsService;
    private final UploadNewsService uploadNewsService;

    @Autowired
    public AdminNewsController(NewsService newsService, UploadNewsService uploadNewsService) {
        this.newsService = newsService;
        this.uploadNewsService = uploadNewsService;
    }

    @GetMapping
    public String showNewsList(Model model) {
        model.addAttribute("newsList", newsService.getAllNews());
        return "admin/news/manage-news";
    }

    @GetMapping("/create")
    public String showCreateNewsForm(Model model) {
        model.addAttribute("news", new News());
        return "admin/news/create-news";
    }

    @PostMapping("/create")
    public String createNews(@RequestParam("title") String title,
                             @RequestParam("content") String content,
                             @RequestParam("image") MultipartFile file, // 🔄 đổi thành "image" cho đồng bộ
                             Model model,
                             RedirectAttributes redirectAttributes) {

        if (isInvalid(title, content, model)) {
            model.addAttribute("news", new News(title, content, null));
            return "admin/news/create-news";
        }

        String imageUrl = null;
        if (!file.isEmpty()) {
            imageUrl = uploadNewsService.handleSaveUploadFile(file, "news");
        }

        News news = new News(title, content, imageUrl);
        news.setStatus(false); // mặc định chưa xuất bản
        newsService.saveNews(news);

        redirectAttributes.addFlashAttribute("message", "Tạo bài viết thành công.");
        return "redirect:/admin/news";
    }

    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }
        model.addAttribute("news", news);
        return "admin/news/update-news";
    }

    @PostMapping("/update/{id}")
    public String updateNews(@PathVariable Long id,
                             @RequestParam("title") String title,
                             @RequestParam("content") String content,
                             @RequestParam("image") MultipartFile file,
                             @RequestParam(value = "status", required = false, defaultValue = "true") boolean status,
                             Model model,
                             RedirectAttributes redirectAttributes) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }

        if (isInvalid(title, content, model)) {
            news.setTitle(title);
            news.setContent(content);
            news.setStatus(status);
            model.addAttribute("news", news);
            return "admin/news/update-news";
        }

        news.setTitle(title);
        news.setContent(content);
        news.setStatus(status);

        if (!file.isEmpty()) {
            String imageUrl = uploadNewsService.handleSaveUploadFile(file, "news");
            news.setImageUrl(imageUrl);
        }

        newsService.saveNews(news);
        redirectAttributes.addFlashAttribute("message", "Cập nhật bài viết thành công.");
        return "redirect:/admin/news";
    }

    @GetMapping("/delete/{id}")
    public String deleteNews(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        News news = newsService.getNewsById(id);
        if (news != null) {
            newsService.deleteNews(id);
            redirectAttributes.addFlashAttribute("message", "Xóa tin tức thành công.");
        } else {
            redirectAttributes.addFlashAttribute("error", "Tin tức không tồn tại.");
        }
        return "redirect:/admin/news";
    }

    @GetMapping("/detail/{id}")
    public String showNewsDetail(@PathVariable Long id, Model model) {
        News news = newsService.getNewsById(id);
        if (news == null) {
            return "redirect:/admin/news";
        }
        model.addAttribute("news", news);
        return "admin/news/detail";
    }

    @GetMapping("/toggle-status/{id}")
    public String toggleStatus(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        News news = newsService.getNewsById(id);
        if (news != null) {
            news.setStatus(!news.isStatus());
            newsService.saveNews(news);
            redirectAttributes.addFlashAttribute("message", "Thay đổi trạng thái bài viết thành công.");
        }
        return "redirect:/admin/news";
    }

    // 🔹 Hàm dùng chung để check lỗi
    private boolean isInvalid(String title, String content, Model model) {
        boolean hasErrors = false;
        if (title == null || title.trim().isEmpty()) {
            model.addAttribute("titleError", "Tiêu đề không được để trống.");
            hasErrors = true;
        }
        if (content == null || content.trim().isEmpty()) {
            model.addAttribute("contentError", "Nội dung không được để trống.");
            hasErrors = true;
        }
        return hasErrors;
    }
}
