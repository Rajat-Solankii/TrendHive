package com.trendhive.controller;

import com.trendhive.model.User;
import com.trendhive.service.AuthService;
import com.trendhive.service.CartService;
import com.trendhive.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AccountController {

    private final AuthService authService;
    private final CartService cartService;
    private final OrderService orderService;

    public AccountController(AuthService authService, CartService cartService, OrderService orderService) {
        this.authService = authService;
        this.cartService = cartService;
        this.orderService = orderService;
    }

    @GetMapping("/profile")
    public String profile(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to access your profile.");
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        model.addAttribute("cartCount", cartService.getCartCount(user));
        return "profile";
    }

    @PostMapping("/profile")
    public String updateProfile(@RequestParam String name,
                                @RequestParam String phone,
                                @RequestParam String address,
                                @RequestParam String city,
                                @RequestParam String state,
                                @RequestParam String zipCode,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to update your profile.");
            return "redirect:/login";
        }

        User updatedUser = authService.updateProfile(user, name, phone, address, city, state, zipCode);
        session.setAttribute("user", updatedUser);
        redirectAttributes.addFlashAttribute("success", "Personal details updated successfully.");
        return "redirect:/profile";
    }

    @GetMapping("/orders")
    public String orders(HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            redirectAttributes.addFlashAttribute("error", "Please log in to view placed orders.");
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        model.addAttribute("orders", orderService.getOrdersByUser(user));
        model.addAttribute("cartCount", cartService.getCartCount(user));
        return "orders";
    }
}
