package util;

import java.sql.*;

public class DBConnect {
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/fashionmen", "root", "");
    }
}
