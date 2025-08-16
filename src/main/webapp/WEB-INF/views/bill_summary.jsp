<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.BillDTO" %>
<%@ page import="com.uni.dto.CustomerDTO" %>
<%@ page import="com.uni.dto.BillItemDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.uni.dto.ItemDTO" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Bill Summary" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Bill Summary</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <button type="button" class="btn btn-primary me-2" onclick="window.print()">
            <i class="bi bi-printer me-2"></i>Print Bill
        </button>
        <a href="<%= request.getContextPath() %>/bills" class="btn btn-outline-secondary">
            <i class="bi bi-arrow-left me-2"></i>Back to Bills
        </a>
    </div>
</div>

<%
  BillDTO bill = (BillDTO) request.getAttribute("bill");
  CustomerDTO customer = (CustomerDTO) request.getAttribute("customer");
  List<BillItemDTO> billItems = (List<BillItemDTO>) request.getAttribute("billItems");
  
  if (bill != null && customer != null) {
%>

<!-- Bill Summary Card -->
<div class="row justify-content-center">
    <div class="col-lg-10">
        <div class="card border-0 shadow-sm" id="billSummary">
            <div class="card-body p-4">
                <!-- Company Header -->
                <div class="row mb-4">
                    <div class="col-6">
                        <div class="d-flex align-items-center">
                            <img src="<%= request.getContextPath() %>/assets/img/logo2.png" alt="Pahan Edu" 
                                 style="height: 50px; width: auto;" class="me-3">
                            <div>
                                <h3 class="mb-0 text-primary fw-bold">Pahan Edu</h3>
                                <p class="text-muted mb-0">Education Management System</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-6 text-end">
                        <h4 class="text-uppercase text-muted mb-1">Bill</h4>
                        <h2 class="text-primary mb-0">#<%= bill.getId() %></h2>
                        <p class="text-muted mb-0">
                            Date: <%= bill.getBillingDate() != null
                                ? new java.text.SimpleDateFormat("MMMM dd, yyyy").format(bill.getBillingDate())
                                : "N/A" %>
                        </p>

                    </div>
                </div>
                
                <hr class="my-4">
                
                <!-- Customer Information -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h6 class="text-uppercase text-muted mb-3">Bill To:</h6>
                        <div class="p-3 bg-light rounded">
                            <h6 class="fw-bold mb-1"><%= customer.getName() %></h6>
                            <p class="mb-1 text-muted">Account: <%= customer.getAccountNumber() %></p>
                            <% if (customer.getUnitsConsumed() != 0) { %>
                                <p class="mb-1 text-muted">Email: <%= customer.getUnitsConsumed() %></p>
                            <% } %>
                            <% if (customer.getPhone() != null) { %>
                                <p class="mb-1 text-muted">Phone: <%= customer.getPhone() %></p>
                            <% } %>
                            <% if (customer.getAddress() != null) { %>
                                <p class="mb-0 text-muted">Address: <%= customer.getAddress() %></p>
                            <% } %>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h6 class="text-uppercase text-muted mb-3">Bill Details:</h6>
                        <div class="p-3 bg-light rounded">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Bill ID:</span>
                                <span class="fw-bold">#<%= bill.getId() %></span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Date:</span>
                                <span class="fw-bold">
                                <%= bill.getBillingDate() != null
                                        ? new java.text.SimpleDateFormat("MMMM dd, yyyy").format(bill.getBillingDate())
                                        : "N/A" %>
                            </span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Status:</span>
                                <span class="badge bg-success">Active</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Due Date:</span>
                                <span class="fw-bold">
                                <%
                                    String dueDate = "N/A";
                                    if (bill.getBillingDate() != null) {
                                        java.util.Calendar cal = java.util.Calendar.getInstance();
                                        cal.setTime(bill.getBillingDate());
                                        cal.add(java.util.Calendar.DAY_OF_MONTH, 30);
                                        dueDate = new java.text.SimpleDateFormat("MMM dd, yyyy").format(cal.getTime());
                                    }
                                %>
                                <%= dueDate %>
                            </span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Bill Items Table -->
                <div class="mb-4">
                    <h6 class="text-uppercase text-muted mb-3">Bill Items:</h6>
                    <div class="table-responsive">
                        <table class="table table-bordered">
                            <thead class="table-light">
                                <tr>
                                    <th class="text-center" style="width: 5%;">#</th>
                                    <th style="width: 40%;">Item Description</th>
                                    <th class="text-center" style="width: 15%;">Quantity</th>
                                    <th class="text-center" style="width: 20%;">Unit Price</th>
                                    <th class="text-center" style="width: 20%;">Line Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<ItemDTO> items = (List<ItemDTO>) request.getAttribute("items");
                                    if (billItems != null && !billItems.isEmpty()) {
                                        double subtotal = 0;
                                        for (int i = 0; i < billItems.size(); i++) {
                                            BillItemDTO item = billItems.get(i);
                                            double lineTotal = item.getQuantity() * item.getUnitPrice();
                                            subtotal += lineTotal;
                                            
                                            // Find item details
                                            String itemName = "Item #" + item.getItemId();
                                            String itemDescription = null;
                                            if (items != null) {
                                                for (ItemDTO itemDTO : items) {
                                                    if (itemDTO.getId() == item.getItemId()) {
                                                        itemName = itemDTO.getName();
                                                        itemDescription = itemDTO.getCategory();
                                                        break;
                                                    }
                                                }
                                            }
                                %>
                                <tr>
                                    <td class="text-center"><%= i + 1 %></td>
                                    <td>
                                        <strong><%= itemName %></strong>
                                        <% if (itemDescription != null) { %>
                                            <br><small class="text-muted"><%= itemDescription %></small>
                                        <% } %>
                                    </td>
                                    <td class="text-center"><%= item.getQuantity() %></td>
                                    <td class="text-center">$<%= String.format("%.2f", item.getUnitPrice()) %></td>
                                    <td class="text-center fw-bold">$<%= String.format("%.2f", lineTotal) %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-3">
                                        <i class="bi bi-inbox me-2"></i>No items found
                                    </td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <!-- Totals Section -->
                <div class="row">
                    <div class="col-md-6 offset-md-6">
                        <div class="p-3 bg-light rounded">
                            <%
                                // Calculate subtotal from items
                                double subtotal = 0;
                                if (billItems != null && !billItems.isEmpty()) {
                                    for (BillItemDTO item : billItems) {
                                        subtotal += item.getQuantity() * item.getUnitPrice();
                                    }
                                }
                                double tax = subtotal * 0.1;
                                double total = subtotal + tax;
                            %>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Subtotal:</span>
                                <span class="fw-bold">$<%= String.format("%.2f", subtotal) %></span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Tax (10%):</span>
                                <span class="fw-bold">$<%= String.format("%.2f", tax) %></span>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between">
                                <span class="text-uppercase fw-bold fs-5">Total Amount:</span>
                                <span class="text-primary fw-bold fs-4">$<%= String.format("%.2f", total) %></span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Footer -->
                <div class="row mt-5">
                    <div class="col-12">
                        <hr>
                        <div class="text-center">
                            <p class="text-muted mb-1">Thank you for your business!</p>
                            <p class="text-muted small mb-0">
                                This is a computer-generated bill. No signature required.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Action Buttons -->
<div class="row justify-content-center mt-4">
    <div class="col-lg-10">
        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <button type="button" class="btn btn-primary w-100" onclick="window.print()">
                            <i class="bi bi-printer me-2"></i>Print Bill
                        </button>
                    </div>
<%--                    <div class="col-md-3">--%>
<%--                        <button type="button" class="btn btn-success w-100" onclick="markAsPaid()">--%>
<%--                            <i class="bi bi-check-circle me-2"></i>Mark as Paid--%>
<%--                        </button>--%>
<%--                    </div>--%>
<%--                    <div class="col-md-3">--%>
<%--                        <button type="button" class="btn btn-info w-100" onclick="sendEmail()">--%>
<%--                            <i class="bi bi-envelope me-2"></i>Send Email--%>
<%--                        </button>--%>
<%--                    </div>--%>
                    <div class="col-md-6 pt-sm-2">
                        <a href="<%= request.getContextPath() %>/bills?id=<%= bill.getId() %>&action=edit" 
                           class="btn btn-warning w-100">
                            <i class="bi bi-pencil me-2"></i>Edit Bill
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<% } else { %>

<!-- Error Message -->
<div class="row justify-content-center">
    <div class="col-lg-6">
        <div class="card border-0 shadow-sm">
            <div class="card-body text-center py-5">
                <div class="mb-4">
                    <div class="display-4 text-muted mb-3">
                        <i class="bi bi-exclamation-triangle"></i>
                    </div>
                    <h5 class="text-muted">Bill Not Found</h5>
                    <p class="text-muted mb-0">The bill you're looking for doesn't exist or has been removed.</p>
                </div>
                <a href="<%= request.getContextPath() %>/bills" class="btn btn-primary">
                    <i class="bi bi-arrow-left me-2"></i>Back to Bills
                </a>
            </div>
        </div>
    </div>
</div>

<% } %>

<script>
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

// Auto-hide alerts
setTimeout(function() {
    var alerts = document.querySelectorAll('.alert');
    alerts.forEach(function(alert) {
        var bsAlert = new bootstrap.Alert(alert);
        bsAlert.close();
    });
}, 5000);
</script>

<style>
/* Print Styles */
@media print {
    .btn, .btn-toolbar, .card-header, .navbar, .sidebar, .footer {
        display: none !important;
    }
    
    body {
        background: white !important;
        color: black !important;
    }
    
    .card {
        border: none !important;
        box-shadow: none !important;
    }
    
    #billSummary {
        page-break-inside: avoid;
    }
    
    .table {
        border-collapse: collapse !important;
    }
    
    .table td, .table th {
        border: 1px solid #dee2e6 !important;
    }
}

.card {
    border-radius: 0.75rem;
    background-color: #ffffff;
}

.table th {
    background-color: #f8f9fa !important;
    color: #495057;
    font-weight: 600;
}

.bg-light {
    background-color: #f8f9fa !important;
}

.text-muted {
    color: #6c757d !important;
}
</style>

<jsp:include page="footer.jsp" />
