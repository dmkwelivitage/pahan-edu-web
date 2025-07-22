<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.BillDTO" %>
<%@ page import="com.uni.dto.BillItemDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Edit Bill - Pahan Edu</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>
<h1>Edit Bill</h1>

<%
  String error = (String) request.getAttribute("error");
  if (error != null && !error.isEmpty()) {
%>
<div class="error"><%= error %></div>
<%
  }

  BillDTO bill = (BillDTO) request.getAttribute("bill");

  if (bill == null) {
%>
<div class="error">No bill data found.</div>
<%
} else {
%>

<form action="<%= request.getContextPath() %>/bills" method="post">
  <input type="hidden" name="action" value="update" />
  <input type="hidden" name="id" value="<%= bill.getId() %>" />

  <label>Customer ID:
    <input type="number" name="customerId" value="<%= bill.getCustomerId() %>" required />
  </label><br />

  <label>Billing Date:
    <input type="date" name="billingDate" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(bill.getBillingDate()) %>" required />
  </label><br />

  <label>Status:
    <input type="text" name="status" value="<%= bill.getStatus() %>" required />
  </label><br />

  <h2>Bill Items</h2>
  <%
    List<BillItemDTO> items = bill.getItems();
    if (items != null && !items.isEmpty()) {
      for (int i = 0; i < items.size(); i++) {
        BillItemDTO item = items.get(i);
  %>
  <fieldset>
    <legend>Item <%= i + 1 %></legend>
    <input type="hidden" name="itemIds" value="<%= item.getId() %>" />

    <label>Item ID:
      <input type="number" name="itemId_<%= i %>" value="<%= item.getItemId() %>" required />
    </label><br />

    <label>Quantity:
      <input type="number" name="quantity_<%= i %>" value="<%= item.getQuantity() %>" required />
    </label><br />

    <label>Unit Price:
      <input type="number" step="0.01" name="unitPrice_<%= i %>" value="<%= item.getUnitPrice() %>" required />
    </label><br />

    <label>Line Total:
      <input type="number" step="0.01" name="lineTotal_<%= i %>" value="<%= item.getLineTotal() %>" readonly />
    </label><br />
  </fieldset>
  <%
    }
  } else {
  %>
  <div>No bill items found.</div>
  <%
    }
  %>

  <button type="submit">Update Bill</button>
</form>

<%
  }
%>

<br />
<a href="<%= request.getContextPath() %>/bills">← Back to Bill List</a>
</body>
</html>
