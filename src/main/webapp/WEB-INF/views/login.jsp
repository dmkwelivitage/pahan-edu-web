<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahan Edu</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #062198 0%, #381260 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .login-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(246, 244, 244, 0.1);
            padding: 3rem;
            width: 100%;
            max-width: 400px;
            text-align: center;
        }
        
        .logo {
            width: 80px;
            height: auto;
            margin-bottom: 1.5rem;
        }
        
        .brand-name {
            color: #053783;
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .signin-text {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        
        .form-floating {
            margin-bottom: 1rem;
        }
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
            margin-left: 2.5rem;
        }
        
        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
        }
        
        .btn-login {
            background: linear-gradient(135deg, #0d6efd, #0dcaf0);
            border: none;
            border-radius: 10px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(13, 110, 253, 0.4);
        }
        
        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            border-radius: 8px;
            padding: 0.75rem;
            margin-top: 1rem;
            font-size: 0.9rem;
        }
        
        .input-group-text {
            background: transparent;
            border: 1px solid #1e1e1e;
            border-right: none;
            margin-top: 0.3rem;
            padding: 1rem;
            color: #6c757d;
        }
        
        .input-group .form-control {
            color: #1e1e1e;
            border-left: none;
        }
        
        .input-group .form-control:focus {
            border-left: none;
        }
        
        @media (max-width: 576px) {
            .login-container {
                margin: 1rem;
                padding: 2rem;
            }
            
            .logo {
                width: 60px;
            }
            
            .brand-name {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <img src="<%= request.getContextPath() %>/assets/img/logo2.png" alt="Pahan Edu Logo" class="logo"/>
        
        <h1 class="brand-name">Pahan Edu</h1>
        <p class="signin-text">Sign in to your account</p>
        
        <form action="<%= request.getContextPath() %>/login" method="post">
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-person"></i>
                </span>
                <input type="text" class="form-control" name="username" placeholder="Username" required />
            </div>
            
            <div class="input-group mb-4">
                <span class="input-group-text">
                    <i class="bi bi-lock"></i>
                </span>
                <input type="password" class="form-control" name="password" placeholder="Password" required />
            </div>
            
            <button type="submit" class="btn btn-login text-white">
                <i class="bi bi-box-arrow-in-right me-2"></i>
                Sign In
            </button>
        </form>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <i class="bi bi-exclamation-triangle me-2"></i>
                <%= request.getAttribute("error") %>
            </div>
        <% } %>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="<%= request.getContextPath() %>/assets/js/script.js" defer></script>
</body>
</html>
