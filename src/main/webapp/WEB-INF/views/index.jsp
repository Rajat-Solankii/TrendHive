<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Shop Smarter</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="site-shell">
    <header class="topbar">
        <div class="topbar-inner">
            <a href="${pageContext.request.contextPath}/" class="brand">
                <span class="brand-mark">TH</span>
                <span>TrendHive</span>
            </a>
            <form class="search-form" action="${pageContext.request.contextPath}/products" method="get">
                <input class="search-input" type="text" name="search" value="${search}" placeholder="Search products by name">
                <button class="search-button" type="submit">Search</button>
            </form>
            <nav class="nav-links">
                <a class="nav-link active" href="${pageContext.request.contextPath}/">Home</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a>
                <c:if test="${user != null}">
                    <a class="nav-link" href="${pageContext.request.contextPath}/orders">Placed Orders</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/profile">Profile</a>
                </c:if>
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">Cart (${cartCount})</a>
                <c:choose>
                    <c:when test="${user != null}">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
                    </c:otherwise>
                </c:choose>
            </nav>
        </div>
    </header>

    <main>
        <section class="hero">
            <div class="hero-panel">
                <span class="eyebrow">Curated Deals. Faster Delivery. Better Style.</span>
                <h1>Discover premium picks that upgrade your everyday life.</h1>
                <p>
                    TrendHive brings together standout electronics, fashion, and lifestyle essentials in a storefront
                    designed to feel polished, fast, and conversion-ready.
                </p>
                <div class="hero-actions">
                    <a class="button" href="${pageContext.request.contextPath}/products">Shop Collection</a>
                    <c:choose>
                        <c:when test="${user != null}">
                            <a class="button secondary" href="${pageContext.request.contextPath}/cart">View Cart</a>
                        </c:when>
                        <c:otherwise>
                            <a class="button secondary" href="${pageContext.request.contextPath}/register">Create Account</a>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="info-row">
                    <span class="meta">Trusted by modern shoppers</span>
                    <span class="meta">Responsive JSP storefront</span>
                    <span class="meta">Session cart experience</span>
                </div>
            </div>

            <div class="spotlight-card">
                <div>
                    <span class="eyebrow">This Week's Spotlight</span>
                    <h2 style="margin: 14px 0 10px;">High-performance essentials with premium finish.</h2>
                    <p class="muted" style="color: rgba(255,255,255,0.76);">
                        Explore categories that combine utility and design, from wearables to home decor.
                    </p>
                </div>
                <div class="spotlight-image">
                    <img src="https://images.unsplash.com/photo-1511556820780-d912e42b4980?auto=format&fit=crop&w=1200&q=80" alt="TrendHive featured products">
                </div>
            </div>
        </section>

        <section class="content">
            <div class="section-title">
                <h2>Featured Products</h2>
                <p class="muted">Top-selling styles and devices picked for a storefront that feels modern and premium.</p>
            </div>

            <div class="products-grid">
                <c:forEach items="${featuredProducts}" var="product">
                    <article class="product-card">
                        <div class="product-image">
                            <span class="product-badge">${product.category}</span>
                            <img src="${product.imageUrl}" alt="${product.name}">
                        </div>
                        <div class="product-body">
                            <h3 class="product-title">${product.name}</h3>
                            <p class="product-description">${product.description}</p>
                            <div class="product-footer">
                                <div>
                                    <div class="price">Rs. ${product.price}</div>
                                    <div class="meta">Fast-moving item</div>
                                </div>
                                <form action="${pageContext.request.contextPath}/cart/add-ajax" method="post" class="add-to-cart-form">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <button class="button" type="submit">Add to Cart</button>
                                </form>
                            </div>
                        </div>
                    </article>
                </c:forEach>
            </div>
        </section>
</main>
    <div class="footer-space"></div>
</div>
<div id="loadingOverlay" class="loading-overlay" aria-hidden="true">
    <div class="loading-card">
        <div class="loading-spinner"></div>
        <div class="loading-text">Loading TrendHive...</div>
    </div>
</div>
<div id="cartPopup" class="cart-popup" role="button" tabindex="0" aria-live="polite">
    <div class="cart-popup-title">Product added to cart</div>
    <div class="cart-popup-text">Click to open your cart.</div>
</div>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
