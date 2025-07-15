<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.uni.dto.UserDTO" %>
<%
  UserDTO user = (UserDTO) request.getAttribute("user");
%>
<html>
<head>
  <title>Dashboard</title>
</head>
<body>
<h2>Welcome, <%= user.getUsername() %>!</h2>
<p>Role: <%= user.getRole() %></p>

<form action="logout" method="post">
  <button type="submit">Logout</button>
</form>
</body>
</html>
