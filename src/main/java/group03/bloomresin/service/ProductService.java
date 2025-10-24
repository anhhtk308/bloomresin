package group03.bloomresin.service;

import group03.bloomresin.domain.*;
import group03.bloomresin.repository.*;
import group03.bloomresin.domain.*;
import group03.bloomresin.domain.dto.ProductCriteriaDTO;
import group03.bloomresin.repository.*;
import group03.bloomresin.service.specification.ProductSpecs;
import jakarta.servlet.http.HttpSession;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;


    public ProductService(ProductRepository productRepository, CategoryRepository categoryRepository,
                          CartRepository cartRepository, CartDetailRepository cartDetailRepository,
                          UserService userService, OrderRepository orderRepository,
                          OrderDetailRepository orderDetailRepository) {
        this.userService = userService;
        this.cartDetailRepository = cartDetailRepository;
        this.productRepository = productRepository;
        this.categoryRepository = categoryRepository;
        this.cartRepository = cartRepository;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public boolean existsByCategoryId(Long categoryId) {
        return productRepository.existsByCategoryId(categoryId);
    }

    public Optional<OrderDetail> getOrderDetailById(long id) {
        return orderDetailRepository.findById(id);
    }

    public Page<Product> fetchProductsWithSpec(Pageable page, ProductCriteriaDTO productCriteriaDTO) {
        Specification<Product> combinedSpec = Specification.where(ProductSpecs.matchStatus(true));
        if (productCriteriaDTO.getCategoryId() != null && productCriteriaDTO.getCategoryId().isPresent()) {
            Specification<Product> categorySpec = ProductSpecs.matchCategoryId(Long.parseLong(productCriteriaDTO.getCategoryId().get()));
            combinedSpec = combinedSpec.and(categorySpec);
        }
        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            List<Long> targetIds = productCriteriaDTO.getTarget().get().stream().map(Long::parseLong).toList();
            Specification<Product> currentSpecs = ProductSpecs.matchListTarget(targetIds);
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            List<Long> factoryIds = productCriteriaDTO.getFactory().get().stream().map(Long::parseLong).toList();
            Specification<Product> currentSpecs = ProductSpecs.matchListFactory(factoryIds);
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpecs = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        Specification<Product> distinctSpec = (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.conjunction();
        };
        combinedSpec = combinedSpec.and(distinctSpec);
        return this.productRepository.findAll(combinedSpec, page);
    }

    public Specification<Product> buildPriceSpecification(List<String> price) {
        Specification<Product> combinedSpec = Specification.where(null);
        for (String p : price) {
            double min = 0;
            double max = 0;
            switch (p) {
                case "duoi-100.000":
                    min = 1;
                    max = 99999;
                    break;
                case "100.000-500.000":
                    min = 100000;
                    max = 499999;
                    break;
                case "tren-500.000":
                    min = 500000;
                    max = 2000000;
                    break;
            }
            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }
        return combinedSpec;
    }

    public List<Product> fetchProducts() {
        return this.productRepository.findAllByStatus(true);
    }

    public Product createProduct(Product pr) {
        return this.productRepository.save(pr);
    }

    public Product getProductByIdAndStatus(long id, boolean status) {
        return this.productRepository.findByIdAndStatus(id, status);
    }

    public List<Product> getProductByStatus(boolean status) {
        return productRepository.findAllByStatus(status);
    }

    public Product handleSaveProduct(Product product) {
        return this.productRepository.save(product);
    }

    public Page<Product> fetchProducts(Pageable page) {
        return this.productRepository.findAll(page);
    }

    public Product getByIdAndStatus(Long id, boolean status) {
        return this.productRepository.findByIdAndStatus(id, status);
    }

    public Category getCategoryByName(String name) {
        return this.categoryRepository.findByName(name);
    }

    public List<CartDetail> getCartDetailsByProduct(Product product) {
        return this.cartDetailRepository.findByProduct(product);
    }

    public Optional<Product> getProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        Optional<User> userOptional = this.userService.getUserByEmail(email);
        User user = userOptional.orElse(null);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);
                cart = this.cartRepository.save(otherCart);
            }
            Optional<Product> productOptional = this.productRepository.findById(productId);
            if (productOptional.isPresent()) {
                Product realProduct = productOptional.get();
                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);
                if (oldDetail == null) {
                    CartDetail cd = new CartDetail();
                    cd.setCart(cart);
                    cd.setProduct(realProduct);
                    cd.setPrice(realProduct.getPrice());
                    cd.setQuantity(quantity);
                    this.cartDetailRepository.save(cd);
                    int s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(oldDetail);
                }
            }
        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();
            Cart currentCart = cartDetail.getCart();
            this.cartDetailRepository.deleteById(cartDetailId);
            if (currentCart.getSum() > 1) {
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currentCart);
            } else {
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(User user, HttpSession session, String receiverName, String receiverAddress,
                                 String receiverPhone, String Note, String voucherCode, double finalTotal) {
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();
            if (cartDetails != null && !cartDetails.isEmpty()) {
                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setNote(Note);
                order.setOrderDate(LocalDateTime.now());
                order.setStatus("PENDING");
                order.setTotalPrice(finalTotal);
                order = this.orderRepository.save(order);

                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity((int) cd.getQuantity());
                    this.orderDetailRepository.save(orderDetail);

                    Product product = cd.getProduct();
                    product.setQuantity(product.getQuantity() - cd.getQuantity());
                    product.setSold(product.getSold() + cd.getQuantity());
                    this.productRepository.save(product);
                }

                for (CartDetail cd : cartDetails) {
                    this.cartDetailRepository.deleteById(cd.getId());
                }
                this.cartRepository.deleteById(cart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public List<Product> findAll(Specification<Product> spec) {
        throw new UnsupportedOperationException("Phương pháp chưa triển khai 'findAll'");
    }

    public List<Product> getProductByNameOrCategory(String keyword, boolean status) {
        return productRepository.findByNameOrCategoryNameAndStatus(keyword, status);
    }

    public Page<Product> searchProducts(String keyword, Pageable pageable, ProductCriteriaDTO productCriteriaDTO) {
        Specification<Product> combinedSpec = Specification.where(ProductSpecs.matchStatus(true));
        if (keyword != null && !keyword.isEmpty()) {
            Specification<Product> keywordSpec = ProductSpecs.matchNameOrCategory(keyword);
            combinedSpec = combinedSpec.and(keywordSpec);
        }
        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            List<Long> targetIds = productCriteriaDTO.getTarget().get().stream()
                    .flatMap(s -> java.util.Arrays.stream(s.split(",")))
                    .map(Long::parseLong)
                    .toList();
            Specification<Product> targetSpec = ProductSpecs.matchListTarget(targetIds);
            combinedSpec = combinedSpec.and(targetSpec);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            List<Long> factoryIds = productCriteriaDTO.getFactory().get().stream()
                    .flatMap(s -> java.util.Arrays.stream(s.split(",")))
                    .map(Long::parseLong)
                    .toList();
            Specification<Product> factorySpec = ProductSpecs.matchListFactory(factoryIds);
            combinedSpec = combinedSpec.and(factorySpec);
        }
        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> priceSpec = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(priceSpec);
        }
        Specification<Product> distinctSpec = (root, query, criteriaBuilder) -> {
            query.distinct(true);
            return criteriaBuilder.conjunction();
        };
        combinedSpec = combinedSpec.and(distinctSpec);
        return productRepository.findAll(combinedSpec, pageable);
    }

    public boolean existsByName(String name) {
        return productRepository.existsByName(name);
    }

    public Product save(Product product) {
        return productRepository.save(product);
    }

    public void deleteProductById(long id) {
        productRepository.deleteById(id); // ❌ Thực hiện xóa thật khỏi DB
    }
}