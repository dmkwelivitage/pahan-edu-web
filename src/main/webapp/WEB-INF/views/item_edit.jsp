<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.ItemDTO" %>
<html>
<head>
  <title>Edit Item - Pahan Edu</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>
<h1>Edit Item</h1>

<%
  ItemDTO item = (ItemDTO) request.getAttribute("item");

  if (item == null) {
%>
<div>No item found.</div>
<%
} else {
%>
<form action="<%= request.getContextPath() %>/items" method="post">
  <input type="hidden" name="action" value="update"/>
  <input type="hidden" name="id" value="<%= item.getId() %>"/>

  <label>Code: <input type="text" value="<%= item.getCode() %>" disabled/></label><br/>
  <label>Name: <input type="text" name="name" value="<%= item.getName() %>" required/></label><br/>
  <label>Category: <input type="text" name="category" value="<%= item.getCategory() %>"/></label><br/>
  <label>Unit Price: <input type="number" step="0.01" min="0" name="unitPrice" value="<%= item.getUnitPrice() %>"/></label><br/>
  <label>Stock Qty: <input type="number" name="stockQty" min="0" value="<%= item.getStockQty() %>"/></label><br/>
  <button type="submit">Update Item</button>
</form>

<% } %>

<br/>
<a href="<%= request.getContextPath() %>/items">Back to List</a>

</body>
</html>
