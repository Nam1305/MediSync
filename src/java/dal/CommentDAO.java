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
        String sql = "SELECT c.commentId, c.content, c.date, c.blogId, cu.customerId, cu.name, cu.avatar "
            + "FROM Comment c "
            + "JOIN Customer cu ON c.customerId = cu.customerId "
            + "WHERE c.blogId = ? "
            + "ORDER BY c.date DESC";

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

    public void addComment(Comment comment, int blogId) {
        String sql = "INSERT INTO Comment (content, date, blogId, customerId) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            if (comment.getContent().trim().isEmpty()) {
                throw new SQLException("Nội dung bình luận không được để trống!");
            }
            ps.setString(1, comment.getContent().trim());
            ps.setDate(2, new java.sql.Date(comment.getDate().getTime()));
            ps.setInt(3, blogId);
            ps.setInt(4, comment.getCustomerId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
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

    public int getCommentsCountByBlogId(int blogId) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Comment WHERE blogId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, blogId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }
    
    
    public boolean deleteComment(int commentId) {
        String sql = "DELETE FROM Comment WHERE commentId = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, commentId);
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return true;
    }


}
