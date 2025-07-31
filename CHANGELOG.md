# 📦 Changelog
All notable changes to this project will be documented in this file.  
This project follows [Semantic Versioning](https://semver.org/).

---

## [1.0.0] - 2025-07-31 - Pending Release
🎉 **Initial Production Release**

### 🚀 Overview
This is the **first stable production release** of the Bookshop Management System built with Maven architecture. It includes full implementation of core modules with tested and styled UI, secure session-based authentication, and comprehensive user guidance.

### ✅ Features

- **Authentication Module**
    - Session-based login/logout system with secure dashboard access
    - `LoginServlet` and `LogoutServlet` with form handling
    - Protected JSP views under `WEB-INF/views`

- **Customer Management**
    - Full CRUD (Create, Read, Update, Delete) operations
    - DTO, DAO, Service, and Servlet implementation
    - JUnit tests for DAO and Service layers

- **Item Management**
    - Add, edit, delete, and list items with styled UI
    - Dark-themed forms and tables
    - Seed SQL and schema updates
    - JUnit tests included

- **Billing Module**
    - Dynamic JSP forms for creating and viewing bills
    - Support for item dropdowns, quantity/price calculation
    - Bill and BillItem entities handled via DAO and Service

- **Help Section**
    - `help.jsp` for guidance on key modules (Login, Customer, Items, Bills)
    - Linked from dashboard navigation

- **Dashboard**
    - Central navigation hub with links to all major modules
    - Styled with Font Awesome icons and responsive layout

### 🛡️ Security

- Session validation for all protected routes
- JSPs restricted to internal views (`WEB-INF/views`)
- No direct URL access allowed to sensitive pages

### 🎨 UI/UX

- Modern dark theme across all pages
- Consistent navigation and buttons
- Font Awesome icon support

### 🧪 Testing

- JUnit tests for core services and DAOs
- Dynamic test setup and teardown using `@BeforeEach` and `@AfterEach`

### 📂 Project Structure

- Follows Maven multi-layered architecture:  
  `model`, `dao`, `service`, `dto`, `controller`, `views`
- Database scripts and seed data under `sql/`
- Static assets under `assets/`

### 🔀 Release Notes

- Merged from `dev` into `main` after full QA
- Feature and hotfix branches squashed and removed post-merge
- Regression testing passed prior to production tagging
- Version tag `v1.0.0` applied to main branch

---

## [0.6.0] - 2025-07-28
### ✨ Added

- Help Section with user-friendly guidance on using key modules (Login, Customer, Items, Bills)
- `help.jsp` static page for instructions and walkthrough
- `HelpServlet` to route and render the help page via `/help`
- Navigation bar link to the Help page from the dashboard

### 🛠️ Changed

- Updated `dashboard.jsp` and common header to include link to Help section

---

## [0.5.0] - 2025-07-21
### ✅ Added

- Full login/logout functionality with session-based authentication.
- `LoginServlet` and `LogoutServlet` controllers with GET/POST handling.
- Secure `DashboardServlet` access via session validation.
- Dark-themed login UI with branding and Font Awesome icons.
- JUnit tests for `AuthService` with dynamic test user setup/teardown.
- JSP views securely placed in `WEB-INF/views`.

### 🖌️ Changed

- Global UI styling updated for modern dark theme.
- Font Awesome integration added for icons.
- Dashboard navigation protected via session checks.

### 🛡️ Security

- Direct access to JSP views restricted by moving them under `WEB-INF/views`.
- Secure session-based authentication flow.

### 🧪 Testing

- JUnit tests implemented for `AuthService`.
- `@BeforeEach` and `@AfterEach` handle test user creation and cleanup.

### 📝 Notes

- Merged into `dev` after code review.
- Feature branch `feature/login` deleted after merge.
- No version tag applied to `main` yet — pending full QA.

---

## [0.4.0] - 2025-07-20
### ✅ Added

- Full Item management module including model, DAO, service, DTO, and servlet.
- CRUD operations for items: add, edit, delete, list.
- JSP views for item management with improved dark-themed UI.
- JUnit tests for ItemDAO and ItemService.
- Dashboard updated with navigation to Items section.
- SQL schema and seed data for items added under `/sql/`.

### 🖌️ Changed

- Global CSS updated for consistent dark theme across all modules.
- Action buttons in item list now styled for better UX.
- Dashboard navigation updated to include Items.

### 📝 Notes

- Merged into `dev` via squash commit.
- Feature branch deleted after PR merge.

---

## [0.3.0] - 2025-07-18
### ✅ Added

- Full Customer CRUD implementation (Create, Read, Update, Delete)
- `CustomerDTO`, `CustomerDAO`, `CustomerService`, and `CustomerServlet`
- JSP pages for listing, adding, and editing customers
- Improved action buttons for Edit and Delete with distinct styling
- Dark-mode-compatible form elements and tables
- Unit tests for CustomerService and DAO with JUnit lifecycle (setup/teardown)
- SQL schema and initial seed data added under `sql/schema.sql` & `sql/seed_data.sql`

### 🖌️ Changed

- Global CSS updated for consistent dark theme across all modules
- Action buttons in customer list now styled for better UX

### 📝 Notes

- Merged into `dev` via squash commit
- Feature branch deleted after PR merge

---

## [0.2.0] - 2025-07-17
### ✅ Added

- New `customers` table
- Seed data for two sample customers

---

## [0.1.0] - 2025-07-16
### ✅ Added

- Session-based login and logout functionality
- `LoginServlet` and `LogoutServlet` with proper GET/POST handling
- Secure `DashboardServlet` with session validation
- Modern, dark-themed login UI with branding and Font Awesome icons
- Global CSS and JavaScript under `assets/`
- JUnit tests for `AuthService` with dynamic test user setup and cleanup
- Protected JSP views under `WEB-INF/views`

### 🖌️ Changed

- Removed public `index.jsp` and redirected to `login`

### 📝 Notes

- This is the first milestone feature for core authentication
- No version tag applied yet — will tag when `dev` stabilizes

---
