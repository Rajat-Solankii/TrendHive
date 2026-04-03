package com.trendhive.controller;

import com.trendhive.model.User;
import com.trendhive.service.CartService;
import com.trendhive.service.OrderService;
import com.trendhive.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.Map;

@Controller
public class CartController {

    private final CartService cartService;
    private final ProductService productService;
    private final OrderService orderService;

    public CartController(CartService cartService, ProductService productService, OrderService orderService) {
        this.cartService = cartService;
        this.productService = productService;
        this.orderService = orderService;
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam("productId") Long productId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to add products to your cart.");
            return "redirect:/login";
        }

        cartService.addToCart(user, productService.getProductById(productId));
        redirectAttributes.addFlashAttribute("success", "Product added to cart.");
        return "redirect:/cart";
    }

    @PostMapping("/cart/add-ajax")
    @ResponseBody
    public Map<String, Object> addToCartAjax(@RequestParam("productId") Long productId,
                                             HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.put("success", false);
            response.put("redirect", "/login");
            response.put("message", "Please log in to add products to your cart.");
            return response;
        }

        cartService.addToCart(user, productService.getProductById(productId));
        response.put("success", true);
        response.put("redirect", "/cart");
        response.put("message", "Product added to cart.");
        response.put("cartCount", cartService.getCartCount(user));
        return response;
    }

    @PostMapping("/cart/remove")
    public String removeFromCart(@RequestParam("cartItemId") Long cartItemId,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to update your cart.");
            return "redirect:/login";
        }

        cartService.removeCartItem(user, cartItemId);
        redirectAttributes.addFlashAttribute("success", "Item removed from cart.");
        return "redirect:/cart";
    }

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to view your cart.");
            return "redirect:/login";
        }

        // The cart page is rendered from persisted cart rows tied to the authenticated user.
        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartService.getCartItems(user));
        model.addAttribute("cartTotal", cartService.getCartTotal(user));
        model.addAttribute("cartCount", cartService.getCartCount(user));
        return "cart";
    }

    @GetMapping("/cart/checkout")
    public String checkoutPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to continue to checkout.");
            return "redirect:/login";
        }

        if (cartService.getCartCount(user) == 0) {
            redirectAttributes.addFlashAttribute("error", "Your cart is empty.");
            return "redirect:/cart";
        }

        model.addAttribute("user", user);
        model.addAttribute("cartItems", cartService.getCartItems(user));
        model.addAttribute("cartTotal", cartService.getCartTotal(user));
        model.addAttribute("cartCount", cartService.getCartCount(user));
        return "checkout";
    }

    @PostMapping("/cart/checkout")
    public String checkout(@RequestParam String phone,
                           @RequestParam String address,
                           @RequestParam String city,
                           @RequestParam String state,
                           @RequestParam String zipCode,
                           @RequestParam String paymentMethod,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to complete checkout.");
            return "redirect:/login";
        }

        if (cartService.getCartCount(user) == 0) {
            redirectAttributes.addFlashAttribute("error", "Your cart is empty.");
            return "redirect:/cart";
        }

        if (phone.trim().isEmpty() || address.trim().isEmpty() || city.trim().isEmpty()
                || state.trim().isEmpty() || zipCode.trim().isEmpty() || paymentMethod.trim().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please fill in all checkout details.");
            return "redirect:/cart/checkout";
        }

        orderService.placeOrder(
                user,
                phone,
                address,
                city,
                state,
                zipCode,
                paymentMethod,
                cartService.getCartItems(user),
                cartService.getCartTotal(user)
        );
        cartService.checkout(user);
        redirectAttributes.addFlashAttribute("customerName", user.getName());
        redirectAttributes.addFlashAttribute("paymentMethod", paymentMethod);
        redirectAttributes.addFlashAttribute("deliveryAddress", address + ", " + city + ", " + state + " - " + zipCode);
        return "redirect:/thank-you";
    }

    @GetMapping("/thank-you")
    public String thankYouPage(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to continue.");
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        model.addAttribute("cartCount", cartService.getCartCount(user));
        return "thank-you";
    }
}
