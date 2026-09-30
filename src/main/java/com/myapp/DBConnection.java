package com.myapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL =
        System.getenv().getOrDefault("DB_URL",
        "jdbc:mysql://localhost:3306/inventorydb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
    private static final String USER =
        System.getenv().getOrDefault("DB_USER", "inventory");
    private static final String PASSWORD =
        System.getenv().getOrDefault("DB_PASSWORD", "inventory123");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC driver not found.", e);
        }
    }

    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
