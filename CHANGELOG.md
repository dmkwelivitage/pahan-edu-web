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
