<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.CustomerDTO" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Customer Lookup" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Customer Lookup</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <a href="<%= request.getContextPath() %>/customers" class="btn btn-outline-secondary me-2">
            <i class="bi bi-arrow-left me-2"></i>Back to Customers
        </a>
    </div>
</div>

<!-- Search Form -->
<div class="row justify-content-center mb-4">
    <div class="col-lg-6">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-search me-2 text-primary"></i>
                    Search Customer by Account Number
                </h5>
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/customer-lookup" method="get" id="lookupForm">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label for="accountNumber" class="form-label">Account Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                                   placeholder="Enter account number" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">&nbsp;</label>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search me-2"></i>Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Error Alert -->
<%
  String error = (String) request.getAttribute("error");
  if (error != null && !error.isEmpty()) {
%>
<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle me-2"></i>
            <%= error %>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </div>
</div>
<%
  }
%>

<!-- Customer Information Display -->
<%
  CustomerDTO customer = (CustomerDTO) request.getAttribute("customer");
  if (customer != null) {
%>
<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-person-circle me-2 text-success"></i>
                    Customer Information
                </h5>
            </div>
            <div class="card-body">
                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label text-muted">Customer ID</label>
                            <div class="form-control-plaintext text-dark fw-bold">#<%= customer.getId() %></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted">Full Name</label>
                            <div class="form-control-plaintext text-dark fw-bold"><%= customer.getName() %></div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted">Account Number</label>
                            <div class="form-control-plaintext text-dark fw-bold"><%= customer.getAccountNumber() %></div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="form-label text-muted">Phone</label>
                            <div class="form-control-plaintext text-dark">
                                <%= customer.getPhone() != null ? customer.getPhone() : "Not provided" %>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted">Address</label>
                            <div class="form-control-plaintext text-dark">
                                <%= customer.getAddress() != null ? customer.getAddress() : "Not provided" %>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-muted">Units Consumed</label>
                            <div class="form-control-plaintext text-dark fw-bold">
                                <%= customer.getUnitsConsumed() %>
                            </div>
                        </div>
                    </div>
                </div>
                
                <hr>
                
                <!-- Quick Actions -->
                <div class="row g-2">
                    <div class="col-md-4">
                        <a href="<%= request.getContextPath() %>/customers?id=<%= customer.getId() %>" 
                           class="btn btn-outline-primary w-100">
                            <i class="bi bi-pencil me-2"></i>Edit Customer
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="<%= request.getContextPath() %>/bills?customerId=<%= customer.getId() %>" 
                           class="btn btn-outline-warning w-100">
                            <i class="bi bi-receipt me-2"></i>View Bills
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="<%= request.getContextPath() %>/bills?action=create&customerId=<%= customer.getId() %>" 
                           class="btn btn-outline-success w-100">
                            <i class="bi bi-plus-circle me-2"></i>Create Bill
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<% } %>

<!-- No Results Message -->
<%
  if (request.getAttribute("searched") != null && customer == null && error == null) {
%>
<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="card border-0 shadow-sm">
            <div class="card-body text-center py-5">
                <div class="mb-4">
                    <div class="display-4 text-muted mb-3">
                        <i class="bi bi-search"></i>
                    </div>
                    <h5 class="text-muted">No Customer Found</h5>
                    <p class="text-muted mb-0">The account number you searched for doesn't exist in our system.</p>
                </div>
                <button type="button" class="btn btn-primary" onclick="document.getElementById('accountNumber').focus()">
                    <i class="bi bi-search me-2"></i>Try Another Search
                </button>
            </div>
        </div>
    </div>
</div>
<% } %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Auto-focus on account number input
    document.getElementById('accountNumber').focus();
    
    // Auto-hide alerts
    setTimeout(function() {
        var alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            var bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
    
    // Form validation
    document.getElementById('lookupForm').addEventListener('submit', function(e) {
        var accountNumber = document.getElementById('accountNumber').value.trim();
        if (!accountNumber) {
            e.preventDefault();
            alert('Please enter an account number to search.');
            return false;
        }
    });
});
</script>

<style>
.card {
    border-radius: 0.75rem;
    background-color: #ffffff;
}

.form-control-plaintext {
    background-color: #f8f9fa;
    padding: 0.5rem 0.75rem;
    border-radius: 0.375rem;
    border: 1px solid #dee2e6;
}

.text-dark {
    color: #212529 !important;
}

.form-label {
    color: #495057;
    font-weight: 500;
    font-size: 0.875rem;
}
</style>

<jsp:include page="footer.jsp" />
