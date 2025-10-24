package group03.bloomresin.controller.client;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group03.bloomresin.domain.Product;
import group03.bloomresin.domain.User;
import group03.bloomresin.service.UserService;
import group03.bloomresin.service.WishlistService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/wishlist")
public class WishlistController {
    private final UserService userService;
    private final WishlistService wishlistService;

    public WishlistController(UserService userService, WishlistService wishlistService) {
        this.userService = userService;
        this.wishlistService = wishlistService;
    }

    private Optional<User> getUserFromSession(HttpSession session) {
        String email = (String) session.getAttribute("email");
        if (email == null || email.isEmpty()) {
            System.out.println("Không tìm thấy email trong phiên làm việc.");
            return Optional.empty();
        }

        Optional<User> userOptional = userService.getUserByEmail(email);
        if (userOptional.isEmpty()) {
            System.out.println("Không tìm thấy người dùng với email: " + email);
        }
        return userOptional;
    }

    @GetMapping("")
    public String getWishlistPage(HttpSession session, Model model) {
        Optional<User> userOpt = getUserFromSession(session);
        if (userOpt.isEmpty()) {
            return "redirect:/login";
        }

        User user = userOpt.get();
        List<Product> wishlist = wishlistService.getWishlist(user);
        if (wishlist == null) {
            wishlist = new ArrayList<>();
        }

        model.addAttribute("wishlist", wishlist);
        return "customer/wishlist/show";
    }

    @GetMapping("/json")
    @ResponseBody
    public ResponseEntity<?> getWishlist(HttpSession session) {
        Optional<User> userOpt = getUserFromSession(session);
        if (userOpt.isEmpty()) {
            return ResponseEntity.status(401).body("Người dùng chưa đăng nhập");
        }

        List<Product> wishlist = wishlistService.getWishlist(userOpt.get());
        return ResponseEntity.ok(wishlist);
    }

    @PostMapping("/add/{productId}")
    @ResponseBody
    @Transactional
    public ResponseEntity<?> addToWishlist(@PathVariable Long productId, HttpSession session) {
        Optional<User> userOpt = getUserFromSession(session);
        if (userOpt.isEmpty()) {
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Người dùng chưa đăng nhập");
            return ResponseEntity.status(401)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
        User user = userOpt.get();
        System.out.println("Thêm sản phẩm có ID: " + productId + " vào wishlist của: " + user.getEmail());
        boolean added = wishlistService.addToWishlist(user, productId);
        int wishlistSize = wishlistService.getWishlist(user).size();
        session.setAttribute("wishlistSize", wishlistSize);
        if (!added) {
            System.out.println("Sản phẩm đã có trong wishlist!");
            Map<String, String> errorResponse = new HashMap<>();
            errorResponse.put("message", "Sản phẩm đã có trong danh sách yêu thích!");
            return ResponseEntity.status(400)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(errorResponse);
        }
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("message", "Đã thêm vào danh sách yêu thích!");
        responseMap.put("redirectUrl", "/product/details/" + productId);
        responseMap.put("wishlistSize", wishlistSize);

        return ResponseEntity.ok()
                .contentType(MediaType.APPLICATION_JSON)
                .body(responseMap);
    }

    @PostMapping("/remove/{productId}")
    @Transactional
    public String removeFromWishlist(@PathVariable Long productId, HttpSession session,
            RedirectAttributes redirectAttributes) {
        Optional<User> userOpt = getUserFromSession(session);
        if (userOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Người dùng chưa đăng nhập");
            return "redirect:/wishlist";
        }
        User user = userOpt.get();
        boolean removed = wishlistService.removeFromWishlist(user, productId);
        if (!removed) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không có trong danh sách yêu thích!");
        } else {
            redirectAttributes.addFlashAttribute("success", "Xoá sản phẩm thành công");
            int wishlistSize = wishlistService.getWishlist(user).size();
            session.setAttribute("wishlistSize", wishlistSize);
        }
        return "redirect:/wishlist";
    }
}
