package group03.bloomresin.controller;

import group03.bloomresin.domain.Category;
import group03.bloomresin.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.List;

@ControllerAdvice
public class GlobalControllerAdvice {

    @Autowired
    private CategoryService categoryService;

    @ModelAttribute("categories")
    public List<Category> categories() {
        return categoryService.getCategoryByStatus(true);
    }
}