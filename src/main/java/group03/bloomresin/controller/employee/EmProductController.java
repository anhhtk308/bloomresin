package group03.bloomresin.controller.employee;

import java.util.List;
import java.util.Optional;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class EmProductController {

    private final ProductService productService;
    private final UploadService uploadService;
    private final CategoryService categoryService;

    public EmProductController(ProductService productService, UploadService uploadService,
            CategoryService categoryService) {
        this.productService = productService;
        this.uploadService = uploadService;
        this.categoryService = categoryService;
    }

    @GetMapping("/employee/product")
    public String getProduct(Model model) {
        List<Product> products = this.productService.getProductByStatus(true);
        model.addAttribute("products", products);
        return "employee/product/show";
    }

    @GetMapping("/employee/product/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newProduct", new Product());
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        model.addAttribute("categories", categories);

        return "employee/product/create";
    }

    @PostMapping(value = "/employee/product/create")
    public String createProductPage(Model model, @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProductBindingResult,
            @RequestParam("productFile") MultipartFile file) {
        List<FieldError> errors = newProductBindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getField() + " - " + error.getDefaultMessage());
        }
        if (newProductBindingResult.hasErrors()) {
            List<Category> categories = this.categoryService.getCategoryByStatus(true);
            model.addAttribute("categories", categories);
            return "employee/product/create";
        }

        product.setCategory(this.productService.getCategoryByName(product.getCategory().getName()));
        String image = this.uploadService.handleSaveUploadFile(file, "product");
        System.out.println(image);
        product.setImage(image);
        product.setStatus(true);
        product.setCreatedAt(LocalDateTime.now());
        product.setUpdatedAt(LocalDateTime.now());

        this.productService.handleSaveProduct(product);

        return "redirect:/employee/product";
    }

    @RequestMapping("/employee/product/update/{id}") // GET
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Optional<Product> Product = this.productService.getProductById(id);
        Product currentProduct = Product.get();
        if (currentProduct == null) {
            return "redirect:/employee/product";
        }
        if (!currentProduct.isStatus()) {
            return "redirect:/employee/product";
        }
        model.addAttribute("newProduct", currentProduct);
        List<Category> categories = this.categoryService.getCategoryByStatus(true);
        model.addAttribute("categories", categories);
        return "employee/product/update";
    }

    @PostMapping("/employee/product/update")
    public String postUpdateProduct(Model model, @ModelAttribute("newProduct") @Valid Product product,
            BindingResult newProductBindingResult,
            @RequestParam("productFile") MultipartFile file) {
        if (newProductBindingResult.hasErrors()) {

            return "employee/product/update";
        }

        Optional<Product> currentProductOpt = this.productService.getProductById(product.getId());

        if (currentProductOpt.isPresent()) {
            Product currentProduct = currentProductOpt.get();
            if (currentProduct != null) {
                if (!file.isEmpty()) {
                    String img = this.uploadService.handleSaveUploadFile(file, "product");
                    currentProduct.setImage(img);
                }
                currentProduct.setCategory(this.productService.getCategoryByName(product.getCategory().getName()));
                currentProduct.setUpdatedAt(LocalDateTime.now());
                currentProduct.setName(product.getName());
                currentProduct.setPrice(product.getPrice());
                currentProduct.setQuantity(product.getQuantity());
                currentProduct.setDetailDesc(product.getDetailDesc());
                currentProduct.setShortDesc(product.getShortDesc());

                this.productService.handleSaveProduct(currentProduct);
            }
        }
        return "redirect:/employee/product";
    }

    @GetMapping("/employee/product/delete/{id}")
    public String deleteProductByEmployee(@PathVariable long id,
                                          RedirectAttributes redirectAttributes) {
        Optional<Product> productOpt = productService.getProductById(id);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            product.setStatus(false); // Xóa mềm
            productService.handleSaveProduct(product);
            redirectAttributes.addFlashAttribute("successMessage", "Nhân viên đã xoá sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không tìm thấy sản phẩm để xoá.");
        }
        return "redirect:/employee/product";
    }

    @GetMapping("/employee/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product newProduct = this.productService.getProductById(id).get();
        model.addAttribute("newProduct", newProduct);
        model.addAttribute("id", id);
        return "employee/product/detail";
    }
    @GetMapping("/employee/product/search")
    public String getProduct(@RequestParam(value = "keyword", required = false) String keyword, Model model) {
        List<Product> products;

        if (keyword != null && !keyword.isEmpty()) {
            products = productService.getProductByNameOrCategory(keyword, true);
        } else {
            products = productService.getProductByStatus(true);
        }

        model.addAttribute("products", products);
        model.addAttribute("keyword", keyword);

        return "employee/product/show";
    }
}
