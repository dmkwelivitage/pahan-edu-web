## [0.5.0] - 2025-07-21
### Added
- Full login/logout functionality with session-based authentication.
- `LoginServlet` and `LogoutServlet` controllers with GET/POST handling.
- Secure `DashboardServlet` access via session validation.
- Dark-themed login UI with branding and Font Awesome icons.
- JUnit tests for `AuthService` with dynamic test user setup/teardown.
- JSP views securely placed in `WEB-INF/views`.

### Changed
- Global UI styling updated for modern dark theme.
- Font Awesome integration added for icons.
- Dashboard navigation protected via session checks.

### Security
- Direct access to JSP views restricted by moving them under `WEB-INF/views`.
- Secure session-based authentication flow.

### Testing
- JUnit tests implemented for `AuthService`.
- `@BeforeEach` and `@AfterEach` handle test user creation and cleanup.

### Notes
- Merged into `dev` after code review.
- Feature branch `feature/login` deleted after merge.
- No version tag applied to `main` yet — pending full QA.

---

## [0.4.0] - 2025-07-20
### Added
- Full Item management module including model, DAO, service, DTO, and servlet.
- CRUD operations for items: add, edit, delete, list.
- JSP views for item management with improved dark-themed UI.
- JUnit tests for ItemDAO and ItemService.
- Dashboard updated with navigation to Items section.
- SQL schema and seed data for items added under `/db/sql`.

### Changed
- Global CSS updated for consistent dark theme across all modules.
- Action buttons in item list now styled for better UX.
- Dashboard navigation updated to include Items.

### Notes
- Merged into `dev` via squash commit.
- Feature branch deleted after PR merge.

---

## [0.3.0] - 2025-07-18
### Added
- Full Customer CRUD implementation (Create, Read, Update, Delete)
- `CustomerDTO`, `CustomerDAO`, `CustomerService`, and `CustomerServlet`
- JSP pages for listing, adding, and editing customers
- Improved action buttons for Edit and Delete with distinct styling
- Dark-mode-compatible form elements and tables
- Unit tests for CustomerService and DAO with JUnit lifecycle (setup/teardown)
- SQL schema and initial seed data added under `sql/schema.sql` & `sql/seed_data.sql`

### Changed
- Global CSS updated for consistent dark theme across all modules
- Action buttons in customer list now styled for better UX

### Notes
- Merged into `dev` via squash commit
- Feature branch deleted after PR merge

---

## [0.2.0] - 2025-07-17
### Added
- New `customers` table
- Seed data for two sample customers

---

## [0.1.0] - 2025-07-16
### Added
- Session-based login and logout functionality
- `LoginServlet` and `LogoutServlet` with proper GET/POST handling
- Secure `DashboardServlet` with session validation
- Modern, dark-themed login UI with branding and Font Awesome icons
- Global CSS and JavaScript under `assets/`
- JUnit tests for `AuthService` with dynamic test user setup and cleanup
- Protected JSP views under `WEB-INF/views`

### Changed
- Removed public `index.jsp` and redirected to `login`

### Notes
- This is the first milestone feature for core authentication
- No version tag applied yet — will tag when `dev` stabilizes
