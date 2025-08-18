<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.UserDTO" %>
<%@ page import="com.uni.dto.CustomerDTO" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<%@ page import="com.uni.dto.BillDTO" %>
<%@ page import="java.util.List" %>
<%
  UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");
  List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
  List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
  List<BillDTO> bills = (List<BillDTO>) request.getAttribute("bills");
  
  // Calculate statistics
  int totalCustomers = customers != null ? customers.size() : 0;
  int totalItems = items != null ? items.size() : 0;
  int totalBills = bills != null ? bills.size() : 0;
  double totalRevenue = 0.0;
  
  if (bills != null) {
      for (BillDTO bill : bills) {
          if (bill.getTotalAmount() != 0) {
              totalRevenue += bill.getTotalAmount();
          }
      }
  }
%>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Dashboard" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2 text-dark">Dashboard</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <div class="btn-group me-2">
            <span class="badge bg-primary fs-6 px-3 py-2">
                <i class="bi bi-person-circle me-2"></i>
                <%= loggedUser != null ? loggedUser.getRole() : "User" %>
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
                    <h2 class="card-title mb-3 text-dark">Welcome back, <%= loggedUser != null ? loggedUser.getUsername() : "User" %>!</h2>
                    <p class="card-text text-muted fs-5">Manage your customers, items, and bills efficiently</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Statistics Cards -->
