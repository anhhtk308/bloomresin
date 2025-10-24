package group03.bloomresin.service;

import java.util.List;

import org.springframework.stereotype.Service;

import group03.bloomresin.domain.Category;
import group03.bloomresin.repository.CategoryRepository;

@Service
public class CategoryService {
    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<Category> getAllCategories() {
        return this.categoryRepository.findAll();
    }

    public Category handleSaveCategory(Category category) {
        return this.categoryRepository.save(category);
    }

    public Category getCategoryById(long id) {
        return this.categoryRepository.findById(id);
    }

    public List<Category> getCategoryByStatus(boolean status) {
        return categoryRepository.findAllByStatus(status);
    }

    public Category findByName(String name) {
        return categoryRepository.findByName(name);
    }

    public Category save(Category category) {
        return categoryRepository.save(category);
    }
}
