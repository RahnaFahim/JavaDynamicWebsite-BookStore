package bookStore_DynamicWebProject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/testdb")
public class testDbServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = dbConnection.initializeDatabase()) {
            if (connection != null) {
                response.getWriter().println("Database connection successful!");
            } else {
                response.getWriter().println("Failed to make database connection.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(response.getWriter());
        }
    }
}
