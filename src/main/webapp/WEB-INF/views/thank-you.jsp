<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Thank You</title>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">Cart (${cartCount})</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </nav>
        </div>
    </header>

    <main class="content">
        <section class="thank-you-panel">
            <div class="thank-you-badge">Order Confirmed</div>
            <h1>Thank you, <c:out value="${customerName != null ? customerName : user.name}" />.</h1>
            <p class="muted">
                Your TrendHive order has been placed successfully. We have started preparing your items for dispatch.
            </p>

            <div class="thank-you-grid">
                <div class="thank-you-card">
                    <h2>Payment Method</h2>
                    <p><c:out value="${paymentMethod != null ? paymentMethod : 'Confirmed'}" /></p>
                </div>
                <div class="thank-you-card">
                    <h2>Delivery Address</h2>
                    <p><c:out value="${deliveryAddress != null ? deliveryAddress : 'Your saved checkout address'}" /></p>
                </div>
            </div>

            <div class="thank-you-actions">
                <a class="button secondary" href="${pageContext.request.contextPath}/orders">View Placed Orders</a>
                <a class="button" href="${pageContext.request.contextPath}/products">Continue Shopping</a>
                <a class="button secondary" href="${pageContext.request.contextPath}/">Go to Home</a>
            </div>
        </section>
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
