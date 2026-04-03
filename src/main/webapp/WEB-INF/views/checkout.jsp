<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Checkout</title>
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
            <span class="eyebrow">Secure Checkout</span>
            <h1>Complete your TrendHive order.</h1>
            <p>Review items, add delivery details, and place your order with a polished checkout flow.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="flash error">${error}</div>
        </c:if>

        <div class="checkout-layout">
            <section class="checkout-form-panel">
                <div class="checkout-card">
                    <h2>Delivery Details</h2>
                    <form action="${pageContext.request.contextPath}/cart/checkout" method="post" class="checkout-form">
                        <div class="checkout-grid">
                            <div class="form-group">
                                <label class="field-label" for="fullName">Full Name</label>
                                <input class="field-input" id="fullName" type="text" value="${user.name}" readonly>
                            </div>
                            <div class="form-group">
                                <label class="field-label" for="email">Email</label>
                                <input class="field-input" id="email" type="email" value="${user.email}" readonly>
                            </div>
                            <div class="form-group">
                                <label class="field-label" for="phone">Phone Number</label>
                                <input class="field-input" id="phone" name="phone" type="text" placeholder="+91 98765 43210" value="${user.phone}" required>
                            </div>
                            <div class="form-group">
                                <label class="field-label" for="zipCode">ZIP / PIN Code</label>
                                <input class="field-input" id="zipCode" name="zipCode" type="text" placeholder="400001" value="${user.zipCode}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="field-label" for="address">Delivery Address</label>
                            <textarea class="field-input field-textarea" id="address" name="address" placeholder="House no, street, area" required>${user.address}</textarea>
                        </div>

                        <div class="checkout-grid">
                            <div class="form-group">
                                <label class="field-label" for="city">City</label>
                                <input class="field-input" id="city" name="city" type="text" placeholder="Mumbai" value="${user.city}" required>
                            </div>
                            <div class="form-group">
                                <label class="field-label" for="state">State</label>
                                <input class="field-input" id="state" name="state" type="text" placeholder="Maharashtra" value="${user.state}" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="field-label" for="paymentMethod">Payment Method</label>
                            <select class="field-input" id="paymentMethod" name="paymentMethod" required>
                                <option value="">Select payment method</option>
                                <option value="Cash on Delivery">Cash on Delivery</option>
                                <option value="UPI">UPI</option>
                                <option value="Credit Card">Credit Card</option>
                                <option value="Debit Card">Debit Card</option>
                            </select>
                        </div>

                        <div class="checkout-actions">
                            <a class="button secondary" href="${pageContext.request.contextPath}/cart">Back to Cart</a>
                            <button class="button" type="submit">Place Order</button>
                        </div>
                    </form>
                </div>
            </section>

            <aside class="checkout-summary-panel">
                <div class="checkout-card">
                    <h2>Order Summary</h2>
                    <div class="checkout-items">
                        <c:forEach items="${cartItems}" var="item">
                            <article class="checkout-item">
                                <img src="${item.product.imageUrl}" alt="${item.product.name}">
                                <div>
                                    <h3>${item.product.name}</h3>
                                    <div class="meta">${item.product.category}</div>
                                    <div class="meta">Qty: ${item.quantity}</div>
                                </div>
                                <strong>Rs. ${item.product.price}</strong>
                            </article>
                        </c:forEach>
                    </div>

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
                </div>
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
