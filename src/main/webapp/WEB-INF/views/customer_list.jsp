<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.CustomerDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Customers - Pahan Edu</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>
<h1>Customer List</h1>

<%
  String error = (String) request.getAttribute("error");
  if (error != null && !error.isEmpty()) {
%>
<div class="error"><%= error %></div>
<%
  }
%>

<table>
  <thead>
  <tr>
    <th>ID</th>
    <th>Account Number</th>
    <th>Name</th>
    <th>Address</th>
    <th>Phone</th>
    <th>Units</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <%
    List<CustomerDTO> customers = (List<CustomerDTO>) request.getAttribute("customers");
    if (customers != null) {
      for (CustomerDTO obj : customers) {
  %>
  <tr>
    <td><%= obj.getId() %></td>
    <td><%= obj.getAccountNumber() %></td>
    <td><%= obj.getName() %></td>
    <td><%= obj.getAddress() %></td>
    <td><%= obj.getPhone() %></td>
    <td><%= obj.getUnitsConsumed() %></td>
    <td>
      <div class="action-buttons">
        <form action="<%= request.getContextPath() %>/customers" method="get" style="display:inline;">
          <input type="hidden" name="id" value="<%= obj.getId() %>"/>
          <button type="submit" class="edit-button">Edit</button>
        </form>

        <form action="<%= request.getContextPath() %>/customers" method="post" style="display:inline;">
          <input type="hidden" name="action" value="delete"/>
          <input type="hidden" name="id" value="<%= obj.getId() %>"/>
          <button type="submit" class="delete-button" onclick="return confirm('Delete this customer?');">Delete</button>
        </form>
      </div>
    </td>

  </tr>
  <%
      }
    }
  %>
  </tbody>
</table>

<h2>Add New Customer</h2>
<form action="<%= request.getContextPath() %>/customers" method="post">
  <input type="hidden" name="action" value="add"/>
  <label>Account Number:
    <input type="text" name="accountNumber" required/>
  </label><br/>
  <label>Name:
    <input type="text" name="name" required/>
  </label><br/>
  <label>Address:
    <input type="text" name="address"/>
  </label><br/>
  <label>Phone:
    <input type="text" name="phone"/>
  </label><br/>
  <label>Units Consumed:
    <input type="number" name="unitsConsumed" min="0" value="0"/>
  </label><br/>
  <button type="submit">Add Customer</button>
</form>
</body>
</html>
