# TrendHive

TrendHive is a full-stack eCommerce web application built with Java, Spring Boot, JSP, MySQL, and Maven. It follows an MVC architecture and includes authentication, product browsing, search, cart management, checkout, profile management, and placed order tracking.

## Tech Stack

- Backend: Java 17+, Spring Boot, Spring MVC, Spring Data JPA
- Frontend: JSP, JSTL, HTML, CSS, JavaScript
- Database: MySQL
- Build Tool: Maven
- Architecture: MVC

## Features

- User registration, login, logout
- Session-based authentication
- BCrypt password hashing
- Product listing on home and products pages
- Product search by name, category, and description
- Add to cart with popup feedback
- Remove items from cart
- Dedicated checkout page
- Thank-you page after successful order placement
- Persisted placed orders
- User profile update page for personal details
- Responsive modern storefront UI

## Project Structure

```text
src/main/java/com/trendhive/
├── controller/
├── model/
├── repository/
├── service/

src/main/resources/
├── static/
│   ├── css/
│   └── js/
├── application.properties

src/main/webapp/WEB-INF/views/
├── index.jsp
├── login.jsp
├── register.jsp
├── products.jsp
├── cart.jsp
├── checkout.jsp
├── thank-you.jsp
├── profile.jsp
├── orders.jsp
```

## Current Modules

### Authentication

- Register new users
- Login existing users
- Logout with session invalidation

### Product System

- Product catalog with seeded demo products
- Search by product name, category, and description
- Product cards with image, price, and add-to-cart action

### Cart System

- Add products to cart
- Remove products from cart
- Cart is stored per logged-in user
- Cart summary with total amount

### Checkout and Orders

- Delivery details form
- Payment method selection
- Order persistence in MySQL
- Thank-you page after order placement
- Placed orders page with order history

### Profile

- Update full name
- Update phone
- Update address
- Update city, state, and zip code

## Database Tables

Hibernate auto-creates the schema using `spring.jpa.hibernate.ddl-auto=update`.

Expected tables:

- `users`
- `products`
- `cart`
- `orders`
- `order_items`

## Configuration

Database configuration is in [src/main/resources/application.properties](/C:/Users/rajat/Downloads/TrendHive_Java_Full/src/main/resources/application.properties).

Default local configuration:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/trendhive?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata
spring.datasource.username=root
spring.datasource.password=root
```

Update these values if your MySQL username or password is different.

## Prerequisites

- Java 17 or higher
- Maven installed and available in PATH
- MySQL Server running
- IntelliJ IDEA recommended

## How To Run

1. Create or start your MySQL server.
2. Update MySQL credentials in `src/main/resources/application.properties` if needed.
3. Open the project in IntelliJ IDEA.
4. Let Maven download dependencies.
5. Run `TrendHiveApplication`.

You can also run from terminal:

```bash
mvn spring-boot:run
```

Application URL:

```text
http://localhost:8080
```

## Notes

- Demo products are seeded automatically when the products table is empty.
- Passwords are stored as BCrypt hashes.
- If you add new entities or controller routes, restart the Spring Boot app.
- If style or JSP updates do not appear immediately, hard refresh the browser.

## Main Pages

- `/` : Home page
- `/products` : Product listing and search
- `/login` : Login page
- `/register` : Registration page
- `/cart` : Cart page
- `/cart/checkout` : Checkout page
- `/thank-you` : Post-order thank-you page
- `/profile` : User profile page
- `/orders` : Placed orders page

## Future Improvements

- Admin panel for product management
- Quantity update controls in cart
- Order status progression
- Email notifications
- Payment gateway integration
- Spring Security integration
