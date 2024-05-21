<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="bookStore_DynamicWebProject.dbConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Your Account</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
    }
    .container {
        max-width: 400px;
        margin: 100px auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    h2 {
        margin-top: 0;
        color: #333;
    }
    input[type="text"],
    input[type="email"],
    input[type="password"],
    input[type="submit"] {
        width: 100%;
        margin-bottom: 20px;
        padding: 10px;
        border-radius: 3px;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }
    input[type="submit"] {
        background-color: #007bff;
        color: #fff;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    input[type="submit"]:hover {
        background-color: #0056b3;
    }
    p {
        color: red;
    }
</style>
</head>
<body>
<div class="container">
    <h2>Create Your Account</h2>
    <form action="register.jsp" method="post">
        <input type="text" name="username" placeholder="Username" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="text" name="full_name" placeholder="Full Name" required>
        <input type="submit" value="Register">
    </form>
    <p>Already have an account? <a href="login.jsp">Login here</a>.</p>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String fullName = request.getParameter("full_name");

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                // Establish database connection
                conn = dbConnection.initializeDatabase();

                // Prepare SQL query to insert user details into the database
                String sql = "INSERT INTO user (username, password, email, full_name) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);
                stmt.setString(3, email);
                stmt.setString(4, fullName);

                // Execute the query
                int rowsInserted = stmt.executeUpdate();

                // Check if the registration was successful
                if (rowsInserted > 0) {
                    out.println("<p>Registration successful!</p>");
                } else {
                    out.println("<p>Failed to register user.</p>");
                }
            } catch (SQLException | ClassNotFoundException e) {
                // Print the stack trace to the JSP output
                e.printStackTrace(new java.io.PrintWriter(out));
                out.println("<p>There was an error processing your request. Please try again later.</p>");
            } finally {
                // Close database connection
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