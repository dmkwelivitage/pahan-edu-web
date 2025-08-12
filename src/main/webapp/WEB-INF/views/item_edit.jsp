<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.ItemDTO" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Edit Item" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Edit Item</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <a href="<%= request.getContextPath() %>/items" class="btn btn-outline-secondary me-2">
            <i class="bi bi-arrow-left me-2"></i>Back to List
        </a>
    </div>
</div>

<%
  ItemDTO item = (ItemDTO) request.getAttribute("item");
  if (item != null) {
%>

<div class="row justify-content-center">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-box-seam me-2 text-success"></i>
                    Item Information
                </h5>
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/items" method="post">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%= item.getId() %>"/>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="name" class="form-label">Item Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="<%= item.getName() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="price" class="form-label">Price <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="price" name="price" 
                                       step="0.01" min="0" value="<%= item.getPrice() %>" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="3"
                                      placeholder="Enter item description"><%= item.getDescription() != null ? item.getDescription() : "" %></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="stock" class="form-label">Stock Quantity</label>
                            <input type="number" class="form-control" id="stock" name="stock" 
                                   min="0" value="<%= item.getStock() %>">
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="<%= request.getContextPath() %>/items" class="btn btn-secondary">
                            <i class="bi bi-x-circle me-2"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-check-circle me-2"></i>Update Item
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
    <strong>Item not found!</strong> The item you're looking for doesn't exist or has been removed.
</div>

<div class="text-center mt-4">
    <a href="<%= request.getContextPath() %>/items" class="btn btn-primary">
        <i class="bi bi-arrow-left me-2"></i>Back to Item List
    </a>
</div>

<% } %>

<style>
    .form-control:focus {
        border-color: #198754;
        box-shadow: 0 0 0 0.2rem rgba(25, 135, 84, 0.25);
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
