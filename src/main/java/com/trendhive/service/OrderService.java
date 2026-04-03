package com.trendhive.service;

import com.trendhive.model.CartItem;
import com.trendhive.model.Order;
import com.trendhive.model.OrderItem;
import com.trendhive.model.User;
import com.trendhive.repository.OrderRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class OrderService {

    private final OrderRepository orderRepository;

    public OrderService(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }

    @Transactional
    public Order placeOrder(User user,
                            String phone,
                            String address,
                            String city,
                            String state,
                            String zipCode,
                            String paymentMethod,
                            List<CartItem> cartItems,
                            BigDecimal totalAmount) {
        Order order = new Order();
        order.setUser(user);
        order.setPhone(phone.trim());
        order.setAddress(address.trim());
        order.setCity(city.trim());
        order.setState(state.trim());
        order.setZipCode(zipCode.trim());
        order.setPaymentMethod(paymentMethod.trim());
        order.setTotalAmount(totalAmount);
        order.setStatus("Placed");
        order.setCreatedAt(LocalDateTime.now());

        List<OrderItem> items = new ArrayList<>();
        for (CartItem cartItem : cartItems) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrder(order);
            orderItem.setProductName(cartItem.getProduct().getName());
            orderItem.setCategory(cartItem.getProduct().getCategory());
            orderItem.setImageUrl(cartItem.getProduct().getImageUrl());
            orderItem.setPrice(cartItem.getProduct().getPrice());
            orderItem.setQuantity(cartItem.getQuantity());
            items.add(orderItem);
        }

        order.setOrderItems(items);
        return orderRepository.save(order);
    }

    public List<Order> getOrdersByUser(User user) {
        return orderRepository.findByUserOrderByCreatedAtDesc(user);
    }
}
