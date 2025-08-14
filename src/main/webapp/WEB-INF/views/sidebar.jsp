<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.UserDTO" %>
<%!
    // Helper function to check if current path matches
    boolean isActive(String path, String currentPath) {
        return currentPath.equals(path) || currentPath.startsWith(path + "/");
    }
%>

<%
    UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");

    // Get the current request URI and extract the path
    String requestURI = request.getRequestURI();
    String contextPath = request.getContextPath();
    String currentPath = requestURI.substring(contextPath.length());
%>

<!-- Mobile Sidebar Toggle Button -->
<button class="btn btn-primary d-md-none position-fixed" 
        style="top: 0; left: 0; z-index: 1000; width: 100%; height: 40px; border-radius: 0; border: none; background-color: #0d6efd;"
        type="button" 
        data-bs-toggle="offcanvas" 
        data-bs-target="#mobileSidebar">
    <i class="bi bi-list"></i>
</button>

<!-- Mobile Sidebar (Offcanvas) -->
<div class="offcanvas offcanvas-start d-md-none" id="mobileSidebar" tabindex="-1">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title">
            <img src="<%= request.getContextPath() %>/assets/img/logo2.png" alt="Pahan Edu" style="height: 30px; width: auto;">
            <span class="ms-2 text-primary fw-bold">Pahan Edu</span>
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body p-0">
        <div class="sidebar-mobile">
            <div class="position-sticky pt-3">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link <%= isActive("/dashboard", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/dashboard">
                            <i class="bi bi-house-door me-2"></i>
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= isActive("/customers", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/customers">
                            <i class="bi bi-people me-2"></i>
                            Customers
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= isActive("/customer-lookup", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/customer-lookup">
                            <i class="bi bi-search me-2"></i>
                            Customer Lookup
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= isActive("/items", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/items">
                            <i class="bi bi-box me-2"></i>
                            Items
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= isActive("/bills", currentPath) || isActive("/bill", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/bills">
                            <i class="bi bi-receipt me-2"></i>
                            Bills
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link <%= isActive("/help", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/help">
                            <i class="bi bi-question-circle me-2"></i>
                            Help
                        </a>
                    </li>
                </ul>
            </div>
            
            <!-- User Info and Logout at Bottom -->
            <div class="sidebar-footer border-top mt-auto">
                <div class="user-info p-3">
                    <div class="d-flex align-items-center mb-2">
                        <div class="user-avatar me-2">
                            <%= loggedUser != null ? loggedUser.getUsername().substring(0, 1).toUpperCase() : "U" %>
                        </div>
                        <div class="user-details">
                            <div class="user-name fw-semibold text-dark">
                                <%= loggedUser != null ? loggedUser.getUsername() : "User" %>
                            </div>
                            <div class="user-role text-muted small">
                                <%= loggedUser != null ? loggedUser.getRole() : "Unknown" %>
                            </div>
                        </div>
                    </div>
                    <form action="<%= request.getContextPath() %>/logout" method="post" class="d-grid">
                        <button type="submit" class="btn btn-outline-danger btn-sm">
                            <i class="bi bi-box-arrow-right me-1"></i>Logout
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Desktop Sidebar -->
<nav id="sidebar" class="col-md-3 col-lg-2 d-none d-md-block bg-white sidebar">
    <!-- Company Logo and Name at Top -->
    <div class="sidebar-header text-center py-3 border-bottom">
        <img src="<%= request.getContextPath() %>/assets/img/logo2.png" alt="Pahan Edu" class="sidebar-logo mb-2">
        <h6 class="sidebar-company-name mb-0 text-primary fw-bold">Pahan Edu</h6>
        <small class="text-muted">Education Management</small>
    </div>
    
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= isActive("/dashboard", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/dashboard">
                    <i class="bi bi-house-door me-2"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= isActive("/customers", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/customers">
                    <i class="bi bi-people me-2"></i>
                    Customers
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= isActive("/customer-lookup", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/customer-lookup">
                    <i class="bi bi-search me-2"></i>
                    Customer Lookup
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= isActive("/items", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/items">
                    <i class="bi bi-box me-2"></i>
                    Items
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= isActive("/bills", currentPath) || isActive("/bill", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/bills">
                    <i class="bi bi-receipt me-2"></i>
                    Bills
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= isActive("/help", currentPath) ? "active" : "" %>" href="<%= request.getContextPath() %>/help">
                    <i class="bi bi-question-circle me-2"></i>
                    Help
                </a>
            </li>
        </ul>
    </div>
    
    <!-- User Info and Logout at Bottom -->
    <div class="sidebar-footer border-top mt-auto">
        <div class="user-info p-3 d-flex align-items-baseline">
            <div class="d-flex align-items-center mb-2">
                <div class="user-avatar me-2">
                    <%= loggedUser != null ? loggedUser.getUsername().substring(0, 1).toUpperCase() : "U" %>
                </div>
                <div class="user-details">
                    <div class="user-name fw-semibold text-dark">
                        <%= loggedUser != null ? loggedUser.getUsername() : "User" %>
                    </div>
                    <div class="user-role text-muted small">
                        <%= loggedUser != null ? loggedUser.getRole() : "Unknown" %>
                    </div>
                </div>
            </div>
            <div class="d-flex align-items-center mb-2">
            <form action="<%= request.getContextPath() %>/logout" method="post" class="d-grid">
                <button type="submit" class="btn btn-outline-danger btn-sm">
                    <i class="bi bi-box-arrow-right me-1"></i>Logout
                </button>
            </form>
            </div>
        </div>
    </div>
</nav>

<style>
    /* Desktop Sidebar Styles */
    .sidebar {
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        z-index: 100;
        padding: 0;
        box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
        background: linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%);
        border-right: 1px solid #dee2e6;
        display: flex;
        flex-direction: column;
        width: 16.666667%;
        overflow-y: auto;
    }
    
    /* Mobile Sidebar Styles */
    .sidebar-mobile {
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    
    .sidebar-header {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border-bottom: 1px solid #dee2e6;
        position: relative;
        z-index: 10;
    }
    
    .sidebar-logo {
        height: 40px;
        width: auto;
        position: relative;
        z-index: 10;
    }
    
    .sidebar-company-name {
        font-size: 0.9rem;
        position: relative;
        z-index: 10;
    }
    
    .sidebar .nav-link,
    .sidebar-mobile .nav-link {
        font-weight: 500;
        color: #495057;
        padding: 0.75rem 1rem;
        border-radius: 0.375rem;
        margin: 0.125rem 0.5rem;
        transition: all 0.2s ease-in-out;
        position: relative;
        z-index: 10;
        text-decoration: none;
    }
    
    .sidebar .nav-link:hover,
    .sidebar-mobile .nav-link:hover {
        color: #0d6efd;
        background-color: rgba(13, 110, 253, 0.1);
        transform: translateX(5px);
    }
    
    .sidebar .nav-link.active,
    .sidebar-mobile .nav-link.active {
        color: #fff !important;
        background: linear-gradient(135deg, #0d6efd, #0dcaf0) !important;
        box-shadow: 0 2px 8px rgba(13, 110, 253, 0.3);
    }
    
    .sidebar .nav-link i,
    .sidebar-mobile .nav-link i {
        width: 20px;
        text-align: center;
    }
    
    .sidebar-footer {
        margin-top: auto;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        position: absolute;
        bottom: 0;
        width: 100%;
        z-index: 10;
    }
    
    .user-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background: linear-gradient(135deg, #0d6efd, #0dcaf0);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 0.9rem;
    }
    
    .user-name {
        font-size: 0.9rem;
    }
    
    .user-role {
        font-size: 0.75rem;
    }
    
    /* Offcanvas customizations */
    .offcanvas {
        width: 280px;
    }
    
    .offcanvas-header {
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        border-bottom: 1px solid #dee2e6;
    }
    
    /* Responsive adjustments */
    @media (max-width: 767.98px) {
        .sidebar {
            display: none !important;
        }
        
        main {
            margin-left: 0 !important;
            padding-top: 20px;
        }
    }
    
    @media (min-width: 768px) {
        main {
            margin-left: 16.666667%;
            padding-top: 20px;
        }
    }
    
    @media (min-width: 992px) {
        main {
            margin-left: 16.666667%;
            padding-top: 20px;
        }
    }
</style>
