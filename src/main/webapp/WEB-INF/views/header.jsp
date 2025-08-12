<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.UserDTO" %>
<%
  UserDTO user = (UserDTO) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.pageTitle} - Pahan Edu</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    
    <style>
        .navbar-brand img {
            height: 40px;
            width: auto;
        }
        
        .navbar-nav .nav-link {
            color: #495057 !important;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover {
            color: #0d6efd !important;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .user-avatar {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        @media (max-width: 768px) {
            .navbar-brand img {
                height: 30px;
            }
            
            .user-info {
                flex-direction: column;
                gap: 5px;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm border-bottom">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="<%= request.getContextPath() %>/dashboard">
                <img src="<%= request.getContextPath() %>/assets/img/logo2.png" alt="Pahan Edu" class="me-2">
                <span class="fw-bold text-primary">Pahan Edu</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <% if (user != null) { %>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                <div class="user-avatar me-2">
                                    <%= user.getUsername().substring(0, 1).toUpperCase() %>
                                </div>
                                <div class="user-info">
                                    <span class="fw-semibold"><%= user.getUsername() %></span>
                                    <small class="text-muted d-block"><%= user.getRole() %></small>
                                </div>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="<%= request.getContextPath() %>/dashboard">
                                    <i class="bi bi-house-door me-2"></i>Dashboard
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <form action="<%= request.getContextPath() %>/logout" method="post" class="d-inline">
                                        <button type="submit" class="dropdown-item text-danger">
                                            <i class="bi bi-box-arrow-right me-2"></i>Logout
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar will be included here -->
            <jsp:include page="sidebar.jsp" />
            
            <!-- Main content area -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
