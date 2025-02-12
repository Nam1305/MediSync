/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class CommentDAO extends DBContext {
    
    public CommentDAO() {
        super();
    }
    
    public List<Comment> getCommentsByBlogId(int blogId) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.commentId, c.content, c.date, c.blogId, cu.customerId, cu.name, cu.avatar FROM Comment c JOIN Customer cu ON c.customerId = cu.customerId WHERE c.blogId = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    comments.add(mapResultSetToComment(rs));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return comments;
    }
    
    private Comment mapResultSetToComment(ResultSet rs) throws SQLException {
        return new Comment(
                rs.getInt("commentId"),
                rs.getString("content"),
                rs.getDate("date"),
                rs.getInt("blogId"),
                rs.getInt("customerId"),
                rs.getString("name"),
                rs.getString("avatar")
        );
    }
}
