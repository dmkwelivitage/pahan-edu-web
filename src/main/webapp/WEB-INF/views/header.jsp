<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.uni.dto.UserDTO" %>
<%
  UserDTO loggedUser = (UserDTO) session.getAttribute("loggedUser");
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
        body {
            background-color: #f8f9fa;
            color: #212529;
        }
        
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
        
        .navbar {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%) !important;
            border-bottom: 1px solid #dee2e6 !important;
        }
        
        .dropdown-menu {
            background: #ffffff;
            border: 1px solid #dee2e6;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        
        .dropdown-item:hover {
            background-color: #f8f9fa;
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
    <nav class="navbar navbar-expand-lg navbar-light shadow-sm">
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
                    <% if (loggedUser != null) { %>
                        <li class="nav-item">
                            <div class="d-flex align-items-center">
                                <div class="user-avatar me-2">
                                    <%= loggedUser.getUsername().substring(0, 1).toUpperCase() %>
                                </div>
                                <div class="user-info">
                                    <span class="fw-semibold"><%= loggedUser.getUsername() %></span>
                                    <small class="text-muted d-block"><%= loggedUser.getRole() %></small>
                                </div>
                            </div>
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
