<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, com.uni.dto.BillDTO, com.uni.dto.BillItemDTO" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<%@ page import="com.uni.service.ItemService" %>
<html>
<head>
    <title>Bill List - Pahan Edu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>
<h1>Bill List</h1>

<a href="<%= request.getContextPath() %>/bills?action=create">+ New Bill</a>
<br><br>

<%
    List<BillDTO> bills = (List<BillDTO>) request.getAttribute("bills");
    ItemService itemService = new ItemService(); // to get item names
    if (bills == null || bills.isEmpty()) {
%>
<p>No bills available.</p>
<%
} else {
%>
<table border="1" cellpadding="8" cellspacing="0">
    <thead>
    <tr>
        <th>Bill ID</th>
        <th>Customer ID</th>
        <th>Date</th>
        <th>Status</th>
        <th>Total</th>
        <th>Items</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (BillDTO bill : bills) {
    %>
    <tr>
        <td><%= bill.getId() %></td>
        <td><%= bill.getCustomerId() %></td>
        <td><%= bill.getBillingDate() %></td>
        <td><%= bill.getStatus() %></td>
        <td><%= bill.getTotalAmount() %></td>
        <td>
            <ul>
                <%
                    List<BillItemDTO> items = bill.getItems();
                    if (items != null && !items.isEmpty()) {
                        for (BillItemDTO item : items) {
                            String itemName = "";
                            try {
                                ItemDTO itemDTO = itemService.getItemById(item.getItemId());
                                itemName = itemDTO != null ? itemDTO.getName() : "Unknown";
                            } catch (Exception e) {
                                itemName = "Error loading item";
                            }
                %>
                <li>
                    <%= itemName %> - Qty: <%= item.getQuantity() %>, Unit: <%= item.getUnitPrice() %>, Line Total: <%= item.getLineTotal() %>
                </li>
                <%
                    }
                } else {
                %>
                <li>No items</li>
                <%
                    }
                %>
            </ul>
        </td>
        <td>
            <a href="<%= request.getContextPath() %>/bills?action=edit&id=<%= bill.getId() %>">Edit</a> |
            <a href="<%= request.getContextPath() %>/bills?action=delete&id=<%= bill.getId() %>" onclick="return confirm('Delete this bill?');">Delete</a>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
    }
%>

<br>
<a href="<%= request.getContextPath() %>/dashboard">← Back to Dashboard</a>
</body>
</html>
