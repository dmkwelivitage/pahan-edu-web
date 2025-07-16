<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.uni.dto.UserDTO" %>
<%
  UserDTO user = (UserDTO) request.getAttribute("user");
%>
<html>
<head>
  <title>Dashboard</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
</head>
<body>
<div class="dashboard-container">
  <div class="user-info">
    <h2>Welcome, <%= user.getUsername() %>!</h2>
    <p><strong>Role:</strong> <%= user.getRole() %></p>
  </div>

  <form action="<%= request.getContextPath() %>/logout" method="post">
    <button class="logout-button" type="submit">Logout</button>
  </form>
</div>
</body>
</html>
