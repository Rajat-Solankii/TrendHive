package com.trendhive.repository;

import com.trendhive.model.CartItem;
import com.trendhive.model.Product;
import com.trendhive.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {

    List<CartItem> findByUserOrderByIdDesc(User user);

    Optional<CartItem> findByUserAndProduct(User user, Product product);

    Optional<CartItem> findByIdAndUser(Long id, User user);

    void deleteByUser(User user);
}
