<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="bookStore_DynamicWebProject.dbConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
    <script type="text/javascript">
        function confirmDelete(bookId) {
            var confirmation = confirm("Are you sure you want to delete this book?");
            if (confirmation) {
                window.location.href = "deleteBook.jsp?book_id=" + bookId;
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Products Page</h1>
        
        <!-- List of Books -->
        <h2>List of Books</h2>
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        conn = dbConnection.initializeDatabase();
                        String sql = "SELECT * FROM book";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("book_id");
                            String title = rs.getString("title");
                            String author = rs.getString("author");
                            String description = rs.getString("description");
                            String price = rs.getString("price");
                %>
                            <tr>
                                <td><%= title %></td>
                                <td><%= author %></td>
                                <td><%= description %></td>
                                <td><%= price %></td>
                                <td>
                                    <a href="addBook.jsp?book_id=<%= id %>"><button type="button" class="btn">Add</button></a>
                                    <a href="updateBook.jsp?book_id=<%= id %>"><button type="button" class="btn">Edit</button></a>
                                    <button type="button" class="btn" onclick="confirmDelete(<%= id %>)">Delete</button>
                                </td>
                            </tr>
                <%
                        }
                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace(new java.io.PrintWriter(out));
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
        <!-- Button to Add Book -->
        <a href="home.jsp" class="btn">Go To HomePage</a>
    </div>
</body>
</html>
