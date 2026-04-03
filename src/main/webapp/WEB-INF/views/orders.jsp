<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Placed Orders</title>
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/orders">Placed Orders</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/profile">Profile</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">Cart (${cartCount})</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </nav>
        </div>
    </header>

    <main class="content">
        <div class="page-header">
            <span class="eyebrow">Placed Orders</span>
            <h1>Track your completed orders.</h1>
            <p>Review every order you have placed, including items, totals, payment method, and delivery address.</p>
        </div>

        <c:choose>
            <c:when test="${empty orders}">
                <div class="empty-state">
                    <h2>No orders placed yet.</h2>
                    <p class="muted">Your future orders will appear here after checkout.</p>
                    <a class="button" href="${pageContext.request.contextPath}/products">Start Shopping</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="orders-list">
                    <c:forEach items="${orders}" var="order">
                        <section class="order-card">
                            <div class="order-header">
                                <div>
                                    <h2>Order #${order.id}</h2>
                                    <div class="meta">${order.createdAt}</div>
                                </div>
                                <div class="order-status">${order.status}</div>
                            </div>

                            <div class="order-meta-grid">
                                <div class="thank-you-card">
                                    <h2>Payment</h2>
                                    <p>${order.paymentMethod}</p>
                                </div>
                                <div class="thank-you-card">
                                    <h2>Delivery</h2>
                                    <p>${order.address}, ${order.city}, ${order.state} - ${order.zipCode}</p>
                                </div>
                            </div>

                            <div class="checkout-items">
                                <c:forEach items="${order.orderItems}" var="item">
                                    <article class="checkout-item">
                                        <img src="${item.imageUrl}" alt="${item.productName}">
                                        <div>
                                            <h3>${item.productName}</h3>
                                            <div class="meta">${item.category}</div>
                                            <div class="meta">Qty: ${item.quantity}</div>
                                        </div>
                                        <strong>Rs. ${item.price}</strong>
                                    </article>
                                </c:forEach>
                            </div>

                            <div class="summary-row total" style="margin-top: 18px;">
                                <span>Total</span>
                                <span>Rs. ${order.totalAmount}</span>
                            </div>
                        </section>
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
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
