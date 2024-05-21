<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="bookStore_DynamicWebProject.dbConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Book</title>
</head>
<body>
    <%
        String bookId = request.getParameter("book_id");

        if (bookId != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                conn = dbConnection.initializeDatabase();
                String sql = "DELETE FROM book WHERE book_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(bookId));
                int rowsDeleted = pstmt.executeUpdate();

                if (rowsDeleted > 0) {
                    out.println("<p>Book deleted successfully!</p>");
                } else {
                    out.println("<p>Failed to delete book.</p>");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace(new java.io.PrintWriter(out));
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }

        // Redirect back to products.jsp
        response.sendRedirect("products.jsp");
    %>
</body>
</html>
