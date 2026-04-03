package com.trendhive.service;

import com.trendhive.model.Product;
import com.trendhive.repository.ProductRepository;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        String searchTerm = keyword.trim();
        return productRepository
                .findDistinctByNameContainingIgnoreCaseOrDescriptionContainingIgnoreCaseOrCategoryContainingIgnoreCase(
                        searchTerm,
                        searchTerm,
                        searchTerm
                );
    }

    public Product getProductById(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new IllegalArgumentException("Product not found: " + productId));
    }

    public void seedProductsIfEmpty() {
        if (productRepository.count() > 0) {
            return;
        }

        // Seed a polished starter catalog so the storefront is usable on first launch.
        productRepository.save(createProduct(
                "Nova Wireless Headphones",
                "Electronics",
                "Immersive over-ear headphones with spatial audio, 40-hour battery life, and low-latency gaming mode.",
                "7499.00",
                "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=900&q=80"
        ));
        productRepository.save(createProduct(
                "Urban Edge Sneakers",
                "Fashion",
                "Lightweight knit sneakers with cushioned midsoles and a streetwear silhouette built for all-day comfort.",
                "3299.00",
                "https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80"
        ));
        productRepository.save(createProduct(
                "Aura Desk Lamp",
                "Home Decor",
                "Minimal matte-metal desk lamp with warm-to-cool lighting presets and touch dimming controls.",
                "2199.00",
                "https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=900&q=80"
        ));
        productRepository.save(createProduct(
                "Momentum Smartwatch",
                "Wearables",
                "Fitness-forward smartwatch with AMOLED display, heart-rate tracking, and 7-day battery performance.",
                "5999.00",
                "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=80"
        ));
        productRepository.save(createProduct(
                "Summit Travel Backpack",
                "Accessories",
                "Water-resistant travel backpack with organized compartments, laptop sleeve, and trolley pass-through.",
                "2899.00",
                "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=900&q=80"
        ));
        productRepository.save(createProduct(
                "BrewCraft Coffee Maker",
                "Kitchen",
                "Programmable coffee maker with reusable filter, aroma boost mode, and thermal carafe.",
                "4599.00",
                "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80"
        ));
    }

    private Product createProduct(String name, String category, String description, String price, String imageUrl) {
        Product product = new Product();
        product.setName(name);
        product.setCategory(category);
        product.setDescription(description);
        product.setPrice(new BigDecimal(price));
        product.setImageUrl(imageUrl);
        return product;
    }
}
