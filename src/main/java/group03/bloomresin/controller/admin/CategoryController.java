package group03.bloomresin.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import group03.bloomresin.domain.Category;
import group03.bloomresin.service.CategoryService;
import group03.bloomresin.service.ProductService;
import group03.bloomresin.service.UploadService;
import jakarta.validation.Valid;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class CategoryController {

    private final CategoryService categoryService;
    private final UploadService uploadService;
    private final ProductService productService;

    public CategoryController(CategoryService categoryService, UploadService uploadService, ProductService productService) {
        this.categoryService = categoryService;
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/category")
    public String redirectCategory() {
        return "redirect:/admin/category/list";
    }

    @GetMapping("/admin/category/list")
    public String getCategory(Model model) {
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        model.addAttribute("categories", categories);
        return "admin/category/show";
    }

    @GetMapping("/admin/category/create")
    public String getCreateCategoryPage(Model model) {
        model.addAttribute("newCategory", new Category());
        return "admin/category/create";
    }

    @PostMapping(value = "/admin/category/create")
    public String createCategoryPage(Model model,
                                     @ModelAttribute("newCategory") @Valid Category category,
                                     BindingResult newCategoryBindingResult,
                                     @RequestParam("imageFile") MultipartFile file,
                                     RedirectAttributes redirectAttributes) {
        if (newCategoryBindingResult.hasErrors()) {
            model.addAttribute("newCategory", category);
            return "admin/category/create";
        }

        if (file.isEmpty()) {
            newCategoryBindingResult.rejectValue("image", "error.image", "  img CANNOT EMPTY");
            model.addAttribute("newCategory", category);
            return "admin/category/create";
        }

        String image = this.uploadService.handleSaveUploadFile(file, "category");
        category.setImage(image);
        category.setStatus(true);

        this.categoryService.handleSaveCategory(category);
        return "redirect:/admin/category/list?successMessage=Category+created+successfully";
    }

    @RequestMapping("/admin/category/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        Category currentCategory = this.categoryService.getCategoryById(id);

        if (currentCategory == null || !currentCategory.isStatus()) {
            return "redirect:/admin/category";
        }

        model.addAttribute("newCategory", currentCategory);
        return "admin/category/update";
    }

    @PostMapping("/admin/category/update")
    public String postUpdateCategory(Model model,
                                     @ModelAttribute("newCategory") @Valid Category category,
                                     BindingResult newCategoryBindingResult,
                                     @RequestParam("imageFile") MultipartFile file,
                                     RedirectAttributes redirectAttributes) {
        Category currentCategory = this.categoryService.getCategoryById(category.getId());
        if (newCategoryBindingResult.hasErrors()) {
            model.addAttribute("newCategory", category);
            return "admin/category/update";
        }

        if (file.isEmpty() && (currentCategory.getImage() == null || currentCategory.getImage().isEmpty())) {
            newCategoryBindingResult.rejectValue("image", "error.image", "iMG CANNOT EMPTY");
            model.addAttribute("newCategory", category);
            return "admin/category/update";
        }

        if (!file.isEmpty()) {
            String img = this.uploadService.handleSaveUploadFile(file, "category");
            currentCategory.setImage(img);
        }

        currentCategory.setName(category.getName());
        this.categoryService.handleSaveCategory(currentCategory);
        return "redirect:/admin/category/list?successMessage=Category+updated+successfully";
    }

    @GetMapping("/admin/category/delete/{id}")
    public String deleteCategory(@PathVariable long id, RedirectAttributes redirectAttributes) {
        Category currentCategory = this.categoryService.getCategoryById(id);

        if (currentCategory == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy danh mục.");
            return "redirect:/admin/category/list";
        }

        boolean hasProducts = productService.existsByCategoryId(currentCategory.getId());
        if (hasProducts) {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa danh mục vì có sản phẩm đang sử dụng.");
            return "redirect:/admin/category/list";
        }

        currentCategory.setStatus(false); // hoặc gọi delete cứng nếu cần
        this.categoryService.handleSaveCategory(currentCategory);
        redirectAttributes.addFlashAttribute("successMessage", "Xóa danh mục thành công.");
        return "redirect:/admin/category/list";
    }

    @GetMapping("/admin/category/{id}")
    public String getCategoryDetailPage(Model model, @PathVariable long id) {
        Category newCategory = this.categoryService.getCategoryById(id);
        model.addAttribute("newCategory", newCategory);
        model.addAttribute("id", id);
        return "admin/category/detail";
    }
}
