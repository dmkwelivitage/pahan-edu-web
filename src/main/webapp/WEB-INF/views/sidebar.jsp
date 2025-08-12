<nav id="sidebar" class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
    <div class="position-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/dashboard") ? "active" : "" %>" href="<%= request.getContextPath() %>/dashboard">
                    <i class="bi bi-house-door me-2"></i>
                    Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/customers") ? "active" : "" %>" href="<%= request.getContextPath() %>/customers">
                    <i class="bi bi-people me-2"></i>
                    Customers
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/items") ? "active" : "" %>" href="<%= request.getContextPath() %>/items">
                    <i class="bi bi-box me-2"></i>
                    Items
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/bills") ? "active" : "" %>" href="<%= request.getContextPath() %>/bills">
                    <i class="bi bi-receipt me-2"></i>
                    Bills
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= request.getRequestURI().contains("/help") ? "active" : "" %>" href="<%= request.getContextPath() %>/help">
                    <i class="bi bi-question-circle me-2"></i>
                    Help
                </a>
            </li>
        </ul>
    </div>
</nav>

<style>
    .sidebar {
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        z-index: 100;
        padding: 48px 0 0;
        box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
        background: linear-gradient(180deg, #f8f9fa 0%, #e9ecef 100%);
    }
    
    .sidebar .nav-link {
        font-weight: 500;
        color: #495057;
        padding: 0.75rem 1rem;
        border-radius: 0.375rem;
        margin: 0.125rem 0.5rem;
        transition: all 0.2s ease-in-out;
    }
    
    .sidebar .nav-link:hover {
        color: #0d6efd;
        background-color: rgba(13, 110, 253, 0.1);
        transform: translateX(5px);
    }
    
    .sidebar .nav-link.active {
        color: #fff;
        background: linear-gradient(135deg, #0d6efd, #0dcaf0);
        box-shadow: 0 2px 8px rgba(13, 110, 253, 0.3);
    }
    
    .sidebar .nav-link i {
        width: 20px;
        text-align: center;
    }
    
    @media (max-width: 767.98px) {
        .sidebar {
            position: static;
            height: auto;
            padding-top: 0;
        }
        
        main {
            margin-left: 0 !important;
        }
    }
    
    @media (min-width: 768px) {
        main {
            margin-left: 16.666667%;
        }
    }
    
    @media (min-width: 992px) {
        main {
            margin-left: 16.666667%;
        }
    }
</style>
