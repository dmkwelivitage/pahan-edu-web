<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.CustomerDTO" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<%@ page import="java.util.List" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Create Bill" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Create New Bill</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <a href="<%= request.getContextPath() %>/bills" class="btn btn-outline-secondary me-2">
            <i class="bi bi-arrow-left me-2"></i>Back to Bills
        </a>
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

<div class="row">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-receipt me-2 text-warning"></i>
                    Bill Information
                </h5>
            </div>
            <div class="card-body">
                <form action="<%= request.getContextPath() %>/bills" method="post">
                    <input type="hidden" name="action" value="add"/>
                    
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="customerId" class="form-label">Customer <span class="text-danger">*</span></label>
                            <select class="form-select" id="customerId" name="customerId" required>
                                <option value="">Select a customer</option>
                                <%
                                    List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
                                    if (customers != null) {
                                        for (CustomerDTO customer : customers) {
                                %>
                                <option value="<%= customer.getId() %>">
                                    <%= customer.getName() %> (<%= customer.getAccountNumber() %>)
                                </option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="billingDate" class="form-label">Bill Date <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="billingDate" name="billingDate" 
                                   value="<%= java.time.LocalDate.now() %>" required>
                        </div>
                        
                        <div class="col-12">
                            <hr>
                            <h6 class="mb-3">Bill Items</h6>
                            <div id="billItems">
                                <div class="row g-2 mb-2 bill-item">
                                    <div class="col-md-4">
                                        <label class="form-label">Item</label>
                                        <select class="form-select" name="itemIds[]" required>
                                            <option value="">Select item</option>
                                            <%
                                                List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
                                                if (items != null) {
                                                    for (ItemDTO item : items) {
                                            %>
                                            <option value="<%= item.getId() %>" data-price="<%= item.getUnitPrice() %>">
                                                <%= item.getName() %> - $<%= String.format("%.2f", item.getUnitPrice()) %>
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
                                            <input type="number" class="form-control" name="unitPrices[]" 
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
                            <i class="bi bi-check-circle me-2"></i>Create Bill
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
                    <small class="text-muted">Customer</small>
                    <div id="selectedCustomer">None selected</div>
                </div>
                <div class="mb-3">
                    <small class="text-muted">Bill Date</small>
                    <div id="selectedDate"><%= java.time.LocalDate.now() %></div>
                </div>
                <div class="mb-3">
                    <small class="text-muted">Items</small>
                    <div id="itemCount">0 items</div>
                </div>
                <hr>
                <div class="d-flex justify-content-between">
                    <strong>Total:</strong>
                    <strong id="summaryTotal">$0.00</strong>
                </div>
            </div>
        </div>
        
        <!-- Tips -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h6 class="mb-0">
                    <i class="bi bi-lightbulb me-2 text-warning"></i>
                    Tips
                </h6>
            </div>
            <div class="card-body">
                <ul class="list-unstyled small mb-0">
                    <li class="mb-2">
                        <i class="bi bi-check-circle text-success me-2"></i>
                        Select customer first
                    </li>
                    <li class="mb-2">
                        <i class="bi bi-check-circle text-success me-2"></i>
                        Add items with quantities
                    </li>
                    <li class="mb-2">
                        <i class="bi bi-check-circle text-success me-2"></i>
                        Prices auto-calculate totals
                    </li>
                    <li>
                        <i class="bi bi-check-circle text-success me-2"></i>
                        Review before creating
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    var addItemBtn = document.getElementById('addItemBtn');
    var billItems = document.getElementById('billItems');
    var customerSelect = document.getElementById('customerId');
    var dateInput = document.getElementById('billingDate');
    
    // Add new item row
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
            updateTotals();
        });
    }
    
    // Remove item row
    billItems.addEventListener('click', function(e) {
        if (e.target.classList.contains('remove-item') || e.target.closest('.remove-item')) {
            if (document.querySelectorAll('.bill-item').length > 1) {
                e.target.closest('.bill-item').remove();
                updateTotals();
            }
        }
    });
    
    // Update totals when inputs change
    billItems.addEventListener('input', function(e) {
        if (e.target.name === 'quantities[]' || e.target.name === 'unitPrices[]') {
            updateTotals();
        }
    });
    
    // Auto-fill price when item is selected
    billItems.addEventListener('change', function(e) {
        if (e.target.name === 'itemIds[]') {
            var itemRow = e.target.closest('.bill-item');
            var priceInput = itemRow.querySelector('[name="unitPrices[]"]');
            var selectedOption = e.target.options[e.target.selectedIndex];
            if (selectedOption.dataset.price) {
                priceInput.value = selectedOption.dataset.price;
                updateTotals();
            }
        }
    });
    
    // Update customer selection display
    if (customerSelect) {
        customerSelect.addEventListener('change', function() {
            var selectedOption = this.options[this.selectedIndex];
            document.getElementById('selectedCustomer').textContent = 
                selectedOption.value ? selectedOption.text : 'None selected';
        });
    }
    
    // Update date display
    if (dateInput) {
        dateInput.addEventListener('change', function() {
            document.getElementById('selectedDate').textContent = this.value;
        });
    }
    
    function updateTotals() {
        var total = 0;
        var itemCount = 0;
        var items = document.querySelectorAll('.bill-item');
        
        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            var qty = parseFloat(item.querySelector('[name="quantities[]"]').value) || 0;
            var price = parseFloat(item.querySelector('[name="unitPrices[]"]').value) || 0;
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
</style>

<jsp:include page="footer.jsp" />
