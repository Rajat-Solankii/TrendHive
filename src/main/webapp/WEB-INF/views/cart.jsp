<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Cart</title>
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
                <input class="search-input" type="text" name="search" placeholder="Search for more products">
                <button class="search-button" type="submit">Search</button>
            </form>
            <nav class="nav-links">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/products">Products</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/orders">Placed Orders</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/profile">Profile</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/cart">Cart (${cartCount})</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </nav>
        </div>
    </header>

    <main class="content">
        <div class="page-header">
            <span class="eyebrow">Your Cart</span>
            <h1>${user.name}, review your picks.</h1>
            <p>Everything you add is stored against your account, ready for the next step in the shopping flow.</p>
        </div>

        <c:if test="${not empty success}">
            <div class="flash success">${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="flash error">${error}</div>
        </c:if>

        <div class="cart-layout">
            <section class="cart-panel">
                <h2>Cart Items</h2>
                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="empty-state" style="margin-top: 18px;">
                            <h2>Your cart is empty.</h2>
                            <p class="muted">Add products from the catalog to see them here.</p>
                            <a class="button" href="${pageContext.request.contextPath}/products">Continue Shopping</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="cart-items">
                            <c:forEach items="${cartItems}" var="item">
                                <article class="cart-item">
                                    <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                    <div class="cart-item-content">
                                        <h3 style="margin: 0 0 6px;">${item.product.name}</h3>
                                        <div class="meta">${item.product.category}</div>
                                        <p class="muted" style="margin: 10px 0 0;">${item.product.description}</p>
                                        <form action="${pageContext.request.contextPath}/cart/remove" method="post" class="remove-form">
                                            <input type="hidden" name="cartItemId" value="${item.id}">
                                            <button class="button danger-button remove-inline-button" type="submit">Remove Product</button>
                                        </form>
                                    </div>
                                    <div class="cart-item-actions">
                                        <div class="price">Rs. ${item.product.price}</div>
                                        <div class="meta">Qty: ${item.quantity}</div>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <aside class="stats-card">
                <h2>Order Summary</h2>
                <div class="summary-row">
                    <span>Items</span>
                    <strong>${cartCount}</strong>
                </div>
                <div class="summary-row">
                    <span>Delivery</span>
                    <strong>Free</strong>
                </div>
                <div class="summary-row total">
                    <span>Total</span>
                    <span>Rs. ${cartTotal}</span>
                </div>
                <a class="button full" style="margin-top: 16px;" href="${pageContext.request.contextPath}/cart/checkout">Proceed to Checkout</a>
                <a class="button secondary full" style="margin-top: 12px;" href="${pageContext.request.contextPath}/products">Add More Items</a>
            </aside>
        </div>
    </main>
</div>
<div id="loadingOverlay" class="loading-overlay" aria-hidden="true">
    <div class="loading-card">
        <div class="loading-spinner"></div>
        <div class="loading-text">Loading TrendHive...</div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
