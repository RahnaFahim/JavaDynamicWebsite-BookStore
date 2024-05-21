package bookStore_DynamicWebProject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConnection {
	private static final String URL = "jdbc:mysql://localhost:3306/bookstore";
    private static final String USER = "root";
    private static final String PASSWORD = "";  

    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        // Register the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Open a connection
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
