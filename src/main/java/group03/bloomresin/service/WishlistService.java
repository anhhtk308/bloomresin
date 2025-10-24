package group03.bloomresin.service;

import group03.bloomresin.domain.Product;
import group03.bloomresin.domain.User;
import group03.bloomresin.domain.WishList;
import group03.bloomresin.repository.WishlistRepository;
import group03.bloomresin.repository.ProductRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class WishlistService {
    private final WishlistRepository wishlistRepository;
    private final ProductRepository productRepository;

    public WishlistService(WishlistRepository wishlistRepository, ProductRepository productRepository) {
        this.wishlistRepository = wishlistRepository;
        this.productRepository = productRepository;
    }

    public List<Product> getWishlist(User user) {
        return wishlistRepository.findByUser(user).stream()
                .map(WishList::getProduct)
                .toList();
    }

    @Transactional
    public boolean addToWishlist(User user, Long productId) {
        return productRepository.findById(productId)
                .filter(product -> wishlistRepository.findByUserAndProduct(user, product) == null)
                .map(product -> {
                    wishlistRepository.save(new WishList(user, product));
                    return true;
                }).orElse(false);
    }

    @Transactional
    public boolean removeFromWishlist(User user, Long productId) {
        return productRepository.findById(productId)
                .map(product -> wishlistRepository.findByUserAndProduct(user, product))
                .filter(wishlistItem -> wishlistItem != null)
                .map(wishlistItem -> {
                    wishlistRepository.delete(wishlistItem);
                    return true;
                }).orElse(false);
    }
}
