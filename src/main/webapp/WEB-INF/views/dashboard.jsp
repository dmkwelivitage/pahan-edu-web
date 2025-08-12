<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.UserDTO" %>
<%
  UserDTO user = (UserDTO) request.getAttribute("user");
%>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Dashboard" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Dashboard</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <div class="btn-group me-2">
            <span class="badge bg-primary fs-6 px-3 py-2">
                <i class="bi bi-person-circle me-2"></i>
                <%= user.getRole() %>
            </span>
        </div>
    </div>
</div>

<!-- Welcome Card -->
<div class="row mb-4">
    <div class="col-12">
        <div class="card border-0 shadow-sm">
            <div class="card-body text-center py-5">
                <div class="mb-4">
                    <div class="display-4 text-primary mb-3">
                        <i class="bi bi-emoji-smile"></i>
                    </div>
                    <h2 class="card-title mb-3">Welcome back, <%= user.getUsername() %>!</h2>
                    <p class="card-text text-muted fs-5">Manage your customers, items, and bills efficiently</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions Grid -->
<div class="row g-4">
    <div class="col-md-6 col-lg-3">
        <div class="card h-100 border-0 shadow-sm hover-card">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-primary bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-people text-white fs-3"></i>
                    </div>
                </div>
                <h5 class="card-title">Customers</h5>
                <p class="card-text text-muted">Manage customer information and accounts</p>
                <a href="<%= request.getContextPath() %>/customers" class="btn btn-primary btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>Manage
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3">
        <div class="card h-100 border-0 shadow-sm hover-card">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-success bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-box text-white fs-3"></i>
                    </div>
                </div>
                <h5 class="card-title">Items</h5>
                <p class="card-text text-muted">Manage inventory and product catalog</p>
                <a href="<%= request.getContextPath() %>/items" class="btn btn-success btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>Manage
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3">
        <div class="card h-100 border-0 shadow-sm hover-card">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-warning bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-receipt text-white fs-3"></i>
                    </div>
                </div>
                <h5 class="card-title">Bills</h5>
                <p class="card-text text-muted">Create and manage customer bills</p>
                <a href="<%= request.getContextPath() %>/bills" class="btn btn-warning btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>Manage
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3">
        <div class="card h-100 border-0 shadow-sm hover-card">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-info bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-question-circle text-white fs-3"></i>
                    </div>
                </div>
                <h5 class="card-title">Help</h5>
                <p class="card-text text-muted">Get assistance and documentation</p>
                <a href="<%= request.getContextPath() %>/help" class="btn btn-info btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>Get Help
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Stats Row -->
<div class="row mt-5">
    <div class="col-12">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-graph-up me-2 text-success"></i>
                    Quick Overview
                </h5>
            </div>
            <div class="card-body">
                <div class="row text-center">
                    <div class="col-md-3 col-6 mb-3">
                        <div class="p-3">
                            <h3 class="text-primary mb-1">∞</h3>
                            <small class="text-muted">Total Customers</small>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-3">
                        <div class="p-3">
                            <h3 class="text-success mb-1">∞</h3>
                            <small class="text-muted">Total Items</small>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-3">
                        <div class="p-3">
                            <h3 class="text-warning mb-1">∞</h3>
                            <small class="text-muted">Total Bills</small>
                        </div>
                    </div>
                    <div class="col-md-3 col-6 mb-3">
                        <div class="p-3">
                            <h3 class="text-info mb-1">∞</h3>
                            <small class="text-muted">Revenue</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .hover-card {
        transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
    }
    
    .hover-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
    }
    
    .card {
        border-radius: 0.75rem;
    }
    
    .bg-gradient {
        background-image: linear-gradient(135deg, var(--bs-primary), var(--bs-primary-rgb));
    }
    
    .bg-success.bg-gradient {
        background-image: linear-gradient(135deg, var(--bs-success), #198754);
    }
    
    .bg-warning.bg-gradient {
        background-image: linear-gradient(135deg, var(--bs-warning), #ffc107);
    }
    
    .bg-info.bg-gradient {
        background-image: linear-gradient(135deg, var(--bs-info), #0dcaf0);
    }
</style>

<jsp:include page="footer.jsp" />
