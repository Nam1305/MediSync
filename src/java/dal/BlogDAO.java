//Them boi Nguyen Dinh Chinh 1-2-25
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Blog;

public class BlogDAO extends DBContext {
    // Xóa biến connection vì đã được kế thừa từ DBContext
    
    // Constructor mặc định
    public BlogDAO() {
        // Gọi constructor của lớp cha (DBContext)
        super();
    }
    
    // Phương thức lấy 4 blog ngẫu nhiên
    public List<Blog> getRandomBlogs() {
        List<Blog> blogs = new ArrayList<>();
        String sql = "SELECT TOP 3 * FROM Blog ORDER BY NEWID()";
        
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                blogs.add(mapResultSetToBlog(rs));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return blogs;
    }
    
    // Ánh xạ dữ liệu từ ResultSet sang Blog Object
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        return new Blog(
                rs.getInt("blogId"),
                rs.getString("blogName"),
                rs.getString("content"),
                rs.getString("image"),
                rs.getString("author"),
                rs.getDate("date")
        );
    }
}