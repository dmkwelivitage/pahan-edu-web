<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.UserDTO" %>
<%
  UserDTO user = (UserDTO) request.getAttribute("user");
%>
<html>
<head>
  <title>Dashboard - Pahan Edu</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
  <style>
    .nav-links {
      margin-top: 30px;
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 16px;
    }

    .nav-button {
      padding: 12px 24px;
      font-size: 16px;
      background-color: #3a82f7;
      color: #fff;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      min-width: 180px;
      text-align: center;
    }

    .nav-button:hover {
      background-color: #2f6cd3;
    }

    .logout-button {
      padding: 12px 24px;
      font-size: 16px;
      background-color: #e74c3c;
      color: #fff;
      border: none;
      border-radius: 8px;
      cursor: pointer;
    }

    .logout-button:hover {
      background-color: #c0392b;
    }

    .user-info {
      text-align: center;
      margin-bottom: 30px;
    }

    .dashboard-container {
      background-color: #1e1e1e;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(255, 255, 255, 0.05);
      width: 90%;
      max-width: 700px;
      margin: 60px auto;
      color: #f5f5f5;
      text-align: center;
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
    <a href="<%= request.getContextPath() %>/customers">
      <button class="nav-button">Manage Customers</button>
    </a>
    <a href="<%= request.getContextPath() %>/items">
      <button class="nav-button">Manage Items</button>
    </a>
    <a href="<%= request.getContextPath() %>/bills">
      <button class="nav-button">Manage Bills</button>
    </a>
  </div>

  <form action="<%= request.getContextPath() %>/logout" method="post" style="margin-top: 40px;">
    <button class="logout-button" type="submit">Logout</button>
  </form>
</div>
</body>
</html>
