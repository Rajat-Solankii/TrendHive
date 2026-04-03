<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<main class="auth-page">
    <div class="auth-wrapper">
        <section class="banner-card">
            <span class="eyebrow" style="background: rgba(255,255,255,0.14); color: #fff;">TrendHive Access</span>
            <h1 style="margin: 16px 0 12px; font-size: clamp(2rem, 5vw, 3.4rem);">Welcome back to smarter shopping.</h1>
            <p style="color: rgba(255,255,255,0.8); line-height: 1.8;">
                Sign in to continue browsing curated products, save your cart, and move through checkout-ready flows.
            </p>
            <div class="info-row">
                <span class="meta" style="color: rgba(255,255,255,0.75);">Session authentication</span>
                <span class="meta" style="color: rgba(255,255,255,0.75);">MySQL-backed users</span>
                <span class="meta" style="color: rgba(255,255,255,0.75);">Responsive storefront</span>
            </div>
        </section>

        <section class="auth-card">
            <h2>Login</h2>
            <p class="muted">Use your TrendHive account to access products and your cart.</p>

            <c:if test="${not empty error}">
                <div class="form-error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label class="field-label" for="email">Email</label>
                    <input class="field-input" id="email" name="email" type="email" placeholder="you@example.com" required>
                </div>
                <div class="form-group">
                    <label class="field-label" for="password">Password</label>
                    <input class="field-input" id="password" name="password" type="password" placeholder="Enter password" required>
                </div>
                <button class="button full" type="submit">Sign In</button>
            </form>

            <p class="muted" style="margin-top: 18px;">
                New to TrendHive?
                <a class="small-link" href="${pageContext.request.contextPath}/register">Create an account</a>
            </p>
        </section>
    </div>
</main>
<div id="loadingOverlay" class="loading-overlay" aria-hidden="true">
    <div class="loading-card">
        <div class="loading-spinner"></div>
        <div class="loading-text">Loading TrendHive...</div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/app.js"></script>
</body>
</html>
