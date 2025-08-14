<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<%@ page import="java.util.List" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Items" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Item Management</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addItemModal">
            <i class="bi bi-plus-circle me-2"></i>Add Item
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

<!-- Items Table -->
<div class="table-card">
    <div class="card-header">
        <h5 class="mb-0">
            <i class="bi bi-box me-2 text-success"></i>
            Item Catalog
        </h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="modern-table">
                <thead>
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Code</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Unit Price</th>
                        <th scope="col">Stock Qty</th>
                        <th scope="col" class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
                        if (items != null && !items.isEmpty()) {
                            for (ItemDTO obj : items) {
                    %>
                    <tr>
                        <td><span class="badge bg-secondary"><%= obj.getId() %></span></td>
                        <td><strong><%= obj.getCode() != null ? obj.getCode() : "-" %></strong></td>
                        <td><%= obj.getName() %></td>
                        <td><%= obj.getCategory() != null ? obj.getCategory() : "-" %></td>
                        <td>
                            <span class="badge bg-success">$<%= String.format("%.2f", obj.getUnitPrice()) %></span>
                        </td>
                        <td>
                            <span class="badge bg-info"><%= obj.getStockQty() %></span>
                        </td>
                        <td class="text-center">
                            <div class="action-buttons">
                                <a href="<%= request.getContextPath() %>/items?id=<%= obj.getId() %>" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <button type="button" class="btn btn-outline-danger btn-sm" 
                                        onclick="deleteItem(<%= obj.getId() %>, '<%= obj.getName() %>')">
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
                            <h5>No items found</h5>
                            <p class="mb-0">Start by adding your first item using the button above.</p>
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

<!-- Add Item Modal -->
<div class="modal fade" id="addItemModal" tabindex="-1" aria-labelledby="addItemModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addItemModalLabel">
                    <i class="bi bi-plus-circle me-2 text-success"></i>
                    Add New Item
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%= request.getContextPath() %>/items" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="add"/>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="code" class="form-label">Item Code <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="code" name="code" required>
                        </div>
                        <div class="col-md-6">
                            <label for="name" class="form-label">Item Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" name="name" required>
                        </div>
                        <div class="col-md-6">
                            <label for="category" class="form-label">Category</label>
                            <input type="text" class="form-control" id="category" name="category" 
                                   placeholder="Enter item category">
                        </div>
                        <div class="col-md-6">
                            <label for="unitPrice" class="form-label">Unit Price <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="number" class="form-control" id="unitPrice" name="unitPrice" 
                                       step="0.01" min="0" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="stockQty" class="form-label">Stock Quantity</label>
                            <input type="number" class="form-control" id="stockQty" name="stockQty" 
                                   min="0" value="0">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check-circle me-2"></i>Add Item
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteItemModal" tabindex="-1" aria-hidden="true">
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
                <p>Are you sure you want to delete item <strong id="itemNameToDelete"></strong>?</p>
                <p class="text-muted small">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteItemForm" action="<%= request.getContextPath() %>/items" method="post" class="d-inline">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" id="itemIdToDelete"/>
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-trash me-2"></i>Delete Item
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function deleteItem(itemId, itemName) {
    document.getElementById('itemNameToDelete').textContent = itemName;
    document.getElementById('itemIdToDelete').value = itemId;
    new bootstrap.Modal(document.getElementById('deleteItemModal')).show();
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
