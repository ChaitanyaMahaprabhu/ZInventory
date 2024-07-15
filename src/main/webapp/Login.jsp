<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />

    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
      rel="stylesheet"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400..700;1,400..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
      rel="stylesheet"
    />
    
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel = "stylesheet" type = "text/css" href = "./style.css"/>
</head>
<body>
    <div class="container">
    <div id = "login-encompass">
        <form action="/login" method="post">
        <h2 class = "login-heading mb-3">Login</h2>
            <input type="text" name="id" placeholder="User ID" class="form-control mt-3" required>
            <input type="password" name="password" placeholder="Password" class="form-control mt-3" required>
            <div class = "mt-3">
                <input type="radio" name="usertype" value="employee" id="employee" checked>
                <label for="employee">Employee</label>
            </div>
            <div>
                <input type="radio" name="usertype" value="admin" id="admin">
                <label for="admin">Admin</label>
            </div>
            
            <input type="submit" value="Login" class="btn btn-primary mt-4">
        </form>
        </div>
    </div>
</body>
</html>
