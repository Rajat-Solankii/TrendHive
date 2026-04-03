<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendHive | Register</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<main class="auth-page">
    <div class="auth-wrapper">
        <section class="banner-card">
            <span class="eyebrow" style="background: rgba(255,255,255,0.14); color: #fff;">Create Account</span>
            <h1 style="margin: 16px 0 12px; font-size: clamp(2rem, 5vw, 3.4rem);">Build your TrendHive storefront identity.</h1>
            <p style="color: rgba(255,255,255,0.8); line-height: 1.8;">
                Register once to keep a personal cart, browse quickly, and experience a professional eCommerce flow.
            </p>
        </section>

        <section class="auth-card">
            <h2>Register</h2>
            <p class="muted">Create your account to start shopping.</p>

            <c:if test="${not empty error}">
                <div class="form-error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label class="field-label" for="name">Full Name</label>
                    <input class="field-input" id="name" name="name" type="text" placeholder="Rajat Sharma" required>
                </div>
                <div class="form-group">
                    <label class="field-label" for="email">Email</label>
                    <input class="field-input" id="email" name="email" type="email" placeholder="you@example.com" required>
                </div>
                <div class="form-group">
                    <label class="field-label" for="password">Password</label>
                    <input class="field-input" id="password" name="password" type="password" placeholder="Create password" required>
                </div>
                <div class="form-group">
                    <label class="field-label" for="confirmPassword">Confirm Password</label>
                    <input class="field-input" id="confirmPassword" name="confirmPassword" type="password" placeholder="Confirm password" required>
                </div>
                <button class="button full" type="submit">Create Account</button>
            </form>

            <p class="muted" style="margin-top: 18px;">
                Already have an account?
                <a class="small-link" href="${pageContext.request.contextPath}/login">Sign in here</a>
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
