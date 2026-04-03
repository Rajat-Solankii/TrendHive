<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Products</title>
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
                <input class="search-input" type="text" name="search" value="${search}" placeholder="Search fashion, electronics, accessories">
                <button class="search-button" type="submit">Search</button>
            </form>
            <nav class="nav-links">
                <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                <a class="nav-link active" href="${pageContext.request.contextPath}/products">Products</a>
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

    <main class="content">
        <div class="page-header">
            <span class="eyebrow">All Products</span>
            <h1>Browse the complete TrendHive collection.</h1>
            <p>
                Search by product name, category, or description, then add items to your personal cart.
                <c:if test="${not empty search}">
                    Showing results for <strong>"${search}"</strong>.
                </c:if>
            </p>
        </div>

        <c:if test="${not empty search}">
            <div class="search-helper">
                <span class="meta">Quick searches:</span>
                <a class="search-chip" href="${pageContext.request.contextPath}/products?search=electronics">Electronics</a>
                <a class="search-chip" href="${pageContext.request.contextPath}/products?search=fashion">Fashion</a>
                <a class="search-chip" href="${pageContext.request.contextPath}/products?search=kitchen">Kitchen</a>
                <a class="search-chip" href="${pageContext.request.contextPath}/products?search=home">Home</a>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty products}">
                <div class="empty-state">
                    <h2>No products matched your search.</h2>
                    <p class="muted">Try a product name, category, or words from the product description.</p>
                    <a class="button" href="${pageContext.request.contextPath}/products">View All Products</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="products-grid">
                    <c:forEach items="${products}" var="product">
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
                                        <div class="meta">${product.category}</div>
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
            </c:otherwise>
        </c:choose>
    </main>
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
