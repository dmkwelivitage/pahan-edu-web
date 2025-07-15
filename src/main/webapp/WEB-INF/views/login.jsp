<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Login</h2>

<form action="login" method="post">
    <label>Username:<br>
        <input type="text" name="username" required>
    </label>

    <label>Password:<br>
    <input type="password" name="password" required><br><br>
    </label>

    <button type="submit">Login</button>
</form>

<p style="color:red;">
    <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
</p>
</body>
</html>