<div class="row g-4 mb-4">
    <div class="col-md-6 col-lg-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-primary bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-people text-white fs-3"></i>
                    </div>
                </div>
                <h3 class="text-primary mb-1"><%= totalCustomers %></h3>
                <h5 class="card-title text-dark">Total Customers</h5>
                <p class="card-text text-muted">Active accounts</p>
                <a href="<%= request.getContextPath() %>/customers" class="btn btn-primary btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>Manage
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-success bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-box text-white fs-3"></i>
                    </div>
                </div>
                <h3 class="text-success mb-1"><%= totalItems %></h3>
                <h5 class="card-title text-dark">Total Items</h5>
                <p class="card-text text-muted">In inventory</p>
                <a href="<%= request.getContextPath() %>/items" class="btn btn-success btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>Manage
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-warning bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-receipt text-white fs-3"></i>
                    </div>
                </div>
                <h3 class="text-warning mb-1"><%= totalBills %></h3>
                <h5 class="card-title text-dark">Total Bills</h5>
                <p class="card-text text-muted">Generated</p>
                <a href="<%= request.getContextPath() %>/bills" class="btn btn-warning btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>Manage
                </a>
            </div>
        </div>
    </div>
    
    <div class="col-md-6 col-lg-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body text-center p-4">
                <div class="mb-3">
                    <div class="bg-info bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="bi bi-currency-dollar text-white fs-3"></i>
                    </div>
                </div>
                <h3 class="text-info mb-1">$<%= String.format("%.2f", totalRevenue) %></h3>
                <h5 class="card-title text-dark">Total Revenue</h5>
                <p class="card-text text-muted">From all bills</p>
                <a href="<%= request.getContextPath() %>/bills" class="btn btn-info btn-sm">
                    <i class="bi bi-arrow-right me-1"></i>View
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Charts and Analytics Row -->
<div class="row g-4 mb-4">
    <!-- Revenue Chart -->
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0 text-dark">
                    <i class="bi bi-graph-up me-2 text-success"></i>
                    Revenue Overview
                </h5>
            </div>
            <div class="card-body">
                <canvas id="revenueChart" width="400" height="200"></canvas>
            </div>
        </div>
    </div>
    
    <!-- Recent Activity -->
    <div class="col-lg-4">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0 text-dark">
                    <i class="bi bi-clock-history me-2 text-primary"></i>
                    Recent Activity
                </h5>
            </div>
            <div class="card-body">
                <div class="timeline">
                    <% if (bills != null && !bills.isEmpty()) { %>
                        <% for (int i = 0; i < Math.min(5, bills.size()); i++) { %>
                            <div class="timeline-item mb-3">
                                <div class="timeline-marker bg-primary"></div>
                                <div class="timeline-content">
                                    <h6 class="mb-1">Bill #<%= bills.get(i).getId() %> Created</h6>
                                    <small class="text-muted">
                                        <%= bills.get(i).getBillingDate() != null ? 
                                            new java.text.SimpleDateFormat("MMM dd, yyyy").format(bills.get(i).getBillingDate()) : "N/A" %>
                                    </small>
                                </div>
                            </div>
                        <% } %>
                    <% } else { %>
                        <p class="text-muted text-center">No recent activity</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions and Help -->
<div class="row g-4">
    <div class="col-lg-6">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0 text-dark">
                    <i class="bi bi-lightning me-2 text-warning"></i>
                    Quick Actions
                </h5>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-6">
                        <a href="<%= request.getContextPath() %>/customers" class="btn btn-outline-primary w-100">
                            <i class="bi bi-person-plus me-2"></i>Add Customer
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="<%= request.getContextPath() %>/items" class="btn btn-outline-success w-100">
                            <i class="bi bi-plus-circle me-2"></i>Add Item
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="<%= request.getContextPath() %>/bills" class="btn btn-outline-warning w-100">
                            <i class="bi bi-receipt me-2"></i>Create Bill
                        </a>
                    </div>
                    <div class="col-6">
                        <a href="<%= request.getContextPath() %>/help" class="btn btn-outline-info w-100">
                            <i class="bi bi-question-circle me-2"></i>Get Help
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-lg-6">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0 text-dark">
                    <i class="bi bi-info-circle me-2 text-info"></i>
                    System Status
                </h5>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-6">
                        <div class="text-center">
                            <div class="h4 text-success mb-1">
                                <i class="bi bi-check-circle"></i>
                            </div>
                            <small class="text-muted">System Online</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="text-center">
                            <div class="h4 text-primary mb-1">
                                <i class="bi bi-database"></i>
                            </div>
                            <small class="text-muted">Database Connected</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="text-center">
                            <div class="h4 text-warning mb-1">
                                <i class="bi bi-shield-check"></i>
                            </div>
                            <small class="text-muted">Security Active</small>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="text-center">
                            <div class="h4 text-info mb-1">
                                <i class="bi bi-clock"></i>
                            </div>
                            <small class="text-muted">24/7 Available</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- User Info at Bottom -->
<div class="row mt-5">
    <div class="col-12">
        <div class="card border-0 shadow-sm">
            <div class="card-body text-center py-4">
                <div class="d-flex align-items-center justify-content-center mb-3">
                    <div class="user-avatar me-3">
                        <%= loggedUser != null ? loggedUser.getUsername().substring(0, 1).toUpperCase() : "U" %>
                    </div>
                    <div class="text-start">
                        <h5 class="mb-1 text-dark">Logged in as: <%= loggedUser != null ? loggedUser.getUsername() : "User" %></h5>
                        <p class="text-muted mb-0">Role: <%= loggedUser != null ? loggedUser.getRole() : "Unknown" %></p>
                    </div>
                </div>
                <p class="text-muted">Welcome to Pahan Edu Management System. You have access to manage customers, items, and bills.</p>
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
        background-color: #ffffff;
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
    
    .text-dark {
        color: #212529 !important;
    }
    
    .text-muted {
        color: #6c757d !important;
    }
    
    .card-title {
        color: #212529 !important;
    }
    
    .card-text {
        color: #6c757d !important;
    }
    
    .timeline {
        position: relative;
        padding-left: 20px;
    }
    
    .timeline-item {
        position: relative;
        padding-left: 20px;
    }
    
    .timeline-marker {
        position: absolute;
        left: -10px;
        top: 5px;
        width: 8px;
        height: 8px;
        border-radius: 50%;
    }
    
    .timeline-content {
        padding-bottom: 10px;
    }
    
    .user-avatar {
        width: 50px;
        height: 50px;
        border-radius: 50%;
        background: linear-gradient(135deg, #0d6efd, #0dcaf0);
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-weight: bold;
        font-size: 1.2rem;
    }
</style>

<!-- Chart.js for Revenue Chart -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
// Sample revenue data - in a real application, this would come from the server
const ctx = document.getElementById('revenueChart').getContext('2d');
const revenueChart = new Chart(ctx, {
    type: 'line',
    data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        datasets: [{
            label: 'Monthly Revenue',
            data: [1200, 1900, 3000, 5000, 2000, 3000],
            borderColor: 'rgb(75, 192, 192)',
            backgroundColor: 'rgba(75, 192, 192, 0.2)',
            tension: 0.1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
            legend: {
                display: false
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    callback: function(value) {
                        return '$' + value;
                    }
                }
            }
        }
    }
});
</script>

<jsp:include page="footer.jsp" />
