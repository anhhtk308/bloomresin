package group03.bloomresin.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import group03.bloomresin.service.NewsService;

@Controller
public class CustomerNewsController {

    private final NewsService newsService;

    @Autowired
    public CustomerNewsController(NewsService newsService) {
        this.newsService = newsService;
    }

    @GetMapping("/customer/news")
    public String showActiveNewsList(Model model) {
        model.addAttribute("newsList", newsService.getActiveNews());
        return "customer/news/list";
    }
}
