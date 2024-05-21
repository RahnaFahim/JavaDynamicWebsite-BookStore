<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="bookStore_DynamicWebProject.dbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
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
</head>
<body>
    <div class="container">
        <h2>Edit Book</h2>
        <%
            // Retrieve the book ID from the request
            String bookId = request.getParameter("book_id");
            String title = "", author = "", description = "", price = "";

            // Database connection
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = dbConnection.initializeDatabase();
                String sql = "SELECT * FROM book WHERE book_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(bookId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    title = rs.getString("title");
                    author = rs.getString("author");
                    description = rs.getString("description");
                    price = rs.getString("price");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace(new java.io.PrintWriter(out));
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <form action="updateBook.jsp" method="post">
            <input type="hidden" name="book_id" value="<%= bookId %>">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required>
            
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" value="<%= author %>" required>
            
            <label for="description">Description:</label>
            <textarea id="description" name="description" required><%= description %></textarea>
            
            <label for="price">Price:</label>
            <input type="text" id="price" name="price" value="<%= price %>" required>
            
            <input type="submit" value="Update Book">
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Retrieve updated form data
                String updatedTitle = request.getParameter("title");
                String updatedAuthor = request.getParameter("author");
                String updatedDescription = request.getParameter("description");
                String updatedPrice = request.getParameter("price");

                try {
                    conn = dbConnection.initializeDatabase();
                    String updateSql = "UPDATE book SET title = ?, author = ?, description = ?, price = ? WHERE book_id = ?";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setString(1, updatedTitle);
                    pstmt.setString(2, updatedAuthor);
                    pstmt.setString(3, updatedDescription);
                    pstmt.setString(4, updatedPrice);
                    pstmt.setInt(5, Integer.parseInt(bookId));
                    int rowsUpdated = pstmt.executeUpdate();

                    if (rowsUpdated > 0) {
                        response.sendRedirect("products.jsp");
                    } else {
                        out.println("<p>Failed to update book.</p>");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace(new java.io.PrintWriter(out));
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
    </div>
</body>
</html>
