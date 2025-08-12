<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.BillDTO" %>
<%@ page import="com.uni.dto.CustomerDTO" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<%@ page import="java.util.List" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Edit Bill" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Edit Bill</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <a href="<%= request.getContextPath() %>/bills" class="btn btn-outline-secondary me-2">
            <i class="bi bi-arrow-left me-2"></i>Back to Bills
        </a>
    </div>
</div>

<%
  BillDTO bill = (BillDTO) request.getAttribute("bill");
  if (bill != null) {
%>

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

<div class="row">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-pencil-square me-2 text-warning"></i>
                    Edit Bill Information
                </h5>
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/bills" method="post">
                    <input type="hidden" name="action" value="update"/>
                    <input type="hidden" name="id" value="<%= bill.getId() %>"/>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="customerId" class="form-label">Customer <span class="text-danger">*</span></label>
                            <select class="form-select" id="customerId" name="customerId" required>
                                <option value="">Select a customer</option>
                                <%
                                    List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
                                    if (customers != null) {
                                        for (CustomerDTO customer : customers) {
                                            String selected = (customer.getId() == bill.getCustomerId()) ? "selected" : "";
                                %>
                                <option value="<%= customer.getId() %>" <%= selected %>>
                                    <%= customer.getName() %> (<%= customer.getAccountNumber() %>)
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="billDate" class="form-label">Bill Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="billDate" name="billDate" 
                                   value="<%= bill.getBillDate() != null ? bill.getBillDate() : java.time.LocalDate.now() %>" required>
                        </div>
                        
                        <div class="col-12">
                            <hr>
                            <h6 class="mb-3">Bill Items</h6>
                            <div id="billItems">
                                <!-- Bill items will be populated here -->
                                <div class="text-center text-muted py-4">
                                    <i class="bi bi-inbox display-4 d-block mb-3"></i>
                                    <h6>Loading bill items...</h6>
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
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Subtotal:</span>
                                        <span id="subtotal">$0.00</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Tax (10%):</span>
                                        <span id="tax">$0.00</span>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between">
                                        <strong>Total Amount:</strong>
                                        <strong class="text-primary fs-5" id="totalAmount">$0.00</strong>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <a href="<%= request.getContextPath() %>/bills" class="btn btn-secondary">
                            <i class="bi bi-x-circle me-2"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-warning">
                            <i class="bi bi-check-circle me-2"></i>Update Bill
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="col-lg-4">
        <!-- Bill Summary -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-transparent border-0">
                <h6 class="mb-0">
                    <i class="bi bi-info-circle me-2 text-info"></i>
                    Bill Summary
                </h6>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <small class="text-muted">Bill ID</small>
                    <div class="fw-bold">#<%= bill.getId() %></div>
                </div>
                <div class="mb-3">
                    <small class="text-muted">Customer</small>
                    <div id="selectedCustomer">
                        <% if (bill.getCustomerName() != null) { %>
                            <%= bill.getCustomerName() %>
                        <% } else { %>
                            Unknown
                        <% } %>
                    </div>
                </div>
                <div class="mb-3">
                    <small class="text-muted">Bill Date</small>
                    <div id="selectedDate">
                        <%= bill.getBillDate() != null ? bill.getBillDate() : "Not set" %>
                    </div>
                </div>
                <div class="mb-3">
                    <small class="text-muted">Items</small>
                    <div id="itemCount">0 items</div>
                </div>
                <hr>
                <div class="d-flex justify-content-between">
                    <strong>Total:</strong>
                    <strong id="summaryTotal">$<%= String.format("%.2f", bill.getTotalAmount()) %></strong>
                </div>
            </div>
        </div>
        
        <!-- Actions -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h6 class="mb-0">
                    <i class="bi bi-gear me-2 text-secondary"></i>
                    Actions
                </h6>
            </div>
            <div class="card-body">
                <div class="d-grid gap-2">
                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="printBill()">
                        <i class="bi bi-printer me-2"></i>Print Bill
                    </button>
                    <button type="button" class="btn btn-outline-success btn-sm" onclick="markAsPaid()">
                        <i class="bi bi-check-circle me-2"></i>Mark as Paid
                    </button>
                    <button type="button" class="btn btn-outline-info btn-sm" onclick="sendEmail()">
                        <i class="bi bi-envelope me-2"></i>Send Email
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<% } else { %>

<div class="alert alert-warning" role="alert">
    <i class="bi bi-exclamation-triangle me-2"></i>
    <strong>Bill not found!</strong> The bill you're looking for doesn't exist or has been removed.
</div>

<div class="text-center mt-4">
    <a href="<%= request.getContextPath() %>/bills" class="btn btn-primary">
        <i class="bi bi-arrow-left me-2"></i>Back to Bill List
    </a>
</div>

<% } %>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var addItemBtn = document.getElementById('addItemBtn');
    var billItems = document.getElementById('billItems');
    var customerSelect = document.getElementById('customerId');
    var dateInput = document.getElementById('billDate');
    
    // Add new item row
    if (addItemBtn) {
        addItemBtn.addEventListener('click', function() {
            var newItem = createItemRow();
            billItems.appendChild(newItem);
            updateTotals();
        });
    }
    
    // Update customer selection display
    if (customerSelect) {
        customerSelect.addEventListener('change', function() {
            var selectedOption = this.options[this.selectedIndex];
            document.getElementById('selectedCustomer').textContent = 
                selectedOption.value ? selectedOption.text : 'Unknown';
        });
    }
    
    // Update date display
    if (dateInput) {
        dateInput.addEventListener('change', function() {
            document.getElementById('selectedDate').textContent = this.value;
        });
    }
    
    function createItemRow() {
        var itemRow = document.createElement('div');
        itemRow.className = 'row g-2 mb-2 bill-item';
        itemRow.innerHTML = `
            <div class="col-md-4">
                <label class="form-label">Item</label>
                <select class="form-select" name="itemIds[]" required>
                    <option value="">Select item</option>
                    <%
                        List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
                        if (items != null) {
                            for (ItemDTO item : items) {
                    %>
                    <option value="<%= item.getId() %>" data-price="<%= item.getPrice() %>">
                        <%= item.getName() %> - $<%= String.format("%.2f", item.getPrice()) %>
                    </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div class="col-md-2">
                <label class="form-label">Quantity</label>
                <input type="number" class="form-control" name="quantities[]" 
                       placeholder="Qty" min="1" value="1" required>
            </div>
            <div class="col-md-3">
                <label class="form-label">Unit Price</label>
                <div class="input-group">
                    <span class="input-group-text">$</span>
                    <input type="number" class="form-control" name="prices[]" 
                           placeholder="Price" step="0.01" min="0" required>
                </div>
            </div>
            <div class="col-md-2">
                <label class="form-label">Line Total</label>
                <span class="form-control-plaintext item-total">$0.00</span>
            </div>
            <div class="col-md-1">
                <label class="form-label">&nbsp;</label>
                <button type="button" class="btn btn-outline-danger btn-sm remove-item d-block">
                    <i class="bi bi-trash"></i>
                </button>
            </div>
        `;
        
        // Add event listeners to new row
        var removeBtn = itemRow.querySelector('.remove-item');
        removeBtn.addEventListener('click', function() {
            if (document.querySelectorAll('.bill-item').length > 1) {
                itemRow.remove();
                updateTotals();
            }
        });
        
        var itemSelect = itemRow.querySelector('[name="itemIds[]"]');
        itemSelect.addEventListener('change', function() {
            var selectedOption = this.options[this.selectedIndex];
            var priceInput = itemRow.querySelector('[name="prices[]"]');
            if (selectedOption.dataset.price) {
                priceInput.value = selectedOption.dataset.price;
                updateTotals();
            }
        });
        
        var qtyInput = itemRow.querySelector('[name="quantities[]"]');
        var priceInput = itemRow.querySelector('[name="prices[]"]');
        qtyInput.addEventListener('input', updateTotals);
        priceInput.addEventListener('input', updateTotals);
        
        return itemRow;
    }
    
    // Remove item functionality
    billItems.addEventListener('click', function(e) {
        if (e.target.classList.contains('remove-item') || e.target.closest('.remove-item')) {
            if (document.querySelectorAll('.bill-item').length > 1) {
                e.target.closest('.bill-item').remove();
                updateTotals();
            }
        }
    });
    
    function updateTotals() {
        var total = 0;
        var itemCount = 0;
        var items = document.querySelectorAll('.bill-item');
        
        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            var qty = parseFloat(item.querySelector('[name="quantities[]"]').value) || 0;
            var price = parseFloat(item.querySelector('[name="prices[]"]').value) || 0;
            var itemTotal = qty * price;
            
            if (qty > 0 && price > 0) {
                itemCount++;
            }
            
            item.querySelector('.item-total').textContent = '$' + itemTotal.toFixed(2);
            total += itemTotal;
        }
        
        var subtotal = total;
        var tax = total * 0.1;
        var grandTotal = total + tax;
        
        document.getElementById('subtotal').textContent = '$' + subtotal.toFixed(2);
        document.getElementById('tax').textContent = '$' + tax.toFixed(2);
        document.getElementById('totalAmount').textContent = '$' + grandTotal.toFixed(2);
        document.getElementById('summaryTotal').textContent = '$' + grandTotal.toFixed(2);
        document.getElementById('itemCount').textContent = itemCount + ' items';
    }
    
    // Auto-hide alerts
    setTimeout(function() {
        var alerts = document.querySelectorAll('.alert');
        for (var i = 0; i < alerts.length; i++) {
            var bsAlert = new bootstrap.Alert(alerts[i]);
            bsAlert.close();
        }
    }, 5000);
});

// Action functions
function printBill() {
    window.print();
}

function markAsPaid() {
    if (confirm('Mark this bill as paid?')) {
        // Add logic to mark bill as paid
        alert('Bill marked as paid!');
    }
}

function sendEmail() {
    if (confirm('Send bill via email?')) {
        // Add logic to send email
        alert('Email sent!');
    }
}
</script>

<style>
.form-control:focus, .form-select:focus {
    border-color: #ffc107;
    box-shadow: 0 0 0 0.2rem rgba(255, 193, 7, 0.25);
}

.card {
    border-radius: 0.75rem;
}

.bill-item {
    background-color: #f8f9fa;
    padding: 1rem;
    border-radius: 0.5rem;
    border: 1px solid #e9ecef;
}

@media print {
    .btn, .btn-toolbar, .card-header {
        display: none !important;
    }
}
</style>

<jsp:include page="footer.jsp" />
