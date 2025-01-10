package com.mycompany.testmaven;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseConnection {
    private String dbUrl;
    private String dbUsername;
    private String dbPassword;
    protected Connection connection;

    // Constructor khởi tạo kết nối CSDL
    public DatabaseConnection() {
        loadDatabaseProperties();
        initializeDatabaseConnection();
    }

    // Hàm để tải thông tin cấu hình từ file db.properties
    private void loadDatabaseProperties() {
        try (InputStream input = this.getClass().getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find db.properties");
                return;
            }

            Properties properties = new Properties();
            properties.load(input);
            this.dbUrl = properties.getProperty("db.url");
            this.dbUsername = properties.getProperty("db.username");
            this.dbPassword = properties.getProperty("db.password");

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi khi tải thông tin cấu hình: " + e.getMessage());
        }
    }

    // Hàm để khởi tạo kết nối tới CSDL
    private void initializeDatabaseConnection() {
        try {
            // Đăng ký driver JDBC
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println("Connecting to database: " + this.dbUrl);
            
            // Kết nối đến cơ sở dữ liệu
            connection = DriverManager.getConnection(this.dbUrl, this.dbUsername, this.dbPassword);
            System.out.println("Kết nối thành công đến cơ sở dữ liệu.");

        } catch (ClassNotFoundException e) {
            System.out.println("Driver không tìm thấy: " + e.getMessage());

        } catch (SQLException e) {
            System.out.println("Lỗi kết nối đến cơ sở dữ liệu: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Lỗi không xác định khi kết nối đến cơ sở dữ liệu: " + e.getMessage());
        }
    }

    // Hàm để đóng kết nối CSDL
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Kết nối đã được đóng.");
            } catch (SQLException e) {
                System.out.println("Lỗi khi đóng kết nối: " + e.getMessage());
            }
        }
    }

    // Getter để lấy đối tượng Connection
    public Connection getConnection() {
        return connection;
    }
}
