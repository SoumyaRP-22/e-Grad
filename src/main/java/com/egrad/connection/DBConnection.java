package com.egrad.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.io.InputStream;
import java.util.Properties;

public class DBConnection {

    private static Connection connection=null;

    public static Connection getConnection() {
        try {
            if (connection == null || connection.isClosed()) {
            	Properties props=new Properties();
            	InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties"); 
            	props.load(in);
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(props.getProperty("db.url"), props.getProperty("db.user"), props.getProperty("db.password"));
                System.out.println("Database connection successful!");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found. Ensure mysql-connector.jar is in WEB-INF/lib");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Database connection failed.");
            e.printStackTrace();
        } catch(Exception e) {
        	e.printStackTrace();
        }
        return connection;
    }
}