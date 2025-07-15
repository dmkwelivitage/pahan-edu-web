package com.uni.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private static Connection connection;

    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
//            try(InputStream input = DBConnection.class.getClassLoader()
//                    .getResourceAsStream("application.properties")) {
//                Properties prop = new Properties();
//                prop.load(input);
//
//                String url = prop.getProperty("db.url");
//                String username = prop.getProperty("db.username");
//                String password = prop.getProperty("db.password");

//                connection = DriverManager.getConnection(url, username, password);
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahan_edu", "root", "");
//            } catch (Exception ex) {
//                throw new SQLException("Unable to load DB configuration:" , ex.getMessage(), ex);
//            }
        }
        return connection;
    }
}
