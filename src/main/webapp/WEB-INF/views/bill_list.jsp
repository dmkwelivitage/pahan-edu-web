<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.BillDTO" %>
<%@ page import="com.uni.dto.BillItemDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<html>
<head>
    <title>Bills - Pahan Edu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>

<h1>Bill List</h1>

<%
    String error = (String) request.getAttribute("error");
    if (error != null && !error.isEmpty()) {
%>
<div class="error"><%= error %></div>
<%
    }
%>

<%
    List<BillDTO> bills = (List<BillDTO>) request.getAttribute("bills");
    if (bills != null) {
        for (BillDTO bill : bills) {
%>
<div class="bill-card">
    <h3>Bill ID: <%= bill.getId() %> | Customer ID: <%= bill.getCustomerId() %> | Date: <%= sdf.format(bill.getBillingDate()) %></h3>
    <p>Status: <%= bill.getStatus() %></p>
    <p>Total Amount: Rs. <%= bill.getTotalAmount() %></p>

    <h4>Bill Items:</h4>
    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
        <tr>
            <th>Item ID</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th>Line Total</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<BillItemDTO> items = bill.getItems();
            if (items != null && !items.isEmpty()) {
                for (BillItemDTO item : items) {
        %>
        <tr>
            <td><%= item.getItemId() %></td>
            <td><%= item.getQuantity() %></td>
            <td>Rs. <%= item.getUnitPrice() %></td>
            <td>Rs. <%= item.getLineTotal() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="4">No items found.</td></tr>
        <%
            }
        %>
        </tbody>
    </table>

    <div class="action-buttons" style="margin-top:10px;">
        <form action="<%= request.getContextPath() %>/bills" method="get" style="display:inline;">
            <input type="hidden" name="id" value="<%= bill.getId() %>" />
            <button type="submit">Edit</button>
        </form>

        <form action="<%= request.getContextPath() %>/bills" method="post" style="display:inline;">
            <input type="hidden" name="action" value="delete" />
            <input type="hidden" name="id" value="<%= bill.getId() %>" />
            <button type="submit" onclick="return confirm('Delete this bill?');">Delete</button>
        </form>
    </div>
    <hr>
</div>
<%
    }
} else {
%>
<p>No bills found.</p>
<%
    }
%>

<h2>Add New Bill</h2>
<form action="<%= request.getContextPath() %>/bills" method="post">
    <input type="hidden" name="action" value="add" />
    <label>Customer ID:
        <input type="number" name="customerId" required />
    </label><br/>
    <label>Billing Date:
        <input type="date" name="billingDate" required />
    </label><br/>
    <label>Status:
        <input type="text" name="status" value="Pending" />
    </label><br/>
    <label>Total Amount:
        <input type="number" step="0.01" name="totalAmount" required />
    </label><br/>

    <h3>Add Items (manually add rows in controller logic)</h3>
    <label>Item 1 - ID:
        <input type="number" name="itemId_1" />
    </label>
    <label>Quantity:
        <input type="number" name="quantity_1" />
    </label>
    <label>Unit Price:
        <input type="number" step="0.01" name="unitPrice_1" />
    </label><br/>

    <!-- You can dynamically handle more items in your servlet -->

    <button type="submit">Add Bill</button>
</form>

</body>
</html>
