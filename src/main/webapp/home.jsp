<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Discover a world of books and knowledge at our bookstore. We offer a wide range of books covering various genres for every reader.">
    <title>Welcome to Our Bookstore</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 100px auto;
            text-align: center;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h1, h2 {
            color: #333;
            font-size: 2.5em;
            margin-bottom: 20px;
        }
        p {
            color: #666;
            margin-bottom: 20px;
            font-size: 1.2em;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            cursor: pointer;
            font-size: 1em;
            margin: 5px;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    HttpSession sess = request.getSession(false);
    if (session == null || session.getAttribute("username") == null) {
%>
        <div class="container">
            <h1>Welcome to Our Bookstore</h1>
            <p>Discover a world of books and knowledge with us!</p>
            <p>We offer a wide range of books covering various genres.</p>
            <p>Whether you're a passionate reader or just starting your journey, we have something for everyone.</p>
            <a href="login.jsp" class="btn">Login</a>
            <a href="register.jsp" class="btn">Register</a>
        </div>
<%
    } else {
%>
        <div class="container">
            <h2>Welcome, <%= session.getAttribute("username") %>!</h2>
            <a href="products.jsp" class="btn">Explore Books</a>
            <a href="logout.jsp" class="btn">Logout</a>
        </div>
<%
    }
%>
</body>
</html>
