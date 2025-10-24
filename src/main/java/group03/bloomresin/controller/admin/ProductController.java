package group03.bloomresin.controller.admin;

import java.util.List;
import java.util.Optional;

import group03.bloomresin.domain.dto.ProductCriteriaDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;

import group03.bloomresin.domain.Category;
import group03.bloomresin.domain.Product;
import group03.bloomresin.service.CategoryService;
import group03.bloomresin.service.ProductService;
import group03.bloomresin.service.UploadService;

import jakarta.validation.Valid;

@Controller
public class ProductController {

    private final ProductService productService;
    private final UploadService uploadService;
    private final CategoryService categoryService;

    public ProductController(ProductService productService, UploadService uploadService,
            CategoryService categoryService) {
        this.productService = productService;
        this.uploadService = uploadService;
        this.categoryService = categoryService;
    }

    @GetMapping("/admin/product")
    public String getProduct(@RequestParam(value = "page", defaultValue = "0") int page, Model model) {
        int pageSize = 10;
        org.springframework.data.domain.Pageable pageable = org.springframework.data.domain.PageRequest.of(page, pageSize);
        org.springframework.data.domain.Page<Product> productPage = this.productService.fetchProducts(pageable);
        model.addAttribute("productPage", productPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        return "admin/product/show";
    }
    
    @GetMapping("/admin/product/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newProduct", new Product());
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        model.addAttribute("categories", categories);
        return "admin/product/create";
    }

    @PostMapping(value = "/admin/product/create")
    public String createProductPage(Model model,
                                    @ModelAttribute("newProduct") @Valid Product product,
                                    BindingResult newProductBindingResult,
                                    @RequestParam("productFile") MultipartFile file,
                                    org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
        }

        if (newProductBindingResult.hasErrors()) {
            List<Category> categories = this.categoryService.getCategoryByStatus(true);
            model.addAttribute("categories", categories);
            return "admin/product/create";
        }

        if (product.getQuantity() < 0) {
            newProductBindingResult.rejectValue("quantity", "error.newProduct", "Số lượng không được là số âm");
            model.addAttribute("categories", this.categoryService.getCategoryByStatus(true));
            return "admin/product/create";
        }

        boolean exists = this.productService.existsByName(product.getName());
        if (exists) {
            newProductBindingResult.rejectValue("name", "error.newProduct", "Tên sản phẩm đã tồn tại");
            model.addAttribute("categories", this.categoryService.getCategoryByStatus(true));
            return "admin/product/create";
        }
        Category selectedCategory = this.productService.getCategoryByName(product.getCategory().getName());
        product.setCategory(selectedCategory);
        String image = this.uploadService.handleSaveUploadFile(file, "product");
        product.setImage(image);
        product.setStatus(true);
        product.setCreatedAt(LocalDateTime.now());
        product.setUpdatedAt(LocalDateTime.now());
        this.productService.handleSaveProduct(product);
        redirectAttributes.addFlashAttribute("successMessage", "Tạo sản phẩm thành công!");
        return "redirect:/admin/product";
    }

    @RequestMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Optional<Product> productOptional = this.productService.getProductById(id);
        if (productOptional.isEmpty()) {
            return "redirect:/admin/product";
        }
        Product currentProduct = productOptional.get();
        if (!currentProduct.isStatus()) {
            return "redirect:/admin/product";
        }
        model.addAttribute("newProduct", currentProduct);
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        model.addAttribute("categories", categories);

        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postUpdateProduct(Model model,
                                    @ModelAttribute("newProduct") @Valid Product product,
                                    BindingResult newProductBindingResult,
                                    @RequestParam("productFile") MultipartFile file) {
        if (newProductBindingResult.hasErrors()) {
            model.addAttribute("categories", categoryService.getCategoryByStatus(true));
            return "admin/product/update";
        }

        Optional<Product> currentProductOpt = this.productService.getProductById(product.getId());
        if (currentProductOpt.isPresent()) {
            Product currentProduct = currentProductOpt.get();

            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUploadFile(file, "product");
                currentProduct.setImage(img);
            }

            // ✅ Sửa phần category để tránh lỗi null
            if (product.getCategory() != null && product.getCategory().getId() > 0) {
                Category cat = this.categoryService.getCategoryById(product.getCategory().getId());
                currentProduct.setCategory(cat);
            }

            currentProduct.setUpdatedAt(LocalDateTime.now());
            currentProduct.setName(product.getName());
            currentProduct.setPrice(product.getPrice());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setDetailDesc(product.getDetailDesc());
            currentProduct.setShortDesc(product.getShortDesc());
            currentProduct.setStatus(true);

            this.productService.handleSaveProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String deleteProductById(@PathVariable long id,
                                    org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            product.setStatus(false); // Xóa mềm
            productService.handleSaveProduct(product);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm để xóa.");
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product newProduct = this.productService.getProductById(id).get();

        // ⚠️ Truy xuất Category để tránh LazyInitializationException khi vào JSP
        if (newProduct.getCategory() != null) {
            newProduct.getCategory().getName(); // ép load
        }

        model.addAttribute("newProduct", newProduct);
        model.addAttribute("id", id);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/search")
    public String getProduct(@RequestParam(value = "keyword", required = false) String keyword,
                             @RequestParam(value = "page", defaultValue = "0") int page,
                             Model model) {
        int pageSize = 10;
        org.springframework.data.domain.Pageable pageable = org.springframework.data.domain.PageRequest.of(page, pageSize);
        org.springframework.data.domain.Page<Product> productPage;

        if (keyword != null && !keyword.isEmpty()) {
            productPage = productService.searchProducts(keyword, pageable, new ProductCriteriaDTO());
        } else {
            productPage = productService.fetchProducts(pageable);
        }

        model.addAttribute("productPage", productPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", productPage.getTotalPages());
        model.addAttribute("keyword", keyword);

        return "admin/product/show";
    }
}