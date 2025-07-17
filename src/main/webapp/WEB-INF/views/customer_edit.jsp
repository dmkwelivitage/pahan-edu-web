<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.CustomerDTO" %>
<html>
<head>
  <title>Edit Customer - Pahan Edu</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>
<h1>Edit Customer</h1>

<%
  String error = (String) request.getAttribute("error");
  if (error != null && !error.isEmpty()) {
%>
<div class="error"><%= error %></div>
<%
  }

  CustomerDTO customer = (CustomerDTO) request.getAttribute("customer");

  if (customer == null) {
%>
<div class="error">No customer data found.</div>
<%
} else {
%>

<form action="<%= request.getContextPath() %>/customers" method="post">
  <input type="hidden" name="action" value="update" />
  <input type="hidden" name="id" value="<%= customer.getId() %>" />

  <label>Account Number:
    <input type="text" name="accountNumber" value="<%= customer.getAccountNumber() %>" disabled />
  </label><br />

  <label>Name:
    <input type="text" name="name" value="<%= customer.getName() %>" required />
  </label><br />

  <label>Address:
    <input type="text" name="address" value="<%= customer.getAddress() %>" />
  </label><br />

  <label>Phone:
    <input type="text" name="phone" value="<%= customer.getPhone() %>" />
  </label><br />

  <label>Units Consumed:
    <input type="number" name="unitsConsumed" min="0" value="<%= customer.getUnitsConsumed() %>" />
  </label><br />

  <button type="submit">Update Customer</button>
</form>

<%
  }
%>

<br />
<a href="<%= request.getContextPath() %>/customers">← Back to Customer List</a>
</body>
</html>
