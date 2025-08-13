<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.CustomerDTO" %>
<%@ page import="java.util.List" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Customers" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Customer Management</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <a href="<%= request.getContextPath() %>/customer-lookup" class="btn btn-outline-info me-2">
            <i class="bi bi-search me-2"></i>Customer Lookup
        </a>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
            <i class="bi bi-plus-circle me-2"></i>Add Customer
        </button>
    </div>
</div>

<!-- Error Alert -->
<%
  String error = (String) request.getAttribute("error");
  if (error != null && !error.isEmpty()) {
%>
<div class="alert alert-danger alert-dismissible fade show" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    <%= error %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
  }
%>

<!-- Success Alert -->
<%
  String success = (String) request.getAttribute("success");
  if (success != null && !success.isEmpty()) {
%>
<div class="alert alert-success alert-dismissible fade show" role="alert">
    <i class="bi bi-check-circle me-2"></i>
    <%= success %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
  }
%>

<!-- Customers Table -->
<div class="card border-0 shadow-sm">
    <div class="card-header bg-transparent border-0">
        <h5 class="mb-0">
            <i class="bi bi-people me-2 text-primary"></i>
            Customer List
        </h5>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Account Number</th>
                        <th scope="col">Name</th>
                        <th scope="col">Address</th>
                        <th scope="col">Phone</th>
                        <th scope="col">Units</th>
                        <th scope="col" class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
                        if (customers != null && !customers.isEmpty()) {
                            for (CustomerDTO obj : customers) {
                    %>
                    <tr>
                        <td><span class="badge bg-secondary"><%= obj.getId() %></span></td>
                        <td><strong><%= obj.getAccountNumber() %></strong></td>
                        <td><%= obj.getName() %></td>
                        <td><%= obj.getAddress() != null ? obj.getAddress() : "-" %></td>
                        <td><%= obj.getPhone() != null ? obj.getPhone() : "-" %></td>
                        <td>
                            <span class="badge bg-info"><%= obj.getUnitsConsumed() %></span>
                        </td>
                        <td class="text-center">
                            <div class="btn-group" role="group">
                                <a href="<%= request.getContextPath() %>/customers?id=<%= obj.getId() %>" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <button type="button" class="btn btn-outline-danger btn-sm" 
                                        onclick="deleteCustomer(<%= obj.getId() %>, '<%= obj.getName() %>')">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="7" class="text-center text-muted py-4">
                            <i class="bi bi-inbox display-4 d-block mb-3"></i>
                            <h5>No customers found</h5>
                            <p class="mb-0">Start by adding your first customer using the button above.</p>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add Customer Modal -->
<div class="modal fade" id="addCustomerModal" tabindex="-1" aria-labelledby="addCustomerModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCustomerModalLabel">
                    <i class="bi bi-person-plus me-2 text-primary"></i>
                    Add New Customer
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%= request.getContextPath() %>/customers" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="add"/>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="accountNumber" class="form-label">Account Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
                        </div>
                        <div class="col-md-6">
                            <label for="name" class="form-label">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="col-12">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="2"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone">
                        </div>
                        <div class="col-md-6">
                            <label for="unitsConsumed" class="form-label">Units Consumed</label>
                            <input type="number" class="form-control" id="unitsConsumed" name="unitsConsumed" min="0" value="0">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle me-2"></i>Add Customer
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteCustomerModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-danger">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    Confirm Delete
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete customer <strong id="customerNameToDelete"></strong>?</p>
                <p class="text-muted small">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteCustomerForm" action="<%= request.getContextPath() %>/customers" method="post" class="d-inline">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" id="customerIdToDelete"/>
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-trash me-2"></i>Delete Customer
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function deleteCustomer(customerId, customerName) {
    document.getElementById('customerNameToDelete').textContent = customerName;
    document.getElementById('customerIdToDelete').value = customerId;
    new bootstrap.Modal(document.getElementById('deleteCustomerModal')).show();
}

// Auto-hide alerts after 5 seconds
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);
});
</script>

<jsp:include page="footer.jsp" />
