<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css" />
    <script src="<%= request.getContextPath() %>/assets/js/script.js" defer></script>
</head>
<body>
<div class="login-container">
    <h2>Login to Pahan Edu</h2>

    <form action="<%= request.getContextPath() %>/login" method="post">
        <label>
            <input type="text" name="username" placeholder="Username" required />
        </label>
        <label>
            <input type="password" name="password" placeholder="Password" required />
        </label>
        <button type="submit">Login</button>
    </form>

    <p class="error-message">
        <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
    </p>
</div>
</body>
</html>
