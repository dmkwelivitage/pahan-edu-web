<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Help" />
</jsp:include>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Help & Documentation</h1>
    <div class="btn-toolbar mb-2 mb-md-0">
        <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-outline-primary">
            <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
        </a>
    </div>
</div>

<!-- Help Content -->
<div class="row">
    <div class="col-lg-8">
        <!-- Getting Started -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-rocket-takeoff me-2 text-primary"></i>
                    Getting Started
                </h5>
            </div>
            <div class="card-body">
                <p class="card-text">Welcome to Pahan Edu! This system helps you manage customers, items, and bills efficiently. Here's how to get started:</p>
                
                <div class="row g-3 mt-3">
                    <div class="col-md-6">
                        <div class="d-flex align-items-start">
                            <div class="bg-primary bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="bi bi-1-circle text-primary"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Add Customers</h6>
                                <p class="text-muted small mb-0">Start by adding your customers with their account details and contact information.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex align-items-start">
                            <div class="bg-success bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="bi bi-2-circle text-success"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Manage Items</h6>
                                <p class="text-muted small mb-0">Add products or services with pricing and stock information.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex align-items-start">
                            <div class="bg-warning bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="bi bi-3-circle text-warning"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Create Bills</h6>
                                <p class="text-muted small mb-0">Generate bills for customers with selected items and quantities.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex align-items-start">
                            <div class="bg-info bg-opacity-10 rounded-circle p-2 me-3">
                                <i class="bi bi-4-circle text-info"></i>
                            </div>
                            <div>
                                <h6 class="mb-1">Track & Manage</h6>
                                <p class="text-muted small mb-0">Monitor your business operations and manage all records efficiently.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features Guide -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-gear me-2 text-success"></i>
                    Features Guide
                </h5>
            </div>
            <div class="card-body">
                <div class="accordion" id="featuresAccordion">
                    <!-- Customer Management -->
                    <div class="accordion-item border-0 mb-2">
                        <h2 class="accordion-header" id="customerHeading">
                            <button class="accordion-button collapsed bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#customerCollapse">
                                <i class="bi bi-people me-2 text-primary"></i>
                                Customer Management
                            </button>
                        </h2>
                        <div id="customerCollapse" class="accordion-collapse collapse" data-bs-parent="#featuresAccordion">
                            <div class="accordion-body">
                                <ul class="list-unstyled mb-0">
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Add new customers with account numbers</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Edit customer information</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Track units consumed</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Manage customer addresses and phone numbers</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Item Management -->
                    <div class="accordion-item border-0 mb-2">
                        <h2 class="accordion-header" id="itemHeading">
                            <button class="accordion-button collapsed bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#itemCollapse">
                                <i class="bi bi-box me-2 text-success"></i>
                                Item Management
                            </button>
                        </h2>
                        <div id="itemCollapse" class="accordion-collapse collapse" data-bs-parent="#featuresAccordion">
                            <div class="accordion-body">
                                <ul class="list-unstyled mb-0">
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Add products and services</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Set pricing and descriptions</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Track stock quantities</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Update item information</li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <!-- Bill Management -->
                    <div class="accordion-item border-0 mb-2">
                        <h2 class="accordion-header" id="billHeading">
                            <button class="accordion-button collapsed bg-light" type="button" data-bs-toggle="collapse" data-bs-target="#billCollapse">
                                <i class="bi bi-receipt me-2 text-warning"></i>
                                Bill Management
                            </button>
                        </h2>
                        <div id="billCollapse" class="accordion-collapse collapse" data-bs-parent="#featuresAccordion">
                            <div class="accordion-body">
                                <ul class="list-unstyled mb-0">
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Create bills for customers</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Add multiple items to bills</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Calculate totals automatically</li>
                                    <li><i class="bi bi-check-circle text-success me-2"></i>Edit and manage existing bills</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Troubleshooting -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-transparent border-0">
                <h5 class="mb-0">
                    <i class="bi bi-question-circle me-2 text-warning"></i>
                    Troubleshooting
                </h5>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <div class="border rounded p-3">
                            <h6 class="text-danger mb-2">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                Common Issues
                            </h6>
                            <ul class="list-unstyled small mb-0">
                                <li>• Can't add customer - Check required fields</li>
                                <li>• Bill not saving - Verify item selection</li>
                                <li>• Login issues - Check credentials</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="border rounded p-3">
                            <h6 class="text-success mb-2">
                                <i class="bi bi-lightbulb me-2"></i>
                                Tips
                            </h6>
                            <ul class="list-unstyled small mb-0">
                                <li>• Use account numbers for easy tracking</li>
                                <li>• Keep item prices updated</li>
                                <li>• Regular backup of data</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Sidebar -->
    <div class="col-lg-4">
        <!-- Quick Actions -->
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-transparent border-0">
                <h6 class="mb-0">
                    <i class="bi bi-lightning me-2 text-primary"></i>
                    Quick Actions
                </h6>
            </div>
            <div class="card-body">
                <div class="d-grid gap-2">
                    <a href="<%= request.getContextPath() %>/customers" class="btn btn-outline-primary btn-sm">
                        <i class="bi bi-plus-circle me-2"></i>Add Customer
                    </a>
                    <a href="<%= request.getContextPath() %>/items" class="btn btn-outline-success btn-sm">
                        <i class="bi bi-plus-circle me-2"></i>Add Item
                    </a>
                    <a href="<%= request.getContextPath() %>/bills" class="btn btn-outline-warning btn-sm">
                        <i class="bi bi-plus-circle me-2"></i>Create Bill
                    </a>
                </div>
            </div>
        </div>

        <!-- Contact Support -->
        <div class="card border-0 shadow-sm">
            <div class="card-header bg-transparent border-0">
                <h6 class="mb-0">
                    <i class="bi bi-headset me-2 text-info"></i>
                    Need More Help?
                </h6>
            </div>
            <div class="card-body">
                <p class="small text-muted mb-3">If you need additional assistance, please contact our support team:</p>
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-envelope text-muted me-2"></i>
                    <span class="small">support@pahanedu.com</span>
                </div>
                <div class="d-flex align-items-center mb-2">
                    <i class="bi bi-telephone text-muted me-2"></i>
                    <span class="small">+1 (555) 123-4567</span>
                </div>
                <div class="d-flex align-items-center">
                    <i class="bi bi-clock text-muted me-2"></i>
                    <span class="small">Mon-Fri: 9AM-6PM</span>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.accordion-button:not(.collapsed) {
    background-color: #e7f3ff;
    color: #0d6efd;
}

.accordion-button:focus {
    box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

.card {
    border-radius: 0.75rem;
}
</style>

<jsp:include page="footer.jsp" />
