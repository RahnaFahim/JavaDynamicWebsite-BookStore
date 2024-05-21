<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="bookStore_DynamicWebProject.dbConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Login to access our bookstore and explore a world of books and knowledge.">
    <title>Login - Our Bookstore</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 400px;
            margin: 100px auto;
            text-align: center;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        h1 {
            color: #333;
            font-size: 2em;
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
        form {
            margin: 20px 0;
        }
        input[type="text"], input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Login</h1>
        <form method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
        <p>Don't have an account? <a href="register.jsp" class="btn">Register</a></p>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    conn = dbConnection.initializeDatabase();
                    String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setString(1, username);
                    stmt.setString(2, password);

                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        // User found, create session
                        HttpSession sess = request.getSession();
                        sess.setAttribute("username", username);
                        response.sendRedirect("home.jsp"); // Redirect to home page or dashboard
                    } else {
                        // User not found, display error message
                        out.println("<p style='color:red;'>Invalid username or password.</p>");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    // Print the stack trace to the JSP output
                    e.printStackTrace(new java.io.PrintWriter(out));
                } finally {
                    // Close resources
                    if (rs != null) {
                        try { rs.close(); } catch (SQLException ignore) {}
                    }
                    if (stmt != null) {
                        try { stmt.close(); } catch (SQLException ignore) {}
                    }
                    if (conn != null) {
                        try { conn.close(); } catch (SQLException ignore) {}
                    }
                }
            }
        %>
    </div>
</body>
</html>
