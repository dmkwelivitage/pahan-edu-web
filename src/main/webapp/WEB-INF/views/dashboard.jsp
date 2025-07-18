<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.uni.dto.UserDTO" %>
<%
  UserDTO user = (UserDTO) request.getAttribute("user");
%>
<html>
<head>
  <title>Dashboard</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
  <style>
    .nav-links {
      margin-top: 20px;
    }
    .nav-links a {
      margin-right: 15px;
      padding: 8px 16px;
      background-color: #007BFF;
      color: white;
      text-decoration: none;
      border-radius: 4px;
      font-weight: bold;
    }
    .nav-links a:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>
<div class="dashboard-container">
  <div class="user-info">
    <h2>Welcome, <%= user.getUsername() %>!</h2>
    <p><strong>Role:</strong> <%= user.getRole() %></p>
  </div>

  <div class="nav-links">
    <a href="<%= request.getContextPath() %>/customers">View Customers</a>
    <a href="<%= request.getContextPath() %>/customers?action=addForm">Add New Customer</a>
  </div>

  <form action="<%= request.getContextPath() %>/logout" method="post" style="margin-top: 30px;">
    <button class="logout-button" type="submit">Logout</button>
  </form>
</div>
</body>
</html>
