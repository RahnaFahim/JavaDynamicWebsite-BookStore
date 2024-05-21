<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
<body>

</head>
<body>
   <div class="container">
        <h2>Add Book</h2>
        <%-- Display the form to add books --%>
        <form action="addBook.jsp" method="post">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required>
            
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required>
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" required></textarea>
            
            <label for="price">Price:</label>
            <input type="text" id="price" name="price" required>
            
            <input type="submit" value="Add Book">
        </form>
        
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="bookStore_DynamicWebProject.dbConnection" %>
<%

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Retrieve form data
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String price = request.getParameter("price");
        
        // Check if all fields are filled
        if (title != null && !title.isEmpty() &&
            author != null && !author.isEmpty() &&
            description != null && !description.isEmpty() &&
            price != null && !price.isEmpty()) {
            
            // Insert data into the database
            try {
                Connection conn = dbConnection.initializeDatabase();
                String sql = "INSERT INTO book (title, author, description, price) VALUES (?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, author);
                stmt.setString(3, description);
                stmt.setString(4, price);
                int rowsInserted = stmt.executeUpdate();
                
                // Check if insertion was successful
                if (rowsInserted > 0) {
                    out.println("<p>Book added successfully!</p>");
                } else {
                    out.println("<p>Failed to add book.</p>");
                }
                
                // Close database connection
                conn.close();
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace(new java.io.PrintWriter(out));
            }
        } else {
            // If any field is empty, display an error message
            out.println("<p>Please fill out all fields.</p>");
        }
    }
%>
</div>

    
</body>
</html>