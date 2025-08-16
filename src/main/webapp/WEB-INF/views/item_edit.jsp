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
                            <label for="code" class="form-label">Item Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="code" name="code" 
                                   value="<%= item.getCode() != null ? item.getCode() : "" %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="name" class="form-label">Item Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" 
                                   value="<%= item.getName() %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="category" class="form-label">Category</label>
                            <input type="text" class="form-control" id="category" name="category" 
                                   value="<%= item.getCategory() != null ? item.getCategory() : "" %>"
                                   placeholder="Enter item category">
                        </div>
                        <div class="col-md-6">
                            <label for="unitPrice" class="form-label">Unit Price <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control text-dark" id="unitPrice" name="unitPrice"
                                       step="0.01" min="0" value="<%= item.getUnitPrice() %>" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="stockQty" class="form-label">Stock Quantity</label>
                            <input type="number" class="form-control" id="stockQty" name="stockQty" 
                                   min="0" value="<%= item.getStockQty() %>">
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
