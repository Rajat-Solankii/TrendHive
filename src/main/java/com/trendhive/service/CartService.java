package com.trendhive.service;

import com.trendhive.model.CartItem;
import com.trendhive.model.Product;
import com.trendhive.model.User;
import com.trendhive.repository.CartItemRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
public class CartService {

    private final CartItemRepository cartItemRepository;

    public CartService(CartItemRepository cartItemRepository) {
        this.cartItemRepository = cartItemRepository;
    }

    public void addToCart(User user, Product product) {
        // Reuse an existing line item when the user adds the same product again.
        CartItem cartItem = cartItemRepository.findByUserAndProduct(user, product)
                .orElseGet(() -> {
                    CartItem item = new CartItem();
                    item.setUser(user);
                    item.setProduct(product);
                    item.setQuantity(0);
                    return item;
                });

        cartItem.setQuantity(cartItem.getQuantity() + 1);
        cartItemRepository.save(cartItem);
    }

    public List<CartItem> getCartItems(User user) {
        return cartItemRepository.findByUserOrderByIdDesc(user);
    }

    public BigDecimal getCartTotal(User user) {
        return getCartItems(user).stream()
                .map(item -> item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public int getCartCount(User user) {
        return getCartItems(user).stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }

    @Transactional
    public void checkout(User user) {
        cartItemRepository.deleteByUser(user);
    }

    @Transactional
    public void removeCartItem(User user, Long cartItemId) {
        cartItemRepository.findByIdAndUser(cartItemId, user)
                .ifPresent(cartItemRepository::delete);
    }
}
