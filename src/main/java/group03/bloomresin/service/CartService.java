package group03.bloomresin.service;

import org.springframework.stereotype.Service;
import group03.bloomresin.domain.Cart;
import group03.bloomresin.repository.CartRepository;

@Service
public class CartService {
    private final CartRepository cartRepository;
    public CartService(CartRepository cartRepository) {
        this.cartRepository = cartRepository;
    }

    public Cart getCartByUserId(Long userId) {
        return cartRepository.findByUserId(userId).orElse(null);
    }

    public void clearCart(Cart cart) {
        cart.getCartDetails().clear();
        cartRepository.save(cart);
    }
}
