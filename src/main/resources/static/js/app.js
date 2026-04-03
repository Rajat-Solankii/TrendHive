document.addEventListener("DOMContentLoaded", function () {
    var flashes = document.querySelectorAll(".flash, .form-error");
    var registerForm = document.querySelector('form[action$="/register"]');
    var addToCartForms = document.querySelectorAll(".add-to-cart-form");
    var cartPopup = document.getElementById("cartPopup");
    var popupRedirectUrl = null;
    var delayedLoaderTimer = null;
    var loadingOverlay = document.getElementById("loadingOverlay");

    flashes.forEach(function (element) {
        setTimeout(function () {
            element.style.transition = "opacity 0.3s ease";
            element.style.opacity = "0";
        }, 3500);
    });

    if (registerForm) {
        registerForm.addEventListener("submit", function (event) {
            var password = document.getElementById("password");
            var confirmPassword = document.getElementById("confirmPassword");

            if (password && confirmPassword && password.value !== confirmPassword.value) {
                event.preventDefault();
                confirmPassword.setCustomValidity("Passwords do not match.");
                confirmPassword.reportValidity();
            }
        });

        var confirmPasswordInput = document.getElementById("confirmPassword");
        if (confirmPasswordInput) {
            confirmPasswordInput.addEventListener("input", function () {
                confirmPasswordInput.setCustomValidity("");
            });
        }
    }

    function hideCartPopup() {
        if (cartPopup) {
            cartPopup.classList.remove("visible");
        }
    }

    function showLoaderWithDelay() {
        clearTimeout(delayedLoaderTimer);
        delayedLoaderTimer = setTimeout(function () {
            if (loadingOverlay) {
                loadingOverlay.classList.add("visible");
            }
        }, 250);
    }

    function hideLoader() {
        clearTimeout(delayedLoaderTimer);
        if (loadingOverlay) {
            loadingOverlay.classList.remove("visible");
        }
    }

    function showCartPopup(message, redirectUrl) {
        if (!cartPopup) {
            return;
        }

        var title = cartPopup.querySelector(".cart-popup-title");
        var text = cartPopup.querySelector(".cart-popup-text");

        if (title) {
            title.textContent = message || "Product added to cart";
        }

        if (text) {
            text.textContent = "Click to open your cart.";
        }

        popupRedirectUrl = redirectUrl;
        cartPopup.classList.add("visible");

        setTimeout(function () {
            hideCartPopup();
        }, 4000);
    }

    if (cartPopup) {
        cartPopup.addEventListener("click", function () {
            if (popupRedirectUrl) {
                window.location.href = popupRedirectUrl;
            }
        });

        cartPopup.addEventListener("keydown", function (event) {
            if ((event.key === "Enter" || event.key === " ") && popupRedirectUrl) {
                event.preventDefault();
                window.location.href = popupRedirectUrl;
            }
        });
    }

    addToCartForms.forEach(function (form) {
        form.addEventListener("submit", function (event) {
            event.preventDefault();

            var formData = new FormData(form);

            fetch(form.action, {
                method: "POST",
                body: formData
            })
                .then(function (response) {
                    hideLoader();
                    return response.json();
                })
                .then(function (data) {
                    if (!data.success && data.redirect) {
                        window.location.href = data.redirect;
                        return;
                    }

                    var cartLinks = document.querySelectorAll('a[href$="/cart"]');
                    if (typeof data.cartCount !== "undefined") {
                        cartLinks.forEach(function (link) {
                            link.textContent = "Cart (" + data.cartCount + ")";
                        });
                    }

                    showCartPopup(data.message, data.redirect);
                })
                .catch(function () {
                    hideLoader();
                    window.location.href = form.getAttribute("data-fallback") || "/cart";
                });

            showLoaderWithDelay();
        });
    });

    document.querySelectorAll("form").forEach(function (form) {
        if (form.classList.contains("add-to-cart-form")) {
            return;
        }

        form.addEventListener("submit", function () {
            showLoaderWithDelay();
        });
    });

    window.addEventListener("pageshow", function () {
        hideLoader();
    });
});
