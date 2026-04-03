<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Profile</title>
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/profile">Profile</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/cart">Cart (${cartCount})</a>
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a>
            </nav>
        </div>
    </header>

    <main class="content">
        <div class="page-header">
            <span class="eyebrow">Personal Details</span>
            <h1>Manage your TrendHive profile.</h1>
            <p>Update your personal and delivery details so checkout stays fast and consistent.</p>
        </div>

        <c:if test="${not empty success}">
            <div class="flash success">${success}</div>
        </c:if>

        <section class="profile-panel">
            <form action="${pageContext.request.contextPath}/profile" method="post" class="checkout-form">
                <div class="checkout-grid">
                    <div class="form-group">
                        <label class="field-label" for="name">Full Name</label>
                        <input class="field-input" id="name" name="name" type="text" value="${user.name}" required>
                    </div>
                    <div class="form-group">
                        <label class="field-label" for="email">Email</label>
                        <input class="field-input" id="email" type="email" value="${user.email}" readonly>
                    </div>
                    <div class="form-group">
                        <label class="field-label" for="phone">Phone Number</label>
                        <input class="field-input" id="phone" name="phone" type="text" value="${user.phone}" required>
                    </div>
                    <div class="form-group">
                        <label class="field-label" for="zipCode">ZIP / PIN Code</label>
                        <input class="field-input" id="zipCode" name="zipCode" type="text" value="${user.zipCode}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="field-label" for="address">Address</label>
                    <textarea class="field-input field-textarea" id="address" name="address" required>${user.address}</textarea>
                </div>
                <div class="checkout-grid">
                    <div class="form-group">
                        <label class="field-label" for="city">City</label>
                        <input class="field-input" id="city" name="city" type="text" value="${user.city}" required>
                    </div>
                    <div class="form-group">
                        <label class="field-label" for="state">State</label>
                        <input class="field-input" id="state" name="state" type="text" value="${user.state}" required>
                    </div>
                </div>
                <div class="checkout-actions">
                    <a class="button secondary" href="${pageContext.request.contextPath}/">Back to Home</a>
                    <button class="button" type="submit">Save Personal Details</button>
                </div>
            </form>
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
