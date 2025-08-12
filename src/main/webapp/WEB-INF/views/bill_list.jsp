<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.BillDTO" %>
<%@ page import="java.util.List" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Bills" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Bill Management</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBillModal">
            <i class="bi bi-plus-circle me-2"></i>Create Bill
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

<!-- Bills Table -->
<div class="card border-0 shadow-sm">
    <div class="card-header bg-transparent border-0">
        <h5 class="mb-0">
            <i class="bi bi-receipt me-2 text-warning"></i>
            Bill Records
        </h5>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th scope="col">Bill ID</th>
                        <th scope="col">Customer</th>
                        <th scope="col">Date</th>
                        <th scope="col">Total Amount</th>
                        <th scope="col">Status</th>
                        <th scope="col" class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<BillDTO> bills = (List<BillDTO>) request.getAttribute("bills");
                        if (bills != null && !bills.isEmpty()) {
                            for (BillDTO obj : bills) {
                    %>
                    <tr>
                        <td><span class="badge bg-secondary">#<%= obj.getId() %></span></td>
                        <td><strong><%= obj.getCustomerId() != 0 ? obj.getCustomerId() : "N/A" %></strong></td>
                        <td><%= obj.getBillingDate() != null ? obj.getBillingDate() : "N/A" %></td>
                        <td>
                            <span class="badge bg-success">$<%= String.format("%.2f", obj.getTotalAmount()) %></span>
                        </td>
                        <td>
                            <span class="badge bg-primary">Active</span>
                        </td>
                        <td class="text-center">
                            <div class="btn-group" role="group">
                                <a href="<%= request.getContextPath() %>/bills?id=<%= obj.getId() %>" 
                                   class="btn btn-outline-primary btn-sm">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="<%= request.getContextPath() %>/bills?id=<%= obj.getId() %>&action=edit" 
                                   class="btn btn-outline-warning btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <button type="button" class="btn btn-outline-danger btn-sm" 
                                        onclick="deleteBill(<%= obj.getId() %>, 'Unknown')">
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
                        <td colspan="6" class="text-center text-muted py-4">
                            <i class="bi bi-inbox display-4 d-block mb-3"></i>
                            <h5>No bills found</h5>
                            <p class="mb-0">Start by creating your first bill using the button above.</p>
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

<!-- Create Bill Modal -->
<div class="modal fade" id="addBillModal" tabindex="-1" aria-labelledby="addBillModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addBillModalLabel">
                    <i class="bi bi-plus-circle me-2 text-warning"></i>
                    Create New Bill
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<%= request.getContextPath() %>/bills" method="post">
                <div class="modal-body">
                    <input type="hidden" name="action" value="add"/>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="customerId" class="form-label">Customer <span class="text-danger">*</span></label>
                            <select class="form-select" id="customerId" name="customerId" required>
                                <option value="">Select a customer</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="billDate" class="form-label">Bill Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="billDate" name="billDate" required>
                        </div>
                        
                        <div class="col-12">
                            <hr>
                            <h6 class="mb-3">Bill Items</h6>
                            <div id="billItems">
                                <div class="row g-2 mb-2 bill-item">
                                    <div class="col-md-4">
                                        <select class="form-select" name="itemIds[]" required>
                                            <option value="">Select item</option>
                                        </select>
                                    </div>
                                    <div class="col-md-2">
                                        <input type="number" class="form-control" name="quantities[]" 
                                               placeholder="Qty" min="1" value="1" required>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="number" class="form-control" name="prices[]" 
                                               placeholder="Price" step="0.01" min="0" required>
                                    </div>
                                    <div class="col-md-2">
                                        <span class="form-control-plaintext item-total">$0.00</span>
                                    </div>
                                    <div class="col-md-1">
                                        <button type="button" class="btn btn-outline-danger btn-sm remove-item">
                                            <i class="bi bi-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <button type="button" class="btn btn-outline-primary btn-sm" id="addItemBtn">
                                <i class="bi bi-plus-circle me-2"></i>Add Item
                            </button>
                        </div>
                        
                        <div class="col-12">
                            <hr>
                            <div class="row">
                                <div class="col-md-6 offset-md-6">
                                    <div class="d-flex justify-content-between">
                                        <strong>Total Amount:</strong>
                                        <strong class="text-primary" id="totalAmount">$0.00</strong>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-warning">
                        <i class="bi bi-check-circle me-2"></i>Create Bill
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteBillModal" tabindex="-1" aria-hidden="true">
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
                <p>Are you sure you want to delete this bill?</p>
                <p class="text-muted small">This action cannot be undone.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <form id="deleteBillForm" action="<%= request.getContextPath() %>/bills" method="post" class="d-inline">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" id="billIdToDelete"/>
                    <button type="submit" class="btn btn-danger">
                        <i class="bi bi-trash me-2"></i>Delete Bill
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function deleteBill(billId, customerName) {
    document.getElementById('billIdToDelete').value = billId;
    new bootstrap.Modal(document.getElementById('deleteBillModal')).show();
}

document.addEventListener('DOMContentLoaded', function() {
    var addItemBtn = document.getElementById('addItemBtn');
    var billItems = document.getElementById('billItems');
    
    if (addItemBtn) {
        addItemBtn.addEventListener('click', function() {
            var newItem = document.querySelector('.bill-item').cloneNode(true);
            var inputs = newItem.querySelectorAll('input, select');
            for (var i = 0; i < inputs.length; i++) {
                inputs[i].value = '';
                if (inputs[i].type === 'number' && inputs[i].name === 'quantities[]') {
                    inputs[i].value = '1';
                }
            }
            billItems.appendChild(newItem);
            updateTotal();
        });
    }
    
    billItems.addEventListener('click', function(e) {
        if (e.target.classList.contains('remove-item') || e.target.closest('.remove-item')) {
            if (document.querySelectorAll('.bill-item').length > 1) {
                e.target.closest('.bill-item').remove();
                updateTotal();
            }
        }
    });
    
    billItems.addEventListener('input', function(e) {
        if (e.target.name === 'quantities[]' || e.target.name === 'prices[]') {
            updateTotal();
        }
    });
    
    function updateTotal() {
        var total = 0;
        var items = document.querySelectorAll('.bill-item');
        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            var qty = parseFloat(item.querySelector('[name="quantities[]"]').value) || 0;
            var price = parseFloat(item.querySelector('[name="prices[]"]').value) || 0;
            var itemTotal = qty * price;
            item.querySelector('.item-total').textContent = '$' + itemTotal.toFixed(2);
            total += itemTotal;
        }
        document.getElementById('totalAmount').textContent = '$' + total.toFixed(2);
    }
    
    setTimeout(function() {
        var alerts = document.querySelectorAll('.alert');
        for (var i = 0; i < alerts.length; i++) {
            var bsAlert = new bootstrap.Alert(alerts[i]);
            bsAlert.close();
        }
    }, 5000);
});
</script>

<jsp:include page="footer.jsp" />
