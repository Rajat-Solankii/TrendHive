package com.trendhive.controller;

import com.trendhive.model.User;
import com.trendhive.service.CartService;
import com.trendhive.service.ProductService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MainController {

    private final ProductService productService;
    private final CartService cartService;

    public MainController(ProductService productService, CartService cartService) {
        this.productService = productService;
        this.cartService = cartService;
    }

    @GetMapping("/")
    public String home(@RequestParam(value = "search", required = false) String search,
                       Model model,
                       HttpSession session) {
        populateCommonModel(model, session, search);
        model.addAttribute("featuredProducts", productService.getAllProducts().stream().limit(4).toList());
        return "index";
    }

    @GetMapping("/products")
    public String products(@RequestParam(value = "search", required = false) String search,
                           Model model,
                           HttpSession session) {
        populateCommonModel(model, session, search);
        return "products";
    }

    private void populateCommonModel(Model model, HttpSession session, String search) {
        User user = (User) session.getAttribute("user");
        model.addAttribute("user", user);
        model.addAttribute("search", search == null ? "" : search);
        model.addAttribute("products", productService.searchProducts(search));
        model.addAttribute("cartCount", user == null ? 0 : cartService.getCartCount(user));
    }
}
