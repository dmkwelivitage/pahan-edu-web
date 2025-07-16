<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Pahan Edu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <script src="<%= request.getContextPath() %>/assets/js/script.js" defer></script>
</head>
<body>
<div class="login-container dark-theme">
    <img src="<%= request.getContextPath() %>/assets/img/logo2.png" alt="Pahan Edu Logo" class="logo"/>

    <p>Sign in</p>
       <p style="color: #2f6cd3; font-size: x-large"> Pahan Edu</p>

    <form action="<%= request.getContextPath() %>/login" method="post">
        <div class="input-group">
            <i class="fas fa-user"></i>
            <label>
                <input type="text" name="username" placeholder="Username" required />
            </label>
        </div>

        <div class="input-group">
            <i class="fas fa-lock"></i>
            <label>
                <input type="password" name="password" placeholder="Password" required />
            </label>
        </div>

        <button type="submit">Login</button>
    </form>

    <p class="error-message">
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
    </p>
</div>
</body>
</html>
