<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.CustomerDTO" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Edit Customer" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Edit Customer</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <a href="<%= request.getContextPath() %>/customers" class="btn btn-outline-secondary me-2">
            <i class="bi bi-arrow-left me-2"></i>Back to List
        </a>
    </div>
</div>

<%
  CustomerDTO customer = (CustomerDTO) request.getAttribute("customer");
  if (customer != null) {
%>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-person-gear me-2 text-primary"></i>
                    Customer Information
                </h5>
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/customers" method="post">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%= customer.getId() %>"/>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="accountNumber" class="form-label">Account Number <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                                   value="<%= customer.getAccountNumber() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="name" class="form-label">Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="<%= customer.getName() %>" required>
                        </div>
                        <div class="col-12">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3"
                                      placeholder="Enter customer address"><%= customer.getAddress() != null ? customer.getAddress() : "" %></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   value="<%= customer.getPhone() != null ? customer.getPhone() : "" %>"
                                   placeholder="Enter phone number">
                        </div>
                        <div class="col-md-6">
                            <label for="unitsConsumed" class="form-label">Units Consumed</label>
                            <input type="number" class="form-control" id="unitsConsumed" name="unitsConsumed" 
                                   min="0" value="<%= customer.getUnitsConsumed() %>">
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="<%= request.getContextPath() %>/customers" class="btn btn-secondary">
                            <i class="bi bi-x-circle me-2"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle me-2"></i>Update Customer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<% } else { %>

<div class="alert alert-warning" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    <strong>Customer not found!</strong> The customer you're looking for doesn't exist or has been removed.
</div>

<div class="text-center mt-4">
    <a href="<%= request.getContextPath() %>/customers" class="btn btn-primary">
        <i class="bi bi-arrow-left me-2"></i>Back to Customer List
    </a>
</div>

<% } %>

<style>
    .form-control:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
    }
    
    .form-label {
        font-weight: 500;
        color: #495057;
    }
    
    .card {
        border-radius: 0.75rem;
    }
</style>

<jsp:include page="footer.jsp" />
